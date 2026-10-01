---
title: "(RP) at distance 2 proved modulo three sign laws — Lemma O (every hole of an odd state oriented, ⟸ Theorem U), (R⁺) and the gap ≥ 1 line-sign law, the last two laws of every frozen state — through a new global identity: at an oriented hole the moment field obeys the cage law Pᵏ, so signed line counts are separable, and with the line-sign law the + and − counts of a two-signed sublattice depend on one transverse coordinate (stripes). Walls between stripes are k-free planes at which (E′) holds automatically, so Theorem D applies without (E′) as a hypothesis. The same argument gives every two-way axis a uniform chain, hence H ⇐ K_u + Lemma O + (R⁺) + (S≥1). The type-only part of (RP) (pattern ⇒ k-free plane) holds without oddness (solver) and is LP-positive; 'three types' enters only in Theorem D(iii)"
author: "Claude (Opus), agent rphand, for Lyndon Drake"
date: 2026-09-27
---

Status tags: **proved** (argument written here or in a cited report), **proved (cage check)** (exhaustive enumeration of one cage, the standard of Lemma R), **computed** (whole odd corpus, 637 states at L = 3 and 720 at L = 4, `h38_lib.load_odd_corpus`, 0 exceptions unless stated), **solver** (type-only model, with the sign field where stated, on the (L,L,L) torus), **conjecture**. Every conditional result names its inputs. All computation on the primary Mac in the project `.venv`, one process at a time; every solve in a capped child process (h32_cap discipline). No Spark was used. Scripts `scratch_h/h240_*.py` – `h249_*.py` (new; several carry more than one mode). No tracked file was edited and nothing was committed.

**Canonical frame used throughout** (every reversing pair is carried to it by a lattice symmetry, `h240`): m = (0,0,0) ∈ A of type x (= l), u = m + d₀ = (1,1,1) and v = m + d₃ = (−1,−1,1) ∈ B of type z (= k); the third axis is j = y. O = (0,0,2) is the A-hole between m and m + 4e_z; its bridgeheads are u, v (s_z = −1) and u′ = (1,−1,3), v′ = (−1,1,3) (s_z = +1); its methylenes are m, (0,0,4), (±2,0,2), (0,±2,2). The x↔y swap fixes u, v, so τ(m) = x is no loss.

*Corrections (2026-09-27, after the independent check `2026-09-27-opus-check.md`; verdict: confirmed, no gap).* (i) In the Corollary of §4 delete 'If a type is absent, Lemma A': an absent type is an empty axis, so the case falls under 'one-way or empty'; the Lemma A of record is a different statement. (ii) Lemma R proves the first two members of (R⁺) (the pairs inside one cage); read §9's 'k-separation ≤ 3' in that sense. (iii) 'K_u (certified)' carries the scope recorded for it: modulo Lemma L, cells with a ≥ 3 and b, c ≥ 4 by window certificates, the small honest cells by torus verdicts. (iv) Case 2 of Theorem W is correct but never occurs on the corpus or in the solver at L = 3, 4.

## 0. Status table

