---
title: "Falsify: a whole-torus SAT search for a counterexample to Theorem U on (3,3,9), (4,4,8), (7,7,7), (8,8,8), (6,6,9) and (3,3,12); none exists, and Theorem U′ is certified on all six"
author: "Claude (Opus), agent falsify, for Lyndon Drake"
date: 2026-10-01
---

## Verdict

**UNSAT.** Every query of Theorem U′ completed UNSAT at every cell of the brief, the optional
two included: (3,3,9), (4,4,8), (3,3,12), (7,7,7), (8,8,8) and (6,6,9). Every query has a SAT
control whose witness was decoded and re-checked. **No counterexample** to U, to H or to the
periodicity conjecture exists on these cells (solver). With DRAT proofs checked by drat-trim
(`s VERIFIED`) and symmetries checked as clause-set identities, **Theorem U′, and so Theorem U,
is certified on all six cells (certified)**. By Theorem 1, **Theorem H holds on all six cells**.
By Lemma 21 it also holds on every cell whose extents divide one of them, coordinate-wise and
up to relabelling the axes. That adds open cells such as (3,6,9) and (4,8,8).

Status tags: **solver** = cadical verdict with no proof. **certified** = the CNF file is
refuted by cadical with a DRAT proof, drat-trim prints `s VERIFIED`, and any symmetry used is
checked as a CNF automorphism. **computed** = an exact computation with no solver verdict.

Total solver and checker wall: 6,353 s, about 106 minutes, inside the 3-hour budget. That is
191 s of pre-flight, 4,259 s of search (F2) and 1,903 s of certificates (F3). Each solve ran in
a child cadical process with a hard `subprocess.run` timeout, one at a time, on this Mac.

## F1. The query set

**The model.** It is the type-only model of h280 (`h280_certlib.Model`), generalised to any cell
in `h740_lib.GModel`:

- one-hot types;
- (T2) on every hexagon, as at most two and at least two of the six match literals, with no
  auxiliaries;
- an odd selector s(h) per hexagon, forbidding a match on A together with one on B.

The only change from h280 is in the geometry. It is built from `lattice.build(a, b, c)`, and the
minimal image uses each coordinate's own box (h280 uses box[0] for all three). **On (4,4,4) and
(5,5,5) the CNF is identical to h280's, clause for clause, in both the type-only and the
type-and-sign models, and the 16 U′ unit sets are identical to h282's** (`h741 --selftest`;
computed).

The type model has weaker hypotheses than a frozen state (no cocycle, no ice rule). So UNSAT
here covers every frozen state, and SAT would only be a candidate for the bond model.

**One query** at a cell (a, b, c) is given by:

- a rod axis k;
- the hole O = c0 + 2e_k, where c0 is the first vertex of the sublattice (A or B), so the holes
  are A + 2e_k for every k;
- an order (lower, upper) = (a, b) or (b, a) of the other two axes;
- a lower bridgehead i ∈ {0, 1}, at s_k = −1;
- an upper bridgehead j ∈ {0, 1}, at s_k = +1.

The units are t(O − 2e_k, k), t(O + 2e_k, k), t(lower_i, a) and t(upper_j, b). The query is base
∧ units ∧ (⋁_h s(h)). The control is base ∧ units, which is SAT, and its witness is re-checked
from positions: one-hot, (T2) counted, the units, and 0 odd hexagons.

That gives **16 queries per axis**: 2 sublattices × 2 orders × 2 × 2 bridgeheads. The cage on
axis k is h280's x-cage with x replaced by k (`gcage`). For k = x it is h280's cage exactly.

**What covers which.** FCC translations act transitively on the holes of each sublattice on
every cell, and they are checked as automorphisms (h743), so one hole per sublattice suffices.

