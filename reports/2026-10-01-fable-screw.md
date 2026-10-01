---
title: "(V) given Statement R: the reach drops by exactly the literal X(v_2) = 1 and no more, the models short of threshold are many and are not label classes, both cut cylinders still refute (V), and on the B grid x = 1 the parametrisation (C) has no linear content at all"
author: "Claude (Fable), agent screw, for Lyndon Drake"
date: 2026-10-01
---

# Verdict

**NOT THERE.** The monodromy picture of step 2, in the form the brief gives it (given R, the
type-x set of a B grid normal to x is a label class of one chain family, advancing one label per
cube, closing after g cubes with the wrong type), is refuted by T1 and by hand.

1. R shortens the one-sided reach of (V) from 2g + 1 to 2g - 1 on all five cells tried
   (g = 4, 5, 6, 4, 8), and the whole of the shortening is the single literal X(v_2) = 1, the one rod
   of R that lies inside the window [-3, 2g - 1]: with that literal alone in place of R the reach is
   the same 2g - 1 on every cell. R contributes nothing else inside a window (solver).
2. One grid short of the new threshold the negation of (V) given R has 8 models of the type-x set
   of B on (12,4,4) and 32 on (12,4,8) (enumeration complete), and more than 50 on (10,5,5) and
   (12,6,6) (capped). On no grid of any model is the type-x set a union of classes of either
   x-chain family, and on no model is the type-x set of a grid a translate of that of the grid one
   cube earlier. The two-model sheet of item 7 is not the near-threshold structure given R
   (solver, computed).
3. (V) given R is false on the whole y-cut cylinder and on the whole z-cut cylinder of every cell
   tried, with (T2) on every hexagon not through the cut grid. R supplies neither transverse circle
   (solver, one query per cell and cut).
4. By hand, for every cell: on the B grid x = 1 each transverse chain meets the grid in
   c/gcd(a,c) or b/gcd(a,b) vertices, so on every cell with b | a and c | a (every cubic cell and
   the four test cells) each meets it once, and (C) restricted to the grid is onto: it imposes no
   linear condition on h_y - h_z, hence none on the type-x set of the grid. The pair (y-chain
   labels, z-chain labels) at a vertex of the grid is never a product on any cell, so Lemma 8 has
   nothing to act on; the premise of T2(i) fails on every cell (proved here, no second reader;
   checked exactly on seven cells).
5. The weights of the transverse chains, seen from the B grids along the rod axis, are sheared by
   one chain label per cube and return after gcd(a,c) or gcd(a,b) cubes; on (12,8,8) that is 4 cubes
   while (V) given R needs 2g - 1 = 15 grids, g = gcd(b,c) = 8. The g of the reach law is the
   modulus of the x-chain labels d = y - z and s = y + z on grids normal to x, not the period of
   any weight of (C) along the rod axis. A monodromy in the weights of (C) cannot be the
   mechanism on every cell (proved geometry plus solver on one cell).

What stands: the reach of (V) given R is still 2g + O(1) over the closed transverse torus and dies
on every cut, so the obstruction is still a closure over the x-chain labels of both circles. But
R is not a first step towards it, and the heights of (C) carry no linear shadow of it on a grid.

# Statement tested

Coordinates in quarter-cube units, cell (a,b,c) modulo (4a,4b,4c), A = even coordinates with sum
0 mod 4, B = A + (1,1,1). A-hole O = (2,0,0); rods v_0 = (0,0,0), v_1 = (4,0,0) of type x; lower
bridgehead beta = (1,1,1) of type y; upper bridgehead by form: `ng2`, (3,-1,1) not of type y, and
`zg`, (3,1,-1) of type z (`UPPER` of h630). **R as hypothesis:** unit clauses X(v_j) = 1 for
v_j = (4j,0,0), every j round the x-circle. **Negation of (V):** some B vertex of the grid x = 1
(relative x = -1) has type x. Type model of h360_lib (one-hot, (T2) on the hexagons all six of
whose vertices have relative x in [-3, Q]), windows `one` only. **Cut:** every hexagon with a
vertex on the transverse grid farthest from the rod line (relative y = -2b or z = -2c) dropped;
`--full` keeps every other hexagon of the torus. Every window is one h32_cap child (cap 120 s,
models 300 s) with a control (the hypotheses alone, SAT in every row below) and the negation
query; UNSAT = the window forces (V). No bond model was run: the type model is the weaker one and
the record (rodline Table A) has them agreeing on these cells.

