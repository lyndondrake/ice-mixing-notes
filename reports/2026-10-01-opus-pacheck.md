---
title: "Hostile check of Lemma L, Lemma A, Theorem P through P1, Lemma 21 and the chain H + P + A to periodicity, with independent programs: four confirmed, and the chain corrected on thin cells, where a frozen zero-flux state with no translation symmetry exists"
author: "Claude (Opus), agent pacheck, for Lyndon Drake"
date: 2026-10-01
---

## Verdicts

- **Lemma L: CONFIRMED.** The proof is correct on every cell; no hypothesis beyond frozen and ice.
- **Lemma A: CONFIRMED.** Correct on every cell, as `theorem-h-orientation` uses it; the lattice Lambda_k always contains a nonzero translation.
- **Theorem P: CORRECTED.** "Every cell" in `theorem-h-orientation` must read "every cell whose extents are all at least two", as `curl-reduction` states it. P1 itself holds on thin cells too, but the one-cube shift is then the identity. The two load-bearing linear-algebra steps of the P1 proof (completeness; ker L = S + G) were written by agents and re-run by the main loop. No independent checker has read them. I read the rank lemma of the second and found no gap. I did not read the first.
- **Lemma 21: CONFIRMED.** Exact re-test with my own code on 7 pairs of cells, both cubic and non-cubic, with unequal multipliers: 0 violations.
- **Chain: CORRECTED (REFUTED as written on thin cells).** On every cell with an extent equal to 1 and another at least 2, there is a frozen zero-flux state with trivial translation stabiliser. Witnesses by solver on (1,1,2), (1,2,2), (1,2,3), (1,3,3), (1,3,4) and (1,4,5) were re-checked with my own code. These cells have a coprime pair, so the sentence after Theorem 14 (line 1163) and the paragraph after the table (lines 186 to 191) of `theorem-h-orientation` are false as stated. With "all extents at least two" added, the chain is complete on the first three rows. The cubic cell of side one has no such state (direct solve, UNSAT), so the project's goal on cubic cells is unaffected.

## Programs

All scripts are new, in `experiments/08_frozen_structure/scratch_h`. Logs are in `.tmp/h732.log` to `.tmp/h737.log`.

- `h730_lib.py` is my own model, written from the note's definitions. It covers sites, bonds, and hexagons as non-backtracking closed six-walks of zero displacement, deduplicated modulo the box. It also covers ice, reversals, curl, moments, flux, translations, and the bond-rule reconstruction of a state from a type field. The only icemix use is decoding the saved states' index order into positions. Self-test: 16abc hexagons on (1,1,1), (1,2,2), (2,2,3) and (3,3,3).
- `h731_cnf.py` builds the CNF: ice, frozen, even, odd somewhere, a missing axis, zero flux (pysat cardinality), and no nonzero translation. Solves run through `h32_cap.run_batch`, one child at a time.
- The checks are `h732_lemmaL.py`, `h733_lemmaA.py`, `h734_p1.py`, `h735_profile.py`, `h736_lift.py` and `h737_thin.py`.

## V1. Lemma L

**Statement as read** (`curl-reduction`, l. 143): in a frozen ice state on any cell (a,b,c), every hexagon has exactly two reversals.

**Hypotheses:** ice and frozen. Flux, cell shape and the six directions are not used.

**Proof read (proved):**
- Each vertex lies on 12 hexagon slots, two per pair of its bonds: a pair is a two-step chain path, and the two remaining directions give the two hexagons.
- The vertex is a reversal exactly for the hexagons through its two kinked pairs (its in-pair and out-pair), so it is a reversal for 4 hexagons.
- Summing gives 4|V| = 32abc = 2|H|.
- Each non-circulating hexagon has an even number of reversals, at least 2, so it has exactly 2.

The count is by slots, so it survives small cells where vertices coincide.

The corollary used in `theorem-h-orientation` is also proved: odd curl iff the two reversals are at distance two, that is, on one sublattice.

**Check (computed, own code):** reversal count per hexagon, per-vertex reversal count (should be 4), and the curl/distance rule.

| source | states | L violations | per-vertex != 4 | curl-rule violations |
|---|---|---|---|---|
| saved hex corpus (3,3,3) | 32 (all odd) | 0 | 0 | 0 |
| h30 odd type lists (3,3,3) | 605 | 0 | 0 | 0 |
| h30 curl-free (3,3,3) | 605 | 0 | 0 | 0 |
| saved hex corpus (4,4,4) | 100 (all odd) | 0 | 0 | 0 |
| h30 odd (4,4,4) | 620 | 0 | 0 | 0 |
| h30 curl-free (4,4,4) | 620 | 0 | 0 | 0 |
| solver: frozen, frozen+odd, even on (1,1,1), (1,2,2), (1,2,3), (2,2,2), (2,2,3), (2,3,4), (3,3,3) | 156 | 0 | 0 | 0 |

