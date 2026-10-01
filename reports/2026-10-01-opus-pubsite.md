---
title: "Agent pubsite: the public notes repository, its sync, validator and site, and draft manifests for nine notes"
author: "Claude (Opus), agent pubsite, for Lyndon Drake"
date: 2026-10-01
---

# What was built

Everything is under `publish/` plus `scripts/publish-notes.sh`; nothing committed.

| path | what |
|---|---|
| `publish/README.md` | what the repository is, how to read it (person and machine), layout, the manifest fields, the status vocabulary quoted from the schema, how to reproduce, how to cite, licences |
| `publish/LICENSE-text.md`, `LICENSE-code.md`, `LICENSE-data.md` | CC BY 4.0 notice (notes, reports, site prose), MIT full text (scripts), CC0 1.0 notice (ledgers, manifests, schema). The two CC files are notices pointing to the legal code URLs, not the full legal code (I had no network to fetch it verbatim) |
| `publish/CHANGELOG.md` | one "Unreleased: first release" entry |
| `publish/CITATION.cff` | Lyndon Drake as sole author; a comment says models are named per claim under provenance. No e-mail (it would be public) |
| `publish/.gitignore` | `.tmp/`, `__pycache__/`, `*.pyc`, `.DS_Store` |
| `publish/PUBLISH-LIST.txt` | 70 source-tab-target lines: 10 notes x (md, pdf), `docs/notes/README.md`, `paper/refs/ice-mixing.json` as `notes/refs.json`, 44 reports, 4 ledgers |
| `scripts/publish-notes.sh` | the sync (bash, `set -euo pipefail`, no heredocs) |
| `publish/scripts/manifests.py` | shared loader (YAML with dates kept as strings, so YAML and JSON forms agree) |
| `publish/scripts/validate.py` | the validator |
| `publish/scripts/build_site.py`, `templates/page.html`, `templates/style.css` | the site builder, its pandoc template and the one stylesheet |
| `publish/manifests/_test/test-note.yaml` | a four-claim fixture exercising every field (sha256, size, formal, supersedes, an unresolved reference) |
| `publish/manifests/_drafts/*.yaml` + `README.md` | draft manifests for the nine other notes (76 claims), not read by the site |
| `publish/docs/` | the generated site: 91 pages, 4.5 MB, `.nojekyll` |

The brief said eleven notes; there are ten (plus the README), so the drafts cover nine.

**Reports published (44):** every report named in the notes' Artefacts sections (abbreviations expanded), in the real manifest, and in the notes README, and all of `2026-10-01-*`.

# How to run the three scripts

From the private repository root:

    scripts/publish-notes.sh --check          # stale/absent targets; exit 1 if any
    scripts/publish-notes.sh                  # copy; refuses (copies nothing) if a source is missing
    .venv/bin/python publish/scripts/validate.py
    .venv/bin/python publish/scripts/build_site.py

Variants: `validate.py --dir manifests/_drafts --also manifests`; `build_site.py --manifests manifests/_test` (or add `--manifests manifests/_drafts` for a preview; `docs/` is rewritten in full each run); `--base-url`; `NOTES_CSL`. PyYAML and jsonschema were installed into the venv. A build takes about 8 s.

Current results: sync 70 listed, 0 stale. `validate.py`: 1 manifest, 32 claims,
0 errors, 3 warnings (the real manifest's `periodicity` cites `curl-reduction/thm-p`,
`lemma-a`, `lemma-l`; with `--also manifests/_drafts` these resolve and there are no
warnings, because the curl-reduction draft uses those exact ids). Drafts: 9 manifests,
76 claims, 0 errors, 0 warnings. `build_site.py`: 0 errors and one notice:
`reports/2026-09-04-certificates-sat.md` has a `---` rule that pandoc reads as a YAML
block, so the builder re-renders that one file with metadata blocks off and says so.
Negative tests: a tampered sha256 and an invalid status both give exit 1. Every
JSON-LD block (87) parses, every relative link in `docs/` resolves, and the inline
JavaScript passes `node --check`. I could not open the pages in a browser (no Chrome
in the sandbox), so the graph's layout and the MathJax rendering have not been seen.

# The site, page by page

- **`index.html`**: a paragraph on the project for a reader who knows nothing of it;
  counts (claims, manifests, notes without a manifest, claims read by a person: 0 of
  32); links to graph, notes, reports, certificates, `llms.txt`, `llms-full.txt`, schema,
  repository; an **Open problems** box (status open or conjecture, plus each manifest's
  `open_problems`: now `thm-h` and `thm-u`) with statements; the **claims table** (id,
  label, kind, status badge with the gloss as tooltip, scope, note), filterable by status,
  note and free text, and by `?status=` / `?note=` in the URL; the status vocabulary with
  glosses, parsed from the schema so it has one source.