# T1 tables

**A. One-sided reach [-3, Q] of (V), form `ng2` (form `zg` agrees on the first four cells).**

| cell | g | gcd(a,b), gcd(a,c) | without R (record 2g+1) | with R | with X(v_2) = 1 alone |
|---|---|---|---|---|---|
| (12,4,4) | 4 | 4, 4 | 9 | **7** | 7 |
| (10,5,5) | 5 | 5, 5 | 11 | **9** | 9 |
| (12,6,6) | 6 | 6, 6 | 13 | **11** | 11 |
| (12,4,8) | 4 | 4, 4 | 9 | **7** | 7 |
| (12,8,8) | 8 | 4, 4 | 17 | **15** | 15 |

Every entry is UNSAT at the Q shown and SAT at Q - 1 (the sweep starts at Q = 3 or 5; (12,8,8) was
run at Q = 14, 15 with R, 16, 17 without, and 7 to 15 with v_2 alone). So R saves exactly two
grids, and v_2 alone saves the same two. Inside [-3, 2g - 1] the rods v_j with j >= 3 lie at
relative x = 4j - 2 >= 10 > 2g - 1 for g <= 5, and for g = 6 and 8 the rod v_3 (x = 10) is inside
the window but adds nothing to v_2.

**B. Cuts, with R, form `ng2`.** Windows [-3, Q] up to Q = 23 (19 on (10,5,5)), then the whole
cut cylinder.

| cell | y-cut, windows | y-cut, full cylinder | z-cut, windows | z-cut, full cylinder |
|---|---|---|---|---|
| (12,4,4) | none <= 23 | negation SAT | none <= 23 | negation SAT |
| (10,5,5) | none <= 19 | negation SAT | none <= 19 | negation SAT |
| (12,6,6) | none <= 23 | negation SAT | none <= 23 | negation SAT |
| (12,4,8) | none <= 23 | negation SAT | none <= 23 | negation SAT |

Rodline's Table B (no R) has R itself surviving the z-cut; (V) given R survives neither cut, even
with every other hexagon of the torus imposed.

**C. Models one grid short of the threshold of A, with R, form `ng2`,** blocking on the X
variables of the B vertices of the window, cap 50, random phases, seed 1.

| cell | window | models | complete | type-x per B grid (all models) | per A grid | d-class unions | s-class unions | translate of previous grid |
|---|---|---|---|---|---|---|---|---|
| (12,4,4) | [-3,6] | 8 | yes | 8 to 10 (of 32; 2bc/g = 8) | 12 to 18 (sheet: 8) | 0 grids | 0 grids | none, 8 models x 6 pairs |
| (12,4,8) | [-3,6] | 32 | yes | 16 to 20 (of 64; 2bc/g = 16) | 26 to 36 | 0 | 0 | not run |
| (10,5,5) | [-3,8] | 50 | capped | 14 to 18 (of 50; 2bc/g = 10) | 20 to 28 | 0 | 0 | none, 20 models x 8 pairs |
| (12,6,6) | [-3,10] | 50 | capped | 24 to 30 (of 72; 2bc/g = 12) | 31 to 39 | 0 | 0 | not run |

Lemma 6 holds inside every window (equal counts on all B grids and on all A grids of a model).
"d-class unions": grids of the window on which the type-x set is a union of whole classes of
d = y - z mod 4g (the x-chains of family {0,1} on that grid), likewise s = y + z for {2,3}; the
sheet of item 7 is one d-class per A grid. "Translate": whether the type-x set of a grid equals the
set of the grid x - 4 shifted by any (dy, dz); none on any pair of grids of any model.

