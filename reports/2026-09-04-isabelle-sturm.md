# Subagent report: Isabelle/HOL certification of the stage-4a real-root verdicts (2026-09-04)

Provenance: Claude Opus 5 (1M) formalisation subagent, dispatched by the
Fable main loop, 2026-09-04. Task: certify, in Isabelle/HOL and independently
of Python, the 24 real-rootedness verdicts that
`icemix.logconcave.real_root_counts` computes for the six stage-4a cells'
four marginal polynomials each. Compute: GB10 (spark, arm64), CPU only, no
GPU, no ARC (no ARC acknowledgement is owed); shared with three other
subagents on the same 20-core machine throughout. Artefacts: `formal/isabelle/`
(new: `ROOT`, `Squarefree_Nonreal.thy`, `Marginals_111.thy` …
`Marginals_123.thy`, `All_Marginals.thy`, `gen_theory.py`, `summary.json`,
`README.md`). **Every number in the generated theories is read straight out
of `experiments/04_lorentzian_giant/results/results.json` by
`gen_theory.py`; none is retyped by hand.** Nothing was committed; the main
loop commits. Nothing outside `formal/isabelle/` and this report was
touched.

---

## 0. Headline

All 24 marginal polynomials — degree, exact real-root count, and headline
real-rooted/not-real-rooted verdict — are **independently certified in
Isabelle/HOL 2025-2** (the AFP `sturm` method, Manuel Eberl's
`Sturm_Sequences`, an entirely different implementation from the Python
Sturm-sequence code in `icemix/logconcave.py`). **All 24 verdicts agree with
Python; zero disagreements.** This also independently re-certifies the four
verdicts pinned by
`tests/test_frozen.py::test_marginals_are_not_real_rooted_beyond_degree_four`.

Squarefreeness (`gcd p (pderiv p) = 1`, decided by `eval` over `complex
poly`) was additionally proved for the 13 of 24 polynomials with degree ≤ 8.
For the 6 of those that are *not* real-rooted, this squarefreeness feeds a
general reusable lemma (`Squarefree_Nonreal.nonreal_root_exists`, proved
once from the fundamental theorem of algebra) that produces an **explicit
non-real complex root witness** — proof that the real-root deficit is a
genuine complex root, not a repeated real root masquerading as one. The
other 11 polynomials (all degree ≥ 12) hit a hard `eval` performance wall on
squarefreeness (see §3) and fall back, as the brief explicitly licenses, to
a plain `card {x::real. poly p x = 0} < degree p` verdict with no
squarefreeness claim.

`isabelle build -d formal/isabelle -o threads=6 IceMixingSturm` exits **0**
in **0:10:08 elapsed (0:21:03 CPU, 6 threads)**, with no `***` error lines.

---

## 1. The 24-row verdict table

Degree, exact real-root count `k` (both independently derived by Isabelle's
`sturm`, not assumed), squarefreeness, verdict, and agreement with Python's
`real_root_counts`. "Squarefree" = "yes (ℂ)" means `gcd p (pderiv p) = 1`
was proved by `eval` over `complex poly`; "not attempted" means the brief's
licensed fallback was taken (see §3) — this is a scope decision, not a
failed proof.

