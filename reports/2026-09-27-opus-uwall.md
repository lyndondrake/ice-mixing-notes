---
title: "The turn beside a free plane (agent uwall): the cage at a turn and the corner-pattern lemma proved by hand; the corner case is exactly the exit of a length-2 excursion (proved) and is refuted with the plane hypothesis on ONE line of the free plane, needs integrality on ONE line of 2L indicators (branching on 1 variable at L = 4, 2 at L = 5), and gains nothing from the sign field; 'a path that turns at every hole of its k-line forces curl-free' proved by Theorem LC; the corner case and (V) both have depth-1 probing refutations in the cage-law calculus (L = 3, 4, 5), but not uniform ones. Not proved: the corner case, (E′), (V)"
author: "Claude (Opus), agent uwall, for Lyndon Drake"
date: 2026-09-27
---

Tags: **proved** (proof written here), **computed** (exact, reproducible, no SAT solver: LP/MILP
with rational-free HiGHS verdicts, or my own bound-propagation engine), **solver** (CaDiCaL via
`h32_cap` or a capped child), **conjecture**. Frame and names as in the attack proposal §2.5: the
A-plane {x_j = c} is k-free, O = (a, c, t) an A-hole in it, coordinates written relative to O in
the order (i, j, k); b1 = (1,1,−1), b2 = (−1,1,1) on plane c+1, b3 = (1,−1,1), b4 = (−1,−1,−1) on
plane c−1; m_i^± = (±2,0,0), m_j^± = (0,±2,0), m_k^± = (0,0,±2). A **turn** (pattern 1010) is
K(b1) = K(b3) = 1, K(b2) = K(b4) = 0. In the model files i = x, j = y, k = z, c = 0, O = (2,0,0).
Scripts `scratch_h/h260_lib.py` … `h269_extract.py` (new; nothing tracked was modified, nothing
committed). All compute on this Mac.

## Status table

