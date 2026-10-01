---
title: "Statement R (the whole line of the rods): its reach, the height language, and what is proved by hand"
author: "Claude (Fable), agent rodline, for Lyndon Drake"
date: 2026-09-30
---

# Verdict

**R TORUS, in the weak form of one circle.** Statement R is not a window
lemma in the sense of (V)'s record and not a torus statement either: its
first step, that $v_2 = (8,0,0)$ is of type $x$, is forced inside a **box
over one closed transverse circle**. With the rods along $x$, the lower
bridgehead $(1,1,1)$ of type $y$ and the upper bridgehead $(3,-1,1)$ not of
type $y$, the box is $x \in [-3, 2b+1]$ relative to the hole, $|z| \le 2b -
1$, and the whole $y$-circle of the cell $(a, b, c)$. Nothing depends on
$a$, $c$ or $\gcd(b,c)$ once the $y$-circle is fixed. The reach is linear
in $b$, the extent of the closed circle. DRAT certificates of this box
lemma are written and checked for $b = 3, 4, 5, 6$ (solver, 0.1 to 0.7 s
each). On the full torus the reach shortens to $2g+1$, $g = \gcd(b,c)$,
which is exactly the law of (V); but R survives the cut of a transverse
grid along $z$, where (V) does not, so R is strictly weaker than (V) and
is not (V) in disguise. (V) implies R in two lines (Lemma 6 and $P^x$).
The later positions $v_j$, $j \ge 3$, are forced as soon as the box reaches
them, with a $z$-radius that grows by about one grid per cube. In the
heights of (C) the statement R has no linear content (the four chains of
axes $y$ and $z$ through $v_j$ carry the label $j$ modulo $\gcd(a,c)$ and
$\gcd(a,b)$, so (C) relates no two positions of a cubic cell), which agrees
with cubethree's feasible LP; R is an integrality statement. What is left
is a hand proof of the box lemma for every $b$; the certificates for $b=3$
(19 kB) and $b=4$ (50 kB) are its guide.

# Statement tested

Coordinates in quarter-cube units, cell $(a,b,c)$ modulo $(4a,4b,4c)$, A
= even coordinates with sum $\equiv 0 \pmod 4$, B = A + (1,1,1). A-hole
$O = (2,0,0)$, rods $v_0 = (0,0,0)$ and $v_1 = (4,0,0)$ of type $x$; lower
bridgehead $\beta = (1,1,1) = v_0 + d_0$ of type $y$; upper bridgehead in
four forms:

| form | literal | note |
|---|---|---|
| `ng2` | $(3,-1,1) = \gamma'$ not of type $y$ | cubethree's R (h514 `R`); $\beta, \gamma'$ share the $z$-chain through $(2,0,2)$ |
| `zg2` | $(3,-1,1)$ of type $z$ | |
| `zg`  | $(3,1,-1) = \gamma$ of type $z$ | the four-literal form of (V′), h620 |
| `ng`  | $(3,1,-1)$ not of type $y$ | h509's non-forcing pair |

Conclusion tested: $v_j = (4j, 0, 0)$ is of type $x$, one assumption
literal per $j$; relative $x$ of $v_j$ is $4j - 2$, unwrapped. Windows:
hexagons all six of whose vertices have relative $x$ in $[-P, Q]$; `one` =
$[-3, Q]$, `sym` = $[-Q, Q]$; a **cut** drops every hexagon with a vertex on
the transverse grid farthest from the line (relative $y = -2b$ or $z =
-2c$); a **tube** keeps only hexagons with $|y| \le W$ and $|z| \le W$, or
on one axis only. Two models: **type** = one-hot everywhere and (T2) on the
window's hexagons (h360_lib); **bond** = ice rule on every vertex of the
torus and the two-arc rule on the window's hexagons (icemix, as h620).
Every window is one child process (h32_cap) with a control (the literals
alone) and the $j$-queries; UNSAT means forced; $Q$ sweeps upward; cap 120 s.
The negation of (V) (some B vertex on the grid $x = 1$ of type $x$) was
added as a comparison query on the cut and tube windows only.

# Reach tables

**A. Torus, no cut** (type model; the bond model gave identical numbers on
(12,4,4) and (10,5,5), 60 s). Forms `zg`, `zg2`, `ng2` agree on every cell;
`ng` forces nothing beyond the periodicity $j \mapsto j + \gcd(a,c)$ of
(C) along the line (e.g. on (12,4,4) it forces $v_4, v_5, v_8, v_9$ and
never $v_2$, $v_3$, even in the symmetric window one grid short of the
torus).