- **Cubic cells (7,7,7), (8,8,8).** The cyclic permutation C (e_x → e_y → e_z) carries axis x to
  y and z. h283 re-run at L = 7 and L = 8 shows that T1 to T3, C, Tr, I and Rz are all
  automorphisms of the type-only + odd CNF, that the deliberate non-symmetry fails, and that
  the 16 hypotheses on axis x form **one orbit** (computed).
  - F2 ran all 16 on axis x directly.
  - F3 certified one per sublattice and order: 4 queries, as at L = 6.
- **Non-cubic cells (3,3,9), (4,4,8), (3,3,12), (6,6,9).** The transposition y ↔ z is not a
  symmetry, and C is not one either. Only the maps that permute equal extents survive.
  `h743_orbits.py` tried every signed permutation preserving the box, with shifts in {0..3}^3.
  It accepted 64 maps as clause-set automorphisms of the base CNF (all 64 site-preserving
  candidates) and found **3 orbits** of the 48 hypotheses on each of the four cells (computed):
  - 16 on axes x and y with (i, j) ∈ {(0,0), (1,1)}, both sublattices and both orders;
  - 16 on axes x and y with (i, j) ∈ {(0,1), (1,0)};
  - all 16 on the long axis z.

  So **the two bridgehead diagonals on the short axes do not reduce to each other**, and z does
  not reduce to x or y. On (4,4,4) the same program finds one orbit of all 48, as a control.
  - F2 ran all 48 queries (3 axes × 16) directly on every non-cubic cell.
  - F3 certified all 48 directly on (3,3,9), (4,4,8) and (3,3,12). On (6,6,9) it certified one
    representative per orbit: x A l0u0 yz, x A l0u1 yz and z A l0u0 xy.

**Encoding check on non-cubic cells** (`h742_corpuslift.py`; computed). Odd frozen corpus states
were repeated by Lemma 21: 60 states of (3,3,3) to (3,3,9), and 40 of (4,4,4) to (4,4,8).

- Every lifted state satisfies the full base CNF, with s(h) = [h odd], and has an odd hexagon.
- Straight holes with both rods of type k were found on every axis: (5796, 5640, 4710) on
  (3,3,9) and (12824, 5148, 6048) on (4,4,8).
- The full U′ pattern occurs 0 times.

**From U′ to U and H.** The unoriented cage is exactly a straight hole with bridgeheads aa/bb
(Lemma 3, an enumeration of one cage, which does not depend on the cell). It contains the four
U′ literals, so U′ on all three axes gives U on the cell, and Theorem 1 gives H.

## Pre-flight (F1), before any batch

One query plus its control, without proof logging (solver):

| cell | N | clauses | one query (s) | queries planned | projected (min) |
|---|---|---|---|---|---|
| (6,6,6) re-time | 1728 | 127,872 | 18.2 (record: about 20) | none | none |
| (3,3,9) | 648 | 47,952 | 0.9 (x), 2.0 (z) | 48 | 1.5 |
| (4,4,8) | 1024 | 75,776 | 6.5 (x), 5.1 (z) | 48 | 5 |
| (3,3,12) | 864 | 63,936 | 3.3 (z) | 48 | 2.5 |
| (7,7,7) | 2744 | 203,056 | 36.7 | 16 | 10 |
| (6,6,9) | 2592 | 191,808 | 32.8 (z) | 48 | 26 |
| (8,8,8) | 4096 | 303,104 | 84.7 | 16 | 23 |

The projected F2 total was about 68 minutes, so no query came near the 45-minute ceiling.

F3 was projected at about 40 minutes. Proof size grows with N: 0.9 to 1.3 GB at side 7 was
measured before side 8 was launched, and 2 to 3 GB was projected at side 8, under the 4 GB limit.

The caps were 300 s for the small cells, 600 s for (7,7,7) and (6,6,9), and 1200 s for (8,8,8).
None was reached.

## F2. Results (all solver; every control SAT, witness ok, 0 odd hexagons)