| # | statement | status |
|---|---|---|
| 1 | Cage at a turn: exactly the three cases (i,i), (i,j), (j,j); what the four hexagons force in each; law C adds nothing | **proved** (§1) |
| 2 | U0 analogues: (i,i) is U′/U0 verbatim; corner case splits into C+ (j-rod up) / C− (j-rod down), exchanged by the half-turn about the i-axis | **proved** (§1) |
| 3 | Corner-pattern lemma: a free-plane corner with rods (s_i e_i, s_j e_j) has bridgehead K-pattern in {0000, the turn of orientation s_i, the straight path on the side opposite to the j-rod} | **proved** (§2) |
| 4 | Corner case ⟺ the exit corner of a length-2 excursion of a corner trail from the free plane | **proved** (§2) |
| 5 | Local structure of C+: m_j^− = k, m_k^− = i, (2,−2,−2) = j, b1+4e_k = k, the entry corner O+(2,0,−2) carries a straight vertical path | **proved** (§3) |
| 6 | Staircase lemma: K(β1) = 1, K(β2) = 0 at every hole of the free-plane k-line of holes through O ⇒ B-plane {x_i = a+1} all type k, {x_i = a−1} k-free ⇒ B i-free ⇒ curl-free (if A carries type i) | **proved** (§4) |
| 7 | Transfer equations of a turn along its k-line (four one-step identities from P^k) | **proved** (§4) |
| 8 | Corner case needs only: the A-line u = 2 of the plane (the A-vertices of the j-chain Γ+ through b3) and m_k^− not of type k; strips of the plane in x_i or x_k need almost the whole plane | **solver** L = 3, 4 (§5) |
| 9 | Sign field adds nothing: every window (in j, u, v) has the same SAT/UNSAT row with and without the bond rule | **solver** L = 3, 4 (§5) |
| 10 | Corner case reach: 2L−2 layers in j, 2L−3 in u, 2L−2 (L = 4) in v; deletion-minimal core (L = 3) 85 hexagons on every layer | **solver** (§5) |
| 11 | Corner case LP (C+ fixed): infeasible at L = 3 (a counting certificate, 336 (T2) rows, small-cell), feasible at L = 4, 5 | **computed** (§6) |
| 12 | Integrality of ONE line of 2L indicators closes it (K on Δ0's B-vertices on c+1, or I on Γ+'s A-vertices, or K on Γ−'s B-vertices), L = 4, 5; one plane's family also suffices; Γ+'s own B-line does not | **computed** (§6) |
| 13 | Branching certificate: L = 4, one bit (type of m_k^+ ∈ {i, j}), two Farkas branches (133 and ~885 (T2) rows after L1 minimisation); L = 5, two bits | **computed** (§6) |
| 14 | Depth-1 probing in the cage-law calculus (bound propagation on one-hot, (T2), C, P^i, P^j, P^k) refutes the corner case at L = 3, 4, 5 (3, 6, 16 probes; band hypothesis: 4, 19) and (V) at L = 4 (15 probes); every probe's propagation spans the whole torus | **computed** (§7) |
| 15 | The corner case, (E′), (V) | **not proved**; exact residual §9 |

## 1. The cage at a turn (proved)

**Four equations.** The four hexagons at O are (O, σ), Πσ = +1; hexagon σ contains the A-vertices
O + 2σ_m e_m (axis m) and the three bridgeheads obtained from σ by flipping one coordinate m
(axis m). With K(m_k^±) = 0 (plane) and the turn substituted (b1, b3 type k so J(b3) = J(b1) =
I(b1) = I(b3) = 0; K(b2) = K(b4) = 0):

- H1, σ = (+,+,+): I(m_i^+) + J(m_j^+) + I(b2) + J(b3) + K(b1) = 2 ⇒ p + α = x,
- H2, σ = (+,−,−): I(m_i^+) + J(m_j^−) + I(b4) + J(b1) + K(b3) = 2 ⇒ p + β = y,
- H3, σ = (−,+,−): I(m_i^−) + J(m_j^+) + I(b1) + J(b4) + K(b2) = 2 ⇒ q + α + y = 2,
- H4, σ = (−,−,+): I(m_i^−) + J(m_j^−) + I(b3) + J(b2) + K(b4) = 2 ⇒ q + β + x = 2,

with p = I(m_i^+), q = I(m_i^−), α = J(m_j^+), β = J(m_j^−), x = J(b2) = 1 − I(b2), y = J(b4)
(b2, b4 ∈ {i, j}; m_i^± ∈ {i, j} since they lie in the plane).

**Lemma T1 (three cases).** (a) p = 1 ⇒ α = β = 0, x = y = 1, q = 1: **(i,i)**, m_i^± type i,
b2 = b4 = j, m_j^± ∉ j. (b) p = 0, q = 1 ⇒ α + β = 1, x = α, y = β: **(i,j) corner**, m_i^− = i,
m_i^+ = j, exactly one j-rod; C+ (m_j^+ = j): b2 = j, b4 = i; C− (m_j^− = j): b2 = i, b4 = j.
(c) p = q = 0 ⇒ α = β = 1, x = y = 1: **(j,j)**, m_j^± = j, b2 = b4 = j. (p, q) = (1, 0) is
impossible. *Proof:* the four equations above. Law C at O (exactly two of the six methylenes are
rods) is the sum of H1–H4 minus bridgehead terms and adds nothing: in each case it holds. ∎

**U0 analogues.** (i,i) is the straight i-cage with bridgeheads kk on the side +i and jj on the
side −i, i.e. uhand's yy/zz under (x,y,z) → (i,j,k); Lemma U0 applies verbatim (both rods i, one
bridgehead j on −i, one k on +i force the other two), and the free plane plays no role. In the
corner case the turn plus (m_i^−, m_i^+) = (i, j) and the in-plane non-k literals at O force the
full pattern of C+ or C− once the j-rod is named (a) above). The half-turn about the i-axis through
O, (d_i, d_j, d_k) ↦ (d_i, −d_j, −d_k), preserves the bond set, the A-sublattice, the type labels,
the plane and the turn (b1 ↔ b3, b2 ↔ b4), and exchanges C+ and C−; so C+ is enough. (j,j):
m_i^± = j already force m_j^± = j and b2 = b4 = j.

