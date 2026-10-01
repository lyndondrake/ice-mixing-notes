# The chain from Theorem U to periodicity, in Lean 4

A standalone Lean 4 formalisation of the diamond-lattice ice model on a general
cell `(a, b, c)`, of the lemmas of the chain from Theorem U to the periodicity
conjecture that are proved by direct combinatorial arguments, and of the
remaining statements of the chain as a blueprint: formal statements whose
proofs are left open (`sorry`), wired together so that the dependency structure
compiles and `#print axioms` shows exactly what each conclusion rests on.

The mathematics is in `docs/notes/theorem-h-orientation.md` (Theorems U, H, 1,
Lemma 21, the periodicity paragraph, Certification) and
`docs/notes/curl-reduction.md` (the model, Lemma A, Lemma C, Lemma L, Theorem P),
with the corrections of `docs/reports/2026-10-01-opus-pacheck.md`.

## What is here

| file | contents |
|---|---|
| `Periodicity/Basic.lean` | the model: points modulo the box, sublattices A and B, the bond vectors, holes, states, the ice rule, types and moments, hexagons `(O, d_j)`, reversals, curl, frozen, odd, rods and charge, translations, flux |
| `Periodicity/Lift.lean` | Lemma 21 (a state repeated periodically), for any pair of cells whose extents divide |
| `Periodicity/LemmaA.lean` | Lemma A on all three axes, Bézout, and the nonzero element `(0, 2g, 2g)` of `Λₓ` |
| `Periodicity/Flux.lean` | translation invariance of sums over the torus; the flux is four times the moment sum of either sublattice; zero flux makes a one-way axis empty |
| `Periodicity/LemmaL.lean` | Lemma L by the note's double count over the twelve slots at each vertex; the two forms of oddness agree |
| `Periodicity/Blueprint.lean` | Lemma C (proved); Lemma L and the flux balance (proved, from the files above); Theorem U, Theorem 1, Theorem P (stated); the derivation of periodicity (proved, with H and P as hypotheses); Theorem H descends along Lemma 21 |
| `Periodicity/Bridge.lean` | the bridge to `h730_lib`: hexagons as lattice walks on every cell; counts and distinctness on four cells |
| `Periodicity/BridgeT1.lean` | the bridge to `formal/theorem1`: the `(1,1,1)` matrix model, against theorem1's own definitions |
| `Periodicity/Thin.lean` | pacheck's `(1,2,2)` witness checked in the model: periodicity is false on that thin cell |
| `Axioms.lean` | `#print axioms` for every theorem (not part of the library) |

Core Lean 4 only: no Mathlib, no Batteries, no network. The toolchain is pinned
in `lean-toolchain` to `leanprover/lean4:v4.33.1`. The one dependency is
`formal/theorem1`, required by path (`lakefile.toml`) so that the bridge checks
the general model against theorem1's definitions themselves, not a copy. Lake
builds the four theorem1 modules it imports (`Basic`, `Decide`, `Structured`,
`Counts`, not `Brute`) into `formal/theorem1/.lake`. No theorem1 source file is
touched.

## How to check it

```sh
export PATH="$HOME/.elan/bin:$PATH"
cd formal/periodicity
lake build                  # about 36 s from scratch
lake env lean Axioms.lean   # about 1 s; prints the axiom dependencies
```

Measured on the primary Mac (Apple silicon), Lean 4.33.1, clean build:

| module | wall |
|---|---|
| `Periodicity.Basic` | 1.8 s |
| `Periodicity.Lift` | 2.4 s |
| `Periodicity.LemmaA` | 2.9 s |
| `Periodicity.Flux` | 2.1 s |
| `Periodicity.LemmaL` | 3.3 s |
| `Periodicity.Blueprint` | 1.2 s |
| `Periodicity.Bridge` | 18 s |
| `Periodicity.Thin` | 5.4 s |
| `Periodicity.BridgeT1` | 14 s |
| theorem1's `Basic`, `Decide`, `Structured`, `Counts` | 2.3 s, 2.6 s, 2.9 s, 10 s |
| **whole project, clean** | **36 s wall, peak RSS 2.2 GB** |
| `lake env lean Axioms.lean` | 1.3 s, 0.4 GB |

