"""Shared loading of claims manifests for validate.py and build_site.py.

Manifests are YAML files in manifests/ at the root of this repository. The
subdirectories manifests/_test/ and manifests/_drafts/ are never read unless a
directory is named explicitly. Dates are kept as strings, exactly as written,
so that the JSON form of a manifest is the YAML form.
"""

from __future__ import annotations

import json
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parent.parent  # the publish/ tree, root of the public repository
SCHEMA_PATH = ROOT / "schema" / "manifest.schema.json"
MANIFEST_DIR = ROOT / "manifests"


class _StringDateLoader(yaml.SafeLoader):
    """SafeLoader that leaves timestamps as strings."""


_StringDateLoader.yaml_implicit_resolvers = {
    k: [(tag, rx) for tag, rx in v if tag != "tag:yaml.org,2002:timestamp"]
    for k, v in yaml.SafeLoader.yaml_implicit_resolvers.items()
}


def load_yaml(path: Path):
    with open(path, encoding="utf-8") as fh:
        return yaml.load(fh, Loader=_StringDateLoader)


def load_schema() -> dict:
    with open(SCHEMA_PATH, encoding="utf-8") as fh:
        return json.load(fh)


def manifest_paths(directory: Path | None = None) -> list[Path]:
    """The manifests of one directory, not descending into subdirectories."""
    d = directory or MANIFEST_DIR
    return sorted(p for p in d.glob("*.yaml") if p.is_file()) + sorted(
        p for p in d.glob("*.yml") if p.is_file()
    )


def load_manifests(directory: Path | None = None) -> list[tuple[Path, dict]]:
    return [(p, load_yaml(p)) for p in manifest_paths(directory)]