Bound propagation from each case (`h269_closure.py 4`, whole plane, no probing; computed):
(i,i) adds nothing beyond Lemma T1; (j,j) adds b1+4e_k = k and b3−4e_k = k (both directions of
the two k-lines); C+ adds 17 types including m_j^− = k, m_k^− = i, (2,−2,−2) = j, b1+4e_k = k,
b3−4e_k = i, (3,1,−3) = k, (2,2,−2) = k (full list in the script output).

## 2. Corners, turns and excursions (proved)

**Lemma T2 (corner-pattern lemma).** Let a free-plane hole be an (i,j)-corner with rods s_i e_i and
s_j e_j. Then its bridgehead pattern (K b1, K b2, K b3, K b4) is 0000, or the turn T_{s_i}
(1010 for s_i = −1, 0101 for s_i = +1), or the straight path S_{s_j} on the side away from the
j-rod (0011 = horizontal, on plane c−1, if s_j = +1; 1100 = vertical, on plane c+1, if
s_j = −1). *Proof for (s_i, s_j) = (−,+)*: put I(m_i^−) = J(m_j^+) = 1 and the other methylenes
unmatched in H1–H4 (general form, without the turn). H3 gives b1 ∉ i, b4 ∉ j, b2 ∉ k; H2 says
exactly two of {b4 = i, b1 = j, b3 = k}; H1 and H4 say exactly one of {b2 = i, b3 = j, b1 = k} and
of {b3 = i, b2 = j, b4 = k}. The three choices in H2 give (b1..b4) ∈ {(j,j,j,i), (j,i,i,i)}
(K = 0000), (k,j,k,i) (1010), (j,i,k,k) (0011). The other sign patterns follow by the reflection
in x_i (b1 ↔ b2, b3 ↔ b4, a lattice symmetry fixing A with the axis labels) and the half-turn of
§1. ∎

So the six-vertex picture of proposal §2.6 meets the corner trails in a rigid way: a corner
crossing the plane upward (s_j = +1) can carry a horizontal path below, a corner crossing
downward a vertical path above, and either can carry the turn whose orientation is its i-rod.

**Lemma T3 (corner case = exit of an excursion).** Every free-plane corner has unused axis k, so a
corner trail crosses the plane at every visit (wprime, corollary of W1). The corner case C+ at O
holds iff the trail through O runs O″ = O + (2,0,−2) → P = O + (1,−1,−1) → O → O + (−1,1,−1),
with P an (i,k)-corner of plane c−1 whose unused axis is j — a length-2 excursion below the plane
whose exit is O; C− is the mirror excursion above. *Proof.* (⇒) O is a corner with octant
σ_n = (−,+,−); by the transition rule (rods trails report Lemma B) σ_{n−1} agrees with σ_n on i, j
and differs on k: (−,+,+), so P = O − σ_{n−1}. P's rods lie in its octant among P − 2e_i = b4
(type i), P + 2e_j = b1 (type k), P + 2e_k = b3 (type k): the rods are b4 and b3, unused axis j,
so σ_{n−2} = (−,−,+) and O_{n−2} = P − σ_{n−2} = O + (2,0,−2), a free-plane hole. (⇐) Given the
excursion with P's rods b4 (i) and b3 (k), O's octant agrees with P's on i and j, so O's rods are
m_i^−, m_j^+; H3 at O gives b4 ∉ j, b2 ∉ k, b1 ∉ i; H2 (I(b4) = K(b3) = 1) gives b1 ∉ j, so b1 = k;
H4 gives b2 = j; so the pattern is 1010 in case C+. If P's rods are (+i, −k) the same argument gives
0101 (mirror). ∎

The main loop's sign remark is Lemma B: the i-rods of O″, P, O share a sign and a role, so the
j-rods of O″ (on c−2) and O (on c+2) have opposite signs. §5 shows the sign field does not
shorten any window, so this does not by itself give a local contradiction.

## 3. The local structure of C+ (proved)

At the B-hole P = (1,−1,−1): law C (rods b4, b3) makes (3,−1,−1) ∉ i, (1,−3,−1) ∉ j,
(1,−1,−3) ∉ k. Its bridgeheads are (2,0,0) = m_i^+ (type j), (2,−2,−2), (0,0,−2) = m_k^−,
(0,−2,0) = m_j^−. With Πs = +1 at a B-hole:

