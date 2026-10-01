#!/usr/bin/env python3
"""Build the static site in docs/ from the notes, reports, ledgers and manifests.

docs/ is generated in full and is removed and rewritten on every run; never
edit it by hand. Reads:

  manifests/*.yaml            the published claims manifests (not _test/, _drafts/)
  notes/*.md, notes/*.pdf     the contribution notes, notes/refs.json their bibliography
  reports/*.md                the checker and agent reports
  certificates/*              the certificate ledgers
  schema/manifest.schema.json the manifest schema (its status vocabulary is shown on the site)

Writes docs/: index.html, graph.html, claims/<note>/<claim>.html,
notes/index.html and notes/<slug>.html (+ PDFs), reports/index.html and
reports/<name>.html, certificates/index.html (+ ledgers), manifests/<slug>.json,
schema/manifest.schema.json, llms.txt, llms-full.txt, sitemap.xml, style.css,
.nojekyll.

Usage:
  build_site.py                         build from manifests/
  build_site.py --manifests manifests/_test
                                        build from another directory (testing)
  build_site.py --base-url URL          absolute URL of the site (sitemap, llms.txt, JSON-LD)

Needs pandoc (3.x) on PATH and PyYAML.
"""

from __future__ import annotations

import argparse
import datetime as dt
import html
import json
import os
import re
import shutil
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from manifests import MANIFEST_DIR, ROOT, SCHEMA_PATH, load_manifests, load_schema, load_yaml  # noqa: E402

DOCS = ROOT / "docs"
NOTES = ROOT / "notes"
REPORTS = ROOT / "reports"
CERTS = ROOT / "certificates"
TEMPLATES = Path(__file__).resolve().parent / "templates"
TMP = ROOT.parent / ".tmp" / "build_site" if (ROOT.parent / ".git").exists() else ROOT / ".tmp" / "build_site"

DEFAULT_BASE_URL = "https://lyndondrake.github.io/ice-mixing-notes/"
REPO_URL = "https://github.com/lyndondrake/ice-mixing-notes"
MATHJAX = "https://cdnjs.cloudflare.com/ajax/libs/mathjax/3.2.2/es5/tex-chtml-full.js"
D3 = "https://cdnjs.cloudflare.com/ajax/libs/d3/7.8.5/d3.min.js"
CSL = Path(os.environ.get("NOTES_CSL", str(Path.home() / ".local/share/pandoc/csl/new-oxford-style-manual-author-date.csl")))

SITE_NAME = "Ice-mixing notes"
LICENCE_URLS = {
    "CC-BY-4.0": "https://creativecommons.org/licenses/by/4.0/",
    "MIT": "https://opensource.org/license/mit",
    "CC0-1.0": "https://creativecommons.org/publicdomain/zero/1.0/",
}

ABOUT = (
    "This site publishes the results of <em>ice-mixing</em>, a research project on spin ice on the "
    "pyrochlore lattice: how fast the standard local dynamics (single hexagon flips) relaxes, which ice "
    "states are <em>frozen</em> (admit no hexagon flip at all), and whether every frozen state of zero "
    "flux is periodic. The results are issued as stand-alone contribution notes, each with a PDF. For "
    "every note that has a claims manifest, its principal results are listed below one by one: what is "
    "asserted, on which cells (the periodic boxes of the lattice on which it holds), with what standing "
    "(proved, certified by a machine-checked proof, computed, conjectured, open), what it rests on, how "
    "to regenerate its evidence, and who wrote it and who checked it. Most of the work was done by "
    "language-model agents (Anthropic's Claude models) directed by Lyndon Drake; every claim names the "
    "model that wrote it and the independent checker that read it, and says whether a person has read "
    "it line by line."
)


# ----------------------------------------------------------------------------
# Small helpers

def esc(s) -> str:
    return html.escape(str(s), quote=True)


def plain(s: str) -> str:
    """A label without TeX dollars, for graph nodes, titles and attributes."""
    s = re.sub(r"\$([^$]*)\$", r"\1", s or "")
    s = re.sub(r"\\math(?:bb|rm|bf|cal|sf|it)\{([^}]*)\}", r"\1", s)
    s = s.replace("\\", "")
    return re.sub(r"\s+", " ", s).strip()


def claim_slug(cid: str) -> tuple[str, str]:
    note, slug = cid.split("/", 1)
    return note, slug


def claim_href(cid: str) -> str:
    note, slug = claim_slug(cid)
    return f"claims/{note}/{slug}.html"


def write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def json_script(obj) -> str:
    return json.dumps(obj, ensure_ascii=False, indent=1).replace("</", "<\\/")


def parse_front_matter(md: Path) -> dict:
    text = md.read_text(encoding="utf-8")
    if not text.startswith("---"):
        return {}
    end = text.find("\n---", 3)
    if end < 0:
        return {}
    try:
        from manifests import _StringDateLoader  # noqa
        import yaml
        return yaml.load(text[3:end], Loader=_StringDateLoader) or {}
    except Exception:
        return {}


def vocabulary(schema: dict, field: str) -> dict[str, str]:
    """The enum of a claim field with each value's gloss, parsed from the schema description."""
    prop = schema["$defs"]["claim"]["properties"][field]
    names = prop["enum"]
    desc = prop.get("description", "")
    out: dict[str, str] = {}
    for i, n in enumerate(names):
        m = re.search(r"(?:^|\s)" + re.escape(n) + r": ", desc)
        if not m:
            out[n] = ""
            continue
        start = m.end()
        nxt = len(desc)
        for other in names:
            m2 = re.search(r"\s" + re.escape(other) + r": ", desc[start:])
            if m2:
                nxt = min(nxt, start + m2.start())
        out[n] = desc[start:nxt].strip()
    return out


# ----------------------------------------------------------------------------
# Pandoc

def pandoc_fragments(texts: list[str]) -> list[str]:
    """Render many Markdown fragments to HTML in one pandoc call."""
    if not texts:
        return []
    parts = []
    for i, t in enumerate(texts):
        parts.append(f"FRAGSEP{i:05d}\n\n{t or ''}\n")
    parts.append(f"FRAGSEP{len(texts):05d}\n")
    src = "\n".join(parts)
    res = subprocess.run(
        ["pandoc", "-f", "markdown", "-t", "html", "--math-method=mathjax", "--wrap=none"],
        input=src, capture_output=True, text=True, check=True,
    )
    pieces = re.split(r"<p>FRAGSEP(\d{5})</p>", res.stdout)
    out = [""] * len(texts)
    # pieces: [before, idx0, frag0, idx1, frag1, ..., idxN, tail]
    for k in range(1, len(pieces) - 1, 2):
        idx = int(pieces[k])
        if idx < len(texts):
            out[idx] = pieces[k + 1].strip()
    return out


def inline(frag: str) -> str:
    m = re.fullmatch(r"<p>(.*)</p>", frag.strip(), flags=re.S)
    return m.group(1) if m else frag


