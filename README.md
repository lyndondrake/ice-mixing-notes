# Ice-mixing notes

Results of a research project on spin ice on the pyrochlore lattice, published as
stand-alone contribution notes with machine-readable claims manifests.

The project studies three questions about the ice states of the pyrochlore lattice
on a periodic box (a *cell* $(a, b, c)$): how fast the standard local dynamics, which
flips the six bonds of one hexagon at a time, relaxes; which ice states are *frozen*,
admitting no hexagon flip at all; and whether every frozen state of zero flux is
periodic. Each result is written up as a contribution note, a short paper with a PDF
that a reader can take without the project's history. The principal results of a note
are listed one by one in its *claims manifest*: what is asserted, on which cells, with
what standing, what it rests on, how its evidence is regenerated, and who wrote and
who checked it.

Most of the work was done by language-model agents (Anthropic's Claude models)
directed by Lyndon Drake. Each claim names the model that wrote it and the independent
checker that read it, and says whether a person has read it line by line. Read that
field before relying on a claim.

The site is at <https://lyndondrake.github.io/ice-mixing-notes/>.

## How to read it

- **For a person:** start at the site's front page. It has a table of every claim,
  filterable by status and note, a box of the open problems, and links to the
  dependency graph, the notes (HTML and PDF), the checker and agent reports, and the
  certificate ledgers. Each claim has a page giving its statement, status, scope,
  dependencies (and the claims that use it), artefacts and provenance.
- **For a machine:** `docs/llms.txt` lists the machine-readable resources;
  `docs/llms-full.txt` is every manifest as JSON in one file; `docs/manifests/<note>.json`
  is one manifest; `schema/manifest.schema.json` is the schema. Claim and note pages
  carry JSON-LD (schema.org) in the page head.

## What is in this repository

| path | contents |
|---|---|
| `notes/` | the contribution notes, Markdown and PDF, with `refs.json`, the bibliography (CSL JSON) |
| `manifests/<note>.yaml` | the claims manifest of a note; `manifests/_drafts/` holds drafts not yet reviewed and not published on the site; `manifests/_test/` is a test fixture |
| `schema/manifest.schema.json` | the JSON Schema (2020-12) every manifest conforms to |
| `reports/` | the checker and agent reports the notes and manifests cite, as they were written |
| `certificates/` | ledgers of the machine-checked proofs: one line per SAT query, with the SHA-256 of the formula and proof and the verdict of `drat-trim` |
| `scripts/` | `validate.py` (checks the manifests), `build_site.py` (writes `docs/`) |
| `docs/` | the generated site, served by GitHub Pages; never edit it by hand |

This repository is a curated mirror. The project's working repository is private and
is the source of truth; the files here are copied from it by a sync step and the site
is rebuilt from them. Artefacts that live only in the working repository (most scripts,
the large formula and proof files) are named in the manifests with a `private:` prefix.

## The manifests

A manifest describes one version of one note. Its note-level fields are the slug
(`note`), `title`, `version`, `date`, `doi` (when archived), `sources`, `licence`,
`authors`, a `summary` and `open_problems`. Then one record per claim:

| field | meaning |
|---|---|
| `id` | `note-slug/claim-slug`, stable across revisions of the note even if the note renumbers |
| `kind` | definition, lemma, theorem, corollary, fact, conjecture, negative-result (a route shown not to work), certificate-campaign (a family of machine-checked proofs on named cells) |
| `label` | how the note names it in this version, e.g. "Theorem 1" |
| `statement` | the statement, self-contained, with LaTeX where needed |
| `status`, `status_detail` | the standing, in the vocabulary below, and what it rests on |
| `scope` | `cells` (the cells on which it holds) and `hypotheses` |
| `depends_on`, `supersedes` | identifiers of other claims, in this or another manifest |
| `artefacts` | reports, ledgers, certificates, scripts, with `sha256`, `size_bytes` and the `regenerate` command where known |
| `formal` | a Lean 4 or Isabelle declaration, if there is one |
| `provenance` | `written_by`, `checked_by`, `human_read`, `date`, `log` |
| `notes` | what a reader taking the claim out of context must know |

### The status vocabulary

Quoted from the schema. Every claim has exactly one.

- `proved`: a written argument read by an independent checker with its own programs.
- `proved-unchecked`: a written argument with no second reader.
- `certified`: a machine-checked proof (DRAT, LRAT, Lean, Isabelle) on the cells named in scope.
- `solver`: a SAT or LP verdict on named cells without a checked proof object.
- `computed`: an exact computation with no solver verdict.
- `explored`: floating-point or sampled evidence only.
- `conjecture`: believed, with evidence named.
- `open`: a target with no verdict.
- `closed-route`: a method shown not to reach the target.
- `corrected`: a statement of an earlier version repaired here.
- `refuted`: shown false, with a witness.

"Independent checker" means a separate agent, asked to find a gap, that wrote its own
programs from the definitions and did not use the author's. It does not mean a person.

## How to reproduce

- **The site:** with Python 3.10 or later, PyYAML and jsonschema, and pandoc 3:

      python scripts/validate.py
      python scripts/build_site.py

  `validate.py` checks every manifest against the schema, checks that every
  `depends_on` and `supersedes` identifier resolves (unresolved ones are warnings,
  since the manifests of the older notes come later), checks that every published
  artefact exists, and verifies every `sha256` given. It exits non-zero on an error.
  `build_site.py` removes and rewrites `docs/`. Set `NOTES_CSL` to a CSL file to
  change the citation style.
- **A certificate:** each ledger line gives the SHA-256 of a CNF formula and of its
  DRAT proof. The claim pages name the script that regenerates the formula and the
  solver version; rerun it, hash the formula, solve it, and check the proof with
  `drat-trim`. The scripts are in the project's working repository and are not yet
  published here; the claim pages name them.
- **A note's PDF:** the Markdown in `notes/` is the source; it was built with pandoc
  and LuaLaTeX with the bibliography `notes/refs.json`.

## How to cite

Cite a note by its title, version and URL, and a claim by its identifier, for example
`theorem-h-orientation/thm-1`, with the note's version. `CITATION.cff` gives the
repository citation. When a release is archived, its DOI is recorded in `CHANGELOG.md`
and in the manifests' `doi` field.

## Licences

- Notes and reports: CC BY 4.0 (`LICENSE-text.md`).
- Scripts: MIT (`LICENSE-code.md`).
- Certificates, ledgers and manifests: CC0 1.0 (`LICENSE-data.md`).