- P^j: 0 = J(2,0,0) − J(2,−2,−2) + J(m_k^−) − J(m_j^−) = 1 − J(2,−2,−2) + J(m_k^−) (m_j^− ∉ j by
  law C at O) ⇒ **(2,−2,−2) = j and m_k^− ∉ j, so m_k^− = i** (plane);
- P^k: K(b3) − K(1,−1,−3) = 1 = −K(2,−2,−2) − K(m_k^−) + K(m_j^−) ⇒ **m_j^− = k**.

(This uses the plane only at m_i^+ and m_k^−.) At the hole O″ = (2,0,−2) (face 1 of the column
below) the four hexagons with m_i^−(O″) = m_k^−(O) = i, m_j^−(O″) = (2,−2,−2) = j, β2(O″) = b1 = k,
β4(O″) = (1,−1,−3) ∉ k give: β4(O″) = i, β1(O″) = (3,1,−3) = k, β3(O″) = (3,−1,−1) = j,
m_i^+(O″) = (4,0,−2) = j, m_j^+(O″) ∉ j. So O″ is the (−i,−j)-corner of Lemma T2 carrying the
vertical path 1100: the path that turned at O goes straight up through O″. Finally P^k at the
B-hole O + (1,1,1) gives **K(b1 + 4e_k) = 1 + K(2,2,2) − K(m_j^+) = 1 + K(2,2,2) − 0**, so
b1 + 4e_k = k and (2,2,2) ∉ k (the brief's identity; in cases C+ and (j,j) the propagation of
the b1 k-line is immediate). The same identity at P gives K(b3 − 4e_k) = 1 + K(2,−2,−2) −
K(m_j^−) = 0 in C+: the b3 k-line breaks downward, and propagation of the whole staircase is not
local (§4).

## 4. The path picture made rigorous, and the staircase lemma

**Six-vertex form (proved; w1prime (CR) restated).** In u = x_i + x_k, v = x_i − x_k the plane's
A-vertices are Λ = (−c,−c) + 4Z², its holes the face centres, the B-vertices of c+1 the midpoints
of the u-edges and those of c−1 the midpoints of the v-edges. (CR) at the hole (u_O, v_O) reads
K(top) + K(left) = K(bottom) + K(right) with top/bottom = b1/b2, right/left = b3/b4: every face
has as many marked edges on {bottom, right} as on {top, left}, so the six admissible patterns are
0000, straight vertical (1100), straight horizontal (0011), the two turns 1010 (right → top) and
0101 (bottom → left), and 1111. The marked edges are the steps of paths monotone in (−u, +v);
Theorem Ω is conservation of their number across any horizontal (ω1) or vertical (ω2) cut. At a
1111 face the decomposition into non-crossing paths is a convention (touching); nothing below
depends on it.

**Transfer along the k-line of holes (proved).** For H_n = O + 4n e_k (all in the plane), P^k at
the four B-holes between consecutive bridgeheads gives

- K β1(n+1) = K β1(n) + K(2,2,4n+2) − K(0,2,4n),
- K β2(n+1) = K β2(n) + K(0,2,4n+4) − K(−2,2,4n+2),
- K β3(n+1) = K β3(n) − K(2,−2,4n+2) + K(0,−2,4n+4),
- K β4(n+1) = K β4(n) − K(0,−2,4n) + K(−2,−2,4n+2).

So the turn propagates from H_n to H_{n+1} (K β1 stays 1, K β2 stays 0) iff
K(−2,2,4n−2) = K(0,2,4n) = K(2,2,4n+2), i.e. K is constant along the (1,0,1)-diagonal of the
plane c+2 through the j-methylene m_j^+(H_n) (and the mirror statement on c−2) — the object of
Theorem D (ii) (Δ constant on the (1,1)-diagonals of plane c+2), which w1prime obtains only after
(E′). The step is local exactly when m_j^+(H_n) (resp. m_j^−) is not of type k.

