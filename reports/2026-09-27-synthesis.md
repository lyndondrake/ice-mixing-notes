---
title: "Synthesis of the first Opus round: Theorem H is reduced to three sign laws, H ⇐ K_u + Lemma O + (R⁺) + (S≥1), of which only Lemma O (Theorem U, hand residue (V)) needs oddness; audited by the main loop"
author: "Claude (Fable 5.1), main loop, for Lyndon Drake"
date: 2026-09-27
---

Status tags as in the note. This report records the main loop's audit of four agent reports of the same day (`2026-09-27-opus-{a3,uwall,rpdata,rphand}.md`) and the map that results. It proves nothing new itself.

## 1. The reduction (agent rphand; audited)

> **H ⇐ K_u + Lemma O + (R⁺) + (S≥1).**

- **K_u**: a uniform chain forces a direction absent. Certified (note, Status of 2026-09-11), modulo Lemma L and within the scope of its window certificates: cells with a ≥ 3 and b, c ≥ 4, the small honest cells by torus verdicts. The reduction inherits that scope.
- **Lemma O**: in an odd state every hole has one rod pointing in and one out. Corner holes: proved. Straight holes: equivalent to Theorem U (an unoriented cage forces curl-free), solver L = 3, 4, 5, hand residue (V).
- **(R⁺)**: two type-k vertices on k-lines at transverse offset (±1, ±1) share a sign, at any k-separation. Every frozen state; solver L = 3, 4, 5; Lemma R (cage enumeration) proves its first two members, the pairs inside one cage.
- **(S≥1)**: two type-k vertices of one k-line with no type-k vertex and at least one other vertex between them share a sign. Every frozen state; solver, all gaps at L = 4 and L = 5.