All 1,210 h30 type lists admit a sign field under my bond rule. All decoded states are ice and frozen in my model, which also cross-checks the decoding.

## V2. Lemma A

**Statement as read** (`curl-reduction`, l. 84): an ice state on (a,b,c) with no vertex of type x is invariant under every translation in Lambda_x = (Z(0,2,2) + B) ∩ (Z(0,2,-2) + B). The same holds for y and z.

**Hypotheses:** the ice rule only. The proof uses neither freezing, flux, a cubic cell, even extents, nor anything about gcds.

**Meanings:**
- "Missing axis" means no vertex has type k.
- "Half-box symmetry" is the cubic special case, where Lambda_x mod the box is {0, (0,2L,2L)}.

**Proof read (proved):**
- A vertex is a kink of a {0,1} chain iff its type is x. I checked this from the pair table at A and at B.
- A kink-free chain keeps its sense, so all its d0 bonds carry one bit and all its d1 bonds carry the other.
- Consecutive d0 bonds on a chain differ by d0 - d1 = (0,2,2). The {2,3} chains give (0,2,-2).
- Nonzero on every cell (my addition): k(0,2,2) lies in Lambda_x iff g = gcd(b,c) divides k. So (0,2g,2g) is in Lambda_x, and it is nonzero modulo (4a,4b,4c) because g ≤ min(b,c). The note states only the cubic case, but its use in `theorem-h-orientation` ("every cell") needs this line, and the line holds.

**Check (computed):**
- Lambda_k was computed by enumeration modulo the box on 8 cells: (1,2,3), (1,3,3), (2,2,2), (2,2,3), (2,3,4), (3,3,3), (2,4,6) and (3,4,5). The (0,2g,2g)-type element is present in every case.
- Solver samples of ice states with one axis absent, frozen and not frozen, all three axes: 233 states. In 0 of them does the stabiliser fail to contain Lambda_k. In 82 the stabiliser is strictly larger.

**The zero-flux remark** (used in the corollaries): the moment sum of each sublattice equals flux/4 in my normalisation. This holds in 233 of 233 states. One-line proof: at an A vertex the bit-1 bonds give d_i + d_j = 2n(v), and the flux is the sum of sigma_e d_e = 2 × (sum over bit-1 bonds of d). The B sublattice gives the same.

So zero flux balances every axis on each sublattice, and in a zero-flux state "one-way" implies "empty". **Proved; computed.**

**Statement used vs statement proved:** they match. `theorem-h-orientation` uses Lemma A on every cell, and the proof is cell-free once the nonzero element above is noted.

## V3. Theorem P via P1

**Statements:**
- `curl-reduction` l. 333: an even-curl ice state on a cell with all extents at least 2 is invariant under a one-cube coordinate shift.
- `theorem-h-orientation` l. 186: "an ice state with even curl has a one-cube period, ... proved for every cell".
- The P1 report claims P1 for every cell, thin cells included (its rank checks include (1,2,2) and (1,3,3)).

**Checker history:** no independent checker of `2026-09-17-p1-proof.md` was found.
- LOG l. 1631 records "main loop reran both scripts".
- LOG l. 1611 lists Theorem P as "not checked by check7", together with completeness and Lemma A.
- No audit report names p1-proof or sc-linear.

**Steps of the P1 proof:**

1. **Type field = e_x + sum f_C m_C + const (completeness).** This rests on `2026-09-17-completeness.md` (agent F: stratified symbolic computation over 68 strata, rerun by the main loop). I did not read it. **Proved by an agent, unchecked.** `theorem-h-orientation` also leans on the same parametrisation (C) and calls it "proved by a symbolic computation and confirmed by exact ranks".
2. **A-match count 1 + L_h(f); curl-free iff Lf = 0.** This is a short argument. It uses Lemma L (confirmed) and the fact that the three A vertices of a hexagon carry three distinct axes, true because a hexagon uses one chain of each axis. **Proved.**
3. **ker L = S + G (probe K, `2026-09-17-sc-linear.md`).**
   - I read §4.1 and §4.2. The block structure is clear: an A-match row involves only A vertices.
   - The rank lemma's minor argument is correct, and I verified both polynomial identities by hand: A - z²P = -(x²R + C) and B - y²Q = C - x²R.
   - The stratum table and the 16 degenerate points rest on the completeness report's stratification, which I did not read.
   - **Proved by an agent; partly read by me; no gap found in what I read.**