**Lemma T4 (staircase ⇒ curl-free; proved).** If K β1(n) = 1 and K β2(n) = 0 for all n, then the
B-plane {x_i = a+1} is entirely of type k and the B-plane {x_i = a−1} carries no type k;
consequently B has no type i, and the state is curl-free as soon as A carries a type-i vertex.
*Proof.* The β1(n) are the L vertices of the B k-line at (x_i, x_j) = (a+1, c+1), the β2(n) those
at (a−1, c+1). Theorem LC for (k, B): h(x_i, x_j) = F(x_i) + G(x_j). So F(a+1) − F(a−1) = L, and
since 0 ≤ h ≤ L, h(a+1, b) = L and h(a−1, b) = 0 for every b. The B i-grid {x_i = a+1} then has no
type-i vertex; Lemma S1 read along i makes B i-free; Theorem M′ (inverted) gives curl-free. ∎
The same holds with (β3, β4) on c−1, or with any single pair of B k-lines x_i = a ± 1 at one x_j.
In the corner case and in (i,i) A carries type i (m_i^−), so **a turn in case C+ or (i,i) that
propagates along its k-line of holes is contradictory resp. forces curl-free**: the whole of
"a path that turns once turns at every hole of its line" is the transfer step above, and Lemma T4
finishes it. This is the precise form of the proposal's §2.6 claim; it is proved except for the
transfer step, which is where all the globality sits.

**The conserved quantity ucore §10 asks for (conjecture, with the evidence of §6).** In the wall
setting the phase is the intercept of a path; Ω conserves the number of paths, and (E′) says each
keeps its intercept. What the computations of §6 locate is *where the 0/1 condition must enter*: on
the path indicators of one column of the plane (the B-vertices of Δ0 on c+1, or of Γ− on c−1), or
on the i/j indicator of the A-line bounding that column. The LP relaxation lets a path split
fractionally between turning and going straight inside that column; integrality of that single
column's steps is what excludes the corner case. I did not find the invariant that does this
uniformly in L.

## 5. What the corner case needs (solver)

Model: type-only torus, (T2) everywhere unless windowed, C+ at O (`h261`, `h262`, `h263`).

**Plane hypothesis (`h261_corner_plane.py`, L = 3, 4).** With 'not k' on a region of the plane only:

| region | C+ | C− | (j,j), (i,i) |
|---|---|---|---|
| nothing; O ± 2e_k only; |d_i| ≤ 4 or |d_k| ≤ 4 (L = 3); |d_i|, |d_k| ≤ 6 (L = 4) | SAT | SAT | SAT |
| **|u| ≤ 2** (the two A-lines u = ±2 bounding the column of holes through O) | **UNSAT** | SAT | SAT |
| **|v| ≤ 2** | SAT | **UNSAT** | SAT |
| whole plane | UNSAT | UNSAT | SAT (no oddness asked) |

The deletion-minimal core at L = 3 (`h262_core.py 3 ij band`, plane literals deletable) keeps the
whole A-line u = 2 and m_k^− only (6 of 12 literals; (2,0,0) is already type j) and **85 of 432
hexagons**, on every j-layer and every u and v residue. The A-line u = 2 is the set of A-vertices
of the j-chain Γ+ of the slab {c−1, c} through b3; the column of holes u = 0 lies between Γ+ and
Γ− (u = −2), and the j-chain Δ0 of the slab {c+1, c+2} at u = 0 has as B-vertices the tops of the
column's faces and as A-vertices their j-methylenes m_j^+ (so (0,2,0), a j-rod in C+, is a kink of
Δ0, next to b2, also type j). **This hypothesis (one line plus one vertex) is used from here on
("band").**

**Reach and signs (`h263_corner_reach.py`).** First UNSAT window, with the band hypothesis:

| window | L = 3 | L = 4 | with the sign field on the window's bonds |
|---|---|---|---|
| |dj| ≤ D (both holes) | D = 4 (2L − 2) | D = 6 (2L − 2) | identical |
| |u − 1| ≤ D | D = 3 | D = 5 | identical |
| |v| ≤ D (along Γ+) | D = 6 (whole) | D = 6 | identical |

So the band localises the *plane* but not the (T2) support, and **the sign field shortens nothing**:
the answer to 'does a signed argument close the corner case' is that no window argument with the
bond rule is shorter than the type-only one; a signed proof would have to use a global sign
quantity (the flux identity), which is a linear consequence already present in the LP (§6).

## 6. Counting and integrality (computed; HiGHS with explicit time limits)