| cell | $g$ | $v_2$, `one` $[-3,Q]$ | $v_2$, `sym` | $v_j$, $j\ge3$, `one` | $v_j$, `sym` |
|---|---|---|---|---|---|
| (8,3,3) | 3 | 7 | 6 | $x_j$ | $\lvert x_j\rvert$ |
| (9,3,3) | 3 | 7 | 6 | $x_j$ | $\lvert x_j\rvert$ (the antipode $x=-18$ not reached) |
| (12,4,6) | 2 | 6 | 6 | $x_j$ | $\lvert x_j\rvert$ |
| (12,4,4) | 4 | 9 | 6 | $x_j$ | $\lvert x_j\rvert$ |
| (12,4,8) | 4 | 9 | 6 | $x_j$ | $\lvert x_j\rvert$ |
| (10,5,5) | 5 | 11 | 8 | $\max(x_j, 11)$ | $\max(\lvert x_j\rvert, 8)$ |
| (12,5,5) | 5 | 11 | 8 | $\max(x_j, 11)$ | $\max(\lvert x_j\rvert, 8)$ |
| (12,6,6) | 6 | 13 | 10 | $\max(x_j, 13)$ | $\max(\lvert x_j\rvert, 10)$ |
| (12,8,8) | 8 | 17 | not run | $\max(x_j, 17)$ ($j \le 4$) | not run |

Law (solver, nine cells): one-sided reach of $v_2$ is $\max(6, 2g+1)$ and
symmetric $\max(6, 2g-2)$; these are the thresholds $(3, 2g+1)$ and
$(2g-2, 2g-2)$ of (V) in the record. Every later $v_j$ is forced the moment
the window contains it, once the window has passed the threshold.

**B. Cut and tube windows, form `ng2`, `one`, type model**; the column V is
the negation of (V) on the same clause set.

| cell | window | $v_2$ | $v_3$ | $v_4$ | $v_5$ | V |
|---|---|---|---|---|---|---|
| (12,4,4) | torus | 9 | 10 | 14 | 18 | 9 |
| (12,4,4) | cut $y$ | 10 | 10 | 15 | 18 | none $\le 23$ |
| (12,4,4) | cut $z$ | 9 | 10 | 14 | none $\le 23$ | none |
| (12,4,4) | tube 7, 6 or 5 (both axes) | none | none | none | none | none |
| (10,5,5) | cut $z$ | 11 | 11 | 14 | 18 | none $\le 19$ |
| (10,5,5) | cut $y$ | 12 | 12 | 14 | 19 | none |
| (10,5,5) | tube 9 (both) | none | none | none | none | none |
| (12,8,8) | cut $y$ | 22 | 22 | 22 | — | none $\le 43$ |
| (12,8,8) | tube 3 to 12 (both) | none $\le 21$ | | | | |
| (12,4,8) | cut $y$ | none $\le 23$ | none | none | none | none |
| (12,4,8) | cut $z$ | 9 | 10 | 14 | 18 | none |
| (12,4,6) | cut $y$ | none $\le 23$ | none | none | none | none |
| (12,4,6) | cut $z$ | 9 | 10 | 14 | 18 | none |
| (12,6,6) | cut $y$ | 15 | 15 | 15 | 18 | none |
| (12,4,8), form `zg` | cut $y$ / cut $z$ | none / 9 | none / 10 | none / 14 | | |

So R needs the closed **$y$-circle** and not the $z$-circle: with $z$ cut it
is forced with reach $2b+1$ on every cell tried (9 for $b=4$ whatever $c$
and $g$, 11 for $b=5$), and with $y$ cut it survives only when $b = c$,
with a larger reach (10, 12, 15, 22 for $c = 4, 5, 6, 8$), presumably by a
second mechanism on the $z$-circle that the equal extents allow. (V) fails
on every cut, as the record says.

**C. Box over the $y$-circle: $x \in [-3, Q]$, $|z| \le W$, $y$ unrestricted.**