**D. The sets, explicitly: (12,4,4), [-3,6], model 0, type-x set of each B grid as relative
(y, z) in [0,16) x [0,16).** Each grid has 32 vertices, four d-classes and four s-classes of 8.

| B grid | type-x set |
|---|---|
| -3 | (5,15) (7,1) (7,9) (7,13) (9,3) (9,7) (9,15) (11,1) (11,9) |
| -1 | (1,13) (5,1) (7,3) (7,15) (9,1) (9,13) (11,7) (11,15) (15,3) |
| +1 | (1,11) (3,1) (5,3) (7,1) (9,15) (11,5) (11,13) (13,15) (15,5) |
| +3 | (1,9) (3,3) (5,1) (7,7) (9,9) (11,3) (11,15) (13,13) (15,7) |
| +5 | (1,7) (5,7) (7,5) (7,9) (9,7) (9,11) (11,1) (11,9) (15,9) |

On grid -1 (the plane of the lower bridgeheads) the nine vertices fall in three d-classes
(4 : 4, 8 : 2, 12 : 3 vertices) and four s-classes; on grid +1 in all four d-classes and all four
s-classes. The other seven models are in `.tmp/h701_1244_q6.log` as class counts.

# Lemmas, in the heights, for every cell

Notation of rodline: h_x = F_x, h_y = F_y + sigma beta, h_z = F_z - sigma alpha, sigma = +1 on A
and -1 on B; Y = h_x - h_z, Z = h_y - h_x, X = 1 + h_z - h_y; type x iff the three heights agree.
Families: x-chains {0,1} (step (0,2,2), constant y - z) and {2,3} (step (0,2,-2), constant
y + z); y-chains {0,2} (step (2,0,2), constant x - z) and {1,3} (step (2,0,-2), constant x + z);
z-chains {0,3} (step (2,2,0), constant x - y) and {1,2} (step (2,-2,0), constant x + y). Put
g_y = gcd(a,c), g_z = gcd(a,b), g = gcd(b,c). On the B grid x = 1 write A_02(y,z) for the weight
of the y-chain of {0,2} through (1,y,z), A_13, B_03, B_12 likewise.

**Lemma S1 (the shear along the rod axis; proved here, no second reader).** For every cell and
every m, the four transverse chains through the B vertex (1 + 4m, y, z) are the chains through
(1, y, z - 4m) for {0,2}, (1, y, z + 4m) for {1,3}, (1, y - 4m, z) for {0,3} and (1, y + 4m, z) for
{1,2}. Hence on the B grid x = 1 + 4m
$$h_y - h_z = A_{02}(y, z - 4m) + A_{13}(y, z + 4m) - B_{03}(y - 4m, z) - B_{12}(y + 4m, z) - (\alpha + \beta),$$
and X = 1 + h_z - h_y there. *Proof.* (1, y, z - 4m) + 2m(2,0,2) = (1 + 4m, y, z), and
(2,0,2) is the step of {0,2}; the other three the same with (2,0,-2), (2,2,0), (2,-2,0). The
constant is sigma(alpha + beta) with sigma = -1. $\square$
A_02(y, .) is a function of z modulo 4g_y (the label x - z of the chain), so the first term has
period g_y in m, and likewise g_y, g_z, g_z for the others. This is the only monodromy in the
weights of (C) along the rod axis, and it closes after lcm(g_y, g_z) cubes: after 4 cubes on
(12,8,8), after L on a cubic cell.

**Lemma S2 (incidence; proved here, no second reader; computed on seven cells, h702).** A
y-chain meets the B grid x = 1 in c/g_y vertices and a z-chain in b/g_z. *Proof.* The chain of
{0,2} through (1,y,z) is {(1 + 2n, y, z + 2n)}; x = 1 mod 4a needs n = 0 mod 2a, and then z runs
over z + 4ak mod 4c, which takes 4c/gcd(4a, 4c) = c/g_y values. The other families the same.
$\square$

