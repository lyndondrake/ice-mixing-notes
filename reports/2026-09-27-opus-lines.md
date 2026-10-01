---
title: "(S≥1) is a corollary of (R⁺) and Lemma O (proved), so H ⇐ K_u + Lemma O + (R⁺). Neither law is tube-local: without Lemma O both are global in all three directions (the class of (V)); with Lemma O both have a light-cone reach, R*(s) = (s−1)/2, so no tube automaton exists. With Lemma O, (R⁺) is a counting statement on the causal diamond between the two rods (exact LP certificates for every separation up to 19, valid for every L), and a new two-cage law (conservation of τ·in and τ·out across every hexagon, plus a trail rule; proved by exhaustive check) gives (R⁺) by hand for |s| ≤ 5"
author: "Claude (Opus), agent lines, for Lyndon Drake"
date: 2026-09-27
---

Status tags: **proved** (argument written here), **proved (cage check)** (exhaustive enumeration of a finite configuration, the standard of Lemma R), **certified** (an exact rational Farkas certificate, verified after rounding, on a finite set of rows that embeds in every torus), **computed** (whole odd corpus, 637 states at L = 3 and 720 at L = 4, 0 exceptions), **solver** (type-only model with the sign field, capped child process), **conjecture**. Scripts `scratch_h/h290_*.py` – `h299_*.py` (new; nothing else was modified, nothing was committed, no Spark was used; every SAT solve ran in a capped child process through `h32_cap` or its own `subprocess.run` worker, one at a time).

Conventions: k = z throughout; v = (0,0,0) ∈ A; an A z-line sits at transverse (x, y) both even, a B z-line at both odd; the four diagonal lines of a line are at transverse offset (±1, ±1). The *separation* s of a pair is |Δz| (odd for (R⁺), a multiple of 4 for (S)). The *tube of radius R* is everything within transverse Chebyshev distance R of the line(s); a hexagon, bond or cage is in the tube if all its vertices are.

## 0. Status table

| # | statement | status |
|---|---|---|
| 1 | Without Lemma O, (R⁺) (s ≥ 5) needs the whole transverse torus; (S≥1) needs all but a band of width ≤ 7 at the transverse antipode (reach 2L − 4 at L = 5…8); both also need almost the whole k-circle and almost the whole slab. The class of (V) | **solver**, L = 4…8 |
| 2 | Both laws are used in the reduction only in odd states, and the hypothesis of (S≥1) already makes a state odd; so Lemma O may be assumed when proving them | **proved** |
| 3 | With Lemma O the reach is a light cone: (R⁺) at separation s needs radius (s−1)/2, (S) at separation s needs about s/2, independent of L. No fixed tube suffices; **no tube automaton exists** | **solver**, L = 6, 8, 10, s ≤ 19 |
| 4 | **Theorem S.** (S) at separation s ⇐ Lemma O on the holes between + (R⁺) at separations < s. Hence **(S≥1) ⇐ (R⁺) + Lemma O**, and **H ⇐ K_u + Lemma O + (R⁺)** | **proved**; computed |
| 5 | Lemma D: a k-line whose four diagonal lines carry no type-k vertex has n_k constant along it (k-free, or all type k of one sign) | **proved** mod Lemma O; computed 24 483 + 51 951 lines |
| 6 | **Conservation lemma.** For a hexagon joining oriented holes O and O + τ: τ·in(O) = τ·in(O+τ) and τ·out(O) = τ·out(O+τ); together with a **trail rule** TR at odd hexagons this is the *exact* two-cage relation (198 of 900 state pairs) | **proved (cage check)**; computed, 0 violations |
| 7 | (R⁺) for \|s\| ≤ 5 from the conservation lemma in two lines (recovers Lemma R, adds s = 5) | **proved** mod Lemma O at two holes |
| 8 | With Lemma O, (R⁺) at separation s is a linear consequence of one-hot, (T2), the bond rule d·n(a) = d·n(b) and Lemma O on the causal diamond between the two rods' holes | **certified** for s = ±3, …, ±13, 15, 17, 19; (S) for gaps 1, 2 |
| 9 | (R⁺) for all s | **open**; the residual is one statement (§7) |
| 10 | (R⁺) does not follow from (S) + Lemma O inside any fixed tube; the laws at one level are cyclically dependent (R1(s) ⇐ R3(≤ s+2); R3(s) ⇐ S(≤ s+1) + R1(< s); S(s) ⇐ R(< s)) | **solver** (tube radius 2, L = 8) |

