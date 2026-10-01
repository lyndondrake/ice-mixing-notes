# Subagent report: stage-1 falsifiers (2026-08-11)

Provenance: Claude Opus subagent, dispatched for stage 1 only (census,
exact-gap ladder, invariant suite) per SPEC-addendum. Report reproduced
verbatim below. Fable review: construction validated (100/100 tests,
crystallographic anchor, two-to-three-method exact count agreement, the
quotient-graph trap caught and closed); the census finding — frozen states
in W=0 at every cell, persisting to arbitrary size by tiling — is REAL and
changes the project's framing: all gap/τ quantities are giant-component
quantities from here on. Also corrects the SPEC-addendum's ladder estimates
(bulk-entropy Pauling estimates undercount thin-cell sectors by 3.5–49×).

---

Verified to 12 significant figures. Stage 1 is complete.

## Report — Stage 1 falsifiers, ice-mixing

**Bottom line: no falsifier fired against the construction, but the census found a real and permanent obstruction — the chain is reducible on the full `W=0` sector at every system size.** All artefacts are at `~/repo/project/ice-mixing/`. Git untouched; no venv needed (numpy 1.26.4 / scipy 1.17.1 / pytest 9.0.2 already present).

### File inventory

| path | contents |
|---|---|
| `icemix/lattice.py` (385) | diamond cell (a,b,c), derived hexagon set, winding signs, translation + tiling maps, naive quotient-graph 6-cycles |
| `icemix/bits.py` (37) | popcount (numpy 1.26 has no `bitwise_count`) |
| `icemix/enumerate.py` (396) | DFS enumerator, frontier-DP counter, brute force, winding by polarisation and by explicit cut-plane |
| `icemix/chain.py` (220) | hexagon masks, fast + reference flippable predicates, sparse `P`, components |
| `icemix/spectrum.py` (104) | dense `eigh` and deflated Lanczos gap |
| `icemix/crystal.py` (216) | independent Fd-3m `16d` Wyckoff build + constructive isomorphism |
| `icemix/invariants.py` (244) | ice rule, winding, involution, reversibility, uniformity, detailed balance |
| `experiments/01_falsifiers/run_falsifiers.py` (649) | the run (283 s, heartbeat `progress.json`) |
| `experiments/01_falsifiers/make_summary.py` (462) | renders `summary.md` from `results.json` |
| `experiments/01_falsifiers/results/{results.json,summary.md,progress.json}` | 64 KB / 233 lines |
| `tests/` (7 files, 704 lines) | **100 tests, all passing, 184 s** |

### Actual vs estimated sector sizes (measured first, as required)

| cell | spins | ice states (exact) | Pauling est. | ratio | s/spin | `W=0` | methods |
|---|---|---|---|---|---|---|---|
| (1,1,1) | 16 | 90 | 26 | 3.5 | 0.2812 | 12 | 3 |
| (1,1,2) | 32 | 3,618 | 656 | 5.5 | 0.2561 | 388 | 2 |
| (1,1,3) | 48 | 181,122 | 16,808 | 10.8 | 0.2522 | 15,024 | 2 |
| (1,2,2) | 64 | 2,891,562 | 430,542 | 6.7 | 0.2325 | 221,628 | 2 |
| (1,1,4) | 64 | 9,765,378 | 430,542 | 22.7 | 0.2515 | 637,988 | 2 |
| (1,1,5) | 80 | 538,851,330 | 1.10e7 | 48.9 | 0.2513 | 28,686,512 | DP only |
| (1,2,3) | 96 | 3,076,306,362 | 2.83e8 | 10.9 | 0.2276 | 196,465,480 | DP only |

**The addendum's ladder estimates are substantially too low** — thin cells carry far more entropy per spin than the bulk 0.2027, and the excess grows as the cell thins. Independent methods: DFS enumeration, frontier/transfer-matrix DP (counts *and* the joint winding histogram, never materialising a state), and brute-force `2^16` at the smallest cell. All agree **exactly**, including full joint W-histograms. External anchor: (1,1,1) reduces to `K(4,4)`, whose ice states are the 4×4 zero-one matrices with row/column sums 2 — the classical **90**, reproduced. Axis permutations (1,1,3)↔(3,1,1) and (1,2,2)↔(2,2,1) agree. `(2,2,2)` skipped with reason (DP blows past 10.5M frontier keys; ~2e11 states).

### Census — flag this prominently

| cell | `W=0` | components | giant | giant frac | frozen |
|---|---|---|---|---|---|
| (1,1,1) | 12 | 12 | 1 | 8.3% | **12 (all)** |
| (1,1,2) | 388 | 70 | 160 | 41.2% | 68 |
| (1,1,3) | 15,024 | 540 | 3,360 | 22.4% | 528 |
| **(1,2,2)** | 221,628 | 205 | **221,424** | **99.91%** | 204 |
| (1,1,4) | 637,988 | 5,492 | 43,008 | 6.7% | 5,412 |