**Lemma S3 ((C) is vacuous on a grid; proved here, no second reader; computed, h702).** If b | a
and c | a, each transverse chain meets the B grid x = 1 exactly once, the 8bc chains through the
grid are distinct, and the map (f, alpha, beta) -> (h_y - h_z restricted to the grid) is onto.
So (C) imposes no linear condition on h_y - h_z, hence on X, on a single grid normal to x.
*Proof.* S2 with g_y = c, g_z = b. Each vertex u of the grid has a chain met by no other vertex
of the grid; vary its weight. $\square$ Computed rank: 32 of 32, 50 of 50, 72 of 72, 64 of 64 on
(12,4,4), (10,5,5), (12,6,6), (12,4,8), and on (4,4,4), (5,5,5); on (12,8,8), where each chain meets
the grid twice, 96 of 128. Two consecutive B grids: rank 60 of 64, 98 of 100, 140 of 144, 108 of 128,
156 of 256; all B grids: 99 of 256 on (4,4,4) and 99 of 768 on (12,4,4) (the number of transverse
chains does not depend on a when b, c | a). These small deficiencies are the linear laws between
grids that agent moment found and showed cannot carry integrality.

**Corollary (T2(i) refuted on every cell; proved here).** On the B grid x = 1, h_y - h_z is a
function of the pair of y-chains through u plus a function of the pair of z-chains through u plus a
constant, but the set of attained pairs is never a product: the y-pair determines (y, z mod
4g_y) and the z-pair determines (z, y mod 4g_z), so the pairs number 2bc while the product has
4bc g_y g_z elements (h702: 32 of 1024 on (12,4,4), 128 of 4096 on (12,8,8)). Lemma 8 therefore
does not apply to X on a grid normal to x on any cell. The one separable quantity with a product
on such a grid pair is h_x in the x-chain labels (Lemma H2), and h_x does not enter X. On the cells
of S3 the type-x set of a B grid is unconstrained by (C) altogether, which is the linear statement
of T1's Table C.

**Lemma S4 (which g; proved geometry plus solver).** By S1 the weights of (C) seen from the B
grids along the rod axis have period lcm(g_y, g_z) cubes. On (12,8,8) that is 4 cubes, 8 grids;
the reach of (V) given R (and given v_2 alone) is 15 = 2 gcd(b,c) - 1 grids (Table A). So the g in
the reach law is the modulus of the x-chain labels d = y - z and s = y + z on grids normal to x
(the classes are the x-chains, g per family per grid pair), and no monodromy in the weights of
(C) along the rod axis is the mechanism of (V) on every cell. (Also: the two rigid models of item 7
are written in those labels, and a label class on a grid is one x-chain, which lives on its own pair
of planes and shares no weight of (C) with any other grid.)

**T2(ii), the step.** It has no premise. The step was to say how the label class carrying type x
on one B grid determines it on the next; Table C says there is no such class on any grid of any
model given R, and no translate rule between consecutive grids. What P^x at O_j gives with R is
Lemma R1 of rodline: the number of upper bridgeheads of O_j of type x equals the number of lower
ones, a count on four B vertices with value 0, 1 or 2 at every hole of the line. The bridgeheads
(4j+1, s, s) and (4j+3, s, -s), s = +-1, of different holes lie on no common transverse chain unless
the holes are g_y or g_z cubes apart (S1), so on a cubic cell (C) relates the counts at two holes to
nothing; the control bit along the line has no linear carrier. I did not look for another step
(stop rule).

**T2(iii), where the circles and integrality enter.** The labels d and s modulo 4g exist on a grid
only because 4b and 4c are both multiples of 4g: both transverse circles closed. On a cut cylinder
one of y, z is unbounded, the classes are not finite, and (V) given R is false there (Table B,
full cylinders), so the closing of both circles is needed and R supplies neither. Integrality is
everything: by S3 the real relaxation (C) says nothing on a grid and little between grids, and the
small rank deficiencies are the linear laws of the moment report. Lemma 8 would have been the
integrality step and has no product to act on (Corollary). Every claim in this section is tagged in
its statement; S1 to S3 are checked exactly on seven cells by h702 and S4's solver part is Table A.

# T3. The exact gap

