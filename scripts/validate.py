#!/usr/bin/env python3
"""Validate the claims manifests of this repository.

Checks, for every manifest in manifests/ (not manifests/_test/ or
manifests/_drafts/ unless --dir names one):

  errors (exit status 1)
    - the manifest conforms to schema/manifest.schema.json;
    - the manifest's `note` matches its file name, and every claim
      identifier is prefixed by it;
    - no claim identifier occurs twice, across all manifests read;
    - every artefact path not prefixed `private:` exists in this tree,
      and its sha256 and size_bytes, when given, match the file;
    - sources.markdown and sources.pdf exist in this tree;
    - the depends_on graph across all manifests has no cycle.

  warnings (reported, exit status unaffected)
    - a depends_on, supersedes or open_problems identifier that resolves
      to no claim of any manifest read (manifests of the older notes come
      later, so cross-references may run ahead of them);
    - an open_problems claim whose status is not open or conjecture;
    - sources.html not yet built.

Usage:
  validate.py                      the published manifests
  validate.py --dir manifests/_test
  validate.py --dir manifests/_drafts --also manifests
                                   drafts, resolving references against the
                                   published manifests too
"""

from __future__ import annotations

import argparse
import hashlib
import sys
from pathlib import Path

from jsonschema import Draft202012Validator, FormatChecker