| # | statement | status |
|---|---|---|
| 1 | **Lemma T** (transfer): (0,0,4) is not type k and u′, v′ are type k; (u′, v′) is a reversing pair at (0,0,4) | **proved** (Pᵏ at O) |
| 2 | **Lemma St**: the hole O is straight, along x = τ(m) or along the third axis y | **proved** ((T2) + law C) |
| 3 | sign pattern: straight-x ⇒ ε(u) = ε(v′) = −ε(v) = −ε(u′); straight-y ⇒ ε(u) = ε(u′) = −ε(v) = −ε(v′) | **proved** (bond rule) |
| 4 | **Lemma sP**: at every *oriented* hole the moment field n_k = ε[τ = k] satisfies Pᵏ; it fails (for all three axes) exactly at the 96 unoriented (yy/zz) cage patterns | **proved (cage check)**, `h249 cage` |
| 5 | **Theorem sLC**: if every hole is oriented, the signed k-line counts are separable, s^S_k = F̃(x_i) + G̃(x_j) | **proved** from 4; computed 0/413 k mixed differences |
| 6 | **Two-product lemma**: P, Q ≥ 0 separable with PQ ≡ 0, neither ≡ 0 ⇒ both depend on the same single coordinate | **proved** |
| 7 | **Stripe theorem**: in an odd state (Lemma O, (S)), a sublattice carrying type-k vertices of both signs has its (#+, #−) per k-line a function of one transverse coordinate | **proved** mod Lemma O, (S); computed 1565 + 1972 instances |
| 8 | **Lemma E** (sign-separated plane): at a k-free plane whose neighbours are uniformly signed with opposite signs (or one neighbour k-free), (E′) holds at every hole | **proved** mod Lemma O at its holes; computed 2469 + 3743 walls |
| 9 | **(c) for the reversing pair**: the m-plane with normal y (O straight-x) or x (O straight-y) is k-free | **proved** mod Lemma O, (S), (R⁺); computed 10 552 + 20 552 |
| 10 | **(b)**: the k-line through m is k-free | **proved** from (R⁺) alone (and a corollary of 9); type-only: **solver** L = 5 without oddness, cores grow (4, 8, 28 hexagons at distance 4, 8, 12) |
| 11 | **(RP), d = 1**: u and v lie on uniform chains, of axis y (straight-x) or x (straight-y) | **proved mod Lemma O, (R⁺), (S≥1)** (+ Theorem D, proved); computed 10 552 + 20 552 |
| 12 | **Walls**: every two-way axis of an odd three-type state has a sign-separated wall, and every type-k vertex beside it lies on a uniform chain | **proved** mod the same three laws; computed 543 + 727 axes, Theorem D's conclusion 2678 + 4214 planes |
| 13 | **H ⇐ K_u + Lemma O + (R⁺) + (S≥1)** | **proved** (reduction) |
| 14 | (S≥1): two type-k vertices of a k-line with ≥ 1 non-k vertex between them and none of type k share a sign, in **every** frozen state | **solver** (type-only + signs, no oddness): gaps 1, 2 at L = 4, gaps 1, 2, 3 at L = 5; gap 0 needs oddness (UNSAT only with an odd hexagon) — it is Lemma O |
| 15 | **W_r (type-only)**: τ(2,0,2) = x, τ(u) = τ(u′) = z ⇒ the A-plane y = 0 is z-free | **solver** L = 3, 4, 5, no oddness, no three types; LP relaxation positive (6, 16): needs integrality; cores global |
| 16 | type-only decomposition of (RP): pattern ⇒ plane is type-only; plane ⇒ uniform chain needs oddness (and three types in the straight-x case) | **solver** L = 3, 4 |
| 17 | (g) 'three types' is used once, in Theorem D(iii); in two-type states every failing member lies on a complete type-k B-plane (the excluded alternative of D) | **proved** (location of use); **computed** 14 244 / 14 244 and 31 344 / 31 344 |
| 18 | (d ≥ 2) SS pairs: the stripe theorem applies, but that the member itself borders a wall is not proved | **computed** (h220), open here |

The three inputs of 11–13, with their standing: **Lemma O** (every hole of an odd state has one rod in, one out) — solver (orient report: bond model L = 3; Theorem U, type-only, L = 3, 4, 5), corner case proved by hand, straight case ⟺ Theorem U, hand residue (V). **(R⁺)** — two type-k vertices at transverse offset (±1, ±1) share a sign, any k-separation; solver L = 3, 4, 5 in all frozen states (extremal §9), Lemma R its first two members (cage check). **(S≥1)** — row 14. The line-sign law (S) = Lemma O (gap 0) + (S≥1).

## 1. Local lemmas (type-only, proved)

**Lemma T (transfer).** Pᵏ at O reads K(0,0,4) − K(m) = K(u′) + K(v′) − K(u) − K(v), with K = [τ = z]. The left side is K(0,0,4) ∈ {0,1} (m is type x), the right side K(u′) + K(v′) − 2 ≤ 0. Both vanish: (0,0,4) is not type z and u′, v′ are type z. Since u′ = (0,0,4) + d₁ and v′ = (0,0,4) + d₂ lie on the z-grid 3, (u′, v′) is a reversing pair at (0,0,4), its members on the −z side. Applying Lemma T to it returns (u, v): the transfer pairs the two bridgehead pairs of one cage and does not propagate. ∎ (Computed: 10 552 + 20 552.)

**Lemma St (straightness).** By law C, O has two rods; its z-methylenes m, (0,0,4) are not type z, so both rods are among the x-methylenes (±2,0,2) and the y-methylenes (0,±2,2). Suppose O were an (x,y)-corner with rods at σ_x e_x, σ_y e_y. In the hexagon (O, σ), σ = (σ_x, σ_y, σ_xσ_y), the A-vertices a_x, a_y are those rods and a_z is a z-methylene, so N_A = 2; its B-vertex b_z = O + (σ_x, σ_y, −σ_xσ_y) is a bridgehead (all four are type z by Lemma T) of hexagon axis z, so N_B ≥ 1, against (T2). Hence O is straight-x (both (±2,0,2) type x) or straight-y (both (0,±2,2) type y). ∎ (Computed: 8592 + 17 692 straight-x, 1960 + 2860 straight-y; the uniform chain has the third axis y exactly in the straight-x instances and the axis τ(m) = x exactly in the straight-y ones.)

**Sign pattern (bond rule d_{τ(a)}ε(a) = d_{τ(b)}ε(b)).** m → u (d₀): ε(u) = ε(m); m → v (d₃): ε(v) = −ε(m). Straight-x: r = (2,0,2) of type x is bonded to u = r + d₂ and u′ = r + d₃, so ε(u) = ε(r), ε(u′) = −ε(r); r′ = (−2,0,2) is bonded to v = r′ + d₁ and v′ = r′ + d₀, so ε(v) = −ε(r′), ε(v′) = ε(r′). Hence ε(u) = ε(v′) = −ε(u′) = −ε(v): **the bridgeheads with y = +1 carry one sign, those with y = −1 the other.** Straight-y: through (0,2,2) and (0,−2,2) of type y the same computation gives ε(u) = ε(u′) = −ε(v) = −ε(v′): **the split is by x.** ∎ (Computed: patterns (1,−1,−1,1) and (1,−1,1,−1) for (u,v,u′,v′) with ε(u) = +1, all instances.)

**Further forced literals (solver backbone, `h241`, pattern only, L = 3, 4, 5).** (2,0,−2), (−2,0,−2) ≠ z; (2,2,0), (−2,−2,0) ≠ y; p, q ≠ y (the two-hexagon lemma); (±3,±1,−1) ≠ x, (±1,±3,−1) ≠ y; (0,0,±4), (0,0,±8) ≠ z (at L = 5 the whole k-line of m). With an odd hexagon: (±2,0,2) ≠ y. With odd and three types: w = (2,2,0) is type z (the first step of the uniform chain; not forced without both hypotheses) and exactly one of (0,2,2), (2,0,2) is type z. Each of these is a finite (T2) consequence, several with hexagon cores of 1–8 hexagons (`h242`); none is used below except through Lemmas T and St.

## 2. The new global identity: Pᵏ for the moment field (proved)

Write n_k(v) = ε(v)[τ(v) = k], the k-component of the moment.

**Lemma sP.** In every frozen state, at every oriented hole O (one rod pointing toward O, one away) and for every axis k,
$$n_k(O+2e_k) - n_k(O-2e_k) \;=\; \sum_{s}\, s_k\, n_k(O+s)$$
(sum over the four bridgeheads, with the sign convention of the type law Pᵏ). At an unoriented hole the identity fails for every k.

*Proof (cage check, `h249_signedcage.py cage`).* Enumerate the 3¹⁰ type assignments of the ten cage vertices and keep the 1200 that satisfy (T2) on the cage's four hexagons (the count of Lemma R; law C and the type law Pᵏ hold in all of them). For each, solve the bond rule on the twelve cage bonds: it is consistent in all 1200 and fixes ε up to a global flip, which changes both sides of the identity and preserves orientation. In the 1104 oriented patterns the identity holds for all three k; the 96 unoriented patterns (all straight, the yy/zz and zz/yy cages of the orient report, 32 per rod axis) violate it for all three k (288 = 96 × 3 violations: along the rod axis the two antiparallel rods, along each other axis two type-k bridgeheads on opposite k-sides with opposite signs). The restriction of a frozen state to a cage is one of the enumerated patterns with its sign solution, so the check is a proof. Identical for A- and B-cages. ∎

The null space of the corpus data (`h249_signedcage.py 3`, 356 distinct signed cage rows per sublattice) is one-dimensional and is exactly this identity, the same vector as for the type rows: the moment field satisfies the cage law and nothing else linear on one cage.

**Theorem sLC.** If every hole of the sublattice S′ is oriented, then for every axis k the signed count s^S_k(x_i, x_j) = Σ_{v ∈ S k-line} n_k(v) is F̃(x_i) + G̃(x_j).

*Proof.* Word for word the proof of Theorem LC (wprime §2), with n_k in place of [τ = k]: summing Lemma sP over an S′-hole k-line telescopes the left side and leaves the vanishing mixed second difference of s^S_k on every unit square. ∎ In an odd state every hole is oriented (Lemma O), so sLC holds on both sublattices. Computed: 0 violations on 137 592 + 276 480 unit squares (`h248_signedlc.py`).

**Two-product lemma (proved).** Let P(a,b) = p(a) + p′(b) ≥ 0 and Q(a,b) = q(a) + q′(b) ≥ 0 on a product set X × Y, with P·Q ≡ 0 and neither identically zero. Then p and q are both constant, or p′ and q′ are both constant.

*Proof.* Q ≢ 0 gives a zero of P, so min P = 0 and the zero set of P is the product Z_P = I_P × J_P (I_P = argmin p, J_P = argmin p′); likewise Z_Q = I_Q × J_Q, and PQ ≡ 0 means Z_P ∪ Z_Q = X × Y. If I_P ≠ X and J_P ≠ Y, pick a₀ ∉ I_P, b₀ ∉ J_P: every (a₀, y) lies outside Z_P, so J_Q = Y, and every (x, b₀) likewise, so I_Q = X: Q ≡ 0, a contradiction. So I_P = X or J_P = Y, not both (P ≢ 0). If I_P = X (p constant), every row b ∉ J_P lies outside Z_P, hence in Z_Q, so I_Q = X: q constant. The case J_P = Y is symmetric. ∎

This is the sheet theorem's non-linear step ('a separable 0/1 function has a constant factor') in the form the signs need: the non-negativity of two separable counts plus the one non-linear constraint PQ = 0.

**Stripe theorem.** Let every hole be oriented and let (S) hold on the S k-lines. If S carries type-k vertices of both signs, there is a transverse axis n ≠ k such that P^S(ℓ) = #(+ type-k on ℓ) and Q^S(ℓ) = #(− type-k on ℓ) depend only on the x_n-coordinate of the S k-line ℓ. So every S-plane {x_n = c} is either k-free or *full of one sign*: each of its S k-lines carries type-k vertices, all of that sign.

*Proof.* P = (h + s)/2 and Q = (h − s)/2 are separable by LC and sLC, non-negative, PQ = 0 by (S), neither zero; apply the two-product lemma. ∎ Computed: 1565 + 1972 (state, axis, two-signed sublattice) instances, all striped, none in both directions.

**Lemma E (the sign-separated plane).** Let F be a k-free plane with normal n ≠ k, and let the type-k vertices of each neighbour plane F ± e_n share one sign σ_± (vacuous if that plane is k-free), with σ₊ = −σ₋ when both neighbours carry type k. If the holes of F are oriented (only needed in the two-sided case), (E′) holds at every hole of F.

*Proof.* At a hole O of F the k-methylenes lie in F and are not type k, so Pᵏ gives T₊ + T₋ = 0 with T_± = Σ_{s: s_n = ±1} s_k K(O+s), and Lemma sP gives σ₊T₊ + σ₋T₋ = 0. If one neighbour is k-free its T vanishes and so does the other; otherwise σ₊ = −σ₋ gives T₊ = T₋ = 0. The two bridgeheads with s_n = +1 have opposite s_k, so T₊ = 0 says they agree in type k, which is (E′); likewise on the other side. ∎

So (E′), false as a statement about all k-free planes and equivalent to Theorem U′ with companions (attack proposal §2.5), is automatic at a k-free plane that separates opposite signs: its content there is Lemma O at the plane's holes.

## 3. (RP) at distance 2

**Theorem RP₁.** Let the state be odd with all three types present, and assume Lemma O, (S≥1) and (R⁺). Let (m; u, v) be a reversing pair on axis k and O the hole between m and m + 4e_k on the side of u, v. Then O is straight along an axis a ∈ {τ(m), j}; with b the other transverse axis, the plane of m's sublattice through m with normal b is k-free, (E′) holds at each of its holes, and u and v lie on complete b-chains all of whose vertices are type k. b is the third axis j exactly when O is straight along τ(m).

*Proof (canonical frame, straight-x; straight-y is the same with x and y exchanged).* (S) = Lemma O (gap 0) + (S≥1).

1. By Lemmas T, St and the sign pattern, the B z-lines (1,1) and (−1,1) contain type-z vertices of sign ε(u) =: +, and (1,−1), (−1,−1) of sign −.
2. B carries both signs on z, so by the stripe theorem (P^B, Q^B) depends only on x or only on y. Only on x is impossible: P^B(1,·) ≥ 1 and Q^B(1,·) ≥ 1 would put both signs on the line (1,1), against (S). So it depends only on y: every B z-line of the plane y = 1 carries type-z vertices, all +, and every B z-line of the plane y = −1 carries type-z vertices, all −.
3. An A z-line (a, 0) is diagonally adjacent to the B-lines (a+1, 1) (nonempty, +) and (a+1, −1) (nonempty, −). A type-z vertex on it would have both signs by (R⁺). So the A-plane {y = 0} is z-free. This is step (c); step (b), the k-line (0,0), is its special case (and follows from (R⁺) and the lines of u and v alone).
4. Lemma E with F = {y = 0} ∩ A, σ₊ = +, σ₋ = −: (E′) at every hole of F.
5. Theorem D (w1prime §4: A-plane c k-free, (E′) at it, odd, three types) with j = y, c = 0: the B-plane y = 1 contains u, so it is not z-free, and the type-z vertices of the slab {1, 2} are complete y-chains of type z. In particular the y-chain of that slab through u, (0,2,2) – u – (2,2,0) – (3,1,−1) – …, is uniform. The mirror (x,y,z) ↦ (x,−y,−z) (a lattice symmetry) gives v on a uniform y-chain of the slab {−1, −2}. ∎

Computed along the proof (`h240_rp_frame.py verify 3|4`, all 10 552 + 20 552 canonical instances): Lemma T, straightness, the sign pattern, (S) on the B z-lines, the stripe direction (y for straight-x, x for straight-y), the k-free plane, (E′) at every hole of it, and the uniform chain of the predicted axis: 0 exceptions in each.

**Where 'odd' enters:** Lemma O (steps 2, 4) and Theorem D(iii). **Where 'three types' enters:** only Theorem D(iii) (§6). (R⁺) and (S≥1) hold in every frozen state.

## 4. Every two-way axis carries a uniform chain; H ⇐ K_u + Lemma O + (R⁺) + (S≥1)

**Theorem W (walls).** Let the state be odd with three types, with Lemma O, (R⁺), (S≥1). If axis k is two-way, there are a normal n ≠ k and a k-free plane F with normal n whose neighbour planes are each k-free or uniformly signed, not both k-free and not of one sign. Every type-k vertex of a non-free neighbour of F lies on a uniform chain (axis n).

*Proof.* Label each plane {x_n = c} (an A-plane for c even, a B-plane for c odd) by the set of signs of its type-k vertices.

*Case 1: some sublattice S carries both signs.* By the stripe theorem choose n so that every S-plane is k-free or full of one sign; both signs occur. (i) An S′-plane next to a full + S-plane has labels in {0, +}: each of its type-k vertices is diagonally adjacent to nonempty + S-lines, (R⁺). (ii) Every S′-plane has a single label: if S′ is two-signed it is striped, and not along the other transverse axis m (a − stripe along m would put a − line into the S′-plane beside a full + S-plane, against (i)), so along n; if S′ is one-signed it is trivial. Now go round the cyclic sequence of S-planes and take a full + S-plane c₁ followed, after k-free S-planes only, by a full − S-plane c₂. Between them all labels are single; let c* be the last + plane in [c₁, c₂) and c** the first nonzero plane after it, which is −. By (i) and its mirror, c** ≥ c* + 2; take F = c* + 1.

*Case 2: A all of sign σ, B all of −σ.* By (R⁺) no nonempty A-line is diagonally adjacent to a nonempty B-line. With LC's product zero sets Z_A = I × J, Z_B = I′ × J′: if I and J were both proper, a full A-column and a full A-row would empty two B-columns and two B-rows and force Z_B = everything, against B ≠ ∅; so Z_A is a union of full planes of one normal, and so is Z_B, with the same normal n (a full A-plane of one normal meets the diagonal neighbourhood of a full B-plane of the other). Full A- and B-planes are never adjacent; take a full A-plane c* whose next nonempty plane is a B-plane and put F = c* + 1, whose other neighbour c* + 2 is k-free.

In both cases Lemma E gives (E′) at F and Theorem D (in the orientation fixed by the lattice symmetries) puts every type-k vertex of the non-free neighbour on a complete type-k n-chain. ∎

Computed (`h248_signedlc.py stripes 3|4`): every two-way axis has such a wall (543 / 543 and 727 / 727 in three-type states; 264 / 264 and 280 / 280 in two-type states), (E′) holds at every hole of every such wall (2469 + 3743 walls), and Theorem D's conclusion holds on every non-free neighbour in three-type states (2678 + 4214).

**Corollary (H, conditional).** In an odd state some direction is absent, given K_u (certified), Lemma O, (R⁺) and (S≥1). *Proof.* If a type is absent, Lemma A. If some axis is one-way or empty, a direction is absent. Otherwise take any axis (it is two-way); Theorem W gives a uniform chain (same-type neighbours share a sign, so it carries one moment); K_u gives an absent direction. ∎

This replaces the proposal's H ⇐ K_u + (RP) + (A₃): (A₃) and (E′) drop out, and the only oddness-dependent input is Lemma O, i.e. Theorem U, whose hand residue is (V). **This reduction should be audited by the main loop before it is relied on**; every step is written above and each has been checked on the corpus and on the solver samples of §7.

## 5. What holds in the type-only model (task (f))

- Local, proved: Lemma T, Lemma St and the forced literals of §1.
- **W_r (solver, `h244_hypq.py`):** three literals suffice for the plane: τ(2,0,2) = x and τ(u) = τ(u′) = z force the A-plane {y = 0} to be z-free, in the type-only model, without oddness and without three types, at L = 3, 4, 5 (UNSAT 0.02 s, 0.28 s, 2.2 s). The configuration is one x-rod of an A-hole with its two cage bridgeheads of type z. In odd states (Lemma O) the other two bridgeheads are then type z as well (otherwise the cage is the unoriented yy/zz cage), so W_r's configuration is the reversing-pair cage.
- (c) and (b) are therefore type-only statements. They are not counting statements: the LP max of the plane's type-z count under one-hot, (T2) and the three literals is 6 (L = 3) and 16 (L = 4) (`h246_lp.py`), so a proof needs integrality; the deletion-minimal hexagon cores for single plane vertices at L = 6 have 439–948 hexagons (`h242`), and the type-z freeness of the whole k-line of m has cores 4, 8, 28 at distance 4, 8, 12. My proof of (c) uses signs and Lemma O and so covers odd states only; a type-only proof (which would also cover the curl-free states, where W_r holds but Lemma O fails) is open.
- (RP)'s two halves (`h243_rp_queries.py`, L = 3, 4): pattern ⇒ plane: UNSAT without oddness. Plane ⇒ chain: the straight-y case (plane {x = 0}) needs oddness only; the straight-x case needs oddness and three types.

## 6. The role of 'three types' (task (g))

In the proof it is used once: Theorem D(iii) excludes Δ ≡ −1, i.e. the whole neighbour plane of type k, by S1 + M′, which need a vertex of the normal's type. In a two-type state (in the canonical frame the absent type is always the third axis y, so O is straight-x) steps 1–4 go through unchanged (computed: plane, stripes and (E′) in all 24 496 + 52 496 two-type instances), and D's alternative occurs: **every member without a uniform chain lies on a complete type-k B-plane {y = ±1}** (14 244 / 14 244 at L = 3, 31 344 / 31 344 at L = 4; 1764 + 5328 members have both). So in two-type states the reversing pair still sits beside a free plane, but its side of the wall can be one full plane of type k.

## 7. Independent checks on solver-generated states

`h244_hypq.py sample` draws odd, three-type frozen states with a sign field from the type-only model (random type assumptions for diversity); `h248_signedlc.py stripes L file` checks Lemma O at every hole, (S) on every line, sLC, the stripe theorem, walls on every two-way axis, (E′) at every wall and Theorem D's conclusion. **Computed, 0 exceptions:** L = 5, 142 states (seed 3): Lemma O at every hole 142/142, (S) and sLC on all 426 (state, axis), stripe theorem 368/368, walls on 184/184 two-way axes, (E′) at 809/809 walls, Theorem D's conclusion 1208/1208. L = 6, 44 states (seed 4; batch stopped at its 300 s cap after 44 of 60): 44/44, 132/132, 130/130, 65/65, 334/334, 486/486. These states are outside the corpus and larger than it, so the chain of §2–§4 is not a feature of the L = 3, 4 corpus.

## 8. What failed, and why

- **A type-only proof of (c).** The claim is type-only (W_r), but LP-positive with global cores, so it needs a non-linear step on the type field alone; the sign-free separable quantities available (LC's three potentials α(x), β(y), γ(z) per sublattice, the wprime/w1prime height functions) gave no product structure with a zero/nonzero dichotomy. The signed counts supply exactly that dichotomy (PQ = 0), which is why the proof goes through signs.
- **Propagating the pair along the line.** Lemma T pairs the two bridgehead pairs of one cage and is an involution; the k-freeness of the line beyond m ± 4e_k and m + 8e_k is not local (cores grow).
- **Avoiding (R⁺).** It is used at one point: an A-line between a full + and a full − B-plane is empty. From Lemma sP at the holes of those planes one gets only a Cauchy–Riemann relation for the + (resp. −) A-kinks on the two A-planes beside each B-plane — a height function, not a contradiction. Lemma R (proved) covers only k-separations ≤ 3.
- **Avoiding (S≥1).** The two-product lemma needs PQ = 0 on every line; with only |s| ≤ h and s ≡ h (mod 2) the zero sets of P and Q need not cover the torus and nothing follows.
- **(RP) for d ≥ 2.** The stripe theorem applies to any two-signed sublattice, but I have not shown that a member of a longer SS pair borders a wall (a + stripe can be two planes wide). Not needed for H by §4.

## 9. The exact residual

For (RP) at d = 1, for Theorem W and for H (given K_u), the residual is three sign laws and nothing else:

1. **Lemma O** in odd states (equivalently Theorem U: an unoriented straight cage forces curl-free). Solver L = 3, 4, 5; hand residue (V). The only input that needs oddness.
2. **(R⁺)** in frozen states. Solver L = 3, 4, 5; hand-proved for k-separation ≤ 3 (Lemma R).
3. **(S≥1)** in frozen states. Solver gaps 1–2 at L = 4, 1–3 at L = 5; gap 1 also in the lines report.

Items 2 and 3 are laws of every frozen state (no oddness), statements about finitely many vertices apart from the unbounded separation along one line, and are the natural next hand targets; item 1 is (V).

## 10. Files

New scripts in `experiments/08_frozen_structure/scratch_h/` (run with the brief's environment line):

- `h240_rp_frame.py L [R]` — canonical frame of all reversing pairs, constant-type table; `verify L [two]` — every step of Theorem RP₁ on the corpus, and the two-type analysis. Cache `.tmp/h240_frame_L*.pkl`.
- `h241_rp_backbone.py L R cap variants` — backbone of the pattern (P, PO, PO3, with Sx/Sy).
- `h242_core.py L cap target [extra] [flags]` — deletion-minimal hexagon cores (own capped worker).
- `h243_rp_queries.py L cap claims variants` — the steps of (RP) as solver queries.
- `h244_hypq.py` — minimal hypotheses for the plane (W_r); `sample L n seed cap` — solver samples with signs.
- `h245_hypbackbone.py` — backbone of an arbitrary hypothesis.
- `h246_lp.py` — LP relaxation of the plane claim.
- `h247_slab.py` — slab-reach queries; `gap L cap g,…` — (S) with gaps, type-only + signs, with and without oddness.
- `h248_signedlc.py [L]` — signed LC, (S), (R⁺) on the corpus; `stripes L [file]` — stripe theorem, walls, (E′), Theorem D's conclusion.
- `h249_signedcage.py L` — null space of signed cage data; `cage` — the cage check proving Lemma sP.

Outputs cited are reproduced by these commands (0.5–25 s each; the samplers up to 5 min).