`h264_corner_milp.py` (feasibility of one-hot + (T2) + C+ + plane, 0 ≤ t ≤ 1):

- **L = 3: the LP is infeasible** (band and whole plane): a pure counting refutation exists; its
  L1-minimised Farkas certificate uses 336 (band) / 347 (whole) of the 432 (T2) rows on every
  layer (`h267_branch.py 3 gammaI band near 1`). A small-cell artefact: **L = 4, 5 LPs are
  feasible.** (h217's corner LP was feasible at L = 3 because it left the j-rod's side free; the
  LP mixes C+ and C−.)
- Integrality closing the L = 4 LP (each alone): kB on all B; kB on the plane c−1 alone; on c+1
  alone; iA, jA, iB, jB, kA on all; iA or jA on the free plane alone; and **one line of 2L
  variables**: K on Δ0's B-vertices (plane c+1, u = 0), I on Γ+'s A-vertices (plane c, u = 2),
  K on Γ−'s B-vertices (plane c−1, u = −2). Not sufficient: K on Γ+'s own B-vertices (u = 2 on
  c−1), K on the two v-lines ±2 of c+1, I on the A-line u = −2. **L = 5: the same three lines
  close, Γ+'s B-line does not.**
- LP ranges on these lines (`h265_project.py 4`): the LP already fixes K(3,1,−3) = 1 (face 1's
  top), I(4,0,−2) = 0, K(2,2,−2) = 1, K(3,−1,−1) = 0; the other line variables are fractional.
