---
title: "Independent check of H ⇐ K_u + Lemma O + (R⁺) + (S≥1): confirmed with corrections (no gap; one mis-cited input, one unexercised case, two standing remarks)"
author: "Claude (Opus), agent check, for Lyndon Drake"
date: 2026-09-27
---

**Verdict: CONFIRMED WITH CORRECTIONS.** Every proof in rphand §1–§4 and in the two borrowed theorems (Theorem D, w1prime §4; Theorem LC, wprime §2) is complete for the hypotheses it states. I found no gap. The corrections are to a citation and to how the inputs' standing is worded; none changes the reduction.

Scripts (new, mine): `scratch_h/h270_cage.py` (cage check from the definitions, no geometry imported), `h271_corpus.py` (corpus audit; imports only `Cell`, `eps_from_types`, `load_odd_corpus`), `h272_sat.py` (solver attacks; own encoding of one-hot, (T2), bond rule, oddness, three types and the three laws as switchable constraints; every solve through `h32_cap`). No existing file was modified. Nothing was committed. Everything ran on this Mac, one solver process at a time.

## 1. Statement-by-statement audit

| statement | hypotheses stated | hypotheses actually used | verdict |
|---|---|---|---|
| Lemma T | frozen, reversing pair (m; u, v) | P^z at O; τ(m) = x ≠ z | complete |
| Lemma St | as T | law C, (T2) on one hexagon (O, σ), Lemma T (all four bridgeheads z) | complete |
| sign pattern | as T, plus straightness | bond rule on 6 bonds; checked vector by vector (m→u d₀, m→v d₃, r→u d₂, r→u′ d₃, r′→v d₁, r′→v′ d₀; straight-y via (0,±2,2)) | complete |
| Lemma sP | frozen, oriented hole | exhaustive cage enumeration; ε determined up to flip on the connected 12-bond cage graph | complete; **reproduced independently** (§3.1) |
| Theorem sLC | every S′-hole oriented | sP on every S′-hole of each hole k-line (telescoping, sign s_k = σ_{S′}s_is_j); no wrap-around needed | complete |
| two-product lemma | P, Q ≥ 0 separable on X × Y, PQ ≡ 0, neither ≡ 0 | min P = 0 because Q ≢ 0; zero sets products of argmins; the rows b ∉ J_P exist because P ≢ 0 | complete |
| stripe theorem | every hole oriented, (S) on the S k-lines | LC and sLC (so orientation of S′-holes), (S) for PQ = 0; the index set of S k-lines is the full product (S-parity)² | complete. The stripe direction is unique (both directions would make P, Q constant, contradicting PQ = 0 with neither zero) |
| (S) = Lemma O gap 0 + (S≥1) | — | at a straight-k hole with rods v, v + 4e_k, "exactly one away" ⟺ ε(v) = ε(v + 4e_k); consecutive pairs on the cyclic line are gap 0 or gap ≥ 1 | correct |
| Lemma E | F k-free, neighbours single-signed and opposite (or one free); holes of F oriented in the two-sided case | P^k at the holes of F (methylenes in F), sP (two-sided only), the two s_n = +1 bridgeheads have opposite s_k | complete; orientation needed exactly where stated (solver, §3.3) |
| Theorem RP₁ | odd, three types, Lemma O, (S≥1), (R⁺) | steps 1–3: T, St, sign pattern, stripe theorem on B (Lemma O at all A-holes for sLC, at straight B-holes for (S)), (R⁺); step 4: Lemma E (Lemma O at the holes of F); step 5: Theorem D (odd, three types) on both sides | complete. Steps 1–3 need no oddness beyond the laws: with the laws imposed as constraints and no oddness, "a type-z vertex in the predicted plane" is UNSAT (and is already type-only UNSAT, rphand's W_r) |
| Theorem W, Case 1 | odd, three types, Lemma O, (R⁺), (S≥1) | stripe theorem on S (direction n); (i) from (R⁺); (ii) from the stripe theorem on S′ plus (i); cyclic choice c₁ → c₂, c*, c** | complete (see §2.2 for the check of the cyclic argument) |
| Theorem W, Case 2 | as above | LC zero sets (min h^A = 0 because B ≠ ∅), (R⁺), a full A-plane never adjacent to a full B-plane; F one-sided, so Lemma E needs no orientation | complete, but **never exercised** (§2.3) |
| Theorem D (w1prime §4) | A-plane c k-free, (E′) at it (upper pair), odd, three types | (i) Lemma 2(b); (ii) P^k at the B-holes of plane c+1; (iii) S1 on the B j-grid c+1, then M′ via inversion, using odd and three types; (iv) diagonals of one B-plane always meet (checked: 4n ≡ Δi + Δk mod 4L is solvable because Δi + Δk ≡ 0 mod 4) | complete. Needs (E′) at plane c on the one side only. Odd and three types are used only in (iii) |
| Theorem LC (wprime §2) | frozen (one-hot + (T2)) | P^k derived from (T2) by Σ_σ σ_k; telescoping along S′-hole k-lines | complete; P^k re-verified on all 1200 cage patterns (3600/3600) |
| Corollary (H) | odd; K_u, Lemma O, (R⁺), (S≥1) | absent type ⇒ empty axis ⇒ an absent direction (trivially); otherwise every axis is two-way, then Theorem W, then a complete type-k n-chain (one sign by the bond rule: same-type neighbours share a sign), then K_u | complete; **cites the wrong Lemma A** (§2.1) |

Specific points the brief asked about:

- **(S) where only (S≥1) was assumed.** (S) is used in the stripe theorem (PQ = 0) and in RP₁ step 2. In both places Lemma O is also assumed, and (S) = Lemma O at straight holes + (S≥1) is exact. No illegitimate use.
- **Lemma O at holes whose orientation was not established.** Every use is inside "odd, Lemma O" (all holes). Lemma E's one-sided case uses none, which matters because Case 2 relies on it.
- **Index sets.** The two-product lemma is applied to (h ± s)/2 on the S k-lines, indexed by (x_i, x_j) ∈ (S-parity)²: a full product. Case 2 applies the zero-set argument to LC counts on the same index set.
- **Sublattice and side bookkeeping for Theorem D.** A B-plane F is carried to an A-plane by the inversion v ↦ (1,1,1) − v. The lower side is carried to the upper by a two-coordinate flip, for example (x,−y,−z) with y the normal: I checked that it maps A to A, B to B (since (1,1,1) ↦ (1,−1,−1) = d₁) and the bond set to itself. Both maps preserve types and (T2). The needed (E′) on the lower side is supplied by Lemma E, which gives both sides.
- **"three types" and "odd" where D(iii) uses S1 and M′.** Available in RP₁ and Theorem W by hypothesis. In the Corollary the two-type case is split off before Theorem W is invoked. The solver shows both hypotheses are genuinely needed (§3.3: D's negation is SAT without either).

## 2. Corrections and remarks

### 2.1 Correction: the Corollary cites Lemma A for the absent-type case

rphand §4 says: *"If a type is absent, Lemma A."* The synthesis (§1) lists "Lemma A (two-type states)" among the proved inputs. The Lemma A of record (`docs/frozen-structure-2026-09-05.md`, "a missing type forces a half-box period") concludes a translation invariance, not an absent direction. The trails report's Lemma A is unrelated. **Repair:** none is needed, because a missing type k is an empty axis k and both ±e_k are absent, so the case falls under the next sentence ("if some axis is one-way or empty"). Delete the Lemma A clause from the Corollary, and delete Lemma A from the synthesis' list of inputs. (Lemma A is still needed for the periodicity conjecture from H, but not for H.)

### 2.2 Theorem W, Case 1: the cyclic argument

I re-derived it and checked it as written on the corpus (`h271`, "W1" rows):

- the S-stripe direction exists;
- (i) holds;
- (ii) holds: every plane along n, of either sublattice, has at most one label;
- the construction (a + S-plane c₁, the next non-empty S-plane a − plane c₂, c* the last + plane in [c₁, c₂), c** the first non-empty plane after it) always gives a − plane c** with c** ≥ c* + 2;
- F = c* + 1 is on the wall list.

Adjacency is excluded in each of the three possible parities of (c*, c**), by (i) or its mirror, so F is k-free. Its neighbours are c* (+) and c* + 2 (0 or −), as claimed. No correction.

### 2.3 Remark: Case 2 of Theorem W is vacuous in every tested setting

No two-way axis in the corpus is in Case 2 (807 / 807 and 1007 / 1007 two-way axes are Case 1). With my encoding, "z two-way, A's type-z vertices all +, B's all −" is **UNSAT** under the three laws as constraints (L = 3: 0.15 s; L = 4: 0.89 s), and also under odd + three types alone (0.14 s; 0.30 s). The written argument for Case 2 is correct, so this is not a gap. It does mean the case has no data behind it. It is probably provably empty (from (R⁺) and Theorem Ω, say), which would shorten the proof. I have not proved that.

### 2.4 Standing of the inputs (task 5)

- **Lemma O in odd states ⇐ Theorem U + corner case + cage enumeration: confirmed.** My independent cage enumeration (`h270`, sign form) gives:
  - 1104 of the 1200 (T2) patterns of a cage are oriented;
  - the 96 unoriented ones are all straight;
  - for rod axis r they are exactly the patterns whose two bridgeheads on one r-side have one transverse type and the two on the other side have the other type (16 per ordered pair, for each of the three axes);
  - no corner cage is unoriented, so the corner case also holds cage-locally.

  This is orient §3's statement, with the side grouping made explicit. The straight case then needs Theorem U, whose standing is solver-only at L = 3, 4, 5 with hand residue (V). My own sign-form query ("adjacent type-z vertices on one line with opposite signs") is SAT without oddness and UNSAT with it: L = 3 in 0.07 s, L = 4 in 1.62 s.
- **(S) = Lemma O (straight holes) + (S≥1): confirmed** (§1).
- **(R⁺) and (S≥1) hold without oddness at L = 3, 4: confirmed** with my own encoding (§3.3).
- **Wording to reconcile.** rphand §0 says Lemma R gives "the first two members" of (R⁺). rphand §9 and the synthesis say it gives "k-separation ≤ 3". One of the two should be corrected; I did not audit Lemma R.
- **K_u's scope.** rphand calls K_u simply "certified". The attack proposal records it as certified modulo Lemma L and the scope of the window certificates (a ≥ 3 and b, c ≥ 4, with the small cells by torus verdicts). The Corollary's "H" inherits that scope. I did not audit K_u, as instructed.

## 3. Independent computations

### 3.1 Cage check of Lemma sP (`h270_cage.py`, 0.38 s)

- **Model:** the ten cage vertices, the four hexagons found by searching all (A-hole, σ) whose six vertices lie in the cage, the twelve bonds, and (T2) as "exactly two of [τ(a_k) = k], [τ(b_k) = k]". The bond rule is solved by propagation.
- **Results, identical for A- and B-cages:**
  - 1200 (T2) patterns;
  - law C 1200/1200;
  - P^k 3600/3600;
  - bond rule consistent in all 1200;
  - 1104 oriented patterns, 0 sP violations;
  - 96 unoriented patterns, exactly 3 violations each (288).

### 3.2 Corpus (`h271_corpus.py`; L = 3: 637 states, 2.8 s; L = 4: 720 states, 6.8 s)

| check | L = 3 checks / failures | L = 4 checks / failures |
|---|---|---|
| Lemma O, every hole | 137 592 / 0 | 368 640 / 0 |
| (S) gap 0 | 60 258 / 0 | 190 470 / 0 |
| (S≥1) | 25 758 / 0 | 99 524 / 0 |
| (R⁺), all diagonal pairs | 388 728 / 0 | 1 533 656 / 0 |
| LC, sLC mixed differences | 137 592 / 0 each | 276 480 / 0 each |
| stripe theorem (one coordinate; never both) | 1565 / 0 | 1972 / 0 |
| two-way axis has a sign-separated wall | 807 / 0 (543 three-type, 264 two-type) | 1007 / 0 (727 + 280) |
| (E′) at every hole of every wall, both sides | 88 884 / 0 | 239 552 / 0 |
| Theorem D's conclusion beside every wall, three-type (type-k vertex on a uniform 4L-chain of the far slab) | 18 738 / 0 | 43 544 / 0 |
| same, two-type states (D not claimed) | 17 748 / 10 800 | 38 576 / 23 296 |
| Theorem W construction as written (Case 1; Case 2 never occurs) | 807 / 0 | 1007 / 0 |
| reversing pairs: opposite signs; O straight along τ(m) or j; m-plane with normal b k-free | 17 524 / 0 each | 36 524 / 0 each |
| RP₁ member on a uniform b-chain, three-type | 10 552 / 0 | 20 552 / 0 |
| same, two-type (D's alternative) | 24 496 / 14 244 | 52 496 / 31 344 |

A chain is the component of a vertex in the 2-regular bond graph between two adjacent planes, computed directly rather than from Lemma 1's formula. Every chain had 4L vertices. The two-type failure counts reproduce rphand §6's 14 244 and 31 344 exactly.

### 3.3 Solver (`h272_sat.py`, CaDiCaL via `h32_cap`)

A three-type state is required only where marked "three". "Laws" means Lemma O at every hole, faithful (S≥1) (no type-k vertex between, at least one vertex between) and (R⁺), all imposed as clauses, with no oddness.

| query | L = 3 | L = 4 |
|---|---|---|
| (R⁺) negation, no oddness | UNSAT 0.02 s | UNSAT 0.36 s |
| control: origin z+, a diagonal z present | SAT | SAT |
| (S) gap 0 negation, no oddness | SAT | SAT |
| (S) gap 0 negation + odd (Lemma O, straight) | UNSAT 0.07 s | UNSAT 1.62 s |
| (S) gap 1 negation, no oddness | UNSAT 0.01 s | UNSAT 0.04 s |
| (S) gap 2 negation, no oddness | — (L = 3 has gap ≤ 1) | UNSAT 0.01 s |
| controls: same gaps, same sign | SAT | SAT |
| **Theorem W: z two-way, no sign-separated wall, laws** | **UNSAT 60.1 s** | **TIMEOUT at 540 s** |
| same + three types | UNSAT (after learning) | not run |
| control: z two-way, laws | SAT 0.00 s | SAT 0.11 s |
| control: no wall, z two-way, no laws | SAT 0.06 s | — |
| control: no wall, (S≥1) + (R⁺) without Lemma O | SAT 0.04 s | TIMEOUT (same batch) |
| no wall, Lemma O alone | UNSAT 57.5 s | — |
| no wall, odd + three types, no laws | UNSAT 168.5 s | — |
| RP₁ (c), straight-x: type z in the A-plane y = 0, laws | UNSAT 0.01 s | UNSAT 0.12 s |
| RP₁ (c), straight-y: type z in the A-plane x = 0, laws | UNSAT 0.00 s | UNSAT 0.08 s |
| reversing-pair frame, neither straight-x nor straight-y (Lemma St) | UNSAT | UNSAT |
| controls: frame + straight-x / straight-y, laws | SAT | SAT |
| Lemma E negation (F free, y = ±1 sign-separated, pair disagreement at one hole, orientation at F's holes only) | UNSAT 0.00 s | UNSAT 0.00 s |
| control: same without orientation | SAT | SAT |
| one-sided (y = −1 free), disagreement, no orientation | UNSAT | UNSAT |
| Theorem D negation (F free, (E′) at F, w₀ = (1,1,1) type z, its up-chain not all z, odd, three) | UNSAT 0.24 s | UNSAT 2.21 s |
| controls: D negation without three types / without odd | SAT / SAT | SAT / SAT |
| Theorem W Case 2 (A all +, B all −, z two-way), laws | UNSAT 0.15 s | UNSAT 0.89 s |
| Case 2, odd + three types (no laws) | UNSAT 0.14 s | UNSAT 0.30 s |

Reading:

- **No intermediate statement could be broken.** Every counterexample query that the reduction predicts to be UNSAT came back UNSAT, each with a satisfiable control, except the L = 4 wall query, which is undecided at the 540 s cap. At L = 3 that query is UNSAT with the laws as constraints and no oddness. The existence of the wall therefore rests on the laws alone, as the proof says, not on oddness.
- Lemma E needs orientation exactly in its two-sided case.
- Theorem D needs both oddness and three types, as §6 of rphand says.
- A side observation: at L = 3, Lemma O alone (as a constraint) already forces the wall. This does not bear on the proof.

Not run: the L = 5, 6 samples of rphand §7, and the L = 4 wall query beyond 540 s, which would need more than the 10-minute foreground budget.