1. **Frozen states exist in `W=0` at every cell examined, and they persist to arbitrarily large cells.** Periodically tiling a small-cell frozen state gives, verified from scratch in the target cell's own hexagon set, a frozen `W=0` ice state of (2,2,2), (2,2,4), (1,2,4) and the 432-spin (3,3,3) — 10/10 cases. So the full `W=0` sector is **never** connected, `Δ=0` on it at every `L`, and every gap/τ in this project is a giant-component quantity. Density falls with size (0.092% at (1,2,2)), so it is measure-zero asymptotically but real at finite `L`.
2. **Disconnection is an aspect-ratio effect, not a chain defect.** Quasi-1D `(1,1,c)` cells shatter; the one cell with a 2-D cross-section, (1,2,2), has a 99.91% giant component with *only isolated frozen states* outside it.
3. Singleton components are exactly the frozen states in every case; no component ever straddles two winding sectors (checked over all 25/69/137 sectors at the three smallest cells). Global arrow reversal acts as a permutation of components and explains the equal-size component pairs.
4. **Caveat:** (1,2,2) is the *only* non-quasi-1D cell reachable by enumeration. Stage 1 says nothing about connectivity in the cubic geometry stage 3 will use.

### Exact gaps (all restricted to the giant component — stated loudly)

| cell | hexagons | states | λ₂ | Δ (per attempt) | 1/Δ | Δ·n_hex | method |
|---|---|---|---|---|---|---|---|
| (1,1,1) | 16 | 1 | — | no gap: sector wholly frozen | | | — |
| (1,1,2) | 32 | 160 | 0.992451 | 7.5488e-3 | 132.5 | 0.2416 | dense |
| (1,1,3) | 48 | 3,360 | 0.996780 | 3.2200e-3 | 310.6 | 0.1546 | Lanczos |
| (1,2,2) | 64 | 221,424 | 0.997436 | 2.5644e-3 | 389.9 | 0.1641 | Lanczos |
| (1,1,4) | 64 | 43,008 | 0.998408 | 1.5923e-3 | 628.0 | 0.1019 | Lanczos |

Sanity `Δ>0` iff connected: holds at all five cells (full-sector Δ = 0 to machine precision everywhere). Lanczos vs dense agree to 0 in double precision where both ran; the (1,2,2) headline was re-verified by 60,000 power iterations on the deflated operator — **agrees to 12 significant figures**. (1,2,3) and (1,1,5): counted but not enumerated (≈4 h / 40 min DFS plus tens of GB), no gap — skipped with reason. These anisotropic anchors are **not** a `z` measurement.

### Invariants — all clean

- Ice rule + winding after **4,369,925** applied moves across five cells: 0 failures (64-spin cells capped at the first 200k states for budget).
- Flip is an involution preserving its hexagon's flippability: 0 failures. Fast 6-bit predicate vs a definition-level reference walk: 0 mismatches.
- `P` exactly symmetric and doubly stochastic at all five cells ⇒ exact detailed balance w.r.t. uniform. Empirical χ² on samples thinned by 20 exact relaxation times: p = 0.250 / 0.632 / 0.518; detailed-balance max |z| = 1.75 / 2.59 / 2.89.
- Trajectory at (1,2,2): 100k attempts, 8,678 moves, 0 ice/winding failures.

### Anomalies worth the supervisor's attention

1. **The quotient-graph trap.** Enumerating "hexagons" as 6-cycles of the periodic quotient graph is wrong on small cells: at (1,1,1) that graph is `K(4,4)` with **96** 6-cycles versus **16** real hexagons. All 80 extras are non-contractible, stay within the ice rule, and change `W` in **80/80** tested cases — exactly the silent flux-sector corruption the brief warned about. The implementation derives hexagons from adjacency *plus displacement*, and the derived counts (6 per bond, 12 per site, `n_hex = n_bonds = 16abc`) are asserted in tests alongside the hand derivation.
2. **(1,1,1)'s `W=0` sector is entirely frozen** (12 states, 12 components). Not a bug; the connected components at that cell all live in `W=±2` sectors.
3. Crystallographic anchor passed on four shapes ((1,1,1), (1,1,2), (1,2,2), (2,2,2)): constructive bijection, identical edge sets, degree 6, tetrahedra = diamond sites, matching adjacency spectra. A deliberate single-bond corruption is confirmed to break it.

### Timings

Full run 283 s wall (CPU only). Slowest items: DFS at (1,2,2) 32 s and (1,1,4) 45 s; axis-permutation DP checks 145 s; Lanczos ≤ 3 s. Test suite 184 s. Nothing exceeded the 10-minute per-computation budget.

### Recommendations for stage 2 (not started, per the gate)

1. Start every chain **inside the giant component** and record the convention — a uniformly drawn `W=0` state is unreachable 93% of the time at (1,1,4).
2. Measure the giant-component fraction at cubic `L=2` empirically before the campaign; enumeration cannot reach it.
3. Do not use the `(1,1,c)` gaps as `z` anchors.
4. Carry Δ in explicit units — attempt vs sweep differs by `n_hex = 16abc`.