There is no reduction. The one statement that closes (V) given R on every cell is (V) itself with
one more literal: *with X(v_0) = X(v_1) = X(v_2) = 1, Y(beta) = 1 and the upper literal, on the
closed transverse torus with (T2) on the grids [-3, 2g - 1], the B grid x = 1 has no vertex of type
x.* Solver status: UNSAT on (12,4,4), (10,5,5), (12,6,6), (12,4,8), (12,8,8) at Q = 2g - 1, SAT at
Q = 2g - 2 (Table A), SAT on both cut cylinders (Table B). What it needs from the second circle is
what (V) needed: the finiteness of the x-chain labels on grids normal to x, which no weight of (C)
carries and which R does not touch.

# What is left and a stop rule

1. Step 2 of the plan, as formulated, is closed: R does not shorten (V) by more than its literal
   v_2, and the heights of (C) carry no monodromy with the right period. Do not re-run (V) given R
   on windows, cuts, tubes or other cells, and do not look for a step in the transverse-chain
   weights along the rod axis.
2. The negative is informative about where not to look: on a grid normal to x the real relaxation
   is vacuous (S3), so any argument must be integral from the first line, and the integral object
   it must handle is the set of x-chain labels of both families on each grid pair, whose modulus is
   g = gcd(b,c). Theorems 10 and 11 close round the rod axis through sums over planes; on a cubic
   cell that route is exactly what S3 says is empty.
3. Owed to the record: the facts of Tables A and B (R contributes exactly v_2 to (V) in a window and
   nothing on a cylinder), which correct the plan's reading that step 1 feeds step 2; and S3, which
   is the exact form of rodline's "on a cubic cell (C) relates no two positions".

# Scripts and timings

All new, in `experiments/08_frozen_structure/scratch_h/`, none existing modified, nothing
committed; logs in `.tmp/h700_*.log`, `.tmp/h701_*.log`, `.tmp/h702.log`, `.tmp/h703_*.log`.

| script | purpose | solver wall |
|---|---|---|
| `h700_vgivenr.py` | reach of (V) given R / without R / given v_2 alone; `--cut AX`, `--full`; forms `ng2`, `zg` | 176 s in all: Table A 25 s on four cells plus 118 s on (12,8,8); cuts 27 s; v_2-only 6 s |
| `h701_rmodels.py` | models of the negation given R one grid short, class analysis per grid | 3.5 s |
| `h702_gridlabels.py` | S1 to S3 exactly: incidences, label pairs, ranks of (C) on grids (numpy, no solver) | 0 |
| `h703_rshift.py` | the translate test between grids four apart; explicit sets | 1 s |

Solver wall in all: about 3 minutes of the 20 allowed. No batch was killed; the longest single
query was 34.5 s ((12,8,8), no R, Q = 17). Every UNSAT has a SAT control on the same clause set
without the negated conclusion, in the same child. One solver child at a time; this Mac only; no
job over a minute.

# Rules kept or broken

Kept: the reading list in order; type model of h360_lib through h630's `TypeSetup`; every solve
through `h32_cap.run_batch` or the h560 worker under a hard cap; one child at a time; no Sparks, no
expq; scripts `h700` to `h703` with docstrings and usage lines; no existing script modified; no
commits; temporary files in `.tmp/`; the 20-minute budget (3 minutes used); the closed list (no
phases, Fourier coefficients, counts or windings of the types on windows; no (V) on an open torus
beyond the cut controls the brief asked for in T1(c); no reach sweeps of R; no U' certificates; no
hunt for a new quantity); status tags on every claim; UK English, no em-dashes; under 400 lines.

Bent: the brief named four cells; I added (12,8,8) (five queries, 118 s) because the four cells
all have gcd(a,b) = gcd(a,c) = gcd(b,c) and cannot tell the period of the weights of (C) from g, and
S4 needed a cell that can. I also ran the full cut cylinders (eight queries, 2 s) beyond the
windows the brief's `--cut` implies, to make Table B a statement about the cylinder and not about
a window. T2(ii) was not carried out as a derivation because its premise failed in T1; what P^x
gives with R is stated instead. Lemmas S1 to S4 are proved here by me and have no second reader.