The proof uses, besides these, only results already proved by hand: law Pᵏ, Theorem LC, Lemma S1, Theorem M′, Theorem D. A state with a type absent needs no argument: an absent type is an empty axis, and both its directions are absent. (An earlier version of this report, and the agent's Corollary, cited 'Lemma A' for that case; the Lemma A of record is a different statement and is not needed for H. Corrected after the independent check, §5.)

**The chain of the argument.**

1. *Lemma sP (cage check).* At an oriented hole the moment field n_k = ε[τ = k] satisfies the cage law Pᵏ. It fails exactly at the 96 unoriented cage patterns.
2. *Theorem sLC.* If every hole is oriented, the signed k-line counts are separable, as the unsigned ones are (Theorem LC).
3. *Two-product lemma.* Two non-negative separable functions with product zero, neither zero, depend on one and the same coordinate. This is the non-linear step.
4. *Stripe theorem.* With (S), the numbers of + and of − type-k vertices per line are such a pair. So a two-signed sublattice is striped: every plane of one normal n is k-free or full of one sign.
5. *Theorem W.* With (R⁺), a two-way axis has a k-free plane whose two neighbours are each k-free or of one sign, not both free and not of the same sign.
6. *Lemma E.* At such a plane (E′) holds at every hole: Pᵏ and Lemma sP give two linear equations for the two sides, which force both to vanish.
7. *Theorem D* then puts every type-k vertex beside the plane on a uniform chain, and K_u finishes.

**Audit by the main loop.** Every step was read against its hypotheses. Points checked in particular: the zero-set argument of the two-product lemma; that the stripe direction in the reversing-pair case is forced by (S) on one line; both cases of Theorem W, including the choice of the plane in the cyclic sequence and the use of (R⁺) in each direction; that Lemma E needs orientation only in its two-sided case; that Theorem D is applied with (E′) at the one plane it needs. Re-run: the cage check (1 200 patterns per cage, 288 violations, all at the 96 unoriented patterns), the stripe and wall checks at L = 4 (1 972 stripes, 727 + 280 walls, (E′) at 3 743 walls), the step-by-step check of the reversing-pair theorem at L = 3 (10 552 instances), and the solver test of (S≥1) at L = 4. All agree with the report. Not re-run: the L = 5, 6 solver samples.

No gap was found. The reduction is recorded as **proved, modulo K_u's certificates and the three laws**.

## 6. Later the same day: (S≥1) is redundant, and (R⁺) lives on a light cone (agent lines; verified)

`2026-09-27-opus-lines.md`, scripts `h290`–`h299`.

- **Theorem S (proved).** Summing the signed cage law over the holes of a k-line between two of its type-k vertices v, w gives n_k(w) − n_k(v) as a signed sum of n_k over the vertices of the four diagonal lines inside the window. If one of those is of type k, (R⁺) twice gives ε(v) = ε(w); if none is, the sum vanishes. So (S) ⇐ Lemma O + (R⁺), and **H ⇐ K_u + Lemma O + (R⁺)**.
- **Both line laws may be proved with Lemma O as a hypothesis**: they are used only in odd states, and a gap on a k-line already makes a corner.
- **No automaton.** Without Lemma O both laws need almost the whole torus in every direction (solver, L = 4 to 8). With Lemma O on the holes, (R⁺) at separation s is forced exactly on tubes of radius (s − 1)/2, independent of L (L = 6, 8, 10, s ≤ 19): a light cone. Its support is the causal diamond of holes between the two rods.
- **With Lemma O, (R⁺) is a counting statement** (certified): for each separation |s| ≤ 13, and s = 15, 17, 19, an exact rational Farkas certificate over one-hot, (T2), the bond rule written for the moments, and Lemma O on the diamond, with multipliers in {1, ½, ¼, −½} and support inside the window. Each is a finite identity of the infinite lattice, so it holds on every torus. For L ≤ 7 every separation that occurs is covered.
- **By hand**: (R⁺) for |s| ≤ 5 from a conservation lemma across a hexagon (τ·in and τ·out agree at the two holes of a hexagon; cage check on the 14 vertices of two adjacent cages).
- **Residual (R⁺_O)**: the certificate written once for every s, a summation over the diamond.

Main-loop checks: the proof of Theorem S read; the certificate at s = 7 regenerated (70 rows, exact check passed); the two-cage enumeration re-run (6 192 patterns, 198 state pairs for each of the four directions).

**The map is therefore: H ⇐ K_u + Theorem U + (R⁺_O)**, with Theorem U the only statement that needs the whole torus.

## 7. Close of the day: (R⁺) proved at every separation; H ⇐ K_u + Theorem U

Agent cone (`2026-09-27-opus-cone.md`, scripts `h310`–`h319`), confirmed by the independent checker check2 (`2026-09-27-opus-check2.md`, scripts `h320`–`h326`, own implementation): **with Lemma O on the causal diamond, (R⁺) holds at every separation and (S) at every gap.**

- The certificates are one closed-form family: Lemma O rows +1 on the diamond D; (T2) rows −½ on the hexagons with a hole in D; one-hot ½·min(2, μ_b), μ_b the number of holes of D of which the vertex is a bridgehead; bond rows d·n(a) − d·n(a + d), a the A end, ¼·min(4, n_E), n_E the number of the bond's six hexagons with both holes in D; the two hypotheses 1.
- What it proves is a **corner law**: of the six corner holes of the diamond exactly one takes its in-rod from outside along its own axis.
- The proof for every s is local. The ten holes around a vertex form a tetrahedron; D cuts it in one of 50 sets; every column of the combination is of the right sign except when the vertex has exactly two bridge holes in D; and that never happens when the transverse offset of the pair is at most 1 (Lemma B). The offset bound is sharp.
- Verified in exact arithmetic by both agents independently for 5 ≤ s ≤ 101, every admissible offset, both sublattice orders, and for the same-line case; separations 1 and 3 are the bond rule and the conservation lemma.
- The identity on the infinite lattice passes to every torus, including when the diamond wraps.
- Orientation is needed at every hole of D, straight holes included, so this proof of (R⁺) depends on Theorem U.

**Final map of the day.**

> **H ⇐ K_u + Theorem U**, with K_u certified within its scope and Theorem U (an unoriented cage forces even curl; hand residue (V)) solver-true and DRAT-certified at L = 4, 5, 6.

Everything else in the chain is proved by hand, with finite cage-sized checks, and has been through an independent checker: Lemma sP, Theorems LC and sLC, the two-product lemma, the stripe theorem, Theorem W, Lemma E, Theorem D, Theorem S, the cone certificate.

**What is known about Theorem U** (orient, ucore, uhand, uwall, vsign): no window, tube or slab short of 2L − 2 layers; no counting proof, signed or unsigned; no propagation of the pattern or of the charge to any single hole; the sign field shortens nothing; integrality of one indicator family suffices (one sublattice's hole charges at L = 3; one line of 2L indicators for the corner case of the turn at L = 4, 5); depth-1 probing on the cage laws refutes it at L = 4, not uniformly.

## 5. Independent check (added the same day)

Agent check (Opus; `2026-09-27-opus-check.md`, scripts `h270`–`h272`, none of the author's scripts used): **confirmed with corrections, no gap.** Every proof of rphand §1–§4, Theorem D and Theorem LC is complete for the hypotheses it states. Corrections, all applied above or noted in the agent report: the citation of Lemma A (not needed); the wording of what Lemma R proves; K_u's scope. Remarks: Case 2 of Theorem W (each sublattice of one sign, the two opposite) is correct as argued but never occurs, neither on the corpus (0 of 1 814 two-way axes) nor in the solver at L = 3, 4, so it is probably provably empty; the solver query 'a two-way axis with no sign-separated wall' is UNSAT at L = 3 and was undecided at L = 4 at a 540 s cap.

## 2. What the other three agents add

- **rpdata (solver).** The sharp (W) — a reversing pair forces a k-free plane through its middle line — holds in the type-only model with no oddness and no three types, L = 3, 4, 5. (RP) holds at every distance at L = 3, 4. The cores of (RP) are as global as (V)'s. These agree with the reduction and are no longer needed for H.
- **uwall (proved).** The staircase lemma and the three cases of a turn. With Lemma E, (E′) at a sign-separated plane is now a consequence of Lemma O, so the transfer step is not needed for H either.
- **a3 (proved).** An odd equal-bounded run carries a pair of consecutive same-sublattice kinks. The reduction H ⇐ K_u + (RP) + (UC′) is superseded: Theorem W covers every two-way axis, split or not, so (UC′) and (A₃) drop out.

## 3. The map after this round

| statement | role | status |
|---|---|---|
| K_u | sign half for a uniform chain | certified |
| Lemma O, corner holes | orientation | proved |
| Lemma O, straight holes = Theorem U | orientation; the only use of oddness | solver L = 3, 4, 5; **(V) open** |
| (R⁺) | coherence between adjacent lines | solver L = 3, 4, 5; open by hand beyond separation 3 |
| (S≥1) | coherence along a line | solver L = 4, 5; open by hand |
| everything else | | proved |

Dropped from the list of things H needs: (W), (W′), (W1′), (E′) as a separate statement, (RP), (A₃), (UC′), (J1), (J2), ORDER, the block induction on even runs, Conjecture G.

## 4. Consequences and next steps

1. **H at a fixed L is now a small computation.** Each of the three laws is decided by the solver in seconds at L ≤ 5. With DRAT certificates for them at a given L, and K_u's certificates (which cover L ≥ 4), Theorem H and hence the periodicity theorem follow at that L. The direct certificate at L = 4 was abandoned on 2026-09-10 after 36 hours.
2. **(R⁺) and (S≥1) are laws of every frozen state along a line, with unbounded separation.** That is the shape of Lemma S, which was proved for every period by a strip automaton. The test is whether each is forced inside a bounded transverse tube around its lines.
3. **(V) is the one statement that is global in all three directions.** New tool for it: Lemma sP fails at an unoriented hole by exactly ±2, so the signed line counts have mixed second differences supported on the unoriented holes.