## 1. What may be assumed (proved)

A frozen state is either curl-free or odd (rods report §1: odd hexagons are exactly the N = 2 octants of corners, curl-free ⟺ no corners). If a k-line carries a type-k vertex v and v + 4e_k is not type k, the hole v + 2e_k has the rod v and a transverse rod, so it is a corner and the state is odd. So the hypothesis of (S≥1) forces oddness, and in an odd state Lemma O (every hole: one rod toward it, one away) holds by Theorem U. (R⁺) has no such hypothesis, but every use of it in the reduction (rphand Theorem RP₁ step 3, Theorem W cases 1 and 2) is inside an odd three-type state. **Both laws may therefore be proved with Lemma O as a hypothesis**, and this changes everything below: without it the laws are global, with it they are cone-local and counting statements.

Notation for oriented holes: in(h) (out(h)) is the unit vector from the hole h to the methylene that is its in-rod (out-rod). A rod h + 2d of axis |d| points away from h iff its sign equals the side, so in(h) = d iff τ(h + 2d) = |d| and ε(h + 2d) = −(side). The in-rod of h on side d is the out-rod of h + 4d on side −d: out(h + 4 in(h)) = −in(h).

## 2. Reach

### 2.1 Without Lemma O: global (solver, `h290`, `h291`)

Tube, minimal R at which the violation is UNSAT (control with equal signs SAT in every row):

| L | (S) gap 1 | (S) gap 2 | (S) gap 3 | (S) gap 4 | (R⁺) s = 5 | (R⁺) s = 7 | (R⁺) s = 9 | whole torus is R = |
|---|---|---|---|---|---|---|---|---|
| 4 | 6 | 6 | – | – | whole | – | – | 7 |
| 5 | 6 | 6 | – | – | whole (R = 8 SAT) | whole | whole | 9 |
| 6 | 8 | 8 | 8 | ≥ 8 (7 SAT) | whole (R = 10 SAT) | whole | – | 11 |
| 7 | 10 | – | 8 | – | – | – | – | 13 |
| 8 | 12 | – | – | – | whole (R = 14 SAT) | – | – | 15 |

(S) is forced once the tube's complement is a band of width ≤ 7 at the transverse antipode (R = 2L − 4 for L ≥ 5; at L = 7 gap 3 the other arc of the line is short and the reach drops to 8). (R⁺) at s ≥ 5 needs *every* hexagon. The other shapes at L = 6 (full in the other two directions): slab |x| ≤ D: (S) D = 8, (R⁺) D = 10 of 11; k-window [z_v − D, z_w + D]: (S) D = 6, (R⁺) D = 8 (the whole circle). So neither law is local in any direction — the signature of (V) (orient report §4: "SAT up to |dx| ≤ 2L − 3"). Without Lemma O no automaton, strip or window argument can exist.

### 2.2 With Lemma O on the tube's holes: a light cone (solver, `h292`)

Orientation ("exactly one of the six methylenes points away") is added at every hole whose cage lies in the tube.

| L | (R⁺) s = 3 | 5 | 7 | 9 | 11 | 13 | 15 | 17 | 19 |
|---|---|---|---|---|---|---|---|---|---|
| 6 | – | 2 | 3 | 4 | – | – | – | – | – |
| 8 | ≤ 1 | 2 | 3 | 4 | 5 | 6 | 7 | – | – |
| 10 | – | – | – | – | – | 6 | 7 | 8 | 9 |

**R*(s) = (s − 1)/2, independent of L.** Below it the tube is SAT, i.e. a genuine periodic configuration of the tube (every tube hexagon (T2), every tube bond the bond rule, every tube hole oriented) violating the law. (S) at L = 8: gap 0 → 2, gap 1 (s = 8) → 4, gap 2 (s = 12) → 6, gap 3 (s = 16) → > 6; gaps 4, 5, 6 → 6, 4, 2 (the other arc of the circle, of length 32 − s, is the short one: the cone follows the shorter arc even though it carries no hypothesis). The LP relaxation (§5.3) is infeasible at exactly the same radii.

### 2.3 With Lemma O and induction hypotheses (solver, `h294`, L = 8)

IH = the laws for every same-line and diagonal pair in the tube of minimal arc < s (sound in a minimal-counterexample argument).