`native_decide` is not used anywhere. Every proved theorem depends only on
`propext` and `Quot.sound` (`hex_closed` on `propext` alone). There is no
`Classical.choice`: two core lemmas that bring it in (`Int.natCast_dvd_natCast`
and the `grind` tactic) are avoided on purpose. The three blueprint
statements (Theorem U, Theorem 1, Theorem P) and the two theorems that compose
them show `sorryAx`; nothing else does.

## Status of the statements

The `formal` field of the manifests should cite the declarations below by
these fully qualified names. **proved** means a Lean proof with no `sorry`,
axioms `propext` and `Quot.sound`. **stated** means a formal statement whose
proof is `sorry`, marked `-- BLUEPRINT: proof open` in the source. That marks
the proof as not yet formalised in Lean; it says nothing about its standing in
the notes, which the last column gives.

| statement (note, label) | Lean declaration | status | standing in the notes |
|---|---|---|---|
| theorem-h-orientation, Lemma 21 | `Periodicity.lemma21` | proved | proved; read by no checker before pacheck's re-test |
| theorem-h-orientation, Lemma 21, use in Theorem 24 (H descends to divisor cells) | `Periodicity.theoremH_of_repeat` | proved | proved |
| curl-reduction, Lemma A (axis x) | `Periodicity.lemmaA_x` | proved | proved; confirmed by pacheck |
| curl-reduction, Lemma A (axes y, z) | `Periodicity.lemmaA_y`, `Periodicity.lemmaA_z` | proved | "the same holds for y and z" |
| pacheck V2: `(0, 2g, 2g)` with `g = gcd(b, c)` lies in `Λₓ` | `Periodicity.gcd_mem_lamX` (`gcd_mem_lamY`, `gcd_mem_lamZ`) | proved | added by pacheck, 1 October 2026 |
| Lemma A with a nonzero translation, every cell | `Periodicity.lemmaA_nonzero` | proved | as used in theorem-h-orientation |
| curl-reduction, Lemma C | `Periodicity.lemmaC` | proved | proved |
| curl-reduction, remark after Lemma A (zero flux balances each axis on each sublattice); pacheck V2 | `Periodicity.fluxBalance` (statement `Periodicity.FluxBalance`; core `Periodicity.oneWay_empty_of_zeroFlux`) | proved | one-line proof by pacheck |
| curl-reduction, Lemma L | `Periodicity.lemmaL` (statement `Periodicity.LemmaL`; proof `Periodicity.lemmaL_proved`) | proved | proved; confirmed by pacheck |
| curl-reduction after Lemma L, and theorem-h-orientation (T2): odd curl iff the two reversals lie on one sublattice | `Periodicity.curl_iff_same_sublattice` | proved | proved |
| theorem-h-orientation, Theorem U | `Periodicity.theoremU` (statement `Periodicity.TheoremU`) | stated | open in general; proved on some cells, certified on others |
| theorem-h-orientation, Theorem H | `Periodicity.TheoremH` (definition of the statement) | stated | open in general |
| theorem-h-orientation, Theorem 1 (U implies H, every cell) | `Periodicity.theorem1` | stated | proved (form of 30 September 2026) |
| curl-reduction, Theorem P (extents at least two) | `Periodicity.theoremP` (statement `Periodicity.TheoremP`) | stated | proved, with P1's two linear-algebra steps checked by p1check |
| theorem-h-orientation, periodicity paragraph: H, P and A give periodicity | `Periodicity.periodic_of_chain` | proved | proved (pacheck V5 form) |
| the same, with the flux balance discharged | `Periodicity.periodic_of_H_P` | proved (hypotheses: H and P on the cell) | |
| periodicity from Theorem U | `Periodicity.periodicity_of_U` | stated (rests on `theorem1`, `theoremP`) | |
| the periodicity conjecture, extents at least two | `Periodicity.periodicity` (statement `Periodicity.Periodic`) | stated (rests on U, Theorem 1 and P) | open where U is |
| pacheck V5: periodicity false on the thin cell `(1,2,2)` | `Periodicity.not_periodic_122` | proved | solver witness, re-checked by pacheck |

## The model, and how it is tied to the notes and to the Python