4. **Slab-type type field, and absorption of the antisymmetric constants.** This follows from 3: the sublattice sign is a function of the parity of any one coordinate. **Proved, given 1 and 3.**
5. **The bridge (jumps J_x = p_x, J_y = r_y + 1, J_z = q_z + 1).**
   - I re-derived the case analysis: type y iff J_x = J_z ≠ J_y, and so on, and the excluded case is exactly three equal jumps.
   - `h735` checks the four-bit computation at an A and a B vertex over all 64 local profile values: (ICE) holds iff the jumps are not all equal, and the type is the odd jump out, with 0 violations.
   - **Proved; computed.**
6. **The profiles close on the torus.**
   - On the connected infinite lattice, the type field fixes the sign field up to global reversal by the bond rule.
   - So the lift of the state and s~ agree up to reversal, and s~ is box-periodic.
   - A box shift along x moves only the x-slab index, so X~_{x+4a} = X~_x.
   - **Proved.**

**Profile lemma (slab sum with (ICE) implies a 4-periodic profile):**
- The reduction to the 8 residue triples is exact. Every combination of residues with the right sum is a vertex, because A is the set of even triples with sum ≡ 0 mod 4.
- `h735` enumerates all 3^12 assignments of nonempty value sets: 2,304 satisfy the 8 conditions, and 0 have no 4-periodic profile. **Proved by exhaustion** (independently of the hand proof, which I also read and found correct).

**Where the extents enter:**
- No step uses that the cell is cubic or that extents are equal, or anything about gcds.
- The one place extents matter is the last word. The profile lemma gives *some* axis a 4-periodic profile, and it does not choose which. If that axis has extent 1, the shift (4,0,0) is the identity.
- So Theorem P's conclusion "invariant under a nonzero translation" needs all extents at least 2. Extent at least 2 on every axis the lemma might pick is needed, and the lemma can pick any.
- This is exactly the hypothesis in `curl-reduction`, and it is dropped in `theorem-h-orientation` l. 186 ("every cell").

**Check (computed; solver with cap):**

| cell | dim K | slab rank | even-curl samples: slab sums / nontrivial one-cube period | negation of P1 |
|---|---|---|---|---|
| (1,2,2) | 16 | 16 | 6/6, **3/6** | not needed (K = slabs) |
| (1,2,4) | 24 | 24 | 5/5, 5/5 | not needed |
| (2,2,2) | 26 | 20 | 6/6, 6/6 | UNSAT, 0 s |
| (2,2,3) | 32 | 24 | 5/5, 5/5 | UNSAT, 0 s |
| (2,3,4) | 40 | 32 | 6/6, 6/6 | UNSAT, 0 s |
| (3,3,3) | 32 | 32 | 5/5, 5/5 | not needed |
| (2,2,6) | 58 | 36 | 3/3, 3/3 | UNSAT, 6 s |
| (2,4,6) | 74 | 44 | 5/5, 5/5 | UNSAT, 32 s |
| (4,4,4) | 98 | 44 | 5/5, 5/5 | UNSAT, 45 s |
| (3,4,6) | 56 | 48 | 6/6, 6/6 | UNSAT, 0 s |

How the negation of P1 is encoded:
- Ice and even curl hold.
- Some functional that vanishes on the slab span is nonzero on a complement of it in K. The functionals are found by my own GF(2) algebra and encoded as Tseitin XOR chains.
- Since an ice state with even curl lies in K, UNSAT is exactly P1 on that cell.

Results:
- (2,3,4), (2,2,6), (2,4,6) and (3,4,6) are new cells beyond the note's list.
- Every sampled even-curl state on a cell with all extents at least 2 has a nontrivial one-cube period.
- On (1,2,2), half the samples have no nontrivial one-cube period, as expected.

## V4. Lemma 21

**Statement as read** (l. 2102): a frozen state of (a,b,c), repeated to (k1 a, k2 b, k3 c), is frozen. It is odd exactly when the original is odd, and it has the same set of moments. So Theorem H on the larger cell implies it on the smaller.

**Proof read (proved).** Hexagons are lattice hexagons (zero-displacement six-walks) modulo the box, so each one has a well-defined image modulo a coarser box. The projection preserves bond directions and cycle order. Hence:
- the ice rule is preserved;
- circulation and curl are those of the image;
- every small hexagon lifts, by taking any lattice representative;
- the moments are those of the image.

The direction Theorem 24 uses: an odd frozen state of the small cell with every axis two-way repeats to an odd frozen state with the same moment set, so every axis is still two-way. That contradicts H on the large cell. This is sound.

The statement says more than the proof needs, and it is still true: oddness holds both ways, because the odd count multiplies by k1 k2 k3.