| cell | marginal | degree | real roots `k` | squarefree | verdict | Isabelle lemma | agrees with Python |
|---|---|---:|---:|---|---|---|---|
| (1,1,1) | Wx | 4 | 4 | yes (ℂ) | real-rooted | `verdict_111_Wx` | yes |
| (1,1,1) | Wy | 4 | 4 | yes (ℂ) | real-rooted | `verdict_111_Wy` | yes |
| (1,1,1) | Wz | 4 | 4 | yes (ℂ) | real-rooted | `verdict_111_Wz` | yes |
| (1,1,1) | s111 | 4 | 2 | yes (ℂ) | NOT real-rooted (non-real root witness) | `verdict_111_s111` | yes |
| (1,1,2) | Wx | 8 | 4 | yes (ℂ) | NOT real-rooted (non-real root witness) | `verdict_112_Wx` | yes |
| (1,1,2) | Wy | 8 | 4 | yes (ℂ) | NOT real-rooted (non-real root witness) | `verdict_112_Wy` | yes |
| (1,1,2) | Wz | 4 | 4 | yes (ℂ) | real-rooted | `verdict_112_Wz` | yes |
| (1,1,2) | s111 | 8 | 4 | yes (ℂ) | NOT real-rooted (non-real root witness) | `verdict_112_s111` | yes |
| (1,1,3) | Wx | 12 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_113_Wx` | yes |
| (1,1,3) | Wy | 12 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_113_Wy` | yes |
| (1,1,3) | Wz | 4 | 4 | yes (ℂ) | real-rooted | `verdict_113_Wz` | yes |
| (1,1,3) | s111 | 12 | 2 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_113_s111` | yes |
| (1,1,4) | Wx | 16 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_114_Wx` | yes |
| (1,1,4) | Wy | 16 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_114_Wy` | yes |
| (1,1,4) | Wz | 4 | 4 | yes (ℂ) | real-rooted | `verdict_114_Wz` | yes |
| (1,1,4) | s111 | 16 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_114_s111` | yes |
| (1,2,2) | Wx | 16 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_122_Wx` | yes |
| (1,2,2) | Wy | 8 | 4 | yes (ℂ) | NOT real-rooted (non-real root witness) | `verdict_122_Wy` | yes |
| (1,2,2) | Wz | 8 | 4 | yes (ℂ) | NOT real-rooted (non-real root witness) | `verdict_122_Wz` | yes |
| (1,2,2) | s111 | 16 | 6 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_122_s111` | yes |
| (1,2,3) | Wx | 24 | 8 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_123_Wx` | yes |
| (1,2,3) | Wy | 12 | 8 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_123_Wy` | yes |
| (1,2,3) | Wz | 8 | 8 | yes (ℂ) | real-rooted | `verdict_123_Wz` | yes |
| (1,2,3) | s111 | 24 | 4 | not attempted | NOT real-rooted (`k<deg` only) | `verdict_123_s111` | yes |

Summary: 7 real-rooted (all four marginals at (1,1,1) except s111; Wz at
(1,1,2)/(1,1,3)/(1,1,4); Wz at (1,2,3)) and 17 not-real-rooted, matching the
brief's cross-check exactly. All 24 `n_real` values match
`icemix.logconcave.real_root_counts` output; **zero disagreements**. Raw
data: `formal/isabelle/summary.json`.

---

## 2. What each lemma actually proves

Per polynomial `p` (see `formal/isabelle/README.md` for the full
walkthrough):

- **`degree_<name>`**: `degree (p :: real poly) = n`, by `eval`. All 24.
- **`sturm_<name>`**: `card {x::real. poly p x = 0} = k`, by the AFP
  `sturm` method — a certified Isabelle decision procedure for Sturm's
  theorem, unrelated in implementation to the Python code. All 24,
  **including both degree-24 cases** ((1,2,3) Wx and s111) — `sturm` itself
  has no degree wall (§3).
- **`sqfree_<name>`**: `gcd (p :: complex poly) (pderiv p) = 1`, by `eval`.
  Only the 13 polynomials with degree ≤ 8.
- **`verdict_<name>`**: three shapes, chosen per polynomial by what's
  provable — see §0 and the README's "What is proved" section. The
  non-real-root-witness form is discharged by a single general lemma,
  `Squarefree_Nonreal.nonreal_root_exists`, proved once (not per
  polynomial) from:
  1. `coprime_pderiv_imp_rsquarefree` — a squarefree complex polynomial has
     no point where it and its derivative vanish together (via
     `poly_eq_0_iff_dvd` and `is_unit_iff_degree`).
  2. `rsquarefree_card_roots_complex` — combined with
     `size_proots_complex` (the fundamental theorem of algebra, already in
     `HOL-Computational_Algebra.Fundamental_Theorem_Algebra`), a squarefree
     complex polynomial has exactly `degree p` distinct roots.
  3. The main lemma: map the real polynomial into `complex poly`, note the
     image of its real roots under `complex_of_real` is exactly the subset
     of complex roots with `Im z = 0` (via the homomorphism identity `poly
     (map_poly complex_of_real p) (complex_of_real x) = complex_of_real
     (poly p x)`), and count: if the real-root count `k` is less than the
     total complex-root count `degree p`, some complex root has `Im z ≠ 0`.

This is a genuine formalisation, not a restatement of the Python output:
Isabelle proves each `card {...} = k` lemma from first principles via
Sturm's theorem (or refuses to, which would be a disagreement — none
occurred), and the non-real-root witness is constructed via the
fundamental theorem of algebra, independent of anything Python computed.

---

## 3. The squarefreeness/degree-12 wall — what was NOT done, and why

Part (c) of the brief asks for squarefreeness on all 24 polynomials, with
an explicit licence to fall back to (a)+(b) only "if squarefreeness proves
hard." It did.