Points are triples modulo `(4a, 4b, 4c)` in quarter-cube units. A state is a
bit on every bond `(p, k)`, with `p` an A point and `k` a direction. `true`
means the arrow points from A to B. The four bits at a vertex are `loc s v`.
At an A vertex they are the bits of its own bonds; at a B vertex, of the bonds
arriving there. The type is the axis of the pair of set bits. A hexagon is a
pair `(O, j)`: an A-hole `O` and `σ = d_j`, the note's `(O, σ)`. Its six bonds
in cycle order are `hexBond`. Frozen means ice plus no circulating hexagon. Odd
means some hexagon with odd curl, the curl being the sum of the six bits mod
2, as curl-reduction defines it. Charge counts the six methylene positions of a
hole, as the proof of Theorem 1 says to on cells with an extent of one.

The bridge establishes:

- **Hexagons, on every cell** (`Bridge.lean`). `walk_is_hexagon`: every closed
  non-backtracking six-walk of zero displacement with six distinct unwrapped
  vertices (`h730_lib`'s definition), started at any A point of any cell,
  traverses one of the model's hexagons bond for bond, up to rotation and
  reflection. `hexagon_is_walk`: every hexagon is such a walk.
  `validWalks_count`: there are 24 such walks from a vertex, that is, twelve
  hexagons through it in two senses.
- **Counts, on `(1,1,1)`, `(1,2,2)`, `(2,2,2)`, `(2,2,3)`** (`counts_111` and
  so on). `4abc` A sites and `4abc` B sites, disjoint, so `8abc` vertices;
  `16abc` bonds; `16abc` hexagons, the count `h730_lib` asserts; and distinct
  hexagons have distinct sets of six bonds.
- **The moment** (`Flux.lean`, `local_moment`). At an ice vertex the four
  signed bond directions add to `4 · (±e_type)`. So `typ` and `sgn` are the
  axis and sign of `d_i + d_j` for the pair of set bits, as curl-reduction
  defines the moment.
- **theorem1's matrix model** (`BridgeT1.lean`). `ice_iff_theorem1`: for every
  matrix, ice in the general model on `(1,1,1)` is theorem1's (R) and (B),
  proved for all `2¹⁶` matrices. `hex_to_theorem1` and `hex_of_theorem1`: the
  16 hexagons of each model are bond cycles of the other.
  `frozen_iff_theorem1` and `zeroFlux_iff_theorem1`: on every ice state,
  freezing and zero flux agree, checked over theorem1's 90 ice states, which
  theorem1 proves complete. Hence `ice_count_111` and `w0_count_111` (90 and
  12, through the bijection `ofMat`) and `frozen_111` (theorem1's Theorem 1,
  transferred). This closes theorem1's own trust boundary, "that the matrix
  model *is* the `(1,1,1)` cell", from the side of the general model.
- **A witness from the Python** (`Thin.lean`). pacheck's `(1,2,2)` state,
  entered in `h730_lib`'s bit order, is frozen, has zero flux and even curl,
  carries all six directions, and is fixed by no nonzero translation, all by
  `decide`. That fixes the bit order, ice rule, hexagons, curl, flux, moments
  and translations of the two models against each other on a state of `h730`.

The theorem-h note defines an odd hexagon by its two reversals lying on one
sublattice, curl-reduction by the parity of its bits. In a frozen state the two
agree (`curl_iff_same_sublattice`, from Lemma L), so `OddState` is the odd
state of both notes.

## Notes for anyone extending this

- `decide +kernel` evaluates in the kernel. All finite checks are kept small:
  the largest is `counts_223` (192 hexagons, 18,000 key comparisons). Do not
  enumerate states on cells larger than `(2,2,2)` by `decide`: a state of
  `(2,2,2)` has 128 bits.
- Translations are integer vectors acting by `wrap` (`x + d mod n`). The
  sublattice tests read only the residues mod 4 (`res`), so a membership fact
  about `p + v` is a `decide` over the 64 residues (`res_add`).
- Core Lean has no finite sums. `Flux.lean` builds the few needed: `sumFin`,
  `sumPt`, linearity, exchange with a sum over four directions, and
  `sumPt_translate`, the invariance of a sum over the torus under translation
  (and the integer forms in `LemmaL.lean`). A double count over the slots of
  hexagons, as in Lemma L or Law C, is a translation of such a sum by the
  offset from a hole to the vertex at a slot (`slot_sum`).