- **`graph.html`**: d3 7.8.5 from cdnjs; nodes coloured by status (colours from CSS
  variables, so dark mode follows), arrows from a claim to the claims that use it, laid
  out in levels by longest dependency chain (foundations at the top), dashed arrows for
  `supersedes`, grey nodes for cited claims of notes with no published manifest yet;
  pan, zoom, drag, hover for full label, click to open the claim page; a legend; a
  `<noscript>` note and a collapsible plain list of the same edges.
- **`claims/<note>/<claim>.html`** (32): label, the statement in a box edged in the
  status colour (MathJax 3.2.2 from cdnjs; statements, details and notes go through
  pandoc so Markdown and TeX render), then Identifier, Kind, Status with gloss and
  detail, Scope and hypotheses, Depends on and **Used by** (computed), Supersedes /
  Superseded by, Artefacts (reports linked to their pages, ledgers to the copies on the
  site, `private:` paths shown as unpublished, size, sha256, regenerate command, note),
  Formal, Provenance (written by, checked by, "Read line by line by a person: **no**",
  date, log), Notes, Source (note and manifest JSON). JSON-LD: a `CreativeWork` with
  `identifier`, `genre` (kind), `creativeWorkStatus`, `text`, `isBasedOn` (its
  dependencies), `isPartOf` the note as a `ScholarlyArticle`, `subjectOf` the manifest.
- **`notes/index.html`** and **`notes/<slug>.html`** (10): the table of notes (title,
  the "contribution" cell of the notes README, date, manifest, PDF). Each note page is
  pandoc (`--standalone`, MathJax, `--toc` in a collapsible box, `--citeproc` with
  `notes/refs.json` and the New Oxford CSL), headed by links (PDF, manifest JSON and
  YAML, Markdown source), the README's certification cell, and the list of the note's
  claims with badges (or "no published claims manifest yet"). Code spans
  `docs/reports/X.md` become links when X is published. JSON-LD `ScholarlyArticle` with
  `hasPart` (one `CreativeWork` per claim) and the PDF as `encoding`. PDFs are copied
  into `docs/notes/`.
- **`reports/index.html`** and **`reports/<name>.html`** (44): newest first, with title,
  file name and the claims that cite each report; each page notes it is published as
  written and lists the citing claims. JSON-LD `Report`.
- **`certificates/index.html`**: per ledger, a table by statement, cell and tag:
  queries, UNSAT, SAT, DRAT verified by drat-trim, proofs kept, proof size; the
  ledger's own sha256; the citing claims; the raw `.jsonl` and `_sha256_` files are
  copied alongside. Totals now: h28x 114 queries, 114 DRAT-verified; h74x 405 queries,
  156 DRAT-verified (the 155 of the campaign plus one main-loop recheck at (7,7,7)).
  The statement letter is the ledger's `stmt`, or for h74x the letter in the query
  name.