**Check (computed, own code; not h550):**
- Every big hexagon's bond cycle, mapped by the projection, equals the bond cycle of a small hexagon up to rotation and reflection.
- Every small hexagon is hit exactly k1 k2 k3 times.
- For each state: ice and frozen status are equal; every big hexagon has the curl and reversal count of its image; the odd count is multiplied by k1 k2 k3; the moment set and the E/O/T pattern are equal.

| small -> large | states | big hexagons not projecting | small not hit exactly k times | violations |
|---|---|---|---|---|
| (3,3,3) -> (3,6,3) | 60 corpus odd | 0 | 0 | 0 |
| (3,3,3) -> (6,6,6) | 25 corpus odd | 0 | 0 | 0 |
| (1,1,1) -> (2,3,1) | 11 solver | 0 | 0 | 0 |
| (1,2,2) -> (2,2,6) | 12 | 0 | 0 | 0 |
| (2,2,2) -> (4,2,6) | 16 | 0 | 0 | 0 |
| (2,2,2) -> (6,6,6) | 16 | 0 | 0 | 0 |
| (2,2,3) -> (4,4,3) | 17 | 0 | 0 | 0 |
| (2,3,4) -> (2,6,4) | 15 | 0 | 0 | 0 |

The solver states mix frozen-odd, frozen and plain ice states, so the "exactly when" is tested in both directions. The corpus odd states cover 13 E/O/T patterns. No two small hexagons share a bond cycle, even on (1,1,1).

Side note: on (1,1,1), (1,1,2) and (1,2,3), "frozen and odd" is UNSAT (solver, no assumptions). So Theorem H at side one is vacuous.

## V5. The chain

Let S be a frozen zero-flux state on (a,b,c).

1. If some axis k is empty: by Lemma A (needs only ice; any cell), S is invariant under (0,2g,2g)-type elements of Lambda_k. These are nonzero on every cell. Done.
2. Otherwise all three axes occur. Zero flux makes each axis balanced on each sublattice (moment sum = flux/4), so every axis is two-way.
3. Theorem H (needs frozen; proved or certified only on the cells of the table's first three rows) says an odd frozen state has an empty or one-way axis. So S is not odd: even curl everywhere.
4. Theorem P (needs ice and even curl): P1 makes S a slab sum. The profile lemma makes one of X, Y, Z 4-periodic. So S is invariant under (4,0,0), (0,4,0) or (0,0,4).
5. **Hypothesis used but not supplied:** that the shift in step 4 is nonzero, which needs every extent to be at least 2. Step 4 cannot choose the axis.

Supply of the hypotheses on each row of the table:
- **Row 2**, (2a', 2b', 2c'), and **row 3, sides 2 to 6:** all extents are at least 2. The chain is complete, given P1's two agent proofs.
- **Row 3, side 1, (1,1,1):** the chain gives only the identity in step 4. But step 3 is vacuous there, and directly: frozen + zero flux + no nonzero translation is UNSAT (solver, 0.1 s). So the conjecture holds at side one by computation, not by the chain.
- **Row 1** (some pair coprime) includes every thin cell (1,b,c). There the conclusion is **false**: `h737` finds frozen, zero-flux, even-curl states with all six directions and stabiliser {0} on (1,1,2), (1,2,2), (1,2,3), (1,3,3), (1,3,4) and (1,4,5). Each was re-checked by `h730`: ice, frozen, flux (0,0,0), trivial stabiliser over all A-lattice translations. Witnesses are in `.tmp/h737_witness_*.json`, as bit lists indexed 4·(A index) + k in `h730` order. As a control, (2,2,3) gives UNSAT in 48 s.

**Correction:** add "with every extent at least two" to:
- `theorem-h-orientation` l. 186 to 191: "on every cell of the first three rows";
- l. 1163: "every frozen zero-flux state of a cell with a coprime pair of extents";
- the abstract's sentence on periodicity.

Also say that at side one the conclusion holds by direct solve. The corollary of Theorem 23 (l. 2048) is fine as it stands, since all its extents are even. The HANDOVER sentence on cubic cells is unaffected.

## Rules kept or broken

Kept:
- Compute was on this Mac only. Every solve ran through `h32_cap.run_batch` with caps of 60 to 150 s, one child at a time. The longest solve was 48 s; total solver time was under 5 minutes.
- Scripts are new, `h730` to `h737`, with the docstring header and a usage line. No existing script was modified.
- Temporary files are in `.tmp/` and `$TMPDIR`. There are no commits.
- No work was done on U, H or K_u.

Not done:
- I did not read `2026-09-17-completeness.md` or the stratum table of `2026-09-17-sc-linear.md`. These are the two places where P1 rests on unchecked agent proofs.
