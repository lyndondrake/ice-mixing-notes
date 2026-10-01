# Contribution notes

One stand-alone note per contribution of the project, each with a PDF,
written for a reader who wants the result and its proof or certificate
without the project's history. Build any of them with

    docbuild.sh -C docs/notes pandoc note-defaults.yaml <slug>.md \
      --bibliography=../../paper/refs/ice-mixing.json \
      -o <slug>.pdf

(The bibliography must be given on the command line: the academic profile's
own bibliography option overrides a YAML `bibliography` field.) On the Mac
the `csl` path in `note-defaults.yaml` does not exist (it is the Sparks'
`~/...`), so add
`--csl=$HOME/.local/share/pandoc/csl/new-oxford-style-manual-author-date.csl`.

There is one bibliography now, `../../paper/refs/ice-mixing.json`, which every
note's front matter names. It is **generated** — exported from the ld-agent
store by `scripts/export-bib.sh` — and replaced the project `.bib` plus the
nine per-note `<slug>.bib` files on 2026-09-14. Pandoc reads CSL JSON
natively, so only the filename changed. See `bib/README.md` for how to add or
correct an entry.

## The notes

| note | contribution | pages | certification |
|---|---|---|---|
| `measurement-z` | the exponent, z = 2.004 ± 0.060 over thirteen sizes to 221,184 spins, the 1/L² correction, the fixed-size test | 13 | none; exact gaps on enumerable cells anchor the estimator |
| `frozen-theorems` | frozen states exist at every size: Theorem 1 (the smallest cell is frozen) and Theorem 2 (the translation-frozen family, C(2c,c)² and the 16^L bound) | 16 | Lean 4 (both theorems, with the bridge to the simulation's hexagons), DRAT, CPOG-certified counts |
| `periodicity-certified` | every frozen zero-flux state of cubic L = 2 and L = 3 is periodic; L = 4 incomplete | 16 | two-method census at L = 2; cube-and-conquer with per-leaf LRAT and a DRAT cover proof at L = 3, with a manifest and an independent checker |
| `curl-reduction` | the periodicity conjecture reduced to a parity statement: Lemmas A and L, Theorem 2D and the profile lemma proved; Theorems H and P certified; slab sums | 14 | DRAT proofs checked by drat-trim (H on five cells, P on six including (4,4,4)); F₂ linear algebra and solver checks |
| `theorem-h-orientation` | Theorem H proved by hand on every cell with a coprime pair of extents and on the cells with two chains in every pair of planes; reduced to Theorem U alone on every cell (30 September; $K_u$ no longer a step); by certificates on the cubic cells of side one to eight and on four cells that are not cubic (1 October); the signed moments as currents along the chains; where the method stops at three chains; what is known about Theorem U | 70 | hand proofs, each read by an independent checker agent with its own programs; DRAT proofs checked by drat-trim for Theorem U′; the chain to periodicity read by two independent checkers on 1 October (Theorem P corrected: every extent at least two); no human line-by-line reading yet |
| `sector-logconcavity` | flux-sector counts are log-concave, the support is the even lattice in an octahedron, the marginals are not real-rooted at high degree | 11 | exact counts by two enumerators; Isabelle/HOL (Sturm's theorem) for the real-root verdicts |
| `sign-gauge-obstruction` | no sign gauge makes the bond correlations negatively associated: the three-bond certificate | 10 | an explicit finite obstruction, hand-checkable and reproduced by three decision procedures |
| `giant-component` | the giant-component conjecture with exact censuses and 27,000 certified flip paths | 12 | none; a conjecture with computational evidence |
| `method` | how the work was done: pre-registration and stage gates, the status vocabulary, the two-method gate, the certification ladder, the division of labour, the record; what the method caught and missed; generalisable findings | 6 | none; the evidence is the log, the handover file and the archived reports |
| `helicity-mode` | the slow even mode at the thin cell is the emergent magnetic helicity; absent as a slow mode in cubic geometry | 11 | exact spectrum by diagonalisation and symmetry analysis; no formal certificate |

`theorem-h-orientation` was revised again on 2026-10-01 and its PDF
rebuilt: Theorem 2 now reaches the cubic cells of side eight and four
cells that are not cubic (a search for a counterexample to Theorem U
found none); the chain from Theorem H to periodicity was read by two
independent checkers, and Theorem P corrected to require every extent
at least two, the thin cells $(1,b,c)$ being counterexamples to the
conclusion without it; a ninth item on Theorem U closes the plan of 30
September; the closed-form certificate of the first step of $K_u$ is
recorded. It was revised on 2026-09-28 and its PDF rebuilt
from the revised text. On 2026-09-30 one item was added to its
section on Theorem U, recording the rounds of 28 and 29 September on
the closure of the sheet (no proof); later that day Theorem 1 was
given its present form, **Theorem U implies Theorem H on every cell**,
with Lemmas 22 to 25 (Theorem 6 across the three axes with Theorem 15
and the diagonal law), read by an independent checker, so that $K_u$
is no longer a step and Theorem U is the one open statement on cubic
cells; an eighth item on Theorem U was added and the PDF rebuilt
again. It was first issued on 2026-09-27 as a
reduction of Theorem H to one conjecture, and the PDF of that date was
wrong about $K_u$. The revision has a new title and abstract, a first
section that states what is proved with a table of the standing of
Theorem H by kind of cell, and five further sections: cells with a
coprime pair of extents (Lemmas 8 to 10, Theorems 12 to 15), the
linear structure of the signed moments (Lemmas 11 and 12, Theorems 16
to 19), cells with two chains in every pair of planes (Lemmas 13 to 20,
Theorems 20 to 23), a state repeated periodically (Lemma 21, Theorem
24), and three chains in every pair of planes, which states no theorem
and records where the method stops. Its last sections give the
standing of each result and a history of the note. The proofs of the
first three of those sections were read by independent checker agents,
and their corrections are in the text. Lemma 21 was tested exactly on
765 repeated states and has had no checker.

**Where the older notes are superseded.** `curl-reduction` and
`periodicity-certified` are of early September 2026 and are kept as
they were issued. Since then Theorem P has been proved for every cell
whose extents are all at least two (report `2026-09-17-p1-proof.md`,
with the hypothesis as `curl-reduction` states it; the first draft of
`theorem-h-orientation` dropped it and was corrected on 1 October
2026), so it no longer rests on certificates, and the standing of
Theorem H is that of the table in the first section of
`theorem-h-orientation`, which replaces what `curl-reduction` says of
it. The periodicity of frozen zero-flux states now holds on every cell
with all extents at least two that has a coprime pair of extents or
two chains in every pair of planes, and on the cubic cells of side one
to eight, with the four cells certified on 1 October and their
divisors. It is open on the cubic cells of side nine and more. On the
thin cells $(1, b, c)$ it is false.

Each note was drafted from the repository's reports and code with a
literature search whose entries were verified against fetched DOI or
arXiv records; statements that rest on the author's own arithmetic or
on prose rather than a results file are flagged in the text.