- **`llms.txt`** (summary blockquote, the status vocabulary, a caution to read
  `status_detail` and `scope`, the manifests, the full-text file, the schema, the notes
  with one line each from the README table and their PDFs, optional links);
  **`llms-full.txt`** (every manifest as JSON with a header per note);
  **`manifests/<slug>.json`**; **`schema/manifest.schema.json`** (copied so the
  schema's own `$id` URL resolves on Pages); **`sitemap.xml`** (91 URLs).
- **`style.css`**: one file, light and dark, phone-width layout, no framework.

# Draft manifests (for review; not on the site)

Written by three Opus sub-agents from each note and the README; validated here; `curl-reduction/thm-p` spot-read.

| note | claims | open problems | "draft; to be confirmed" |
|---|---|---|---|
| curl-reduction | 12 (thm-p, lemma-a, lemma-l, lemma-c, thm-2d, thm-h as certificate campaign, p1 conjecture, ...) | p1 | none |
| periodicity-certified | 9 (l2-periodic, l3-periodic certified; l4-incomplete open; ...) | l4-incomplete, periodicity-conjecture | none |
| frozen-theorems | 10 (thm-1, thm-2-frozen certified via Lean; count proved-unchecked) | none | none |
| sector-logconcavity | 10 (real-root-counts certified by Isabelle; not-real-rooted computed) | support-realisation, logconcavity-general | none |
| sign-gauge-obstruction | 7 | none | none |
| giant-component | 7 (nf-g conjecture; unrestricted form refuted) | nf-g | none |
| measurement-z | 9 (exponent explored) | matching-gap-bound | none |
| helicity-mode | 7 | cell-123 | none |
| method | 5 findings, all kind fact | none | all five |

What the drafters flagged for the main loop:

1. `docs/notes/README.md` is inconsistent with itself: "Where the older notes are
   superseded" says periodicity holds on cubic sides one to six, open at seven; the
   table and the 1 October paragraph say side eight. The drafts quote "one to six"
   where they cite that paragraph. The paragraph needs updating (not mine to edit).
2. The README says Theorem P was "corrected to require every extent at least two";
   `curl-reduction`'s Theorem P already has that hypothesis. The correction was to
   the periodicity chain as `theorem-h-orientation`'s first draft stated it.
3. Two incompatible statements are both called "Theorem H" (curl-reduction: six
   directions imply even curl; theorem-h-orientation: an axis empty or one-way). No
   `supersedes` link was drawn; consider one, or a note on `theorem-h-orientation/thm-h`.
4. sector-logconcavity: the abstract says all 24 real-root verdicts are certified in
   Isabelle; the body certifies 13 in full and only a root-count deficit for the other
   11, whose "not real-rooted" rests on a Python squarefreeness computation. The
   draft splits it (certified / computed); the README repeats the abstract's wording.
5. CPOG model counts were given `certified`, though the schema's gloss names only
   DRAT, LRAT, Lean and Isabelle.
6. `checked_by` in the drafts lists second enumerators and decision procedures named in
   the notes, which are not independent agents.
7. The method note's status words are not the schema's; some artefacts are directories or globs.

# What I would change in the schema

The schema is unchanged. Suggestions, most useful first:

1. **`certified` should name the checkers it admits, CPOG included** (or say CPOG
   counts are `computed`). Two drafts depend on the answer.
2. **Separate independent readers from cross-checks.** `checked_by` is defined as
   "independent checkers that read it with their own programs", but the older notes'
   evidence is second methods in the same codebase. Add an optional `cross_checks`
   list (second enumerator, three decision procedures, drat-trim) and keep
   `checked_by` for independent readers. Today `drat-trim` sits in `checked_by` in the
   real manifest.
3. **A machine-readable cell list.** `scope.cells` is free text; an optional
   `cells_list` (array of `[a,b,c]`, plus a `family` string for infinite families)
   would let a reader or a tool ask "does this hold on (6,6,9)?".
4. **Artefact patterns.** Allow `kind: directory` or a `glob: true` flag, since notes
   cite directories and globs.
5. **A status for findings about practice** (the method note), or leave that note
   without a manifest.
6. **`definition` with status `proved`** (the real manifest's `model`) reads oddly; a
   `defined` status, or allowing `status` to be omitted for definitions, would be clearer.
# What is left

- Create `lyndondrake/ice-mixing-notes` on GitHub (public), push `publish/` as its root
  (the sync is file-level; a `git subtree split --prefix=publish` or a fresh clone
  with `rsync` of `publish/` are both possible), and set Pages to "Deploy from a
  branch", `main`, folder `/docs`.
- Decide whether the private repository tracks the generated `publish/docs/` or ignores it.
- Zenodo: enable the GitHub integration for the public repository, cut a release
  (tag), let Zenodo mint the DOI, then record it in `CHANGELOG.md`, each manifest's
  `doi`, and `CITATION.cff` (`doi:`, `version:`, `date-released:`). Add `.zenodo.json`
  if the deposit metadata should differ from `CITATION.cff`.
- Review the nine drafts against the log and promote them to `manifests/`.
- Seven older reports contain absolute paths to home directories (`~/...`,
  `~/...`): `2026-08-11-stage1-falsifiers`, the five `2026-09-04-*`
  in the list, `2026-09-17-completeness`. Harmless but personal; publish as written
  or redact in the copies.
- `notes/README.md` is published (as the brief asks) but contains private build
  instructions (`docbuild.sh`, Spark paths); the site does not render it.

# Rules kept or broken

- Kept: wrote only under `publish/` and `scripts/publish-notes.sh`; did not modify
  `docs/`, `formal/`, `experiments/`, `LOG.md`, `HANDOVER.md`, the root README or any
  existing script; Python from the project venv; temporary files in `.tmp/`; no `/tmp`;
  no commits; no network fetches (cdnjs URLs are only written into the HTML); UK
  English and no em-dashes in what I wrote (checked by grep); no statuses, checkers or
  hashes invented: the site renders what the manifests say, the certificate counts are
  computed from the ledgers, and the drafts were held to the notes and the README.
- Departures: the brief said `pandoc --mathjax`; pandoc 3.11 deprecates the flag, so
  the builder uses the equivalent `--math-method=mathjax:URL`. The first draft-manifest
  sub-agent was dispatched with an unfilled placeholder for its notes; it wrote nothing,
  and I sent it the three slugs. I edited one drafter's output (`method.yaml`: a
  directory artefact `reports/` became `private:docs/reports/`) so the drafts validate.
  The test fixture in `manifests/_test/` is in the public tree; delete it before the first push if unwanted.