| hypotheses | (S) gaps 1–3 | (R⁺) s ≡ 1 (mod 4): 9, 13, −9 | (R⁺) s ≡ 3: 7, 11, 15, −11 |
|---|---|---|---|
| O | 4, 6, > 6 | 4, 6, 4 | 3, 5, 7, 5 |
| O + IH | **2** (also inside 6 of the ends) | 4, 6, 4 (cone) | 3, 5, 7, 5 (cone) |
| O + (S) at all separations | – | cone | 2, 4, 6, 4 |
| O + (R⁺, s ≡ 3) at all separations | – | **2** | – |
| O + (R⁺, s ≡ 3) up to s + 2 | – | **2** | – |
| O + (S) up to s + 1 + (R⁺, s ≡ 1) below s | – | – | **2** |
| O + (S) below s + all of IH | – | – | cone |

So (S)'s induction step is local (it is Theorem S, §4), but (R⁺)'s is not: each residue class needs the other at a *larger* separation. At level m the statements R1(4m+1), R3(4m+3), S(4m+4) depend on each other in a cycle, and that cycle is what the torus breaks and a tube cannot.

### 2.4 Deletion-minimal cores (`h293`, L = 8, flag o)

| law | R | hexagons | bonds | oriented holes | extent (transverse, k) |
|---|---|---|---|---|---|
| (R⁺) (1,1,5) | 2 | 7 | 5 | 2: (0,0,2), (1,1,3) | 3, [0, 5] |
| (R⁺) (1,−1,7) | 3 | 20 | 19 | 7 | 4, [0, 8] |
| (R⁺) (1,1,9) | 4 | 38 | 30 | 14 | 5, [0, 9] |
| (R⁺) (1,−1,11) | 5 | 67 | 51 | 26 | 6, [0, 11] |
| (S) gap 1 | 4 | 26 | 17 | 10 | 4, [0, 8] |

The oriented holes of the (R⁺) cores are exactly the **causal diamond** D(h_v, h_w) of §5.3 (2, 6, 14, 26 holes): the holes lying on some z-monotone hexagon path from h_v = v + 2e_z (the hole v's rod enters) up to h_w = w − 2e_z (the hole w's rod enters). An up-path alternates an A→B step (±1, ±1, 1) with x = y, which moves a = x + y by ±2, and a B→A step with x = −y, which moves b = x − y by ±2. So the diamond is a product of two 1+1-dimensional light cones, and its transverse radius at the middle is (s − 1)/2.

## 3. The automaton: none, and why

Task 2 asked for an automaton on a fixed tube. There is none:

- **Without Lemma O** the tube of radius R is SAT for every R below the whole transverse torus (§2.1). A tube automaton of any radius would have closed walks through the violation.
- **With Lemma O** the tube of radius R is SAT at every separation s > 2R + 1 (§2.2; e.g. R = 2 at s = 7, R = 6 at s = 15, R = 8 at s = 19). Each SAT answer is a periodic tube configuration, i.e. a closed walk of the radius-R automaton through a violating pair. So for each fixed R the automaton is refuted by a separation of order 2R. The cone does not saturate up to s = 19 at L = 10.
- **With Lemma O and any induction on separation** the step for (R⁺) is not tube-local either (§2.3). A tube automaton for the step would need the other residue class at larger separation, so it is circular.

The failure modes the lemma-s audit lists were checked. **Over-constraint:** every tube model is a subset of the torus constraints (the torus row R = 99 reproduces the torus verdicts, controls SAT), and the one over-constraint I introduced was caught this way (§6). **Dropped checks at a seam:** the tubes are full k-circles with no seam, and the per-s certificates of §5.3 were checked to have k-support inside the window [z_v, z_w] (no wrap). The direction model of §5.2 was validated on the whole corpus (every hexagon of every state in the relation) and against the full model: it is weaker, as it must be (reach 4 against 3 at s = 7, equal elsewhere).

So the answer to Task 2 is negative, and the reason is exact. (R⁺) is not a statement about a bounded cross-section, but it is not global either: its domain of dependence is the causal diamond, which grows linearly with the separation. What replaces the automaton is §5.3, a uniform *linear* argument over that diamond.

## 4. Hand proofs: (S) from (R⁺)