class PandocLog:
    def __init__(self) -> None:
        self.warnings: list[str] = []
        self.errors: list[str] = []


def run_pandoc_page(src: Path, out: Path, *, root: str, pagetitle: str, description: str,
                    before: str, header: str, log: PandocLog, toc: bool = True,
                    citeproc: bool = True) -> None:
    TMP.mkdir(parents=True, exist_ok=True)
    before_f = TMP / (out.stem + ".before.html")
    header_f = TMP / (out.stem + ".header.html")
    before_f.write_text(before, encoding="utf-8")
    header_f.write_text(header, encoding="utf-8")
    cmd = [
        "pandoc", str(src), "--standalone", f"--math-method=mathjax:{MATHJAX}",
        "--template", str(TEMPLATES / "page.html"),
        "-V", f"root={root}",
        "-M", f"pagetitle={pagetitle}",
        "-M", f"description-meta={description}",
        "-M", "lang=en-GB",
        "--include-before-body", str(before_f),
        "--include-in-header", str(header_f),
        "--resource-path", str(src.parent),
        "--wrap=none",
        "-o", str(out),
    ]
    if toc:
        cmd += ["--toc", "--toc-depth=2"]
    if citeproc:
        cmd += ["--citeproc", "--bibliography", str(NOTES / "refs.json"), "-M", "link-citations=true"]
        if CSL.is_file():
            cmd += ["--csl", str(CSL)]
    out.parent.mkdir(parents=True, exist_ok=True)
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0 and "YAML" in res.stderr:
        # A later '---' line followed by text that is not YAML (a horizontal rule in a report):
        # read the file again without metadata blocks, and say so.
        log.warnings.append(f"{src.relative_to(ROOT)}: YAML metadata block unreadable; rendered without metadata blocks")
        res = subprocess.run(cmd[:2] + ["-f", "markdown-yaml_metadata_block"] + cmd[2:], capture_output=True, text=True)
    for line in res.stderr.splitlines():
        if line.strip():
            log.warnings.append(f"{src.relative_to(ROOT)}: {line.strip()}")
    if res.returncode != 0:
        log.errors.append(f"{src.relative_to(ROOT)}: pandoc exited {res.returncode}")


def link_report_mentions(html_text: str, root: str, published: set[str]) -> str:
    """Turn `docs/reports/X.md` code spans and X.md links into links to the published report pages."""

    def code_sub(m):
        name = m.group(2)
        if name in published:
            return f'<a href="{root}reports/{name}.html"><code>{m.group(1)}{name}.md</code></a>'
        return m.group(0)

    html_text = re.sub(r"<code>((?:docs/)?reports/)([\w.-]+)\.md</code>", code_sub, html_text)

    def href_sub(m):
        name = m.group(2)
        if name in published:
            return f'href="{root}reports/{name}.html"'
        return m.group(0)

    html_text = re.sub(r'href="((?:\.\./|docs/reports/|reports/)*)([\w.-]+)\.md"', href_sub, html_text)
    return html_text


# ----------------------------------------------------------------------------
# Page shell

def nav(root: str) -> str:
    return (
        '<nav class="site-nav" aria-label="Site"><div class="inner">'
        f'<a class="brand" href="{root}index.html">{SITE_NAME}</a>'
        f'<a href="{root}index.html#claims">Claims</a>'
        f'<a href="{root}graph.html">Graph</a>'
        f'<a href="{root}notes/index.html">Notes</a>'
        f'<a href="{root}reports/index.html">Reports</a>'
        f'<a href="{root}certificates/index.html">Certificates</a>'
        f'<a href="{root}llms.txt">For machines</a>'
        "</div></nav>"
    )


def footer(root: str, built: str) -> str:
    return (
        '<footer class="site-foot">'
        f'Notes and reports CC BY 4.0; scripts MIT; certificates, ledgers and manifests CC0 1.0. '
        f'Source: <a href="{REPO_URL}">{REPO_URL.replace("https://", "")}</a>. '
        f'Built {built} from the manifests; see <a href="{root}llms.txt">llms.txt</a> for the machine-readable files.'
        "</footer>"
    )


def page(title: str, body: str, *, root: str, description: str, built: str,
         jsonld=None, math: bool = False, wide: bool = False, extra_head: str = "", scripts: str = "") -> str:
    head = [
        "<!doctype html>",
        '<html lang="en-GB">',
        "<head>",
        '<meta charset="utf-8">',
        '<meta name="viewport" content="width=device-width, initial-scale=1">',
        f"<title>{esc(title)}</title>",
        f'<meta name="description" content="{esc(description)}">',
        f'<link rel="stylesheet" href="{root}style.css">',
    ]
    if jsonld is not None:
        head.append(f'<script type="application/ld+json">{json_script(jsonld)}</script>')
    if math:
        head.append(f'<script defer src="{MATHJAX}"></script>')
    if extra_head:
        head.append(extra_head)
    head.append("</head>")
    cls = ' class="wide"' if wide else ""
    return "\n".join(head) + f"\n<body>\n{nav(root)}\n<main{cls}>\n{body}\n</main>\n{footer(root, built)}\n{scripts}\n</body>\n</html>\n"


def badge(status: str, gloss: str = "") -> str:
    t = f' title="{esc(gloss)}"' if gloss else ""
    return f'<span class="badge st-{esc(status)}"{t}>{esc(status)}</span>'