| cell | $b$ | $W$ | $v_2$ | $v_3$ | $v_4$ | $v_5$ | $v_6$ |
|---|---|---|---|---|---|---|---|
| (12,3,8) | 3 | 3 | none | none | none | | |
| (12,3,8) | 3 | 5 | 7 | 10 | none $\le 23$ | | |
| (12,3,8) | 3 | 7 | 7 | 10 | 14 | 18 | none $\le 23$ |
| (12,3,8) | 3 | 9, 11, 13 | 7 | 10 | 14 | 18 | 22 |
| (12,4,8) | 4 | 3, 5 | none | none | none | | |
| (12,4,8) | 4 | 7, 9, 11 | 9 | 10 | 14 | | |
| (12,4,8) | 4 | 5 on $y$ only, $z$ closed | none | none | none | | |
| (10,5,5) | 5 | 3, 5, 7 | none | none | none | | |
| (10,5,5) | 5 | 9 | 11 | 11 | 14 | | |
| (12,6,8) | 6 | 5, 7, 9 | none | none | none | | |
| (12,6,8) | 6 | 11 | 13 | 13 | 14 | | |

Law (solver, four values of $b$): the first step needs $Q = 2b+1$ and $W =
2b-1$; the $z$-radius needed for $v_j$ then grows by two every two cubes
($W = 5, 5, 7, 7, 9$ for $j = 2, \dots, 6$ at $b = 3$), so on a cubic cell
the far half of the line uses the $z$-circle as well.