**Lemma (telescoped sP) (proved).** Let ℓ be a k-line of S with vertices u_j = u₀ + 4j e_k and holes O_j = u_j + 2e_k. If O_a, …, O_{b−1} are oriented, then
$$n_k(u_b) - n_k(u_a) \;=\; \sum_{j=a}^{b-1}\ \sum_{s} s_k\, n_k(O_j + s),$$
and the right side is a signed sum of n_k over **the vertices of the four diagonal lines of ℓ with k-coordinate strictly between those of u_a and u_b**, each exactly once, with sign s_k (the same for all vertices of one diagonal line).

*Proof.* Sum Lemma sP (rphand §2, proved by cage check) over O_a … O_{b−1}; the left sides telescope. Each hole has one bridgehead on each diagonal line, at k-offset s_k = ±1, fixed per line (for A-holes s_k = −s_x s_y). Consecutive holes are 4 apart, and so are consecutive vertices of a line, so the bridgeheads run through the diagonal vertices in the open window without repetition. ∎ The convention (coefficient s_k, the same for A- and B-holes) was checked on the corpus: 0 violations of sP_z and P^z in 137 592 + 368 640 (state, hole) pairs (`h298 check`).

**Theorem S (proved).** Let v = u_a and w = u_b be type-k vertices of ℓ, with the holes between them oriented. Suppose every pair (v, x) and (x, w), where x is a type-k vertex on a diagonal line of ℓ strictly inside the window, satisfies (R⁺). Then ε(v) = ε(w).

*Proof.* If such an x exists, ε(v) = ε(x) = ε(w). Otherwise every term on the right of the telescoped identity is 0, so n_k(w) = n_k(v), and both are type k. ∎

Every pair (v, x), (x, w) has separation < s = 4(b − a). So **(S) at separation s ⇐ Lemma O on the holes between + (R⁺) at separations < s**, for all gaps including gap 0. In odd states Lemma O holds, so the line-sign law (S) = Lemma O (gap 0) + (S≥1) follows from (R⁺). **Corollary: H ⇐ K_u + Lemma O + (R⁺)**, the reduction of rphand §4 with (S≥1) removed, since (S) is used there only in odd states (the stripe theorem and RP₁ step 2).

**Lemma D (proved mod Lemma O).** If the four diagonal lines of ℓ carry no type-k vertex, n_k is constant along ℓ: ℓ is k-free or entirely of type k with one sign. (Telescope between consecutive vertices.) Computed: 24 483 + 51 951 such lines, 0 exceptions, 817 + 1587 of them full.

**The rung identity (proved).** An A-vertex a and B-vertex a + d₀, d₀ = (1,1,1), always have ε(a) = ε(a + d₀) (the bond rule with d₀_τ = 1 for every τ). So on the (1,1) ladder, (R⁺)(a₀, b_I) with b_I = a_I + d₀ is the statement ε(a₀) = ε(a_I) about the A-line alone, whenever a₀ and b_I are type k. The other ladders carry the factor d_{τ(a)} d_{τ(b)}.

## 5. Hand proofs and certificates for (R⁺)

### 5.1 The two-cage relation (proved, cage check; `h295 cage`, `analyse`)

Take a hexagon joining the A-hole O and the B-hole O′ = O + τ. The union of the two cages has 14 vertices and 7 hexagons. Of the 3¹⁴ type assignments, 6192 satisfy (T2) on the 7 hexagons. Every one has a consistent sign field on the union (unique up to the global flip), and 5136 have both holes oriented. Collecting (in, out) at O and at O′ over these and their flips gives **198 of the 900** state pairs, the same for all four τ. They are exactly the pairs satisfying:

- **Conservation lemma.** τ·in(O) = τ·in(O′) and τ·out(O) = τ·out(O′). (Each side is ±1: whether the rod lies in the octant of τ or of −τ.)
- **Trail rule TR.** If the hexagon is odd, with both rods of one hole on the hexagon's side and both rods of the other on the far side, then the in-rods of the two holes share an axis or the out-rods do.