sys.path.insert(0, str(Path(__file__).resolve().parent))
from manifests import MANIFEST_DIR, ROOT, load_manifests, load_schema  # noqa: E402


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as fh:
        for chunk in iter(lambda: fh.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def find_cycle(graph: dict[str, list[str]]) -> list[str] | None:
    WHITE, GREY, BLACK = 0, 1, 2
    colour = {n: WHITE for n in graph}
    stack: list[str] = []

    def visit(n: str) -> list[str] | None:
        colour[n] = GREY
        stack.append(n)
        for m in graph.get(n, []):
            if m not in colour:
                continue
            if colour[m] == GREY:
                return stack[stack.index(m):] + [m]
            if colour[m] == WHITE:
                c = visit(m)
                if c:
                    return c
        stack.pop()
        colour[n] = BLACK
        return None

    for n in list(graph):
        if colour[n] == WHITE:
            c = visit(n)
            if c:
                return c
    return None


def resolve_dir(arg: str) -> Path:
    p = Path(arg)
    if not p.is_absolute():
        cand = ROOT / p
        p = cand if cand.exists() else Path.cwd() / p
    return p.resolve()


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--dir", default=None, help="manifest directory to validate (default: manifests/)")
    ap.add_argument("--also", action="append", default=[],
                    help="further manifest directories whose claims count for resolving references (not validated)")
    ap.add_argument("--no-hash", action="store_true", help="skip sha256 verification")
    args = ap.parse_args()

    target = resolve_dir(args.dir) if args.dir else MANIFEST_DIR
    errors: list[str] = []
    warnings: list[str] = []

    schema = load_schema()
    validator = Draft202012Validator(schema, format_checker=FormatChecker())

    loaded = load_manifests(target)
    if not loaded:
        print(f"validate.py: no manifests in {target}")
        return 0

    extra_ids: set[str] = set()
    for d in args.also:
        for _, m in load_manifests(resolve_dir(d)):
            for c in (m or {}).get("claims", []) or []:
                if isinstance(c, dict) and "id" in c:
                    extra_ids.add(c["id"])

    claims: dict[str, tuple[str, dict]] = {}
    for path, m in loaded:
        rel = path.relative_to(ROOT) if path.is_relative_to(ROOT) else path
        if not isinstance(m, dict):
            errors.append(f"{rel}: not a mapping")
            continue
        for err in sorted(validator.iter_errors(m), key=lambda e: list(e.absolute_path)):
            loc = "/".join(str(x) for x in err.absolute_path) or "(root)"
            errors.append(f"{rel}: schema: {loc}: {err.message}")
        slug = m.get("note")
        if slug and slug != path.stem:
            errors.append(f"{rel}: note '{slug}' does not match the file name '{path.stem}'")
        for c in m.get("claims", []) or []:
            if not isinstance(c, dict) or "id" not in c:
                continue
            cid = c["id"]
            if slug and not cid.startswith(slug + "/"):
                errors.append(f"{rel}: claim '{cid}' is not prefixed by the note slug '{slug}'")
            if cid in claims:
                errors.append(f"{rel}: claim '{cid}' duplicates one in {claims[cid][0]}")
            else:
                claims[cid] = (str(rel), c)
        src = m.get("sources", {}) or {}
        for key in ("markdown", "pdf"):
            if key in src and not (ROOT / src[key]).is_file():
                errors.append(f"{rel}: sources.{key} '{src[key]}' does not exist in this tree (run scripts/publish-notes.sh)")
        if "html" in src and not (ROOT / src["html"]).is_file():
            warnings.append(f"{rel}: sources.html '{src['html']}' not yet built (run scripts/build_site.py)")

    known = set(claims) | extra_ids

    for path, m in loaded:
        if not isinstance(m, dict):
            continue
        rel = path.relative_to(ROOT) if path.is_relative_to(ROOT) else path
        for op in m.get("open_problems", []) or []:
            if op not in known:
                warnings.append(f"{rel}: open_problems '{op}' resolves to no claim")
            elif op in claims and claims[op][1].get("status") not in ("open", "conjecture"):
                warnings.append(f"{rel}: open_problems '{op}' has status '{claims[op][1].get('status')}', not open or conjecture")

    graph: dict[str, list[str]] = {}
    for cid, (rel, c) in claims.items():
        graph[cid] = list(c.get("depends_on", []) or [])
        for d in graph[cid]:
            if d not in known:
                warnings.append(f"{rel}: {cid}: depends_on '{d}' resolves to no claim")
            if d == cid:
                errors.append(f"{rel}: {cid} depends on itself")
        sup = c.get("supersedes")
        if sup and sup not in known:
            warnings.append(f"{rel}: {cid}: supersedes '{sup}' resolves to no claim")
        for a in c.get("artefacts", []) or []:
            p = a.get("path", "")
            if p.startswith("private:"):
                continue
            f = ROOT / p
            if any(ch in p for ch in "*?[") or f.is_dir():
                # a directory or a glob pattern: require at least one file, check no hash
                matches = [m for m in ROOT.glob(p.rstrip("/") + ("/**/*" if f.is_dir() else "")) if m.is_file()]
                if not matches:
                    errors.append(f"{rel}: {cid}: artefact pattern '{p}' matches no file in this tree")
                elif "sha256" in a or "size_bytes" in a:
                    errors.append(f"{rel}: {cid}: artefact pattern '{p}' cannot carry sha256 or size_bytes")
                continue
            if not f.is_file():
                errors.append(f"{rel}: {cid}: artefact '{p}' does not exist in this tree")
                continue
            if "size_bytes" in a and f.stat().st_size != a["size_bytes"]:
                errors.append(f"{rel}: {cid}: artefact '{p}' is {f.stat().st_size} bytes, manifest says {a['size_bytes']}")
            if "sha256" in a and not args.no_hash:
                got = sha256_of(f)
                if got != a["sha256"]:
                    errors.append(f"{rel}: {cid}: artefact '{p}' sha256 {got} does not match the manifest's {a['sha256']}")

    cyc = find_cycle(graph)
    if cyc:
        errors.append("depends_on cycle: " + " -> ".join(cyc))

    for w in warnings:
        print(f"warning: {w}")
    for e in errors:
        print(f"error: {e}")
    print(f"validate.py: {len(loaded)} manifest(s), {len(claims)} claim(s), "
          f"{len(errors)} error(s), {len(warnings)} warning(s) in {target.relative_to(ROOT) if target.is_relative_to(ROOT) else target}")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