**Backbone of the box** (h631, (12,4,8), $Q = 9$, $W = 7$, 376 vertices,
0.5 s): 149 forced literals, all at relative $x \le 5$ and $|z| \le 5$; the
B $y$-lines at $(x, z) = (3, \pm1)$ (through $\gamma$ and $\gamma'$) and at
$(5, \pm 3)$ (absolute $x$) are forced entirely free of type $x$, the line
through $\beta$ has 14 of 32 forced; the rod $v_2$ is forced. On the torus
window $[-3, 9]$ of (12,4,4), by contrast, every B vertex of the window is
forced not to be of type $x$ (416 vertices, 403 forced literals, 0.6 s): there
R is a consequence of (V) in the window.

**Certificates** (h633, type model, form `ng2`; `certs/h633_R_b<b>_<cell>_q.{cnf,drat}`
with a `_ctrl.cnf` that is SAT). Hypotheses, exactly: one-hot at every
vertex of the cell; (T2) on every hexagon all six of whose vertices satisfy
$-3 \le x - 2 \le 2b+1$ and $|z| \le 2b-1$; the four unit clauses $X(v_0) =
X(v_1) = 1$, $Y(\beta) = 1$, $Y(\gamma') = 0$; negated conclusion $X(v_2) =
0$. The box does not wrap when $4a > 2b+5$ and $4c > 4b-1$, so each
certificate is a lemma for every cell with that $b$ meeting these bounds,
and for their quotients by lifting.

| $b$ | cell | hexagons | clauses | cadical | drat-trim | proof | cnf sha256 | drat sha256 |
|---|---|---|---|---|---|---|---|---|
| 3 | (12,3,8) | 192 | 14 213 | UNSAT 0.0 s | VERIFIED 0.1 s | 19 kB | c16d0141d6a4f64f | 8aafe99657383a05 |
| 4 | (12,4,8) | 480 | 24 773 | UNSAT 0.1 s | VERIFIED 0.1 s | 50 kB | 917bd529b9bd7d96 | 05bc8b4887b6e303 |
| 5 | (12,5,6) | 960 | 36 485 | UNSAT 0.2 s | VERIFIED 0.1 s | 570 kB | 289175f169e9bada | 88ce53b9c97abce1 |
| 6 | (12,6,8) | 1680 | 62 117 | UNSAT 0.7 s | VERIFIED 0.4 s | 2.2 MB | 1eb3931e8a4ef651 | ceeb294a6d681da8 |

The type model is weaker than the bond model (the types of a frozen state
satisfy (T2)), so each certificate also covers the frozen states.

# The height language

Everything in this section except the integrality count is in the record:
(C) and the plane parametrisation $F_z = P(n) + Q(m)$ are in the note's
section on the coprime cells; the window $F_z \le F_x \le F_y \le F_z + 1$
and the gauge of one constant per kagome layer are in
`2026-09-10-u-heights.md` §3. What follows restates them in one notation
and checks them exactly on 1,417 states (h632).

**Definitions.** On sublattice $S$ with $\sigma = +1$ on A and $-1$ on B,
$h_x = F_x$, $h_y = F_y + \sigma\beta$, $h_z = F_z - \sigma\alpha$. Then (C)
reads $Y = h_x - h_z$, $Z = h_y - h_x$, $X = 1 + h_z - h_y$.

**Lemma H1 (window and gap; proved).** In every solution of the type
model, at every vertex, $h_z \le h_x \le h_y \le h_z + 1$, and exactly one
of the three differences $h_x - h_z$, $h_y - h_x$, $h_z + 1 - h_y$ equals 1:
the type is $y$, $z$ or $x$ respectively. Type $x$ if and only if the three
heights agree. *Proof.* The three differences are the indicators $Y$, $Z$,
$X$, which lie in $\{0,1\}$ and add to 1. $\square$

**Lemma H2 (separability on a pair of planes; proved).** On the pair of
$k$-planes $\{t, t+1\}$ of $S$, $h_k(v) = f(C_1(v)) + f(C_2(v))$, where
$C_1, C_2$ are the chains of the two families of axis $k$ through $v$,
labelled by residues modulo $g_k$ ($g_x = \gcd(b,c)$ etc.), and every pair
of labels occurs at a vertex of the pair of planes. *Proof.* The first
statement is the definition of $F_k$; the second is the note's transitivity
argument (translations of the plane fix one label and move the other).
Checked computationally: on every pair of $x$-planes of the five cells
below the label pairs fill the $g_x \times g_x$ product. $\square$ Note that
$h_y$ and $h_z$ on that pair of planes are not separable in these labels;
they involve chains transverse to the planes.

**Lemma H3 (gauge; proved and computed).** A kagome layer $\Lambda$ is the
set of chains whose step is orthogonal to a bond direction $d_i$ and whose
A vertices lie on one plane $v \cdot d_i = s$; each chain lies in two
layers and each vertex in four, one per direction, meeting one chain of
each axis there. Adding $c_\Lambda$ to the weights of the chains of
$\Lambda$ leaves $Y$ and $Z$ unchanged and shifts the three heights at every
vertex by the same amount $\sum_i c_{\Lambda_i(v)}$ (proved: one chain of
each axis). There are $4\gcd(a,b,c)$ layers. Computed on (3,3,3), (4,4,4),
(6,3,3), (12,4,4), (5,5,5): the kernel of $(f, \alpha, \beta) \mapsto (Y,Z)$
has dimension $12, 16, 12, 16, 20 = 4\gcd(a,b,c)$, the layer indicators
are independent and lie in it, so the kernel is exactly the layer span and
the heights are determined up to that common shift. $\alpha$ and $\beta$
are determined by the state.

**Checks (h632).** (C) was solved exactly (least squares, rationalised,
verified in Fractions) on every one of the 637 odd corpus states of (3,3,3)
and 720 of (4,4,4), and on 20 sampled solutions of the type model on each
of (6,3,3), (12,4,4), (5,5,5): 1,417 states, 1,417 exact solutions, 0
violations of the window and 0 vertices whose type is not the open gap
(these two are identities once (C) holds, so the check is of (C)). The
antisymmetric constants are $(0,0)$ on 553 of 637 and 645 of 720 corpus
states and on all 60 samples; otherwise $\pm\frac16, \pm\frac13$ at $L=3$
and $\pm\frac18, \pm\frac14$ at $L=4$.

**Integrality (computed; disagrees with the record as I read it).** The
gauge orbit of $f$ contains an integer vector on 19 of 637 states of
(3,3,3), 20 of 720 of (4,4,4), and 0 of 60 samples (decided exactly by
propagating fractional parts on the layer graph, the lifted vector
re-verified against (C)). The least $d$ with a representative in
$\frac1d\mathbb{Z}$ is 27 or 54 for 424 of the 637 states at $L=3$, 32 to 96
for 456 of 720 at $L=4$, and up to 160 on (12,4,4) with 9 of 20 states
needing $d > 216$. The 10 September statement that balanced $f$ "can be
taken integral on every state examined" does not hold on the corpus; the
main loop should check whether the chain modes of that report are
normalised differently before treating this as a correction.

# R by hand

Notation: $O_j = v_j + 2e_x$ is the A-hole between $v_j$ and $v_{j+1}$;
its lower bridgeheads are $v_j + d_0, v_j + d_1$ and its upper ones $v_{j+1}
+ d_2, v_{j+1} + d_3$, all on B.

**Lemma R1 (the step; proved).** In the type model, for every $j$,
$X(v_{j+1}) - X(v_j) = \#\{\text{upper bridgeheads of } O_j \text{ of type }
x\} - \#\{\text{lower ones of type } x\}$. If no bridgehead of $O_j$ has
type $x$ then $X(v_{j+1}) = X(v_j)$. *Proof.* Law $P^x$ at $O_j$. $\square$

**Lemma R2 ((V) implies R; proved).** If the B grid $x = 1$ has no vertex
of type $x$, then B has no vertex of type $x$ and every $v_j$ is of type
$x$. *Proof.* Lemma 6 of the note (grid counts) gives the same number of
type-$x$ vertices on every B plane normal to $x$, so all are zero; then
Lemma R1 along the line, from $X(v_0) = 1$. $\square$ This is why R has
(V)'s reach on the torus, and why every B vertex of the threshold window is
forced there (backbone above). The converse fails: R holds on the $z$-cut
cylinder where (V) does not (Table B).

**Lemma R3 (the line in the heights; proved).** $X(v_j) = 1 - D_j$ with
$D_j = h_y(v_j) - h_z(v_j) \in \{0, 1\}$, and $D_j = \varphi(j \bmod
\gcd(a,c)) + \psi(j \bmod \gcd(a,b))$, where $\varphi$ is the sum of the
weights of the two $y$-chains through $v_j$ plus $\beta$ and $\psi$ minus
the sum of the two $z$-chains through $v_j$ plus $\alpha$. *Proof.* The
$y$-chain of family $\{d_0,d_2\}$ through $v_j$ is $\{(4j + 2n, 0, 2n)\}$,
with constant $(x - z)/4 \equiv j \pmod{\gcd(a,c)}$; likewise the other
three. $\square$ On a cubic cell all four labels are $j \bmod L$, so (C)
imposes no relation between $D_j$ and $D_{j'}$ for $j \ne j'$: the rods fix
$D_0 = D_1 = 0$ and say nothing about $D_2$. This is the exact content of
cubethree's "the rods fix two positions of three" and of its feasible LP:
R is an integrality statement, not a linear one. When $\gcd(a,b,c) = 1$
the pair of labels runs over the product and Lemma 8 of the note makes
$\varphi$ or $\psi$ constant, which is the route of Theorem 13.

**Lemma R4 (what the bridgeheads say in the heights; proved).** With
$Y(\beta) = 1$ and $Y(\gamma') = 0$, and $Z_c$ the $z$-chain of family
$\{d_1, d_2\}$ through $(2,0,2)$ that carries both,
$$f(X^{01}_{v_0}) + f(X^{23}_\beta) - f(X^{23}_{v_1}) - f(X^{01}_{\gamma'})
= 1 + f(Z^{03}_{v_0}) - f(Z^{03}_{v_1}),$$
where $X^{01}_{v_0}$ is the $x$-chain of family $\{d_0,d_1\}$ through $v_0$
(planes 0, 1), $X^{23}_\beta$ the one through $\beta$ (planes 1, 2),
$X^{23}_{v_1}$ (planes 3, 4), $X^{01}_{\gamma'}$ (planes 2, 3), and
$Z^{03}_{v}$ the $z$-chain of family $\{d_0,d_3\}$ through $v$. *Proof.*
Subtract $Y = h_x - h_z$ at $\gamma'$ from the same at $\beta$; $Z_c$
cancels. $\square$ The right side is a difference of the $z$-heights of the
two rods, the left a combination of four $x$-chains in the planes $0$ to
$4$; the identity is what the note's Theorem 10 uses first. With $g = 1$
the four $x$-chains are functions of their planes and the argument closes
round the rod axis. With $g \ge 2$ it does not, and no linear argument can
(Lemma R3).

**The gap, stated precisely.** What is not proved by hand is the box lemma:

> **Conjecture R$_b$.** For every $b$, on every cell $(a, b, c)$ with $4a >
> 2b + 5$ and $4c > 4b - 1$, the hypotheses of the certificate table (one-hot,
> (T2) on the hexagons of the box $x \in [-3, 2b+1]$, $|z| \le 2b - 1$ over
> the closed $y$-circle, and the four literals) force $X(v_2) = 1$.

Certified for $b = 3, 4, 5, 6$; solver-true on the torus of every cell in
Table A; false with $W = 2b - 3$ or $Q = 2b$ on every cell tried (Table
C), and false on any tube in $y$. Given R$_b$, the rest of R on a cubic cell
is Lemma R1 once B is known to be $x$-free near the line, and that is (V)
again; on the torus the solver forces the later positions as they enter
the window, but the mechanism there is (V) in the window (backbone), so R
does not stand on its own for $j \ge 3$ without the $z$-circle either.

What the certificate suggests the hand proof uses: the closed $y$-lines
(the $y$-lines of B through the four bridgeheads are $2b$ vertices long
and are forced $x$-free in whole, two of them at $x = 3$ and two more at $x
= 5$), the sums of $P^y$ over closed $y$-lines of holes, whose methylene
terms telescope (the proof of Theorem 5), and an integrality step of the
kind cubethree found sufficient (the one A $x$-line through $O + 2e_y$).
The width $2b - 1$ in $z$ and $2b + 1$ in $x$ are both the length of a
$y$-line less a constant, which points at a count on $y$-lines that must
saturate. I did not find the identity, and did not force one.

# What is left and a stop rule

1. **A hand proof of R$_b$ for all $b$.** One round, from the $b = 3$
   certificate (192 hexagons, 19 kB) and the backbone: look for a sum of
   $P^y$ over the closed $y$-lines of holes in the box that, with the
   integrality of one line, forces $D_2 = 0$. Stop if a session produces no
   identity whose reach is $2b+1$; then R$_b$ stays a per-$b$ certificate,
   which is enough for Theorem H on no new cell (R is weaker than (V)).
2. **Do not** measure more reach, sweep more cells, or re-run (V) on
   windows, slabs or cuts; the (V) queries here were comparison controls
   only (fourteen solves) and reproduced the record.
3. **For the plan "R, then monodromy along the rod axis, then
   integrality":** R gives the full line at the cost of one closed
   transverse circle and integrality, and the full line does not give (V)
   (the $z$-cut cylinder has R and not (V)); whatever (V) needs from the
   second transverse circle is not supplied by R, and the monodromy step
   must supply it.
4. **Owed to the record:** the integrality of the weights, which the 10
   September report claims and the corpus contradicts as read here; and
   R as a consequence of (V) (Lemma R2), which the note's list of what the
   pattern forces states as a solver fact.

# Scripts and timings

All new, in `experiments/08_frozen_structure/scratch_h/`; none existing
modified; nothing committed.

| script | purpose | solver wall |
|---|---|---|
| `h630_rreach.py` | reach sweeps: cells joined by `+`, `--model type\|bond`, `--forms`, `--win one,sym`, `--cut AX`, `--tube W [--tubeax AX]`, `--js`, `--vtarget`, `--Qmax`, `--timeout` | Table A 594 s; bond 60 s; cuts and tubes 262 s |
| `h631_backbone.py` | forced literals of a window, per grid and per $y$-line | 1.1 s |
| `h632_heights.py` | exact solve of (C), heights, kernel, integral lifts, on corpus and samples | 1.4 s (samples); 60 s of exact arithmetic |
| `h633_rcert.py` | DRAT certificates of R$_b$ with SAT controls | 1.7 s in all |

Solver wall time in all: about 16 minutes of the 90 allowed. One batch
was killed at the 120 s cap: (12,6,6), form `ng`, symmetric window $Q =
22$, 6,048 hexagons; its finished queries are in Table A's note on `ng`
and nothing rests on it. Every UNSAT reported has a SAT control on the same
clause set without the negated conclusion. Everything ran in the Mac
`.venv`, one solver process at a time, on this machine only.

# Rules kept or broken

Kept: read the note, the two reports and the scripts named before
starting; type-only model as in h360_lib and bond model as in h620, both
used; every solve in a child with a hard cap (120 s, backbones 300 s,
cadical 300 s); one solver process at a time; no job over 10 minutes; no
Sparks, no expq; scripts `h630`–`h633`; no commits; `h580`–`h619` and the
topics of kuwall and zeroflux untouched; status tags and counts given;
report under 400 lines; UK English, no em-dashes.

Bent: the negation of (V) was solved on cut and tube windows as a
comparison, which touches the handover's closed list for (V); these were
controls for R's tables, not new measurements of (V), and every one agreed
with the record. The lemmas H1 to H3 and R1 to R4 are proved here by me and
have no second reader; the certificates were checked by drat-trim only.