| cell | axis | queries | verdict | solve total / max (s) | controls | ctrl max (s) |
|---|---|---|---|---|---|---|
| (3,3,9) | x | 16 | 16 UNSAT | 16.9 / 1.4 | 16 SAT, ok | 0.10 |
| (3,3,9) | y | 16 | 16 UNSAT | 18.1 / 1.4 | 16 SAT, ok | 0.09 |
| (3,3,9) | z | 16 | 16 UNSAT | 35.8 / 2.6 | 16 SAT, ok | 0.10 |
| (4,4,8) | x | 16 | 16 UNSAT | 102.2 / 7.6 | 16 SAT, ok | 0.12 |
| (4,4,8) | y | 16 | 16 UNSAT | 114.8 / 8.0 | 16 SAT, ok | 0.10 |
| (4,4,8) | z | 16 | 16 UNSAT | 92.0 / 6.4 | 16 SAT, ok | 0.12 |
| (3,3,12) | x | 16 | 16 UNSAT | 29.9 / 2.5 | 16 SAT, ok | 0.10 |
| (3,3,12) | y | 16 | 16 UNSAT | 24.4 / 2.1 | 16 SAT, ok | 0.12 |
| (3,3,12) | z | 16 | 16 UNSAT | 57.5 / 4.3 | 16 SAT, ok | 0.19 |
| (7,7,7) | x | 16 | 16 UNSAT | 677.6 / 48.3 | 16 SAT, ok | 0.16 |
| (8,8,8) | x | 16 | 16 UNSAT | 1499.2 / 124.1 | 16 SAT, ok | 0.20 |
| (6,6,9) | x | 16 | 16 UNSAT | 502.7 / 35.3 | 16 SAT, ok | 0.18 |
| (6,6,9) | y | 16 | 16 UNSAT | 536.5 / 39.5 | 16 SAT, ok | 0.14 |
| (6,6,9) | z | 16 | 16 UNSAT | 524.5 / 34.9 | 16 SAT, ok | 0.46 |

There were 224 queries: 224 UNSAT, 0 SAT and 0 TIMEOUT. The 224 controls were all SAT.

The (7,7,7) solve times (37 to 48 s) are somewhat inflated, because the orbit program h743 ran
alongside the first queries; that was CPU contention, not a second solver.

## Witness section

None: no query was SAT, so the bond-model re-run, the two-way check (a) and the
conjecture search (b) did not arise.

## F3. Certificates (certified)

Each UNSAT query was re-run with a cadical DRAT proof and checked by drat-trim.

| cell | axis | queries | verdict | drat-trim | proof size (MB) | solve max (s) | drat-trim max (s) |
|---|---|---|---|---|---|---|---|
| (3,3,9) | x, y, z | 48 (all) | 48 UNSAT | 48 × `s VERIFIED` | 17.4 to 35.1 | 2.7 | 1.6 |
| (3,3,12) | x, y, z | 48 (all) | 48 UNSAT | 48 × `s VERIFIED` | 17.5 to 50.2 | 4.4 | 2.2 |
| (4,4,8) | x, y, z | 48 (all) | 48 UNSAT | 48 × `s VERIFIED` | 73.4 to 151.0 | 8.7 | 5.1 |
| (7,7,7) | x | 4 (A/B × yz/zy, l0u0) | 4 UNSAT | 4 × `s VERIFIED` | 864 to 1287 | 47.5 | 29.8 |
| (6,6,9) | x, x, z | 3 (one per orbit) | 3 UNSAT | 3 × `s VERIFIED` | 753, 753, 900 | 35.2 | 20.9 |
| (8,8,8) | x | 4 (A/B × yz/zy, l0u0) | 4 UNSAT | 4 × `s VERIFIED` | 1982 to 2916 | 123.2 | 69.5 |

What each cell's certificate rests on:

- (3,3,9), (3,3,12) and (4,4,8) are certified on every query directly, needing only the FCC
  translations.
- (7,7,7) and (8,8,8) are certified through the single orbit and C (h283 at L = 7, 8).
- (6,6,9) is certified through the three orbits of h743.