# ----------------------------------------------------------------------------
# Main build

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--manifests", action="append", default=None,
                    help="manifest directory (repeatable; default manifests/)")
    ap.add_argument("--base-url", default=DEFAULT_BASE_URL)
    args = ap.parse_args()
    base = args.base_url.rstrip("/") + "/"
    built = dt.date.today().isoformat()

    if shutil.which("pandoc") is None:
        print("build_site.py: pandoc not on PATH", file=sys.stderr)
        return 2

    schema = load_schema()
    status_gloss = vocabulary(schema, "status")
    kind_gloss = vocabulary(schema, "kind")
    statuses = list(status_gloss)

    mdirs = [Path(d) if Path(d).is_absolute() else (ROOT / d) for d in (args.manifests or [str(MANIFEST_DIR)])]
    manifests: list[dict] = []
    for d in mdirs:
        for p, m in load_manifests(d.resolve()):
            m["_path"] = p
            manifests.append(m)
    if not manifests:
        print("build_site.py: no manifests found; building notes, reports and certificates only")

    # ---- notes and reports present in the tree
    note_files = sorted(p for p in NOTES.glob("*.md") if p.name != "README.md")
    note_meta: dict[str, dict] = {}
    for p in note_files:
        fm = parse_front_matter(p)
        note_meta[p.stem] = {
            "title": str(fm.get("title", p.stem)),
            "subtitle": fm.get("subtitle"),
            "date": str(fm.get("date", "")),
            "author": fm.get("author", ""),
            "abstract": fm.get("abstract", ""),
            "pdf": (NOTES / f"{p.stem}.pdf").is_file(),
        }
    readme_rows = {}
    if (NOTES / "README.md").is_file():
        for line in (NOTES / "README.md").read_text(encoding="utf-8").splitlines():
            m = re.match(r"\|\s*`([a-z0-9-]+)`\s*\|(.*)\|\s*$", line)
            if m:
                cells = [c.strip() for c in m.group(2).split("|")]
                if len(cells) >= 3:
                    readme_rows[m.group(1)] = {"contribution": cells[0], "pages": cells[1], "certification": cells[2]}

    report_files = sorted(REPORTS.glob("*.md"))
    published_reports = {p.stem for p in report_files}
    report_meta: dict[str, dict] = {}
    for p in report_files:
        fm = parse_front_matter(p)
        title = fm.get("title")
        if not title:
            for line in p.read_text(encoding="utf-8").splitlines():
                if line.startswith("# "):
                    title = line[2:].strip()
                    break
        mdate = re.match(r"(\d{4}-\d{2}-\d{2})", p.stem)
        report_meta[p.stem] = {"title": str(title or p.stem), "date": mdate.group(1) if mdate else "",
                               "author": str(fm.get("author", ""))}

    # ---- claims
    claims: dict[str, dict] = {}
    claim_note: dict[str, dict] = {}
    by_note: dict[str, list[str]] = defaultdict(list)
    for m in manifests:
        for c in m.get("claims", []):
            claims[c["id"]] = c
            claim_note[c["id"]] = m
            by_note[m["note"]].append(c["id"])
    depended_by: dict[str, list[str]] = defaultdict(list)
    superseded_by: dict[str, list[str]] = defaultdict(list)
    for cid, c in claims.items():
        for d in c.get("depends_on", []) or []:
            depended_by[d].append(cid)
        if c.get("supersedes"):
            superseded_by[c["supersedes"]].append(cid)
    open_ids = [cid for cid, c in claims.items() if c["status"] in ("open", "conjecture")]
    for m in manifests:
        for op in m.get("open_problems", []) or []:
            if op in claims and op not in open_ids:
                open_ids.append(op)
    report_cited_by: dict[str, list[str]] = defaultdict(list)
    ledger_cited_by: dict[str, list[str]] = defaultdict(list)
    for cid, c in claims.items():
        for a in c.get("artefacts", []) or []:
            p = a.get("path", "")
            if p.startswith("reports/") and p.endswith(".md"):
                report_cited_by[Path(p).stem].append(cid)
            if p.startswith("certificates/"):
                ledger_cited_by[Path(p).name].append(cid)

    # ---- render every claim text fragment in one pandoc call
    frag_keys: list[tuple[str, str]] = []
    frag_src: list[str] = []
    for cid, c in claims.items():
        for field, text in (("label", c.get("label", "")), ("statement", c.get("statement", "")),
                            ("status_detail", c.get("status_detail", "")), ("notes", c.get("notes", "")),
                            ("cells", (c.get("scope") or {}).get("cells", "")),
                            ("hypotheses", (c.get("scope") or {}).get("hypotheses", ""))):
            if text:
                frag_keys.append((cid, field))
                frag_src.append(str(text))
    for m in manifests:
        if m.get("summary"):
            frag_keys.append(("note:" + m["note"], "summary"))
            frag_src.append(m["summary"])
        frag_keys.append(("note:" + m["note"], "title"))
        frag_src.append(m["title"])
    for slug, nm in note_meta.items():
        frag_keys.append(("notefile:" + slug, "title"))
        frag_src.append(nm["title"])
    rendered = dict(zip(frag_keys, pandoc_fragments(frag_src)))

    def R(cid: str, field: str, inl: bool = False) -> str:
        h = rendered.get((cid, field), "")
        return inline(h) if inl else h

    # ---- clean and set up docs/
    if DOCS.exists():
        if DOCS.resolve().parent != ROOT.resolve():
            print("build_site.py: refusing to remove an unexpected docs/ path", file=sys.stderr)
            return 2
        shutil.rmtree(DOCS)
    DOCS.mkdir()
    (DOCS / ".nojekyll").write_text("", encoding="utf-8")
    shutil.copy2(TEMPLATES / "style.css", DOCS / "style.css")
    (DOCS / "schema").mkdir()
    shutil.copy2(SCHEMA_PATH, DOCS / "schema" / "manifest.schema.json")
    pages: list[str] = []

    # manifests as JSON
    (DOCS / "manifests").mkdir()
    manifest_json: dict[str, dict] = {}
    for m in manifests:
        clean = {k: v for k, v in m.items() if not k.startswith("_")}
        manifest_json[m["note"]] = clean
        write(DOCS / "manifests" / f"{m['note']}.json", json.dumps(clean, ensure_ascii=False, indent=2) + "\n")

    def note_url(slug: str) -> str:
        return f"{base}notes/{slug}.html"

    def note_title_html(slug: str) -> str:
        if ("notefile:" + slug, "title") in rendered:
            return inline(rendered[("notefile:" + slug, "title")])
        if ("note:" + slug, "title") in rendered:
            return inline(rendered[("note:" + slug, "title")])
        return esc(slug)

    def note_title_plain(slug: str) -> str:
        if slug in note_meta:
            return plain(note_meta[slug]["title"])
        for m in manifests:
            if m["note"] == slug:
                return plain(m["title"])
        return slug

    def artefact_link(path: str, root: str) -> str:
        if path.startswith("private:"):
            return f'<code>{esc(path[len("private:"):])}</code> <span class="muted small">(in the private repository; not published)</span>'
        if path.startswith("reports/") and path.endswith(".md") and Path(path).stem in published_reports:
            return f'<a href="{root}reports/{esc(Path(path).stem)}.html"><code>{esc(path)}</code></a>'
        if path.startswith("notes/") and path.endswith(".md"):
            return f'<a href="{root}notes/{esc(Path(path).stem)}.html"><code>{esc(path)}</code></a>'
        if path.startswith("notes/") and path.endswith(".pdf") or path.startswith("certificates/"):
            return f'<a href="{root}{esc(path)}"><code>{esc(path)}</code></a>'
        return f'<a href="{REPO_URL}/blob/main/{esc(path)}"><code>{esc(path)}</code></a>'

    def claim_ref(cid: str, root: str) -> str:
        if cid in claims:
            c = claims[cid]
            return (f'<a href="{root}{claim_href(cid)}">{R(cid, "label", True) or esc(cid)}</a> '
                    f'{badge(c["status"], status_gloss.get(c["status"], ""))} '
                    f'<span class="hash">{esc(cid)}</span>')
        return (f'<code>{esc(cid)}</code> <span class="badge st-external" '
                f'title="No published manifest contains this claim yet">not yet in a manifest</span>')

    licence_text = "https://creativecommons.org/licenses/by/4.0/"

    # ------------------------------------------------------------------ claim pages
    for cid, c in claims.items():
        m = claim_note[cid]
        note, slug = claim_slug(cid)
        root = "../../"
        prov = c["provenance"]
        sc = c.get("scope") or {}
        rows = []
        rows.append(f"<dt>Identifier</dt><dd><code>{esc(cid)}</code></dd>")
        rows.append(f'<dt>Kind</dt><dd>{esc(c["kind"])} <span class="muted small">{esc(kind_gloss.get(c["kind"], ""))}</span></dd>')
        st = c["status"]
        rows.append(f'<dt>Status</dt><dd>{badge(st)} <span class="muted small">{esc(status_gloss.get(st, ""))}</span>'
                    + (f'<div>{R(cid, "status_detail")}</div>' if c.get("status_detail") else "") + "</dd>")
        rows.append(f'<dt>Scope</dt><dd>{R(cid, "cells", True)}'
                    + (f'<br><span class="muted">Hypotheses:</span> {R(cid, "hypotheses", True)}' if sc.get("hypotheses") else "")
                    + "</dd>")
        deps = c.get("depends_on", []) or []
        rows.append("<dt>Depends on</dt><dd>" + (
            '<ul class="plain">' + "".join(f"<li>{claim_ref(d, root)}</li>" for d in deps) + "</ul>"
            if deps else '<span class="muted">nothing beyond its definitions</span>') + "</dd>")
        users = sorted(depended_by.get(cid, []))
        rows.append("<dt>Used by</dt><dd>" + (
            '<ul class="plain">' + "".join(f"<li>{claim_ref(u, root)}</li>" for u in users) + "</ul>"
            if users else '<span class="muted">no claim in a published manifest</span>') + "</dd>")
        if c.get("supersedes"):
            rows.append(f'<dt>Supersedes</dt><dd>{claim_ref(c["supersedes"], root)}</dd>')
        if superseded_by.get(cid):
            rows.append("<dt>Superseded by</dt><dd>" + "<br>".join(claim_ref(s, root) for s in superseded_by[cid]) + "</dd>")
        arts = c.get("artefacts", []) or []
        if arts:
            items = []
            for a in arts:
                bits = [f'<span class="kind">{esc(a["kind"])}</span> {artefact_link(a["path"], root)}']
                if a.get("size_bytes") is not None:
                    bits.append(f'<span class="muted small">{a["size_bytes"]:,} bytes</span>')
                if a.get("sha256"):
                    bits.append(f'<div class="hash">sha256 {esc(a["sha256"])}</div>')
                if a.get("regenerate"):
                    bits.append(f'<div class="small">Regenerate: <code>{esc(a["regenerate"])}</code></div>')
                if a.get("note"):
                    bits.append(f'<div class="small muted">{esc(a["note"])}</div>')
                items.append("<li>" + " ".join(bits) + "</li>")
            rows.append('<dt>Artefacts</dt><dd><ul class="plain">' + "".join(items) + "</ul></dd>")
        f = c.get("formal")
        if f:
            fb = [f'{esc(f.get("system", ""))}']
            if f.get("declaration"):
                fb.append(f'<code>{esc(f["declaration"])}</code>')
            if f.get("status"):
                fb.append(f'({esc(f["status"])})')
            if f.get("project"):
                fb.append(f'in <code>{esc(f["project"])}</code>')
            if f.get("axioms"):
                fb.append("axioms: " + ", ".join(f"<code>{esc(x)}</code>" for x in f["axioms"]))
            rows.append("<dt>Formal</dt><dd>" + " ".join(fb) + "</dd>")
        pv = []
        pv.append("Written by: " + (esc("; ".join(prov.get("written_by", []))) or '<span class="muted">not recorded</span>'))
        pv.append("Checked by: " + (esc("; ".join(prov.get("checked_by", []))) or '<span class="muted">no independent checker</span>'))
        pv.append("Read line by line by a person: " + ("yes" if prov.get("human_read") else "<strong>no</strong>"))
        pv.append(f'Status reached: {esc(prov.get("date", ""))}')
        if prov.get("log"):
            pv.append(f'Project log: {esc(prov["log"])}')
        rows.append("<dt>Provenance</dt><dd>" + "<br>".join(pv) + "</dd>")
        if c.get("notes"):
            rows.append(f'<dt>Notes</dt><dd>{R(cid, "notes")}</dd>')
        rows.append(f'<dt>Source</dt><dd><a href="{root}notes/{esc(note)}.html">{note_title_html(note)}</a>, version {esc(m["version"])}; '
                    f'<a href="{root}manifests/{esc(note)}.json">manifest (JSON)</a></dd>')

        body = (
            f'<p class="kind"><a href="{root}notes/{esc(note)}.html">{esc(note)}</a> / {esc(slug)}</p>'
            f'<h1>{R(cid, "label", True)}</h1>'
            f'<div class="statement" style="--c: var(--st-{esc(st)})">{R(cid, "statement")}</div>'
            f'<dl class="fields">{"".join(rows)}</dl>'
        )
        url = f"{base}{claim_href(cid)}"
        jsonld = {
            "@context": "https://schema.org",
            "@type": "CreativeWork",
            "@id": url,
            "url": url,
            "identifier": cid,
            "name": plain(c["label"]),
            "genre": c["kind"],
            "text": c["statement"].strip(),
            "creativeWorkStatus": st,
            "dateModified": prov.get("date"),
            "license": LICENCE_URLS.get((m.get("licence") or {}).get("text", ""), licence_text),
            "isPartOf": {
                "@type": "ScholarlyArticle",
                "@id": note_url(note),
                "url": note_url(note),
                "name": plain(m["title"]),
                "version": m["version"],
                "author": [{"@type": "Person", "name": a} for a in m.get("authors", [])],
            },
            "isBasedOn": [f"{base}{claim_href(d)}" for d in deps if d in claims],
            "subjectOf": {"@type": "Dataset", "url": f"{base}manifests/{note}.json", "encodingFormat": "application/json"},
        }
        desc = plain(c["statement"])[:280]
        write(DOCS / claim_href(cid), page(f"{plain(c['label'])} ({cid})", body, root=root, description=desc,
                                           built=built, jsonld=jsonld, math=True))
        pages.append(claim_href(cid))

    # ------------------------------------------------------------------ index
    root = ""
    status_counts = Counter(c["status"] for c in claims.values())
    human = sum(1 for c in claims.values() if c["provenance"].get("human_read"))
    trs = []
    for cid, c in claims.items():
        note = claim_note[cid]["note"]
        trs.append(
            f'<tr data-status="{esc(c["status"])}" data-note="{esc(note)}" data-text="{esc((cid + " " + plain(c["label"]) + " " + plain(c["statement"])).lower())}">'
            f'<td class="id"><a href="{claim_href(cid)}">{esc(claim_slug(cid)[1])}</a></td>'
            f'<td>{R(cid, "label", True)}</td>'
            f'<td class="opt kind">{esc(c["kind"])}</td>'
            f'<td>{badge(c["status"], status_gloss.get(c["status"], ""))}</td>'
            f'<td class="opt small">{R(cid, "cells", True)}</td>'
            f'<td class="opt small"><a href="notes/{esc(note)}.html">{esc(note)}</a></td></tr>'
        )
    status_opts = "".join(f'<option value="{esc(s)}">{esc(s)} ({status_counts[s]})</option>' for s in statuses if status_counts[s])
    note_opts = "".join(f'<option value="{esc(m["note"])}">{esc(m["note"])} ({len(by_note[m["note"]])})</option>' for m in manifests)
    open_box = ""
    if open_ids:
        open_box = ('<section class="panel open-problems"><h2>Open problems</h2>'
                    '<p class="small">Claims whose status is open or conjecture: the targets the notes name.</p><ul class="plain">'
                    + "".join(f'<li>{claim_ref(o, root)}<div class="small">{R(o, "statement")}</div></li>' for o in open_ids)
                    + "</ul></section>")
    notes_without = [s for s in note_meta if s not in by_note]
    legend = "".join(f"<dt>{badge(s)}</dt><dd>{esc(g)}</dd>" for s, g in status_gloss.items())
    body = f"""
<h1>{SITE_NAME}</h1>
<p>{ABOUT}</p>
<p class="small muted">{len(claims)} claims in {len(manifests)} manifest{'s' if len(manifests) != 1 else ''};
{len(note_meta)} notes in all ({len(notes_without)} without a published manifest yet).
Claims read line by line by a person: {human} of {len(claims)}.</p>
<p><a href="graph.html">Dependency graph</a> · <a href="notes/index.html">Notes</a> ·
<a href="reports/index.html">Checker and agent reports</a> · <a href="certificates/index.html">Certificate ledgers</a> ·
<a href="llms.txt">llms.txt</a> · <a href="llms-full.txt">llms-full.txt</a> ·
<a href="schema/manifest.schema.json">manifest schema</a> · <a href="{REPO_URL}">repository</a></p>
{open_box}
<section id="claims">
<h2>Claims</h2>
<div class="filters">
<label>Status <select id="f-status"><option value="">all</option>{status_opts}</select></label>
<label>Note <select id="f-note"><option value="">all</option>{note_opts}</select></label>
<label>Search <input id="f-text" type="search" placeholder="word or identifier"></label>
<span id="claim-count"></span>
</div>
<div class="table-wrap"><table class="claims">
<thead><tr><th>claim</th><th>label</th><th class="opt">kind</th><th>status</th><th class="opt">scope</th><th class="opt">note</th></tr></thead>
<tbody id="claim-rows">
{''.join(trs)}
</tbody></table></div>
</section>
<section>
<h2>The status vocabulary</h2>
<p class="small">Every claim has exactly one of these. They are the project's own, defined in the
<a href="schema/manifest.schema.json">manifest schema</a> and discussed in the note
<a href="notes/method.html">on the method</a>.</p>
<dl class="vocab">{legend}</dl>
</section>
"""
    filter_js = """<script>
(function () {
  var s = document.getElementById('f-status'), n = document.getElementById('f-note'),
      t = document.getElementById('f-text'), out = document.getElementById('claim-count');
  var rows = Array.prototype.slice.call(document.querySelectorAll('#claim-rows tr'));
  function apply() {
    var sv = s.value, nv = n.value, tv = t.value.trim().toLowerCase(), k = 0;
    rows.forEach(function (r) {
      var ok = (!sv || r.dataset.status === sv) && (!nv || r.dataset.note === nv) &&
               (!tv || r.dataset.text.indexOf(tv) >= 0);
      r.hidden = !ok; if (ok) k++;
    });
    out.textContent = k + ' of ' + rows.length + ' shown';
  }
  [s, n].forEach(function (e) { e.addEventListener('change', apply); });
  t.addEventListener('input', apply);
  var q = new URLSearchParams(location.search);
  if (q.get('status')) s.value = q.get('status');
  if (q.get('note')) n.value = q.get('note');
  apply();
})();
</script>"""
    jsonld = {
        "@context": "https://schema.org",
        "@type": "WebSite",
        "name": SITE_NAME,
        "url": base,
        "description": plain(re.sub(r"<[^>]+>", "", ABOUT)),
        "author": {"@type": "Person", "name": "Lyndon Drake"},
        "hasPart": [{"@type": "ScholarlyArticle", "name": plain(m["title"]), "url": note_url(m["note"])} for m in manifests],
    }
    write(DOCS / "index.html", page(SITE_NAME, body, root=root, built=built, wide=True, math=True, jsonld=jsonld,
                                    description="Contribution notes on pyrochlore spin ice with claims manifests: status, scope, dependencies, artefacts and provenance of every result.",
                                    scripts=filter_js))
    pages.append("index.html")

    # ------------------------------------------------------------------ graph
    level: dict[str, int] = {}

    def lvl(cid: str, seen=()) -> int:
        if cid in level:
            return level[cid]
        if cid in seen:
            return 0
        deps = [d for d in claims.get(cid, {}).get("depends_on", []) or []]
        v = 0 if not deps else 1 + max(lvl(d, seen + (cid,)) for d in deps)
        level[cid] = v
        return v

    nodes, edges, ext = [], [], set()
    for cid, c in claims.items():
        for d in c.get("depends_on", []) or []:
            if d not in claims:
                ext.add(d)
            edges.append({"source": d, "target": cid, "type": "depends"})
        if c.get("supersedes"):
            if c["supersedes"] not in claims:
                ext.add(c["supersedes"])
            edges.append({"source": c["supersedes"], "target": cid, "type": "supersedes"})
    for d in ext:
        level[d] = 0
    for cid in claims:
        lvl(cid)
    for cid, c in claims.items():
        lab = plain(c["label"])
        short = re.split(r"[(,;:]", lab)[0].strip() or lab
        nodes.append({"id": cid, "label": short[:34], "title": f"{lab}: {c['status']}", "status": c["status"],
                      "note": claim_note[cid]["note"], "level": level.get(cid, 0), "href": claim_href(cid)})
    for d in sorted(ext):
        nodes.append({"id": d, "label": d.split("/")[-1], "title": f"{d}: not yet in a published manifest",
                      "status": "external", "note": d.split("/")[0], "level": 0, "href": ""})
    graph_data = {"nodes": nodes, "edges": edges}
    legend_items = "".join(badge(s, status_gloss.get(s, "")) for s in statuses if status_counts[s])
    if ext:
        legend_items += '<span class="badge st-external">not yet in a manifest</span>'
    body = f"""
<h1>Dependency graph</h1>
<p class="small">Each node is a claim; an arrow runs from a claim to the claims whose proofs use it, so the foundations
are at the top and the main results lower down. Dashed arrows run from a superseded claim to the one that replaces it.
Colour is the status. Drag to pan, scroll or pinch to zoom, hover for the full label, click a node to open its page.
Grey nodes are cited claims of notes whose manifests are not yet published.</p>
<div class="legend">{legend_items}</div>
<svg id="graph" role="img" aria-label="Dependency graph of the claims"></svg>
<noscript><p>The graph needs JavaScript. The same information is on each claim's page and in the
<a href="index.html#claims">table of claims</a>.</p></noscript>
<details class="panel small"><summary>The graph as a list</summary><ul>
{''.join(f'<li><a href="{claim_href(c)}">{esc(c)}</a> uses: ' + (', '.join(esc(d) for d in claims[c].get('depends_on', []) or []) or 'nothing') + '</li>' for c in claims)}
</ul></details>
<script type="application/json" id="graph-data">{json_script(graph_data)}</script>
"""
    graph_js = f"""<script src="{D3}"></script>
<script>
(function () {{
  if (typeof d3 === 'undefined') return;
  var data = JSON.parse(document.getElementById('graph-data').textContent);
  var svg = d3.select('#graph'), el = document.getElementById('graph');
  var W = el.clientWidth, H = el.clientHeight;
  var css = getComputedStyle(document.documentElement);
  function colour(s) {{ return css.getPropertyValue('--st-' + s).trim() || '#888'; }}
  var maxLevel = d3.max(data.nodes, function (d) {{ return d.level; }}) || 1;
  var gap = Math.max(80, (H - 80) / (maxLevel + 1));
  svg.append('defs').append('marker').attr('id', 'arrow').attr('viewBox', '0 -4 8 8')
     .attr('refX', 15).attr('refY', 0).attr('markerWidth', 7).attr('markerHeight', 7).attr('orient', 'auto')
     .append('path').attr('d', 'M0,-4L8,0L0,4').attr('fill', css.getPropertyValue('--muted').trim());
  var g = svg.append('g');
  svg.call(d3.zoom().scaleExtent([0.2, 4]).on('zoom', function (e) {{ g.attr('transform', e.transform); }}));
  var link = g.append('g').selectAll('path').data(data.edges).join('path')
     .attr('class', function (d) {{ return 'edge ' + d.type; }}).attr('marker-end', 'url(#arrow)');
  var node = g.append('g').selectAll('g').data(data.nodes).join('g').attr('class', 'node')
     .on('click', function (e, d) {{ if (d.href) location.href = d.href; }});
  node.append('circle').attr('r', 8).attr('fill', function (d) {{ return colour(d.status); }})
     .attr('stroke', css.getPropertyValue('--bg').trim()).attr('stroke-width', 1.5);
  node.append('text').attr('x', 11).attr('y', 4).text(function (d) {{ return d.label; }});
  node.append('title').text(function (d) {{ return d.title + '\\n' + d.id; }});
  var sim = d3.forceSimulation(data.nodes)
     .force('link', d3.forceLink(data.edges).id(function (d) {{ return d.id; }}).distance(70).strength(0.25))
     .force('charge', d3.forceManyBody().strength(-260))
     .force('y', d3.forceY(function (d) {{ return 40 + d.level * gap; }}).strength(0.9))
     .force('x', d3.forceX(W / 2).strength(0.04))
     .force('collide', d3.forceCollide(30));
  node.call(d3.drag()
     .on('start', function (e, d) {{ if (!e.active) sim.alphaTarget(0.2).restart(); d.fx = d.x; d.fy = d.y; }})
     .on('drag', function (e, d) {{ d.fx = e.x; d.fy = e.y; }})
     .on('end', function (e, d) {{ if (!e.active) sim.alphaTarget(0); d.fx = null; d.fy = null; }}));
  sim.on('tick', function () {{
    link.attr('d', function (d) {{ return 'M' + d.source.x + ',' + d.source.y + 'L' + d.target.x + ',' + d.target.y; }});
    node.attr('transform', function (d) {{ return 'translate(' + d.x + ',' + d.y + ')'; }});
  }});
}})();
</script>"""
    write(DOCS / "graph.html", page("Dependency graph of the claims", body, root="", built=built, wide=True,
                                    description="The dependency graph of every claim in the published manifests, coloured by status.",
                                    scripts=graph_js))
    pages.append("graph.html")

    log = PandocLog()

    # ------------------------------------------------------------------ notes
    (DOCS / "notes").mkdir(exist_ok=True)
    note_rows = []
    order = sorted(note_meta, key=lambda s: (note_meta[s]["date"], s), reverse=True)
    for slug in order:
        nm = note_meta[slug]
        if nm["pdf"]:
            shutil.copy2(NOTES / f"{slug}.pdf", DOCS / "notes" / f"{slug}.pdf")
        m = next((x for x in manifests if x["note"] == slug), None)
        links = []
        if nm["pdf"]:
            links.append(f'<a href="{slug}.pdf">PDF</a>')
        if m:
            links.append(f'<a href="../manifests/{slug}.json">claims manifest (JSON)</a>')
            links.append(f'<a href="{REPO_URL}/blob/main/manifests/{slug}.yaml">manifest (YAML)</a>')
        links.append(f'<a href="{REPO_URL}/blob/main/notes/{slug}.md">Markdown source</a>')
        if m:
            cl = "".join(f'<li>{claim_ref(cid, "../")}</li>' for cid in by_note[slug])
            claims_box = (f'<section class="panel"><h2>Claims of this note</h2>'
                          f'<p class="small">From the manifest of version {esc(m["version"])}. '
                          f'Each links to its status, scope, dependencies, artefacts and provenance.</p>'
                          f'<ul class="plain small">{cl}</ul></section>')
        else:
            claims_box = ('<section class="panel small"><p>This note has no published claims manifest yet; its standing is as the '
                          'note itself and the <a href="index.html">notes index</a> state it.</p></section>')
        rr = readme_rows.get(slug)
        cert = f'<p class="small"><strong>Certification, as the notes index states it:</strong> {esc(rr["certification"])}</p>' if rr else ""
        before = nav("../") + f'<div class="doc-links" style="max-width:54rem;margin:0 auto;padding:0.8rem 16px 0">' \
                 f'<p class="small">{" · ".join(links)}</p>{cert}{claims_box}</div>'
        jsonld = {
            "@context": "https://schema.org",
            "@type": "ScholarlyArticle",
            "@id": note_url(slug),
            "url": note_url(slug),
            "headline": plain(nm["title"])[:110],
            "name": plain(nm["title"]),
            "datePublished": nm["date"],
            "version": m["version"] if m else nm["date"],
            "author": [{"@type": "Person", "name": "Lyndon Drake"}],
            "creditText": str(nm["author"]),
            "license": licence_text,
            "inLanguage": "en-GB",
            "encoding": [{"@type": "MediaObject", "contentUrl": f"{base}notes/{slug}.pdf", "encodingFormat": "application/pdf"}] if nm["pdf"] else [],
        }
        if m:
            jsonld["hasPart"] = [{"@type": "CreativeWork", "@id": f"{base}{claim_href(cid)}", "identifier": cid,
                                  "name": plain(claims[cid]["label"]), "creativeWorkStatus": claims[cid]["status"]}
                                 for cid in by_note[slug]]
            jsonld["subjectOf"] = {"@type": "Dataset", "url": f"{base}manifests/{slug}.json", "encodingFormat": "application/json"}
        header = f'<script type="application/ld+json">{json_script(jsonld)}</script>'
        out = DOCS / "notes" / f"{slug}.html"
        run_pandoc_page(NOTES / f"{slug}.md", out, root="../", pagetitle=plain(nm["title"]),
                        description=plain(rr["contribution"]) if rr else plain(nm["title"]),
                        before=before, header=header + "\n", log=log)
        if out.is_file():
            out.write_text(link_report_mentions(out.read_text(encoding="utf-8"), "../", published_reports) +
                           "", encoding="utf-8")
        pages.append(f"notes/{slug}.html")
        note_rows.append(
            f'<tr><td><a href="{slug}.html">{note_title_html(slug)}</a>'
            + (f'<div class="small muted">{esc(rr["contribution"])}</div>' if rr else "")
            + f'</td><td class="small">{esc(nm["date"])}</td>'
            + f'<td class="small">{"<a href=" + chr(34) + "../index.html?note=" + slug + chr(34) + ">" + str(len(by_note[slug])) + " claims</a>" if m else "not yet"}</td>'
            + f'<td class="small">{"<a href=" + chr(34) + slug + ".pdf" + chr(34) + ">PDF</a>" if nm["pdf"] else ""}</td></tr>'
        )
    body = f"""
<h1>Contribution notes</h1>
<p>One stand-alone note per contribution of the project, each with a PDF, written for a reader who wants the result
and its proof or certificate without the project's history. The HTML versions here are rendered from the same
Markdown as the PDFs. Where a later note supersedes part of an earlier one, the later note says so; the earlier
notes are kept as they were issued.</p>
<div class="table-wrap"><table>
<thead><tr><th>note</th><th>date</th><th>manifest</th><th>PDF</th></tr></thead>
<tbody>{''.join(note_rows)}</tbody></table></div>
"""
    write(DOCS / "notes" / "index.html", page("Contribution notes", body, root="../", built=built, math=True,
                                               description="The contribution notes of the ice-mixing project, with PDFs and claims manifests."))
    pages.append("notes/index.html")

    # ------------------------------------------------------------------ reports
    (DOCS / "reports").mkdir(exist_ok=True)
    rep_rows = []
    for p in sorted(report_files, key=lambda p: p.stem, reverse=True):
        rm = report_meta[p.stem]
        cites = report_cited_by.get(p.stem, [])
        cite_html = ", ".join(f'<a href="../{claim_href(c)}">{esc(claim_slug(c)[1])}</a>' for c in cites)
        before = nav("../") + ('<div style="max-width:54rem;margin:0 auto;padding:0.8rem 16px 0" class="small">'
                               f'<p>A report archived by the project, published as it was written. '
                               f'<a href="index.html">All reports</a> · <a href="{REPO_URL}/blob/main/reports/{p.name}">Markdown source</a>'
                               + (f'<br>Cited as an artefact by: {cite_html}' if cites else "") + "</p></div>")
        jsonld = {"@context": "https://schema.org", "@type": "Report", "name": plain(rm["title"]),
                  "url": f"{base}reports/{p.stem}.html", "datePublished": rm["date"], "license": licence_text,
                  "creditText": rm["author"] or None, "inLanguage": "en-GB"}
        jsonld = {k: v for k, v in jsonld.items() if v}
        out = DOCS / "reports" / f"{p.stem}.html"
        run_pandoc_page(p, out, root="../", pagetitle=plain(rm["title"])[:150], description=plain(rm["title"])[:280],
                        before=before, header=f'<script type="application/ld+json">{json_script(jsonld)}</script>\n',
                        log=log, toc=True, citeproc=False)
        if out.is_file():
            out.write_text(link_report_mentions(out.read_text(encoding="utf-8"), "../", published_reports), encoding="utf-8")
        pages.append(f"reports/{p.stem}.html")
        rep_rows.append(f'<tr><td class="small">{esc(rm["date"])}</td><td><a href="{p.stem}.html">{esc(plain(rm["title"]))}</a>'
                        f'<div class="hash">{esc(p.name)}</div></td><td class="small">{cite_html}</td></tr>')
    body = f"""
<h1>Reports</h1>
<p>The checker and agent reports that the notes and the manifests cite, published as they were written. Most
were written by language-model agents: an author agent that proved or computed something, or a checker agent
asked to find a gap in another agent's work with programs of its own. Each report states its own provenance.
They are the evidence behind the statuses on the claim pages, not polished exposition; the notes are the
exposition.</p>
<div class="table-wrap"><table>
<thead><tr><th>date</th><th>report</th><th>cited by claims</th></tr></thead>
<tbody>{''.join(rep_rows)}</tbody></table></div>
"""
    write(DOCS / "reports" / "index.html", page("Reports", body, root="../", built=built,
                                                 description="Checker and agent reports cited by the ice-mixing notes and claims."))
    pages.append("reports/index.html")

    # ------------------------------------------------------------------ certificates
    (DOCS / "certificates").mkdir(exist_ok=True)
    cert_sections = []
    import hashlib
    for f in sorted(CERTS.glob("*")):
        if not f.is_file():
            continue
        shutil.copy2(f, DOCS / "certificates" / f.name)
    for f in sorted(CERTS.glob("*.jsonl")):
        rows = [json.loads(line) for line in f.read_text(encoding="utf-8").splitlines() if line.strip()]
        groups: dict[tuple, Counter] = defaultdict(Counter)
        for r in rows:
            cell = tuple(r["cell"]) if r.get("cell") else ((r["L"],) * 3 if r.get("L") else ())
            key = (r.get("stmt") or (re.match(r"h\w+?_([A-Za-z]+)_", r.get("name", "")) or [None, ""])[1], "×".join(map(str, cell)) and "(" + ",".join(map(str, cell)) + ")", r.get("tag", ""))
            g = groups[key]
            g["queries"] += 1
            g["unsat"] += r.get("verdict") == "UNSAT"
            g["sat"] += r.get("verdict") == "SAT"
            g["drat_verified"] += bool(r.get("verified")) and "VERIFIED" in str(r.get("drat_trim", ""))
            g["drat_kept"] += bool(r.get("drat_kept"))
            g["proof_bytes"] += int(r.get("drat_bytes") or 0)
        trs = []
        tot = Counter()
        for key in sorted(groups, key=lambda k: (k[0], k[1], k[2])):
            g = groups[key]
            tot.update(g)
            trs.append(f"<tr><td>{esc(key[0])}</td><td>{esc(key[1])}</td><td>{esc(key[2])}</td><td>{g['queries']}</td>"
                       f"<td>{g['unsat']}</td><td>{g['sat']}</td><td>{g['drat_verified']}</td><td>{g['drat_kept']}</td>"
                       f"<td>{g['proof_bytes'] / 1e6:,.1f}</td></tr>")
        trs.append(f"<tr><th colspan=3>total</th><th>{tot['queries']}</th><th>{tot['unsat']}</th><th>{tot['sat']}</th>"
                   f"<th>{tot['drat_verified']}</th><th>{tot['drat_kept']}</th><th>{tot['proof_bytes'] / 1e6:,.1f}</th></tr>")
        sha_files = sorted(CERTS.glob(f.name.split("_")[0] + "_sha256_*.txt"))
        cites = sorted(set(ledger_cited_by.get(f.name, []) + sum((ledger_cited_by.get(s.name, []) for s in sha_files), [])))
        digest = hashlib.sha256(f.read_bytes()).hexdigest()
        cert_sections.append(
            f'<section><h2 id="{esc(f.stem)}"><code>{esc(f.name)}</code></h2>'
            f'<p class="small"><a href="{esc(f.name)}">raw ledger (JSON lines)</a>'
            + "".join(f' · <a href="{esc(s.name)}">{esc(s.name)}</a>' for s in sha_files)
            + f'<br><span class="hash">sha256 of the ledger {digest}</span>'
            + (f'<br>Cited by: ' + ", ".join(f'<a href="../{claim_href(c)}">{esc(c)}</a>' for c in cites) if cites else "")
            + '</p><div class="table-wrap"><table><thead><tr><th>statement</th><th>cell</th><th>tag</th><th>queries</th>'
            '<th>UNSAT</th><th>SAT</th><th>DRAT verified</th><th>proof kept</th><th>proof size, MB</th></tr></thead><tbody>'
            + "".join(trs) + "</tbody></table></div></section>")
    body = f"""
<h1>Certificate ledgers</h1>
<p>The machine-checked evidence for the certified claims. Each line of a ledger records one SAT query: the
statement and cell it encodes, the SHA-256 of the CNF formula, the solver's verdict, and, where a proof was
produced, the size and SHA-256 of the DRAT proof and the verdict of the independent checker
<code>drat-trim</code>. A query with verdict UNSAT and a DRAT proof verified by <code>drat-trim</code> is a
machine-checked proof that no state of the kind encoded exists on that cell. Queries without a proof (for
instance pre-flight runs) are solver verdicts only. The formulas and proofs themselves (hundreds of megabytes to
gigabytes) are not published; they are regenerated by the scripts named on the claim pages and checked
against the hashes in the <code>*_sha256_*.txt</code> files. The statement letters and tags are those of the
ledgers; the claim pages and the campaign reports explain them.</p>
<p class="small muted">Counts below are computed from the ledgers when the site is built.</p>
{''.join(cert_sections)}
"""
    write(DOCS / "certificates" / "index.html", page("Certificate ledgers", body, root="../", built=built,
                                                      description="Certificate ledgers: SAT queries, DRAT proofs and drat-trim verdicts behind the certified claims."))
    pages.append("certificates/index.html")

    # ------------------------------------------------------------------ llms.txt, llms-full.txt
    lines = [
        f"# {SITE_NAME}",
        "",
        "> Results of a research project on pyrochlore spin ice (the hexagon-flip dynamics, frozen states, and the periodicity of frozen zero-flux states), "
        "published as stand-alone contribution notes with machine-readable claims manifests. Each claim records its statement, status, scope, "
        "dependencies, artefacts with hashes and regenerate commands, and provenance (which model wrote it, which independent checker read it, whether a person has).",
        "",
        "Statuses are from a fixed vocabulary: " + "; ".join(f"{s}: {g.rstrip('.')}" for s, g in status_gloss.items()) + ".",
        "",
        "Read a claim's status_detail and scope before using it: many results hold on named cells only. Claim identifiers are stable across revisions of a note.",
        "",
        "## Claims manifests",
        "",
    ]
    for m in manifests:
        lines.append(f"- [{m['note']}]({base}manifests/{m['note']}.json): {len(by_note[m['note']])} claims, version {m['version']}; {plain(m['title'])}")
    lines += ["", "## Full text for machines", "",
              f"- [llms-full.txt]({base}llms-full.txt): every published manifest serialised as JSON, one after another, with a header per note",
              f"- [manifest schema]({base}schema/manifest.schema.json): JSON Schema (2020-12) of a claims manifest, with the status and kind vocabularies",
              "", "## Notes", ""]
    for slug in order:
        nm = note_meta[slug]
        rr = readme_rows.get(slug)
        extra = f"; PDF {base}notes/{slug}.pdf" if nm["pdf"] else ""
        lines.append(f"- [{plain(nm['title'])}]({note_url(slug)}): {plain(rr['contribution']) if rr else 'contribution note'}{extra}")
    lines += ["", "## Optional", "",
              f"- [Dependency graph]({base}graph.html): the claims as a graph, coloured by status (the same data as the manifests)",
              f"- [Reports]({base}reports/index.html): the checker and agent reports cited as artefacts",
              f"- [Certificate ledgers]({base}certificates/index.html): SAT queries, DRAT proofs and drat-trim verdicts, with raw JSON-lines files",
              f"- [Repository]({REPO_URL}): sources, manifests in YAML, scripts", ""]
    write(DOCS / "llms.txt", "\n".join(lines))
    full = [f"# {SITE_NAME}: every published claims manifest as JSON", f"# Built {built}. Schema: {base}schema/manifest.schema.json", ""]
    for m in manifests:
        full += ["", "=" * 78, f"# Note: {m['note']}", f"# Title: {plain(m['title'])}", f"# Version: {m['version']}",
                 f"# Note page: {note_url(m['note'])}", "=" * 78, json.dumps(manifest_json[m["note"]], ensure_ascii=False, indent=2)]
    write(DOCS / "llms-full.txt", "\n".join(full) + "\n")

    # ------------------------------------------------------------------ sitemap
    sm = ['<?xml version="1.0" encoding="UTF-8"?>', '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">']
    for p in sorted(set(pages)):
        sm.append(f"  <url><loc>{esc(base + p)}</loc></url>")
    sm.append("</urlset>")
    write(DOCS / "sitemap.xml", "\n".join(sm) + "\n")

    # ------------------------------------------------------------------ summary
    for w in log.warnings:
        print(f"pandoc: {w}")
    for e in log.errors:
        print(f"error: {e}")
    print(f"build_site.py: {len(claims)} claims from {len(manifests)} manifest(s); {len(note_meta)} notes, "
          f"{len(report_files)} reports, {len(list(CERTS.glob('*.jsonl')))} ledgers; {len(set(pages))} pages; "
          f"{len(log.warnings)} pandoc warning line(s), {len(log.errors)} error(s); output in {DOCS.relative_to(ROOT.parent) if ROOT.parent in DOCS.parents else DOCS}")
    return 1 if log.errors else 0


if __name__ == "__main__":
    sys.exit(main())