Conservation is the conjunction of (T2) in rod form (#rods of O on τ's side + #rods of O′ on −τ's side = 2), HI_in (the in-rods of O and O′ are not both on the far sides) and its reversal HI_out. Given (T2), each of HI_in and HI_out is a monotonicity, and their sum is fixed, so both are equalities. TR is the local form of the rods-report corner rule (§2 there: the triple never swaps in ↔ out). Computed on the whole corpus: 0 violations of (T2) rod form, HI_in, HI_out and TR on 275 184 + 737 280 (state, hexagon) pairs.

### 5.2 (R⁺) for |s| ≤ 5 (proved, mod Lemma O at two holes)

- s = 3, w = (1,−1,3). v of sign + points up: in(0,0,2) = −e_z. w of sign − points down: in(1,−1,1) = +e_z. The holes differ by τ = (1,−1,−1), a hexagon step, and τ·(−e_z) = +1 ≠ −1 = τ·(+e_z). This contradicts conservation.
- s = 5, w = (1,1,5): in(0,0,2) = −e_z and in(1,1,3) = +e_z. Here τ = (1,1,1) gives −1 ≠ +1.
- s = −3, −5 (w below): use out instead. v of sign + is the out-rod of (0,0,−2), with out = +e_z. w = (1,1,−3) of sign − is the out-rod of (1,1,−1), with out = −e_z, and τ = (1,1,1). For w = (1,−1,−5), (1,−1,−3) has out = −e_z and τ = (1,−1,−1).
- s = ±1 is the bond rule.

This recovers Lemma R (by a different finite check) and adds s = ±5: **when the two target holes are hexagon-adjacent, (R⁺) is one line of conservation.** For |s| ≥ 7 they are not adjacent. In-conservation alone then does not suffice (the model with rod links and conservation of τ·in only is SAT at s = 7, 9, 11), and neither does conservation without TR (SAT at s = 7, 9). Conservation + TR + rod links (the *direction model*: a state (in, out) per hole, 30 states) does suffice at s = 5, 7, 9, 11 with the cone reach (`h295 dir`, L = 8; 4, 4, 5 against the full model's 3, 4, 5). So **(R⁺) is a statement about oriented rod loops with the two hexagon rules alone**; signs and types beyond the loops are not needed.

### 5.3 (R⁺) is a counting statement on the causal diamond (certified per s; `h296`, `h297`)

Relax to real variables p_k(u), m_k(u) ≥ 0 (type k with sign ±; n_k = p_k − m_k). The rows are:

- one-hot: Σ(p + m) = 1;
- (T2) per hexagon;
- the bond rule, which is **linear in the moment field**: d·n(a) = d·n(b);
- Lemma O: Σ_k p_k(h + 2e_k) + m_k(h − 2e_k) = 1.

Fix p_z(v) = 1 and maximise m_z(w). **The optimum is 0 exactly from the cone radius on**, and 1 below it (s = 7…19, the same radii as §2.2). The dual certificate, rounded to 1/24 and re-verified in exact rational arithmetic (Aᵀy ≤ c, b·y = 0), has multipliers only in {1, ½, ¼, −½}: +1 on Lemma O rows, −½ on (T2) rows, ½ or 1 on one-hot, ¼, ½ or 1 on bonds. The identity reads m_z(w) + Σ r_j x_j = 0 with r ≥ 0. At s = 5 the slack terms are the transverse in-rods of (0,0,2) from −x, −y and of (1,1,3) from +x, +y: HI in LP form. The support lies in the window [z_v, z_w] (k-range [1, s − 1]; checked, no wrap) at transverse extent (s − 1)/2. Each certificate is therefore a finite identity of the infinite lattice and **proves (R⁺) at that separation on every torus, in every state whose diamond holes are oriented.**

Certified: s = ±3, ±5, ±7, ±9, ±11, ±13 and 15 (L = 8); 13, 17, 19 (L = 10; 1132 rows at s = 19). (S): gap 1 (R = 4) and gap 2 (R = 6). Restricting the Lemma O rows to the causal diamond D(h_v, h_w) keeps the LP infeasible for s = 5, …, 13 and (S) gaps 1, 2 (`h296 … diamond`; |D| = 2, 6, 14, 26, 44 and 10, 35). So **Lemma O is needed only on the causal diamond.** The cage laws alone (sP, P^k, law C, O without (T2) across hexagons and without the bond rows) are not enough: that LP is feasible (`h298`, `h299`).

**Hand proof beyond |s| = 5: not found.** The certificates are uniform in shape (the diamond, fixed multiplier values), which points to a discrete Green's-function summation over D. The sum of the Lemma O rows over D is a divergence theorem for the rod flow, since in an oriented hole "one away" together with law C is "zero divergence". The (T2) and bond rows then transport the two incoming apex fluxes (v's rod into h_v from below, w's into h_w from above) to the lateral boundary. I did not find the closed form of the bond and one-hot part of the certificate.

## 6. What failed, and one near-miss

- **An automaton on a tube, with or without Lemma O**: impossible (§3).
- **Induction on separation**: the step for (S) is local, the step for (R⁺) is not (§2.3). The dependency R1(s) → R3(s + 2) → S(s + 3) → R(< s + 3) returns to level s.
- **A "cone law"** (any up-rod below and down-rod above in its causal future are incompatible) is false. On the torus the lifted cones cover everything, so it would force every axis one-way. Only the diagonal and same-line cases hold.
- **HI alone** proves only s = 5; **conservation without TR** fails at s ≥ 7.
- **Near-miss (caught):** the first two-cage relation was built from one sign normalisation, without the global flip. The direction model was then *stronger* than the full model (UNSAT at radius 3 where the full model is SAT), which is impossible for a projection. Closing the relation under the flip (99/127 → 198 pairs, now the same for all τ) fixed it. This is the lemma-s audit's over-constraint failure mode, detected by comparing a projection with its source.
- **Bug (caught):** a flag test `"all" in flags` fired on the token `Sall` and put Lemma O on every hole of the torus. It was visible as a jump in the oriented-hole count; the affected run was repeated.

## 7. The exact residual

With this report the three inputs of rphand are two: **H ⇐ K_u + Lemma O + (R⁺)** (proved, given rphand's reduction). And (R⁺) is needed only in odd states, where it may use Lemma O on the causal diamond. What remains is:

> **(R⁺_O)** *If the holes of the causal diamond between h_v = v + 2e_z and h_w = w − 2e_z are oriented, an up-pointing z-rod v and a down-pointing z-rod w on diagonal lines (w above v, at any separation s) cannot coexist* (and the mirror with out-rods for w below v).

Its status: proved for |s| ≤ 5 (conservation); certified for |s| ≤ 13 and s = 15, 17, 19 on every L; solver at every separation for L ≤ 5 (extremal §9). It is a linear consequence of one-hot, (T2), the bond rule and Lemma O on D, and a consequence of the oriented rod loops with conservation and TR (§5.1–5.2). A proof for all s needs the uniform certificate: a summation over the diamond whose (T2)/bond part is written out once for every s. This is the natural next hand target, and it is a 1+1+1-dimensional light-cone argument, not an automaton. The remaining global input of H is then only Lemma O, i.e. Theorem U and its residue (V).

## 8. Computations (all on this Mac; wall clock)

| script | what | time |
|---|---|---|
| `h290_reach.py L cap S\|R seps Rs` | tube reach, no Lemma O, L = 4, 5, 6, 7, 8 | 0.3 – 44 s per call |
| `h291_shapes.py 6 … slab\|kwin` | slab and k-window reach, L = 6 | 3 – 9 s |
| `h292_oriented.py L cap law seps Rs o` | tube reach with Lemma O on tube holes, L = 6, 8, 10 | 0.5 – 36 s |
| `h293_core.py 8 300 law sep R o` | deletion-minimal cores (hexagons, bonds, holes) | 0.2 – 1.6 s |
| `h294_induct.py 8 300 law seps Rs flags` | induction step with IH / (S) / (R⁺) residue classes; `ends<W>`, `box<W>` | 0.3 – 20 s |
| `h295_hi.py corpus 3\|4` | Lemma O, HI, (T2) rod form, HI_out, TR, Lemma D on the corpus | 2 s, 4 s |
| `h295_hi.py cage` / `analyse` | two-cage enumeration (3¹⁴, vectorised), relation = conservation + TR | 2 s |
| `h295_hi.py dir 8 R seps Rs [cons\|consin\|cons+TR]` | direction model (states (in, out), hexagon relation, rod links) | 40 s; variants 3 min |
| `h296_lp.py L law seps Rs [noO] [x diamond]` | LP relaxation; Lemma O only on the causal diamond | 5 – 30 s |
| `h297_farkas.py L law sep R [show]` | exact Farkas certificates, support and slack | 3 – 57 s |
| `h298_wave.py check L` / LP | sP_z and P^z convention on the corpus; z-only cage laws (feasible) | 2 – 5 s |
| `h299_cagelp.py 8 R 1,1,5 3 rows` | which row families the certificate needs | seconds |

Every UNSAT above has its control (equal signs, same model) SAT beside it. No solve exceeded 16 s.