- **Branching certificates (`h267_branch.py`).** On the I-values of Γ+'s A-line: **L = 4 needs one
  bit, the type of m_k^+ = (0,0,2) ∈ {i, j}**; both branches LP-infeasible, L1-minimised
  certificates 133 (T2) rows + 118 one-hot rows (m_k^+ = i) and 885 + 447 (m_k^+ = j; probably
  not the sparsest, HiGHS's L1 LP is degenerate). L = 5: two bits, m_k^+ and (−2,0,4), three
  leaves. On Δ0's line: 3 bits, 4 leaves (L = 4). On Γ−'s line: 3 bits, 4 leaves.
- Law families (`h268_laws.py 4`, all variables integral): {C, P^j, P^k}, {C, P^i, P^k},
  {P^i, P^j, P^k} at both sublattices each refute; any two families, and P^k alone or with C, do
  not; {C_A, P^j, P^k} refutes, {C_B, P^j, P^k} does not. Smaller mixed subsets were
  inconclusive at a 60 s limit (reported as no verdict).

So the corner case has exactly (V)'s residual shape, 'laws + non-negativity + integrality', but
the integrality is much thinner: one line of 2L indicators instead of one sublattice family, and
at L = 4 a single case split.

## 7. Depth-1 probing in the cage-law calculus (computed)

`h269_extract.py`: bound propagation on the integer equations one-hot, (T2), C, P^i, P^j, P^k
(both sublattices), plus failed-literal probes ('suppose ℓ; propagation contradicts; so ¬ℓ'),
then greedy minimisation of the probe sequence. Every step is a one-equation deduction, so the
output is a checkable proof for that L. Results:

| statement | L = 3 | L = 4 | L = 5 |
|---|---|---|---|
| corner case C+, whole plane | 3 probes | 6 probes | 16 probes |
| corner case C+, band | 4 probes | 19 probes | — |
| (V), case (i,i) + '(−1,−3,1) of type i' (no plane) | — | 15 probes | — |

Each probe's refutation forces 100–2500 literals and reaches every layer and every u. So this is
a finite-L certificate, not a hand proof, and its size grows with L. It corrects uhand verdict 3
in one respect: one-hexagon closure with depth-1 splits derives nothing for (V), but **bound
propagation on the cage laws (four-hexagon sums) with depth-1 splits refutes (V) at L = 4** — the
residual "needs integrality" is met by local 0/1 reasoning on the cage laws, just not uniformly.

## 8. What failed, and why

- **A local induction along the k-line of holes.** The transfer step (§4) is local only when the
  j-methylene of the next hole is not of type k; in C+ the b1 line propagates one step and the b3
  line breaks at once (b3 − 4e_k = i), so the staircase is not what kills C+ with the band
  hypothesis (which does not even contain the k-line of holes).
- **A signed shortcut.** The opposite-sign j-rods on c ± 2 (Lemma B) do not help any window
  (§5), and every global sign identity is linear (flux) and hence already inside the feasible LP.
- **Reading a certificate.** The smallest per-branch Farkas certificate found (133 rows, L = 4)
  and the L = 3 root certificate (336 rows) are spread over all layers; I could not recognise a
  structure in the time available. The probing proofs (§7) are no more readable.
- **Law-family minimisation** beyond three families hit the 60 s MILP limit.

## 9. The exact residual

> **(CC) Corner case, residual form (computed, L = 4, 5; solver-true, L = 3, 4).** One-hot and
> (T2) on the torus; the A-line {x_j = c, x_i + x_k = a + t + 2} and the vertex O − 2e_k not of type
> k; C+ at O. Then the LP relaxation is feasible, and becomes infeasible once the 2L indicators
> I(·) on that A-line (equivalently J, since K = 0 there) are required to be 0/1. At L = 4 the
> split on I(O + 2e_k) alone suffices.

A uniform proof needs an invariant carried round the torus (the reach is 2L − 2 in every
direction) that sees one line's integrality. By Lemmas T3–T4 the corner case would also follow
from the transfer step 'a turn at H_n propagates to H_{n+1}' under the whole-plane hypothesis, and
the case (i,i) is then Theorem U′; the case (j,j) additionally needs oddness (T4 gives curl-free
directly when A has type i). Recommendation: attack (CC) via the one-bit split at m_k^+, since at
L = 4 it is the smallest completely explicit object the turn problem has produced; the question to
answer is whether the two branch certificates are sums of laws along the column and the chains
Γ±, Δ0 (the planes u ∈ {−2, 0, 2}) with a bounded number of transverse terms.

## 10. Files and computations

All from `scratch_h`, `.venv`, `PYTHONPATH=<repo>:<repo>/experiments/08_frozen_structure`,
`TMPDIR=<repo>/.tmp`; SAT solves through `h32_cap` (or, for cores, a capped child in the same
pattern); LP/MILP HiGHS with explicit time limits.

| script | what | verdict | wall |
|---|---|---|---|
| `h260_lib.py` | shared model (relative frame, selectors, signs) | — | — |
| `h261_corner_plane.py 3`, `4` | plane regions × cases, with/without signs | band |u| ≤ 2 suffices for C+, |v| ≤ 2 for C−; signs identical | 0.4 s, 0.5 s |
| `h262_core.py 3 ij band 300 0` | deletion-minimal core (hexagons + plane literals) | 85 hexagons, A-line u = 2 + m_k^− | 0.6 s |
| `h263_corner_reach.py 3`, `4` | reach in j, u, v, types vs signs | 2L−2 / 2L−3 / 2L−2; signs identical | 0.2 s, 0.5 s |
| `h264_corner_milp.py 3/4/5 …` | LP and partial-integrality MILPs | LP infeasible L = 3 only; one line closes L = 4, 5 | < 1 s; ≈ 50 s; ≈ 35 s |
| `h265_project.py 4` | LP ranges on six lines | §6 | ≈ 1 min |
| `h266_nearmiss.py 4 5` | near-miss pictures (D = 5) | Δ0 nearly all type k, broken at b2–(0,2,0) | 0.2 s |
| `h267_branch.py 3/4/5 …` | branching on one line; Farkas L1 sizes | 1 bit (L = 4), 2 bits (L = 5) | 1–6 s; certificates ≈ 1 min |
| `h268_laws.py 4 …` | law-family subsets | §6 | 0–60 s each (60 s limit) |
| `h269_closure.py 3/4/5 case whole [probe]` | local closure, depth-1 probing (first version) | §1, §7 | 1 s, 9 s, 67 s |
| `h269_extract.py L case plane` | minimal probe sequences | §7 | 1.4 s, 3.6 s, 56 s; band L = 4 43 s; (V) L = 4 26 s |

One run broke the compute rule: `h269_closure.py 6 ij whole probe` (old, slow engine) passed the
10-minute foreground limit, was moved to the background by the harness and stopped by me
without a result. Nothing else ran over two minutes.
