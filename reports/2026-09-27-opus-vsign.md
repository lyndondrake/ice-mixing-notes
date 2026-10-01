---
title: "(V) through the signed cage defect (agent vsign): the defect of the signed cage law is the hole's charge c = #away − #toward, the same for all three axes (proved); the signed line counts obey a Poisson equation whose source is a divergence of cross counts on the other sublattice (proved), so the charges are neutral on every plane (the flux identity) and in every rectangle with empty corner lines; but no hole's orientation is forced by an unoriented hole, the sign field shortens no window, the signed LP stays positive, and (V) is not proved. What is new and quantitative: the gap-1 line-sign law on x-lines (or (R⁺) at x-separation 5) cuts the x-reach of Theorem U from 2L − 2 to 2⌈L/3⌉ + 1 (solver, L = 4 … 10), while the transverse torus stays fully needed; integrality of the hole charges alone closes the signed LP at L = 3"
author: "Claude (Opus), agent vsign, for Lyndon Drake"
date: 2026-09-27
---

Status tags: **proved** (argument written here, or an exhaustive cage check, the project's standard for Lemma R and Lemma sP), **computed** (exact, no SAT solver: enumeration, data checks, LP with HiGHS), **solver** (CaDiCaL through `h32_cap`, type-only model with the sign field where stated, on the (L,L,L) torus), **conjecture**. All computation on this Mac, one solver process at a time; nothing over ten minutes in the foreground (one MILP was stopped at its 540 s limit without a verdict, §7). Scripts `scratch_h/h300_lib.py` … `h309_lawreach.py` (new). No tracked file was edited and nothing was committed.

Frame throughout (as uhand): the A-hole O = (2,0,0), rods v = (0,0,0), v′ = (4,0,0) of type x, lower bridgeheads β = (1,1,1), β′ = (1,−1,−1), upper bridgeheads γ = (3,1,−1), γ′ = (3,−1,1). The unoriented pattern yy/zz is β, β′ of type y and γ, γ′ of type z. (V): no B-site of the grid x = 1 (g+1) is of type x.

## 0. Status table

| # | statement | status |
|---|---|---|
| 1 | **Lemma D.** At every hole O and for every axis k, the defect of the signed cage law is D_k(O) = c(O) := #rods pointing away − #rods pointing toward O ∈ {−2, 0, 2}; the same for all three k | **proved** (cage check, `h301`; hand computation for yy/zz) |
| 2 | **Rod cancellation.** The total charge on an S′-hole k-line is a divergence of the signed cross counts U_i, U_j (type i resp. j on the S′ k-lines) | **proved** |
| 3 | **Signed LC with sources.** σ_{S′} □s^S_k + ∇·U^{S′} = 0 on every unit square, in every frozen state (sLC is the case of no charges) | **proved** from 1, 2; computed 0 violations |
| 4 | **Neutrality.** The charges of each sublattice sum to 0 on every coordinate plane of holes (this is the flux identity M_n(p+2) = M_n(p−2)); in any rectangle of hole lines the charge is at most the sum of h over its four corner lines, hence 0 when the corner lines are k-free | **proved** |
| 5 | An unoriented hole has an opposite charge in each of its three planes; the smallest neutral configuration is two antiparallel dipoles (4 holes); under (S≥1) the rod line of an unoriented hole carries an even number ≥ 2 of flips, all at adjacent pairs | **proved** (the last: mod (S≥1)) |
| 6 | Staircase analogue: by W_r the unoriented cage is uwall's turn (case (i,i)) beside the y-free A-plane {z = 0}; (V) ⟸ the turn repeats along the y-line of holes through O ⟸ one pair of B y-lines (1, z₀) full and (3, z₀) empty; transfer step ⟺ K(2, 4n+4, 2) = K(0, 4n+2, 2) | **proved** (mod W_r, which is solver) |
| 7 | Geometry of U in curl-free states: every unoriented hole sits on a complete rod line; complete lines carry 0, 2 or 4 flips; charged hole lines of every axis occur | **computed** (30 witnesses L = 3, 4, 5 and 40 samples) |
| 8 | No propagation: under yy/zz every other hole of both sublattices can be oriented and can be unoriented | **solver** L = 3, 4 (full torus, with signs) |
| 9 | The sign field shortens no window (slab threshold 2L − 2 with and without it) | **solver** L = 4 |
| 10 | The (R⁺)-consequences at the cage (four x-free B x-lines, two y-free and two z-free A lines), with or without the rods, force nothing | **solver** L = 4 |
| 11 | No signed counting proof: the signed LP (types, moments, bond rule, Lemma D) is positive: 8.50, 19.18, 32.93 at L = 3, 4, 5 (unsigned 26/3, 178/9, 299/9) | **computed** |
| 12 | Integrality of the hole charges alone (all, or the A-charges, or the B-charges) closes the signed LP at L = 3; charges of O's plane or lines do not | **computed** L = 3; L = 4 no verdict in 540 s |
| 13 | **x-localisation by the line laws.** With the gap-1 line-sign law on the x-lines inside the window (or (R⁺) at x-separation 5), Theorem U and (V) hold on the slab \|dx\| ≤ R*(L) = 5, 5, 5, 7, 7, 7, 9 for L = 4 … 10, i.e. 2⌈L/3⌉ + 1; without them 2L − 2 | **solver** |
| 14 | The transverse torus stays fully needed with every law on every axis (tubes and boxes SAT); only the x-lines' laws matter, only on A, only the triples through O's grid (L ≤ 6) | **solver** L = 5 (and 4, 6) |
| 15 | The law instances themselves: gap-1 (S) is x-global (slab 2L − 2) but transversally shorter (tube 6, 6, 8 at L = 4, 5, 6); (R⁺) at separation 5 needs the whole torus | **solver** L = 4, 5, 6 |
| 16 | (V), Theorem U | **not proved**; exact residual §9 |

## 1. Lemma D: the defect is the charge (proved)

For a hole O of sublattice S′ with rods r = O + 2σe_a (law C: two of them), the rod points away from O iff ε(r) = σ (orient report §2). Put

  c(O) = Σ_{rods r = O + 2σ e_a} σ ε(r) = #away − #toward ∈ {−2, 0, 2},  η(O) = c(O)/2.

c = 0 iff O is oriented; η = +1 is a *source* (both rods away), η = −1 a *sink*. Write the signed cage defect, with Πs = σ_{S′} over the bridgeheads (σ_A = −1, σ_B = +1),

  D_k(O) = n_k(O + 2e_k) − n_k(O − 2e_k) − Σ_s s_k n_k(O + s),  n_k = ε[τ = k].

**Lemma D.** *In every frozen state, D_x(O) = D_y(O) = D_z(O) = c(O) at every hole O.*

*Proof (cage check, `h301_defect.py`, 0.2 s).* As for Lemma sP: of the 3¹⁰ type patterns of a cage, the 1200 satisfying (T2) on its four hexagons, each with the bond rule solved on its twelve bonds (consistent in all 1200, unique up to the global flip, which changes the signs of c and of every D_k together). Result, identical for A- and B-cages: the 1104 oriented patterns have D = (0,0,0); the 96 unoriented ones (rod axis a with bridgeheads the two other types, one pair per side) have D = (c, c, c) with c = ±2, in all 96. Since the restriction of a frozen state to a cage is one of these patterns with its sign solution, this is a proof. ∎

*Hand computation for yy/zz (the case Theorem U needs).* Bond rule d_{τ(a)}ε(a) = d_{τ(b)}ε(b): v → β along d₀ gives ε(β) = ε(v); v → β′ along d₁ = (1,−1,−1) gives ε(β′) = −ε(v); v′ → γ along d₂ = (−1,1,−1) gives −ε(v′) = −ε(γ); v′ → γ′ along d₃ = (−1,−1,1) gives −ε(v′) = ε(γ′). No bridgehead is of type x and no transverse methylene is a rod, so

  D_x = ε(v′) − ε(v),  D_y = −(ε(β) − ε(β′)) = −2ε(v),  D_z = −(−ε(γ) + ε(γ′)) = 2ε(v′)

(β, β′ have s_y = +1, −1; γ, γ′ have s_z = −1, +1). Always c(O) = ε(v′) − ε(v) (v is on the − side). The cage is unoriented, ε(v′) = −ε(v), so all three defects equal 2ε(v′) = c(O). (At an oriented pattern D = 0 = c, by the cage check.) ∎

So Lemma sP is the case c = 0 of Lemma D, and "fails by ±2 for all three axes" (rphand) is: *the defect is the charge, and it does not depend on the axis.*

## 2. Rod cancellation and the Poisson equation (proved)

Coordinates: for an axis k let i < j be the others; an S k-line is indexed by its transverse position (α, β) = (x_i, x_j). h^S_k(α,β) = # type-k vertices on it, s^S_k(α,β) = Σ n_k over it. For the other two types put U^{S′}_{i|k}(α,β) = Σ_{w on the S′ k-line (α,β)} n_i(w), and likewise U_{j|k}.

**Proposition (rod cancellation).** *For the S′-hole k-line ℓ at (α,β),*

  Σ_{O∈ℓ} c(O) = U_{i|k}(α+2,β) − U_{i|k}(α−2,β) + U_{j|k}(α,β+2) − U_{j|k}(α,β−2).

*Proof.* Every S′-vertex w of type a is a rod of exactly the two holes w ∓ 2e_a, contributing +ε(w) to c(w − 2e_a) (w is on the + side there) and −ε(w) to c(w + 2e_a). A rod of axis k has both holes on one hole k-line: its contributions cancel on ℓ. A rod of axis i has its holes on the hole k-lines (α_w ± 2, β_w); it meets ℓ iff w lies on the S′ vertex k-line (α ± 2, β), and then contributes ±ε(w) = ±n_i(w), the sign + for the line α + 2. Each type-i vertex of that line meets ℓ exactly once. The same for j. ∎

**Theorem (signed LC with sources).** *In every frozen state, for every S, k and every S′-hole k-line (α,β),*

  σ_{S′} [s(α+1,β+1) + s(α−1,β−1) − s(α+1,β−1) − s(α−1,β+1)] = −Σ_{O∈ℓ} c(O) = −(∇·U^{S′}_{⊥k})(α,β),

*with s = s^S_k.*

*Proof.* Sum Lemma D over the holes of ℓ: the methylene terms telescope round the k-circle (sLC's proof), leaving −σ_{S′} □s = Σ D_k = Σ c. Then the Proposition. ∎

Theorem sLC (rphand) is the case in which every hole is oriented. The identity itself holds everywhere, without oddness: it couples the signed k-counts of S (a mixed second difference) to the signed transverse counts of S′ on the same k-lines (a divergence). **Computed** (`h302_witness.py analyse`): Lemma D at 35 712 holes, the Poisson form at 26 592 hole lines and the divergence form at the same lines, 0 violations, on 30 curl-free witnesses with an unoriented cage (L = 3, 4, 5) and 40 unconstrained samples at L = 4 (35 odd, 5 curl-free).

**Corollaries (proved).**

1. *Plane neutrality.* Summing the Poisson identity over a full row of hole lines telescopes to 0: the charges of each sublattice sum to zero on every coordinate plane of holes, for all three normals. By rod cancellation the charge of the S′-hole plane {x_n = p} is M^{S′}_n(p+2) − M^{S′}_n(p−2) (rods of axis ≠ n cancel inside the plane), so plane neutrality *is* the flux identity; for the planes containing the rod axis x it uses the x-circle, for the plane normal to x it uses the transverse circles.
2. *Rectangle bound.* For a rectangle R of S′-hole k-lines with corner S k-lines a′ < a″, b′ < b″ (one step outside R), |Σ_{O over R} c(O)| ≤ h(a′,b′) + h(a″,b″) + h(a′,b″) + h(a″,b′). In particular a rectangle whose four corner lines are k-free carries zero net charge.
3. *Partners.* An unoriented hole O has a hole of opposite charge in each of its three planes. The smallest configuration neutral on every plane has four holes, and it is two antiparallel dipoles on parallel lines: +(0,0,0), −(0,0,a), −(b,c,0), +(b,c,a) (charges ±1 with zero plane sums force an even number; two holes would coincide; the four-hole case is forced into this shape by the plane counts).
4. *Dipoles on the rod line (mod (S≥1)).* If (S≥1) holds on the S′ a-line through the rods of O, then going round the type-a vertices of that line the sign changes an even number of times and never across a gap, so the hole line carries an even number ≥ 2 of unoriented a-holes with alternating charges, each between two adjacent type-a vertices.

## 3. What the charges look like where they exist (computed)

Unoriented holes exist only in curl-free states (Lemma O, solver), so the geometry of U can only be read there. `h302_witness.py` on states of the type-only model with the sign field (genuine ice states), with yy/zz at O (12 states at L = 3, 10 at L = 4, 8 at L = 5) and without hypothesis (40 at L = 4, of which 35 odd with U = ∅ and 5 curl-free):

| quantity | L = 3 (yy/zz) | L = 4 (yy/zz) | L = 5 (yy/zz) | L = 4 (free) |
|---|---|---|---|---|
| \|U\| per state | 36–96 | 64–192 | 160–420 | 80–192 (curl-free), 0 (odd) |
| unoriented holes on an incomplete rod line | 0 | 0 | 0 | 0 |
| complete lines with 0 / 2 / 4 flips (x on A) | 0 / 216 / 0 | 64 / 192 / 48 | 0 / 370 / 70 | — |
| charged A-hole x-lines | 0 | 0 | 0 | 72 |
| charged A-hole y- / z-lines | 208 / 176 | 140 / 196 | 228 / 256 | 12 / 24 |

Reading. With yy/zz the unoriented A-holes all have rod axis x and sit in dipoles on complete A x-lines; the A-hole x-lines are all neutral (B is x-free, so s^B_x ≡ 0), and the charges show up on the *transverse* hole lines, where the Poisson identity turns them into z- or y-derivatives of the sign profile of an adjacent complete B-plane (for k = y and the hole plane x = 2: s^B_y(1, z−1) − s^B_y(1, z+1) = 2N_y(2, z), since the plane x = 3 is y-free and x = 1 is full). They fill neither lines nor planes: a sheet at L = 3 is 12 of the 18 A-holes of four of the six hole planes normal to x.

## 4. Negative results on propagation and on signs (solver, computed)

**No hole is forced by an unoriented hole (`h303_propagate.py`).** Full torus, type-only model with the sign field, yy/zz at O; for every hole H of both sublattices, "H oriented" and "H unoriented" (encoded on its six methylenes) asked separately.

| L | holes tested | forced unoriented | forced oriented | free | wall |
|---|---|---|---|---|---|
| 3 | 216 | O only | 0 | 215 | 1.2 s |
| 4 | 512 | O only | 0 | 511 | 5.4 s |

So neutrality forces partners but no particular partner: the defect does not propagate to any single hole, in any direction, on either sublattice. (ucore's "the next cage's pattern is free" is the case H = O + 4e_x.) Task 3 of the brief is answered negatively at the level of single holes.

**Signs shorten no window (`h304_slabsign.py`, L = 4).** x-slab |dx| ≤ R, full transverse torus, (T2) and optionally the bond rule on the window: (V) and "some hexagon odd" flip from SAT to UNSAT at R = 6 = 2L − 2 in both models.

**(R⁺)'s consequences at the cage force nothing (`h305_hyp.py`, L = 4).** (R⁺) at the antiparallel rods makes the four B x-lines (±1, ±1) x-free; at β, β′ (type y, opposite signs) the A y-lines (x,z) = (0,0), (2,0) y-free; at γ, γ′ the A z-lines (x,y) = (2,0), (4,0) z-free. Each of these, together or with the rods, leaves "B has type x", (V)'s negation and "some hexagon odd" all SAT; the four literals of U′ make all three UNSAT (0.5 s, 0.01 s, 0.9 s).

**No signed counting proof (`h306_signedlp.py`, computed).** Variables t(v,k) ≥ 0 and p, m ≥ 0 with p + m = t (n = p − m); one-hot, (T2); the bond rule, which is *linear in n* (Σ_k d_k n_k(a) = Σ_k d_k n_k(b)); Lemma D as E_x = E_y = E_z at every hole; yy/zz with n_x(v) = −1, n_x(v′) = +1. Maximise the type-x mass of B-grid g+1:

| L | types only (uhand) | + bond rule | + Lemma D | + charges e = η + 1 ∈ [0, 2] |
|---|---|---|---|---|
| 3 | 26/3 ≈ 8.67 | 8.50 | 8.50 | 8.50 |
| 4 | 178/9 ≈ 19.78 | 19.18 | 19.18 | — |
| 5 | 299/9 ≈ 33.22 | — | — | 32.93 |

The signed laws remove almost nothing; so the Poisson identity, plane neutrality and the rectangle bound, all rational consequences of these rows and of t ≥ 0, cannot prove (V) by any weighting. (Imposing sP at every hole except those of O's x-hole line makes the LP infeasible, as neutrality predicts; that is not a proof, since other holes may be unoriented.)

## 5. Where integrality has to enter (computed; L = 4 left open)

With the charges as variables and **integral** (η ∈ {−1, 0, 1}), everything else continuous (`h306 … TSDE[e]`):

| integral set (L = 3) | optimum | time |
|---|---|---|
| all hole charges (216) | 0 | 61 s |
| A-hole charges (108) | 0 | 114 s |
| B-hole charges (108) | 0 | 82 s |
| A-hole charges of O's x-plane (18) | 7.67 | 9 s |
| A-hole charges on O's three hole lines (7) | 8.25 | 3 s |
| t_x on B-grids g±1 / on the A-grids of v, v′ (signed LP) | 0 / 0 | 32 s / 33 s |

So at L = 3, "(V) = signed linear laws + non-negativity + integrality of one sublattice's charges": a residual of uhand's shape with the integral family being the *hole charges* rather than a type family. **Caveat:** uhand found L = 3-only closures (the B-grids g±1 family closes at L = 3 and not at L = 4), and the L = 4 run with all charges integral stopped at its 540 s limit without an incumbent; the thin type family at L = 4 likewise hit its 300 s limit. Neither is a verdict. The L = 4 charge MILP is the one computation of this report that was reduced and left out (it would need more than ten minutes).

## 6. The staircase analogue (proved, mod W_r)

rphand's W_r (solver, type-only, no oddness): an x-rod of an A-hole with its two cage bridgeheads on that side of type z makes the A-plane through the hole with normal y z-free. At the unoriented cage its mirror applies to v with β, β′: **the A-plane P = {z = 0} is y-free**, and O lies in it. In uwall's frame (i, j, k) = (x, z, y), P is a k-free plane with normal j, and the bridgehead pattern of O, (K b₁, K b₂, K b₃, K b₄) = (K γ′, K β, K γ, K β′) = (0, 1, 0, 1), is the turn of the mirror orientation, with both i-methylenes rods: uwall's case (i,i). So (V) is, verbatim, "a turn of case (i,i) at a free plane forces curl-free", and uwall's apparatus applies:

- **Staircase lemma (uwall T4, with LC for (B, y)).** h^B_y(x, z) = F(x) + G(z). If for one z₀ the B y-line (1, z₀) is full of type y and the B y-line (3, z₀) has none, then F(1) − F(3) = L, so the B-plane {x = 1} is entirely of type y — which is (V) — and {x = 3} is y-free. The natural candidates are z₀ = 1 (the lines of β and γ′) and z₀ = −1 (β′, γ).
- **Transfer along the y-line of holes H_n = O + 4n e_y.** Pʸ at the B-hole between β(n) and β(n+1) = β(n) + 4e_y reads
  K β(n+1) − K β(n) = K(2, 4n+4, 2) − K(2, 4n+2, 0) + K(0, 4n+4, 0) − K(0, 4n+2, 2), K = [type y].
  The second and third terms lie on the A y-lines (2, 0) and (0, 0) of P, which are y-free, so **the turn propagates from H_n to H_{n+1} iff K(2, 4n+4, 2) = K(0, 4n+2, 2)**: type y constant along the (1,1,0)-diagonal of the A-plane z = 2 — exactly uwall's transfer condition. With signs nothing is gained: (R⁺) puts every type-y vertex of the A y-lines (0, 2), (2, 2) and of the B y-line (1, 1) on one sign, and then the signed transfer (Lemma D at the same B-holes) says only that those B-holes are oriented.

So task 4 has a precise answer: the repetition to look for is the turn along the y-line of holes through O (or the z-line, with the roles of β and γ exchanged), and its transfer step is uwall's; it is as global as (V) (the solver makes every B-site of the grid g+1 flip together).

## 7. The line laws localise the x-direction partly (solver)

`h308_lawslab.py`: full-torus variables; (T2) and the bond rule only on the window; a line law imposed as an axiom (it holds in every frozen state, so a window lemma under it is a valid reduction U ⇐ law + window). Queries: (V)'s negation and "some hexagon of the window odd", with a SAT control.

**Threshold of the symmetric x-slab |dx| ≤ R (full transverse torus).**

| L | no law | (S≥1) gap 1, x-lines, triples inside the slab | (R⁺) x-lines | all laws, all axes |
|---|---|---|---|---|
| 4 | 6 | **5** | 5 (sep ≤ 5 suffices) | 5 |
| 5 | 8 | **5** | 5 (sep ≤ 5; sep ≤ 3 does not) | 5 |
| 6 | 10 (2L − 2) | **5** | 5 (sep ≤ 5) | — |
| 7 | 12 | **7** | 7 (both laws on x-lines) | — |
| 8 | (14) | **7** | — | > 6 |
| 9 | (16) | **7** | — | — |
| 10 | (18) | **9** | — | — |

(Values in brackets are 2L − 2, checked here at L = 4, 5, 7 and by h101/ucore at L = 4, 5.) The first UNSAT R fits **R*(L) = 2⌈L/3⌉ + 1** at every L = 4 … 10; the "odd" and (V) queries flip together in every row. Details:

- *Which law.* Either law on the x-lines alone gives the whole gain; on the y- or z-lines alone the threshold at L = 5 is 7 (from 8). (S≥1) at gap 1 suffices (gap 2 adds nothing), on **A** x-lines only (B x-lines alone: SAT), and at L = 4, 5, 6 only the triples whose middle vertex lies on O's own A-grid dx = 0 (at L = 7 that restriction is no longer enough). (R⁺) at x-separation ≤ 5 suffices; ≤ 3, which is Lemma R and already implied by the cages in the slab, does not.
- *Asymmetric windows (L = 5).* [−5, 4] and [−4, 5] (10 grids) suffice with the gap-1 law; [−4, 4], [−3, 6], [−6, 3], [−7, 2], [−2, 7], [−2, 8] do not.
- *The transverse torus stays global.* With the x-law on every x-line: at L = 5, restricting the law to x-lines within transverse distance 8 of O (of 10) leaves (V)'s negation SAT, distance 9 makes it UNSAT; every box |dx| ≤ 5 or 7, |dy|, |dz| ≤ 6, 8, 9 is SAT; with all laws on all three axes every tube |dy|, |dz| ≤ 4 … 9 (full x-circle) is SAT.

So the line laws buy a factor of about three in the x-reach and nothing transversally. **Consequence (solver-level reduction):** Theorem U ⇐ (S≥1) at gap 1 on the x-lines + [the slab lemma: (V) on |dx| ≤ 2⌈L/3⌉ + 1]; and since H needs (S≥1) anyway, H ⇐ K_u + (R⁺) + (S≥1) + slab lemma. The slab lemma is still linear in L and transversally global, so this is a sharpening of the residual, not a localisation.

**How global are the law instances themselves (`h309_lawreach.py`).** Negation of gap-1 (S) on an A x-line (a, c = a + 8e_x of type x, b = a + 4e_x not, ε(a) ≠ ε(c)), and of (R⁺) at separation 5 (a ∈ A, w = a + (5,1,1) ∈ B, both type x, opposite signs):

| L | gap-1 (S): slab / tube threshold | (R⁺) sep 5: slab / tube |
|---|---|---|
| 4 | 6 / 6 (of 8) | 8 / 8 (whole torus) |
| 5 | 8 / 6 (of 10) | 10 / 10 |
| 6 | 10 / 8 (of 12) | 12 / 12 |

Gap-1 (S) is x-global (slab 2L − 2) but needs less than the whole transverse torus; (R⁺) at separation 5 needs everything. Oddness shortens neither. So the decomposition of Theorem U by (S) at gap 1 trades an x-global, partly transversally local statement (the law) against a transversally global statement with a third of the x-reach (the slab lemma).

## 8. What failed, and why

- **Propagation of unorientedness** (brief item 3). No single hole's orientation is forced (§4). The only propagation is neutrality — every plane through O carries a partner — which is a counting statement and so (§4, LP) cannot carry the proof.
- **A signed counting proof.** The Poisson identity, plane neutrality, the rectangle bound and Lemma D are all rows of the signed LP, which stays positive at L = 3, 4, 5. Signs make the bond rule linear, but the relation between n and t (|n| ≤ t, n ≡ t mod 2) is the nonlinear part, and that is where the proof would have to live.
- **A signed window.** The sign field changes no window threshold (§4) — the same finding as uwall's for the corner case.
- **A sign-forced plane.** A first reading of the full-torus backbone with signs suggested the A-plane {z = 0} is forced to be of type x; it is not — the forced literals are exactly W_r's two planes (P = {z = 0} y-free, {y = 0} z-free), B x-free, the grids g±1 monochromatic and the x-line of v (`h308 EXTRAQ`: "some A-vertex of {z = 0} is type z" is SAT on the full torus at L = 4). Recorded so that it is not rediscovered.
- **Using (S), (R⁺) to close U.** They cut the x-reach by a factor of three (§7) but leave a slab lemma whose reach still grows with L and which needs the whole transverse torus; imposing every law on every axis does not make any box or tube suffice.

## 9. The exact residual

The proved identities make the obstruction precise. In every frozen state:

- the charges c(O) of the unoriented holes are the sources of the signed line counts (§2), neutral on every plane (the flux identity) and in every rectangle with k-free corner lines;
- none of this, weighted in any way, excludes an unoriented hole (§4 LP), and no single further hole is forced (§4).

Two residual forms, each smaller than (V) in one respect:

> **(Vq) — integrality of charges (computed at L = 3 only).** One-hot, (T2), the bond rule in the moment variables, Lemma D, t ≥ 0, and η ∈ {−1, 0, 1} on the holes of one sublattice ⇒ the B-grid g+1 carries no type x. The L = 3 closure may be a small-cell effect; L = 4 needs a run of more than ten minutes.

> **(V_slab) — the slab lemma (solver, L = 4 … 10).** yy/zz at O; (T2) and the bond rule on the slab |dx| ≤ 2⌈L/3⌉ + 1 with the full transverse torus; gap-1 line-sign law on the A x-lines inside the slab ⇒ no type x on B-grid g+1, and no odd hexagon in the slab.

A hand proof of (V_slab) would, with (S≥1) (needed by H anyway), give Theorem U. Its x-reach is linear in L, so it still needs an invariant carried along x — now over a third of the circle — and it needs the whole transverse torus, as sheetcore's sheet theorem does: the natural next object is a separable (F(y) + G(z)) function on the transverse lattice of the slab, of the kind LC and sLC supply, whose integrality forces the plane x = 1 to be of type y. The staircase analogue (§6) names the line pair (the B y-lines through β and γ′) whose difference would have to reach L.

## 10. Files and computations

Scripts in `experiments/08_frozen_structure/scratch_h/` (run with the brief's environment line):

- `h300_lib.py` — hole records (rods, charge, defect D), line counts h, s, samplers.
- `h301_defect.py` — the cage check of Lemma D.
- `h302_witness.py sample L n seed cap [yyzz|zzyy|none|odd]` (env NRAND = number of random diversifying literals, default 3); `analyse FILE [k]` — Lemma D, Poisson, divergence form, plane neutrality, U geometry. Samples in `<repo>/.tmp/vsign_w_*.json`.
- `h303_propagate.py L RH W cap [pattern]` — orientation backbone of every hole.
- `h304_slabsign.py L cap slab|tube R,…` — windows with and without the sign field.
- `h305_hyp.py L cap [S] hyp…` — (R⁺)-derived hypotheses.
- `h306_signedlp.py L variant tl [integrality sets]` — the signed LP/MILP (variants T, TS, TSD, TSDE, TSDEe, TSDo; sets Bg13, Ag04, xline, eA, eB, eAxplane, eAlines; env FEAS for the feasibility form).
- `h307_nearmiss.py L R cap` — near-miss slab state with signs, charges listed.
- `h308_lawslab.py L cap slab|tube|box|aslab R,… none|R|S|RS` — windows under the line laws (env LAWAX, LAWNEAR, LAWGAP, LAWSEP, LAWINSIDE, LAWSUB, LAWMID, BOXRX; BACKBONE, EXTRAQ, DUMP for backbones, plane queries, near-miss dumps).
- `h309_lawreach.py L cap S1|R5 slab|tube R,…` — reach of the two law instances.

| command | what | verdict | wall |
|---|---|---|---|
| `h301_defect.py` | cage check | 1104 oriented D = 0; 96 unoriented D = (c,c,c) | 0.2 s |
| `h302 sample 3 40 1 120 yyzz`; `4 40 2 200 yyzz`; `5 30 4 300 yyzz`; `4 40 3 200 none` | witnesses | 12, 10, 8, 40 states | 0.5–1.3 s each |
| `h302 analyse` (four files) | identities, geometry | 0 violations; §3 table | < 1 min each |
| `h303 3 6 0 300`, `h303 4 8 0 300` | orientation backbone | only O forced | 1.2 s, 5.4 s |
| `h304 4 120 slab 3,…,7` | signs and windows | 6 with and without signs | 7 s |
| `h305 4 300 …` | (R⁺)-hypotheses | all SAT except rods + yz | 2 s |
| `h306 3 T/TS/TSD/TSDo`; `4 TS/TSD`; `5 TSDE` | signed LP | §4 table | 0.5 s; 9 s; 176 s |
| `h306 3 TSDE[e] …` (7 runs) | charge integrality | §5 table | 3–114 s |
| `h306 3 TSD 120 Bg13/Ag04/xline` | thin type integrality | 0 / 0 / 7.36 | 4–33 s |
| `h306 4 TSD 300 Bg13` | idem, L = 4 | time limit, no verdict | 300 s |
| `h306 4 TSDEe 540` | charges integral, L = 4 | time limit, no incumbent | 540 s |
| `FEAS=0.5 h306 3 TSDEe 200` | feasibility form | time limit | 200 s |
| `h307 4 5 120` | near-miss | O's y-plane charge unbalanced inside the slab | 0.2 s |
| `h308` slab scans, L = 4 … 10 | §7 tables | R* = 5, 5, 5, 7, 7, 7, 9 | 0.1 s (L = 4) … 290 s (L = 10, R = 8, 9) |
| `h308` restrictions (axes, near, gap, sep, inside, sub, mid, box, tube, aslab) | §7 details | as stated | < 6 s each |
| `h308` backbone / EXTRAQ | forced literals with signs | W_r planes, B x-free, g±1 mono | < 1 s |
| `h309` S1, R5 at L = 4, 5, 6 | law reach | §7 last table | < 4 s each |

Longest single foreground runs: `h308 10 500 slab 8,9 S` (4 min 54 s), `h306 4 TSDEe 540` (9 min, stopped at its limit), `h306 5 TSDE` (3 min). Nothing ran in the background.