**Empirical finding** (`formal/isabelle/probe_all/`, a 24-way parallel
probe run, `-j 3 -o threads=2`, 240s per-lemma timeout, since deleted after
use — the finding is recorded here): `eval` on
`gcd (p :: complex poly) (pderiv p)` — the executable subresultant-style
polynomial gcd in `HOL-Computational_Algebra.Polynomial_Factorial`
(`gcd_poly_code`, via `pseudo_mod` + `primitive_part` at each step) —

- **proves squarefreeness for all 13 degree-≤8 polynomials in 5–11
  seconds each**, including ones with 10-digit coefficients (e.g.
  (1,2,3) Wz, max coefficient 2,218,493,976, 8s);
- **times out (>240s) on all 11 degree-≥12 polynomials**, including ones
  with *modest* 5–6 digit coefficients (e.g. (1,1,3) Wx, max coefficient
  56,222, still failed).

So the wall is **degree, not coefficient magnitude** — isolated by testing
(1,2,3) Wz (degree 8, huge coefficients: 8s) against (1,1,3) Wy (degree 12,
modest coefficients: still timed out at 240s) and against `sturm` on the
same (1,1,3) Wy polynomial (19s — no problem at all). This points at
coefficient blow-up internal to the naive/subresultant-lite pseudo-remainder
sequence the code equation implements, not at the input size. A first
smoke test on the full (1,2,3) cell (all four marginals, degrees 8/12/24/24
together) hit a 20-minute session timeout at only 9% CPU utilisation,
consistent with the same blow-up (large intermediate rationals, not
compute-bound work).

**Decision:** attempt squarefreeness (and therefore the non-real-root
witness) only for degree ≤ 8 (`SQUAREFREE_DEGREE_LIMIT = 8` in
`gen_theory.py`); the 11 degree-≥12 polynomials get `degree_*` + `sturm_*`
only, with a `verdict_*` of `card {...} < degree p` and no squarefreeness
or non-real-root claim. This is the licensed fallback, not a proof failure
— nothing was attempted and abandoned mid-build; the scope was decided
before generating those 11 theories, from the probe evidence above.

**Not investigated further** (out of scope for this pass, flagged for
anyone who wants full squarefreeness on all 24): a modular/CRT-based gcd
algorithm, or computing squarefreeness over `int poly`/`rat poly` instead
of `complex poly` (untested — the wall was isolated on `complex poly`;
`rat poly` might behave differently, though the (1,1,3) Wy timeout was in
fact first observed on `rat poly` before the switch to `complex poly`, so a
different base ring is unlikely to help). `sturm` itself was never the
bottleneck at any degree tested (up to 24).

---

## 4. Build

Prerequisite (session heap for `Sturm_Sequences`, one-time):
```
isabelle build -b -o threads=6 Sturm_Sequences
```
0:03:58 elapsed (0:13:51 CPU), exit 0, tmux session `isabelle-sturm-build`.

Main build:
```
isabelle build -d formal/isabelle -o threads=6 IceMixingSturm
```
**0:10:08 elapsed, 0:21:03 CPU (factor 2.08, 6 threads), exit 0**, tmux
session `isabelle-final`, log `formal/isabelle/final-build.log` (kept — no
`***` error/warning lines). Isabelle 2025-2, AFP `afp-2025-2` (matching
component versions), `~/.local/opt/afp/thys/Sturm_Sequences`.

Regenerate the theories from `results.json` (never hand-edit the
`Marginals_*.thy` coefficient lists):
```
~/.pyenv/versions/3.12.13/bin/python3 formal/isabelle/gen_theory.py
```

---

## 5. Files

- `formal/isabelle/ROOT` — session `IceMixingSturm`.
- `formal/isabelle/Squarefree_Nonreal.thy` — the three general lemmas
  (hand-written, not regenerated).
- `formal/isabelle/Marginals_111.thy` … `Marginals_123.thy` — the 24
  polynomials' lemmas, six theories, one per cell (generated).
- `formal/isabelle/All_Marginals.thy` — imports all six.
- `formal/isabelle/gen_theory.py` — the generator; reads `results.json`
  directly, no hand-typed coefficients.
- `formal/isabelle/summary.json` — machine-readable per-polynomial record
  (degree, `n_real`, `n_distinct`, squarefree-attempted/proved,
  `verdict_kind`) — source of the table in §1.
- `formal/isabelle/README.md` — how to build and check, and the
  squarefreeness scope cut.
- `formal/isabelle/final-build.log` — the clean build log referenced above.

Not touched: anything outside `formal/isabelle/` and this report,
including the other subagents' concurrent work visible in `formal/theorem1/`,
`formal/theorem2/`, `experiments/07_certificates/`, `icemix/cnf.py` (not
mine — left as found).