The two (6,6,9) x proofs have equal size (753,088,480 B) but different CNF and DRAT hashes.

**Files.** Proofs over 50 MB were deleted after checking, and their SHA-256 and size were kept.
96 proofs are kept, all from the three small cells. All CNFs are kept. Together the files take
2.9 GB in `scratch_h/certs/h74x_*`.

`.gitignore` now ignores `certs/h74x_*.cnf` and `certs/h74x_*.drat`. The verdict file
`certs/h74x_results.jsonl` (all 233 rows, pre-flight included) and the hash list
`certs/h74x_sha256_2026-10-01.txt` are not ignored. Nothing was committed.

## What this changes in the map

Theorem U, and with it Theorem H by Theorem 1, now holds by certificate on (3,3,9), (4,4,8),
(3,3,12), (6,6,9), (7,7,7) and (8,8,8). By Lemma 21 it also holds on every cell whose extents
divide one of these, up to an axis permutation. Examples are (3,6,9), (4,8,8), (2,8,8) and
(1,7,7).

This extends Theorem 2 and proves nothing uniform. Two facts bear on the hand route:

- The search found no near miss: every control is SAT in under 0.5 s, and every query is UNSAT
  in at most about 2 minutes.
- Solve time grows smoothly with N, from 1.4 s at N = 648 to 124 s at N = 4096. On a cubic cell
  it goes 2.4, 9.5, 18 to 22, 37 to 48 and 85 to 124 s from side 4 to side 8.

The K_u certificates of the first step already exist at sides 7 and 8, but they are no longer
needed (Theorem 1, form of 30 September).

## Scripts and timings

All the scripts below are in `experiments/08_frozen_structure/scratch_h/`. No existing script was
modified. h282 and h283 were re-run unchanged.

- `h740_lib.py`: the GModel encoding (h280 generalised to a cell (a, b, c)), `gcage` on any axis,
  and `uprime_queries`.
- `h741_uprime.py`: the runner. It does the control then the query, decodes and re-checks
  witnesses, and with `--drat` adds the DRAT proof and drat-trim. `--selftest` checks the CNF
  against h280 and h282. It writes rows to `certs/h74x_results.jsonl`.
- `h742_corpuslift.py`: the corpus lift encoding check.
- `h743_orbits.py`: the automorphisms and orbits on a non-cubic cell.
- `h744_summary.py`: the tables and the SHA-256 list.

The logs are in `.tmp/h741_F2_*.log` and `.tmp/h741_F3_*.log`.

Re-run any cell, from `scratch_h` with the brief's environment line:

```
h741_uprime.py 3 3 9 xyz all [--drat]
h741_uprime.py 8 8 8 x 0,0,0,0 0,1,0,0 1,0,0,0 1,1,0,0 --drat --cap 1200 --dcap 2400
h743_orbits.py 6 6 9
h283_symcheck.py 8
```

## Rules kept or broken

- **Kept:**
  - Mac only, with no `--host`.
  - Every solve and check in a child process with a hard timeout (`h280_certlib.run`).
  - One solver process at a time.
  - Nothing detached: long batches ran as harness background shells, sequential, each finishing
    before the next.
  - Whole-torus queries only: no windows, slabs or cuts.
  - No hand-proof routes touched.
  - New scripts numbered h740 to h744, with docstrings.
  - No existing script modified, and no commits.
  - The brief asked for proofs over 4 GB to be skipped. The largest was 2.9 GB, so none was
    skipped.
  - Solver and checker wall 106 minutes, inside the 3-hour limit.
- **Edits outside scratch_h:**
  - `.gitignore`: three lines for `certs/h74x_*`, as the brief allowed.
- **Deviation:**
  - Witness files would have gone to `.tmp/h741_witness_*.json`, not `.tmp/h74x_witness_<cell>.json`.
    None was written.
  - h743 ran alongside the (7,7,7) batch. It is a pure-Python CNF identity check, not a solver,
    but it slowed those solves.
