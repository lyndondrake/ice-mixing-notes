---
title: "Theorem H for frozen pyrochlore ice: proofs on the cells with a coprime pair of extents and on the cells with two chains in every pair of planes, a reduction to Theorem U alone on every cell, and the cubic cells of side one to eight"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-10-01
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  Theorem H says that a frozen state of pyrochlore spin ice with a
  hexagon of odd curl has a dipole axis that is empty or carries one
  sign only. With Theorem P and Lemma A of an earlier note it gives the
  periodicity of frozen zero-flux states on every cell whose extents
  are all at least two. This note proves Theorem H on
  two families of cells and reduces it to two statements on the rest.
  On a cell in which two of the three extents are coprime, no
  sublattice of a frozen state carries all three types of vertex, and
  Theorem H follows in a few lines. On the cells $(2a', 2b', 2c')$ with
  $a'$, $b'$ and $c'$ pairwise coprime, which have two chains of each
  family in every pair of neighbouring planes, a state is described by
  functions of one coordinate, and Theorem H is proved from that
  description and from the structure of the signed moments, which on
  every cell are a sum of currents along the chains when every hole is
  oriented. On every cell Theorem H is reduced to one statement,
  Theorem U, which says that in an odd state every octahedral hole has
  one rod pointing towards it and one away. The reduction is written
  out in full. Its steps are a cage law for the signed moments, the
  separability of line counts, a lemma on two non-negative separable
  functions with product zero, a law for rods on neighbouring lines
  with an explicit linear certificate, and the law that writes the
  fraction of each type on a line as the difference of two profiles of
  one coordinate: with every hole oriented, the count of a two-way
  type on a line depends on one transverse coordinate, the two
  sublattices share that coordinate, and with three two-way axes some
  type has the same count on every line of both sublattices, which the
  law for neighbouring lines makes one-way. An earlier form of the
  reduction needed a second statement, $K_u$, that a chain of one
  moment forces a direction to be absent; it is no longer a step.
  Theorem U is certified by DRAT proofs on the cubic cells of side
  four to eight and on the cells $(3,3,9)$, $(4,4,8)$, $(3,3,12)$ and
  $(6,6,9)$, and a state repeated periodically is a state of a larger
  cell, so Theorem H holds on the cubic cells of side one to eight. A
  search for a counterexample to Theorem U on those cells found none.
  On the cubic cells of side nine and more Theorem U, and with it
  Theorem H, is open. The method of the two families does not carry
  over to three chains in every pair of planes, and the note records
  where it stops. The proofs were written by language-model agents and
  read by separate agents as checkers, with independent programs. No
  human has yet read them line by line.
---

# The statement

The setting is that of the note on the curl reduction. The diamond
lattice has sublattices A, the points with even coordinates whose sum
is a multiple of four, and $B = A + (1,1,1)$, in units of a quarter of
the cubic edge, with bonds along $d_0 = (1,1,1)$, $d_1 = (1,-1,-1)$,
$d_2 = (-1,1,-1)$ and $d_3 = (-1,-1,1)$ from each A vertex. The cell
$(a, b, c)$ is the torus of $a$, $b$ and $c$ cubes along the three
axes, so coordinates are taken modulo $(4a, 4b, 4c)$. Its **extents**
are $a$, $b$ and $c$, and the cubic cell of side $L$ is $(L, L, L)$.
The sections up to the proof of Theorem 1 are written for the cubic
cell and hold on every cell with the changes of wording named in the
subsection on cells that are not cubic. An
ice state puts an arrow on every bond with two in and two out at every
vertex, and the vertex then has a moment $n(v) = \varepsilon(v)
e_{\tau(v)}$ along one of the six directions $\pm e_x, \pm e_y, \pm
e_z$. The axis $\tau(v)$ is the type of the vertex and $\varepsilon(v)$
its sign. The arrows agree at the two ends of a bond exactly when

$$d_{\tau(a)}\,\varepsilon(a) = d_{\tau(b)}\,\varepsilon(b)
\qquad\text{on every bond } (a, b = a + d),$$

which is the **bond rule**. Two neighbours of the same type therefore
have the same sign. A state is frozen when no hexagon circulates, and
by Lemma L of the earlier note every hexagon of a frozen state has
exactly two reversals of its flow. The hexagon has even curl when the
two reversals lie on different sublattices and odd curl when they lie
on the same one. A frozen state is **odd** if some hexagon has odd
curl.

Say that axis $k$ is empty in a state if no vertex has type $k$,
one-way if the vertices of type $k$ all have one sign, and two-way if
both signs occur. All six directions occur exactly when all three axes
are two-way.

**Theorem H.** An odd frozen state has an axis that is empty or
one-way.

A chain is one of the closed $\langle 110 \rangle$ walks of bonds, of
$4L$ vertices. It has an axis, the coordinate in which its two bonds at
every vertex agree, and a vertex is a kink of the chain when its type
is that axis. A chain is **uniform** when all its vertices carry the
same moment. By the bond rule a chain all of whose vertices have one
type is uniform. In this note that type is always different from the
axis of the chain, so a uniform chain has no kinks.

A **hole** is an octahedral interstice of the lattice, and the next
section attaches two rods to every hole. The rods have directions given
by the signs of the moments.

## The statement of the reduction, and a second statement that is no longer needed

**Theorem U.** In an odd frozen state every hole has one rod pointing
towards it and one pointing away.

Theorem H follows from Theorem U on every cell (Theorem 1 below, in
its form of 30 September 2026). The first form of the reduction, of 27
September, needed a second statement as well, and the record of that
statement is kept here because the certificates of the cubic cells
were built on it and because its standing was corrected twice.

**$K_u$.** A frozen state that contains a uniform chain lacks one of
the six directions.

Neither is proved for every cell. Theorem U is proved by hand on the
cells with a coprime pair of extents and on the cells with two chains
in every pair of planes, and for some holes of other cells (Theorems 10
and 11). It is certified by DRAT proofs on the cubic cells of side
four to eight and on four cells that are not cubic. $K_u$ was established on 11 September 2026 by
window lemmas with DRAT certificates, one lemma proved as a strip
automaton for every period, and steps proved by hand. The windows were
recorded for extents of at least three along the chain and four across
it. One step has a smaller scope than the record gave it. The first
step says that a uniform chain makes every chain of the second family
in the two neighbouring slabs of one sense. Its certificate is a window
about a point of the uniform chain, and its conclusion holds only
within transverse distance two of that chain, while the later steps
need it on the whole slab. On a cell $(a, b, c)$ with the chain along
$x$ the chain comes round again at transverse distance $2\gcd(b, c)$,
so the certificates give the whole slab only when $\gcd(b, c) \leq 2$.
The statement on the whole slab is not a window lemma of that shape,
since it is satisfiable to negate in windows of radius up to seven. It
is certified on the whole torus, by DRAT proofs checked by drat-trim,
for the cubic cells of side four to eight, and is open for the others.
This gap was found on 27 September 2026 by an independent checker that
was reading the record for another purpose.

## What is proved

**Theorem 1 (the reduction).** On every cell, Theorem U implies
Theorem H.

In its first form, of 27 September 2026, the theorem had the
hypothesis that $K_u$ holds for uniform chains of all three axes. The
proof given in the section "Proof of Theorem 1" needs it no longer;
the earlier proof is kept there as a second route, valid where $K_u$
holds.

**Theorem 2.** Theorem H holds on the cubic cells of side four to
eight, and on the cells $(3,3,9)$, $(4,4,8)$, $(3,3,12)$ and $(6,6,9)$.

**Theorem 14.** On a cell in which some pair of extents is coprime,
every odd frozen state lacks one of the three types, so Theorem H
holds.

**Theorem 22.** On a cell $(2a', 2b', 2c')$ with $a'$, $b'$ and $c'$
pairwise coprime, Theorem U holds.

**Theorem 23.** On such a cell Theorem H holds.

**Theorem 24.** Theorem H holds on the cubic cells of side one, two
and three.

Theorems 14 and 23 are proved by hand and use neither Theorem U as a
hypothesis nor $K_u$. Theorem 14 rests on a statement about the types
of one sublattice (Theorem 12), and Theorem 23 on a description of the
states of those cells by functions of one coordinate (Theorem 20) and
on the structure of the signed moments (Theorems 17 and 19). Theorems 2
and 24 rest on certificates. The standing of Theorem H is then as
follows.

| cells | Theorem H |
|---|---|
| some pair of extents coprime, for instance $(L, L, L+1)$ | proved (Theorem 14) |
| $(2a', 2b', 2c')$ with $a'$, $b'$, $c'$ pairwise coprime, for instance $(2,2,2)$ and $(4,6,10)$ | proved (Theorem 23) |
| cubic, side one to eight; $(3,3,9)$, $(4,4,8)$, $(3,3,12)$, $(6,6,9)$ and the cells whose extents divide one of these | by certificates of Theorem U (Theorems 2 and 24, Lemma 21) |
| every other cell, the cubic cells of side nine and more among them | open; follows from Theorem U (Theorem 1) |

On the cells of the last row Theorem H follows from Theorem U by
Theorem 1, and Theorem U is open there. A pair of neighbouring
planes normal to an axis holds as many chains of each family of that
axis as the greatest common divisor of the two other extents. In the
cells of the first row some axis has one, and in those of the second
every axis has two. The method that proves Theorem H on them does not
carry over to three, and a later section records where it stops.
Theorem U is also proved on the cells of the first two rows (as a
corollary of Theorem 12, and Theorem 22), so on those cells Theorem 1
gives a second proof of Theorem H.

Theorem P of the earlier note, that an ice state with even curl on a
cell whose extents are all at least two has a one-cube period, has
since been proved for every such cell in the project's working note.
The hypothesis on the extents is needed: the proof makes the profile of
some axis periodic with period one cube without choosing the axis, and
on an axis of extent one that shift is the identity. With Lemma A for
the states in which a type is absent, Theorem H gives the periodicity
of frozen zero-flux states: on every cell of the first three rows of
the table whose extents are all at least two, every frozen zero-flux
state is invariant under a nonzero translation. On the thin cells the
conclusion is false: the cells $(1,2,2)$, $(1,2,3)$, $(1,3,3)$,
$(1,3,4)$ and $(1,4,5)$ carry frozen zero-flux states of even curl,
with all six directions, that no nonzero translation fixes (solver, 1
October 2026, witnesses re-checked by an independent program and a
sample run again by the main session). The cubic cell of side one has
no such state (solver), so the statement holds there by computation
and not through the chain. Side four is the cubic cell
on which a cube-and-conquer proof of that statement had left 407
leaves unrefuted, and on which a direct certificate of H was abandoned
after thirty-six hours of solving.

# Holes, cages and rods

Put $\mathcal{H}_A = A + (2,0,0)$ and $\mathcal{H}_B = B + (2,0,0)$.
These are the holes of the two sublattices. A hole $O$ of sublattice
$S$ has six nearest vertices of $S$, its **methylenes** $O \pm 2e_k$,
and four nearest vertices of the other sublattice $S'$, its
**bridgeheads** $O + s$ with $s \in \{\pm 1\}^3$ and $s_x s_y s_z = -1$
for an A-hole, $+1$ for a B-hole. The ten vertices with the twelve
bonds among them are the **cage** of $O$.

The hexagons are the pairs of holes $(O, O')$ with $O \in \mathcal{H}_A$
and $O' = O + \sigma$, $\sigma \in \{\pm 1\}^3$, $\sigma_x \sigma_y
\sigma_z = +1$. The hexagon has the three A vertices $a_k = O +
2\sigma_k e_k$ and the three B vertices $b_k = O' - 2\sigma_k e_k$, and
at $a_k$ and at $b_k$ it uses a chain of axis $k$. So $a_k$ is a
reversal of the hexagon exactly when its type is $k$, and likewise
$b_k$. Writing $N(O, \sigma)$ for the number of $k$ with $\tau(O +
2\sigma_k e_k) = k$, Lemma L reads

$$N(O,\sigma) + N(O', -\sigma) = 2 \qquad\text{on every hexagon.}
\tag{T2}$$

Each hole lies on four hexagons, one for each admissible octant, and
the $b_k$ of a hexagon at the A-hole $O$ are bridgeheads of $O$: $b_k =
O + s$ where $s$ is $\sigma$ with its $k$-th entry reversed.

A vertex $v$ of type $k$ is a **rod**. It joins the two holes $v \pm
2e_k$ of its own sublattice, of which it is a methylene.

**Law C.** In a frozen state every hole has exactly two rods among its
six methylenes.

*Proof.* Add (T2) over the four hexagons at an A-hole $O$. Each
methylene $O + 2se_k$ lies in the two octants with $\sigma_k = s$, so
the first terms add to twice the number of rods of $O$. Each bridgehead
$O + s$ occurs three times among the $b_k$, once for each axis $k$,
so it contributes $\sum_k [\tau(O+s) = k] = 1$, and the four bridgeheads
contribute four. The right side is eight. A B-hole is the image of an
A-hole under the inversion $v \mapsto (1,1,1) - v$, which exchanges the
sublattices and preserves bonds, types and (T2). $\square$

Multiplying (T2) by $\sigma_k$ before adding gives the second cage law.
Write $K = [\tau = k]$.

**Law $P^k$.** For every hole $O$ and axis $k$,
$$K(O + 2e_k) - K(O - 2e_k) = \sum_{s} s_k\, K(O + s),$$
the sum being over the four bridgeheads.

*Proof.* On the methylene side the terms with axis $m \neq k$ cancel,
because $\sigma_k$ takes both signs for each value of $\sigma_m$, and
the terms with axis $k$ give $2(K(O+2e_k) - K(O-2e_k))$. The bridgehead
$O + s$ occurs as $b_k$ with $\sigma_k = -s_k$ and as $b_m$, $m \neq
k$, with $\sigma_k = s_k$, so it contributes $s_k(1 - 2K(O+s))$, and
$\sum_s s_k = 0$. The right side $2\sum_\sigma \sigma_k$ vanishes.
$\square$

A hole is **straight** if its two rods lie on one axis and a **corner**
otherwise.

**Lemma 1.** A frozen state is odd if and only if some hole is a
corner. In a state with even curl the vertices of type $k$ of each
sublattice fill complete $k$-lines $\{v + 4ne_k\}$.

*Proof.* The hexagon $(O, \sigma)$ is odd exactly when $N(O,\sigma)$ is
0 or 2. If it is 2, $O$ has two rods in one octant, which has one
methylene on each axis, so $O$ is a corner. If it is 0 the same holds
at $O'$. Conversely the two rods of a corner lie in a common octant of
the right parity. If every hole is straight and $v$ has type $k$, the
hole $v + 2e_k$ has $v$ as a rod and hence $v + 4e_k$ as its other rod.
$\square$

The rods of one sublattice thus form loops through the holes, two rod
ends at every hole, and the loops of an even-curl state are straight
lines round the torus.

# Orientation and charge

A rod at $O + 2se_k$ with sign $\varepsilon$ **points away** from $O$
if $\varepsilon = s$ and towards $O$ if $\varepsilon = -s$. The
**charge** of a hole is
$$c(O) = \#\{\text{rods pointing away}\} - \#\{\text{rods pointing
towards}\} \in \{-2, 0, 2\},$$
and $O$ is **oriented** when $c(O) = 0$. Theorem U says that an odd
state has no charged hole. A straight hole on axis $k$ with rods $v$ and
$v + 4e_k$ is oriented exactly when the two rods have the same sign.

**Lemma 2.** Every corner of a frozen state is oriented.

*Proof.* The two rods of a corner $O$ lie in an octant $\sigma$ with
$N(O,\sigma) = 2$, so they are the two reversals of the hexagon $(O,
\sigma)$. One of them is its source and the other its sink. The two
hexagon bonds at the rod $a_k = O + 2\sigma_k e_k$ both have
$k$-component $-\sigma_k$, so $a_k$ is a source when $\varepsilon(a_k) =
-\sigma_k$, which is pointing towards $O$, and a sink when it points
away. $\square$

So Theorem U concerns straight holes only, and it says that two
consecutive vertices of type $k$ on a $k$-line of an odd state have the
same sign.

Write $n_k(v) = \varepsilon(v)\,[\tau(v) = k]$ for the $k$-component of
the moment.

**Lemma 3 (the signed cage law).** In a frozen state, for every hole
$O$ and every axis $k$,
$$n_k(O + 2e_k) - n_k(O - 2e_k) - \sum_s s_k\, n_k(O + s) = c(O).$$

So at an oriented hole the moments obey the law $P^k$ that the types
obey, and at a charged hole they fail it by the charge, by the same
amount on all three axes.

*Proof.* The statement involves the ten vertices of one cage. Of the
$3^{10}$ assignments of types to them, 1,200 satisfy (T2) on the four
hexagons of the cage. In each the bond rule on the twelve bonds of the
cage has a solution, unique up to the global reversal, which changes
the sign of both sides. The identity holds in all 1,200. The
restriction of a frozen state to a cage is one of these, with its
signs. $\square$

The same enumeration shows that 1,104 of the patterns are oriented and
96 are not, that the 96 are all straight, and that a straight hole on
axis $k$ is charged exactly when the two bridgeheads on one side of it
along $k$ have one of the two other types and the two on the other side
have the other type. This is the **unoriented cage**. Orientation is
therefore a property of the types, and Theorem U is a statement about
the type field alone.

# The law for neighbouring lines

A **$k$-line** is a set $\{v + 4ne_k\}$, $L$ vertices of one
sublattice, indexed by its two transverse coordinates. The $k$-lines of
A sit at even transverse positions and those of B at odd ones, and a
line has four **diagonal neighbours**, the lines of the other
sublattice at transverse offset $(\pm 1, \pm 1)$.

**Theorem 3 (the diagonal law, $R^+$).** Let $v$ and $w$ be vertices of
type $k$ on diagonally neighbouring $k$-lines of a frozen state, and
suppose the holes of the causal diamond between them are oriented. Then
$\varepsilon(v) = \varepsilon(w)$.

The causal diamond is defined, and the theorem proved, in a later
section. In an odd state satisfying Theorem U the hypothesis on the
holes always holds.

**Theorem 4 (the line law, $S$).** Let $v$ and $w$ be vertices of type
$k$ on one $k$-line, and suppose the holes of the line between them are
oriented, together with the holes that Theorem 3 needs. Then
$\varepsilon(v) = \varepsilon(w)$.

*Proof.* Let the holes between $v$ and $w$ be $O_1, \dots, O_m$. Adding
Lemma 3 over them, the methylene terms telescope to $n_k(w) - n_k(v)$,
and what remains is a signed sum of $n_k$ over bridgeheads. The
bridgeheads of the $O_j$ are vertices of the four diagonal neighbours
of the line, each lying strictly between $v$ and $w$ in the coordinate
$x_k$ and each occurring once. If one of them, $u$, has type $k$, then
$\varepsilon(v) = \varepsilon(u) = \varepsilon(w)$ by Theorem 3. If
none has, the sum vanishes and $n_k(w) = n_k(v)$. $\square$

# Line counts

Fix an axis $k$ and a sublattice $S$. For the $k$-line of $S$ at
transverse position $(\alpha, \beta)$ let $h(\alpha,\beta)$ be the
number of its vertices of type $k$ and $s(\alpha,\beta) = \sum n_k$
their signed number. A function of two variables is **separable** if
it is a sum $F(\alpha) + G(\beta)$.

**Theorem 5.** In a frozen state $h$ is separable. If every hole is
oriented, $s$ is separable. In general the mixed second difference of
$s$ round a hole line is, up to sign, the total charge of that line.

*Proof.* Let $\ell$ be a $k$-line of holes of $S'$ at transverse
position $(\alpha, \beta)$ and add $P^k$ over its $L$ holes. The left
side telescopes to zero round the torus. The bridgehead $O + s$ lies on
the $k$-line of $S$ at $(\alpha + s_i, \beta + s_j)$, and as $O$ runs
over $\ell$ it runs over that whole line. Its coefficient $s_k$ is
$\pm s_i s_j$ with a sign fixed by the sublattice. So
$$h(\alpha{+}1,\beta{+}1) + h(\alpha{-}1,\beta{-}1) -
h(\alpha{+}1,\beta{-}1) - h(\alpha{-}1,\beta{+}1) = 0.$$
The mixed second difference of $h$ vanishes on every unit square of the
lattice of lines, and adding over a rectangle gives $h(\alpha,\beta) =
h(\alpha,\beta_0) + h(\alpha_0,\beta) - h(\alpha_0,\beta_0)$. With
Lemma 3 in place of $P^k$ the same sum gives the mixed second
difference of $s$ equal to $\mp \sum_{O \in \ell} c(O)$. $\square$

The first statement puts strong constraints on where a type can be
absent. If some line of $S$ has no vertex of type $k$, the lines with
none form a product set $I \times J$, where $I$ and $J$ are the sets on
which $F$ and $G$ take their minima.

# Two separable functions with product zero

**Lemma 4.** Let $P(\alpha,\beta) = p(\alpha) + p'(\beta)$ and
$Q(\alpha,\beta) = q(\alpha) + q'(\beta)$ be non-negative functions on
a product $X \times Y$ with $PQ = 0$ everywhere, neither of them
identically zero. Then either $p$ and $q$ are both constant or $p'$ and
$q'$ are both constant.

*Proof.* $Q$ is somewhere positive, so $P$ has a zero, its minimum is
zero, and its zero set is the product $Z_P = I_P \times J_P$ of the
sets where $p$ and $p'$ are least. The same holds for $Q$, and $Z_P
\cup Z_Q = X \times Y$. Suppose $I_P \neq X$ and $J_P \neq Y$ and take
$\alpha_0 \notin I_P$, $\beta_0 \notin J_P$. The column $\{\alpha_0\}
\times Y$ misses $Z_P$, so it lies in $Z_Q$ and $J_Q = Y$. The row $X
\times \{\beta_0\}$ gives $I_Q = X$. Then $Q$ vanishes identically. So
$I_P = X$ or $J_P = Y$, and not both. If $I_P = X$, every row $\beta
\notin J_P$ misses $Z_P$ and lies in $Z_Q$, so $I_Q = X$. $\square$

This is the one step of the reduction that is not linear. The sheet
theorem of the project's earlier work used the same fact for a single
function with values 0 and 1.

**Theorem 6 (stripes).** Let a frozen state have every hole oriented,
and suppose sublattice $S$ has vertices of type $k$ of both signs.
Then there is an axis $n \neq k$ such that every plane $\{x_n = c\}$ of
$S$ either has no vertex of type $k$, or has a vertex of type $k$ on
every one of its $k$-lines, all of one sign.

*Proof.* Let $P$ and $Q$ count the vertices of type $k$ of sign $+$ and
$-$ on each $k$-line of $S$. Then $P = (h + s)/2$ and $Q = (h - s)/2$
are separable by Theorem 5 and non-negative. No line carries both
signs, by Theorem 4, so $PQ = 0$. Neither vanishes identically. By
Lemma 4 both depend on one transverse coordinate, $x_n$, and on each
plane $x_n = c$ at most one of the two constants $P(c)$, $Q(c)$ is
positive. $\square$

# Walls

Call a plane $\{x_n = c\}$ of one sublattice **$k$-free**, for $n \neq
k$, if it has no vertex of type $k$. The planes $x_n = c$ alternate
between the sublattices as $c$ increases.

**Theorem 7 (walls).** Let an odd frozen state have every hole oriented
and let axis $k$ be two-way. Then there are an axis $n \neq k$ and a
$k$-free plane $F = \{x_n = c\}$ such that the vertices of type $k$ on
each of the two neighbouring planes $x_n = c \pm 1$ have one sign, the
two planes do not have the same sign, and at least one of them has a
vertex of type $k$.

*Proof.* Label every plane $x_n = c$ by the set of signs of its
vertices of type $k$.

Suppose first that some sublattice $S$ has both signs. Theorem 6 gives
the axis $n$, and every plane of $S$ is labelled $\emptyset$, $\{+\}$
or $\{-\}$, the last two being full in the sense of the theorem.
A vertex of type $k$ on a plane of $S'$ next to a full plane of $S$ of
sign $+$ lies on a line diagonally neighbouring a line of that plane,
so it has sign $+$ by Theorem 3. If $S'$ also has both signs it is
striped, and its stripes run along $n$, because a stripe of sign $-$
along the other transverse axis would meet the plane of $S'$ next to a
full plane of $S$ of sign $+$. So every plane of either sublattice has at most one
sign. Going round the torus in $x_n$, take a plane $c^*$ of sign $+$
such that the next plane with any vertex of type $k$, say $c^{**}$, has
sign $-$. If the two were adjacent, one of them would be a full plane
of $S$ and the other would have its sign. So they are not adjacent,
and $F = \{x_n = c^* + 1\}$ has the properties claimed.

Otherwise each sublattice has at most one sign, and since the axis is
two-way, A has sign $\sigma$ and B has sign $-\sigma$. By Theorem 3 no
line of A with a vertex of type $k$ is a diagonal neighbour of such a
line of B. The empty lines of A form a product $I \times J$ by Theorem
5, and it is not empty, since otherwise B would have no vertex of type
$k$. If $I$ and $J$ were both proper, A would have a full column and a
full row of lines, the two neighbouring columns and the two
neighbouring rows of B would be empty, and B would be empty
altogether. So the empty lines of A form complete planes, the others
form full planes, and the same holds for B, with the same normal $n$
because a full plane of A of one normal has lines neighbouring those
of a full plane of B of the other. Full planes of A and B are never
adjacent. Take a full plane $c^*$ of A whose next full plane is a plane
of B. Then $c^* + 1$ and $c^* + 2$ are $k$-free and $F = \{x_n = c^* +
1\}$ serves. $\square$

The second case has not been seen in any computed state and is
unsatisfiable on the cells of side three and four. It is kept because
the argument needs it.

**Lemma 5.** Let $F = \{x_n = c\}$ be as in Theorem 7. At every hole
$O$ of $F$, the two bridgeheads of $O$ on the plane $c + 1$ are both of
type $k$ or neither is, and the same holds for the two on the plane $c
- 1$.

*Proof.* The methylenes $O \pm 2e_k$ lie in $F$ and are not of type
$k$. Let $T_\pm = \sum s_k K(O + s)$ over the two bridgeheads with $s_n
= \pm 1$. Law $P^k$ gives $T_+ + T_- = 0$. If one of the neighbouring
planes is $k$-free its $T$ vanishes and so does the other. If not, the
two planes have signs $\sigma_+ = -\sigma_-$, the hole is oriented, and
Lemma 3 gives $\sigma_+ T_+ + \sigma_- T_- = 0$, so again both vanish.
The two bridgeheads with $s_n = +1$ have opposite $s_k$, so $T_+ = 0$
says that their indicators agree. $\square$

The statement of Lemma 5 for an arbitrary $k$-free plane was the
conjecture $(E')$ of the project's reports. In that generality it is
false, since a $k$-free plane with a hole whose upper bridgeheads
disagree exists in frozen states of even curl. At the walls of an odd
state it is a consequence of orientation.

# Uniform chains beside a wall

Two facts from the earlier work are needed. The first has a short
proof.

**Lemma 6 (grid counts).** In a frozen state the number of vertices of
type $j$ on the plane $\{x_j = t\}$ is the same for all planes of A and
the same for all planes of B.

*Proof.* Let $f(t)$ be that number. Add $P^j$ over the holes of the
plane $x_j = t$. Every vertex of the plane $t + 2$ is $O + 2e_j$ for
one hole $O$ of the plane $t$, and every vertex of the plane $t + 1$ is
a bridgehead, with $s_j = +1$, of two of them. So $f(t+2) - f(t-2) =
2\,(f(t+1) - f(t-1))$ for every $t$. With $g(t) = f(t+1) - f(t-1)$
this reads $g(t+1) + g(t-1) = 2g(t)$. A periodic sequence with
vanishing second difference is constant, and $\sum_t g(t) = 0$.
$\square$

**Theorem $M'$ (proved in the project's reports).** On a cubic cell
(and on every cell: see the subsection on cells that are not cubic), a
frozen state in which one sublattice has no vertex of type $k$ and the
other has one has even curl.

Its proof, by two discrete integrations on the transverse torus and
finite lemmas on four hexagons with DRAT certificates, is in the
report on the sheet theorem.

**Theorem 8.** Let an odd frozen state have all three types, let $F =
\{x_j = c\}$ be a $k$-free plane of A at whose holes the conclusion of
Lemma 5 holds for the plane $c + 1$, and suppose the plane $c + 1$ has
a vertex of type $k$. Then every vertex of type $k$ on the planes $c +
1$ and $c + 2$ lies on a uniform chain, a chain of axis $j$ all of type
$k$.

*Proof.* Write the coordinates in the order $(x_i, x_j, x_k)$. For a
hole $O$ of $F$ the two bridgeheads on the plane $c + 1$ are $O +
(1,1,-1)$ and $O + (-1,1,1)$, and every pair of vertices of that plane
differing by $(2,0,-2)$ arises so. Hence $K$ is constant on every
diagonal of the plane $c + 1$ in the direction $(1,0,-1)$.

Let $O'$ be a B-hole of the plane $c + 1$. Its bridgeheads on the plane
$c$ are not of type $k$, and those on the plane $c + 2$ are $g_1 = O' +
(1,1,1)$ and $g_2 = O' + (-1,1,-1)$, so $P^k$ at $O'$ reads $K(O' +
2e_k) - K(O' - 2e_k) = K(g_1) - K(g_2)$. A vertex $g$ of the plane $c +
2$ has two neighbours below it, $g + (1,-1,-1)$ and $g + (-1,-1,1)$,
which differ by $(2,0,-2)$ and so have a common value $\kappa(g)$ of
$K$. For $g_1$ these neighbours include $O' + 2e_k$ and for $g_2$ they
include $O' - 2e_k$. So $\Delta(g) = K(g) - \kappa(g)$ satisfies
$\Delta(g_1) = \Delta(g_2)$, and $\Delta$ is constant on every diagonal
of the plane $c + 2$ in the direction $(1,0,1)$.

If $\Delta = -1$ on such a diagonal, the vertices below it form a
diagonal of the plane $c + 1$ in the direction $(1,0,1)$, all of type
$k$. It meets every diagonal in the direction $(1,0,-1)$, so the whole
plane $c + 1$ is of type $k$ and has no vertex of type $j$. By Lemma 6
B has no vertex of type $j$, the state has one, and Theorem $M'$ gives
even curl. So $\Delta \geq 0$, and both neighbours above a vertex of
type $k$ of the plane $c + 1$ are of type $k$.

The plane $c + 1$ has a vertex of type $k$. Its diagonal in the
direction $(1,0,-1)$ is all of type $k$ and meets every diagonal of
that plane in the direction $(1,0,1)$. So each of those contains a
vertex $w'$ of type $k$, and the vertex $g = w' + (1,1,-1)$ above it
has $\kappa(g) = 1$, hence $K(g) = 1$ and $\Delta(g) = 0$. The map $w'
\mapsto w' + (1,1,-1)$ carries the diagonals of the plane $c + 1$ in
the direction $(1,0,1)$ onto those of the plane $c + 2$, so $\Delta =
0$ on the whole plane $c + 2$. A vertex of the plane $c + 2$ is of type $k$ exactly when its
two neighbours below are, and a vertex of the plane $c + 1$ exactly
when its two neighbours above are. Those neighbours are its neighbours
on the chain of axis $j$ through it in the slab of the two planes. So a
chain of that slab with one vertex of type $k$ is all of type $k$.
$\square$

By the inversion and the reflections of the lattice the theorem holds
with A and B exchanged and on the lower side of the plane.

# The diagonal law on the causal diamond

This section proves Theorem 3. Take $k = z$ and, by the symmetries,
$v$ an A vertex at the origin and $w$ at $(\delta_x, \delta_y, s)$
with $|\delta_x| = |\delta_y| = 1$ and $s$ odd and positive. For $s =
1$ the two are bonded and the bond rule gives the result. Suppose
$\varepsilon(v) = +1$ and $\varepsilon(w) = -1$. Then $v$ points into
the hole $h_v = v + 2e_z$ from below and $w$ points into $h_w = w -
2e_z$ from above.

Two holes joined by a hexagon differ by a vector $\tau \in \{\pm
1\}^3$. An upward path is a sequence of such steps with $\tau_z = +1$,
and the **causal diamond** $D$ is the set of holes lying on an upward
path from $h_v$ to $h_w$. It is an octahedron of holes with apices
$h_v$ and $h_w$, of transverse radius $(s-1)/2$ at its middle.

For an oriented hole write $\operatorname{in}(h)$ for the unit vector
from $h$ to the rod that points towards it.

**Lemma 7 (conservation).** If two oriented holes $O$ and $O + \tau$
are joined by a hexagon, then $\tau \cdot \operatorname{in}(O) = \tau
\cdot \operatorname{in}(O + \tau)$, and the same for the rods pointing
away.

*Proof.* The two cages have fourteen vertices and seven hexagons. Of
the $3^{14}$ assignments of types 6,192 satisfy (T2) on the seven, each
has a sign field unique up to reversal, and 5,136 have both holes
oriented. The relation holds in all of these. $\square$

When $s$ is 3 or 5 the holes $h_v$ and $h_w$ are joined by a hexagon,
and Lemma 7 contradicts the two rods. For larger
$s$ conservation along paths is not enough, and the proof is a single
linear identity over the diamond.

Introduce for every vertex $u$ and axis $k$ two variables $p_k(u),
m_k(u) \geq 0$, to be read as the indicators that $u$ has moment
$+e_k$ or $-e_k$, and let $n(u) = \sum_k (p_k(u) - m_k(u))e_k$. A
frozen state whose diamond is oriented satisfies the following linear
equations, each written with its right side subtracted.

- One-hot at $u$: $\sum_k (p_k(u) + m_k(u)) - 1 = 0$.
- (T2) at a hexagon: $\sum (p_k(u) + m_k(u)) - 2 = 0$, the sum over its
  six vertices $u$ with $k$ the axis the hexagon uses at $u$.
- The bond rule at a bond $(a, a + d)$, $a \in A$: $d \cdot n(a) - d
  \cdot n(a + d) = 0$.
- Orientation at a hole $h$ of $D$: $\sum_k \bigl(p_k(h + 2e_k) +
  m_k(h - 2e_k)\bigr) - 1 = 0$.
- The hypotheses: $p_z(v) - 1 = 0$ and $m_z(w) - 1 = 0$.

For a vertex $u$ let $\mu(u)$ be the number of holes of $D$ of which
$u$ is a bridgehead, and for a bond let $\nu$ be the number of the six
hexagons through it that have both their holes in $D$.

**Theorem 9 (the certificate).** For every odd $s \geq 5$, the sum of
the orientation equations of the holes of $D$, minus half the (T2)
equations of the hexagons with at least one hole in $D$, plus
$\tfrac12 \min(2, \mu(u))$ times the one-hot equation of every vertex,
plus $\tfrac14 \min(4, \nu)$ times the bond equation of every bond,
plus the two hypotheses, is identically
$$-1 - \sum_j r_j x_j$$
in the variables $x_j$, with every $r_j \geq 0$.

The left side vanishes on a state satisfying the equations and the
right side is at most $-1$, so no such state exists, which is Theorem 3
for $s \geq 5$. The identity is a finite identity on the infinite
lattice. A state on a torus lifts to a periodic state of the lattice
that satisfies every lifted equation, so the theorem holds on every
torus, whether or not the diamond wraps round it. Negative separations
and the other sublattice order follow by the symmetries of the lattice,
which permute the variables and preserve the system of equations.

Exactly four of the coefficients $r_j$ are non-zero, each equal to 1.
They belong to the variables that say that the hole of $D$ extreme in
the direction $+x$, $-x$, $+y$ or $-y$ has its inward rod on that axis
on the outer side. Without the two hypotheses the identity is therefore
a statement about the six corners of the octahedron.

**Corollary (the corner law).** In a frozen state with $D$ oriented,
exactly one of the six corner holes of $D$ has its inward rod on its
own axis, on the side away from $D$.

Theorem 3 says that the two apices cannot both be such corners. The
same certificate, with $w$ on the line of $v$, is valid and gives the
line law directly.

*Proof of Theorem 9.* A vertex $u$ lies in the cages of ten holes. Six
are the holes $u \pm 2e_k$ of which it is a methylene and four are the
holes $u + \sigma$ of which it is a bridgehead. The hole $u + 2se_k$ is
joined by a hexagon to $u + \sigma$ exactly when $\sigma_k = s$, so the
ten holes are the four vertices and six edges of a tetrahedron $T(u)$,
and the twelve hexagons through $u$ are its twelve incidences. Every
equation in which a variable of $u$ occurs has a multiplier determined
by which holes of $T(u)$ lie in $D$. So the coefficient of each
variable of $u$ in the combination is a function of the set $D \cap
T(u)$.

In the coordinates $t = z$, $a = x + y$ and $b = x - y$ the diamond is
cut out by eight inequalities, four for the future of $h_v$ and four
for the past of $h_w$. Each of them cuts $T(u)$ in the whole of it, or
nothing, or a vertex with its three edges, or the opposite face. The
intersections of such sets number fifty, in nine classes under the
symmetries of the tetrahedron, and the coefficients can be computed
for each. They are zero in seven classes. In the class of a single
edge, a hole $h = u - 2d$ alone, the coefficient is 1 on the variable
saying that $u$ is the inward rod of $h$ and zero elsewhere. In the
class of two faces, where $u$ is a bridgehead of exactly two holes of
$D$, a coefficient of the wrong sign occurs.

That class does not arise. If $u$ were a bridgehead of exactly two
holes of $D$, then, because the future of $h_v$ is closed upwards and
the past of $h_w$ downwards, either both lower bridge holes of $u$ are
in $D$ and neither upper one, or the reverse, or one of each. In each
case the inequalities, written in the coordinates $a$ and $b$
separately, would require the numbers of steps available in the two
coordinates to differ by more than one, which they never do, or by an
amount that is possible only when the transverse offset of $w$ is at
least two. The case
analysis is given in full in the report of the agent that found it and
was derived again by the checker. At any transverse offset of two or
more the class does arise, from the first admissible separation, and
the linear programme is then feasible.

The variable $p_z(u)$ has a non-zero coefficient only when $u + 2e_z$
is a hole of $D$ with no hole of $D$ below it, which is $h_v$, and the
hypothesis on $v$ cancels it. To find the constant, evaluate the
identity at the state in which every vertex has moment $+e_z$. It
satisfies every equation except $m_z(w) = 1$, where the left side is
$-1$, and the variables $p_z$ have coefficient zero. $\square$

The finite parts of this proof are the cut structure of the
tetrahedron, the table of fifty intersections, and the agreement of the
local coefficients with those of the whole combination. Each was
computed by two independent implementations. The identity itself was
verified in exact rational arithmetic for every odd $s$ from 5 to 101,
for every admissible transverse offset and both sublattice orders, and
on the line for every gap up to ten.

Orientation is used at every hole of the diamond. Removing the
orientation equation of any one hole makes the system feasible, and
orientation of the corner holes alone, which Lemma 2 provides without
any conjecture, does not suffice. So the diagonal law as proved here
depends on Theorem U.

# Proof of Theorem 1

The proof uses Theorem 15 of the section on cells with a coprime pair
of extents, which holds on every cell: on each sublattice the fractions
of the three types on the three lines through a vertex are differences
of three profiles of one coordinate. It was found on 30 September 2026
by combining that law with Theorem 6 across the three axes at once. The
earlier proof, which needed $K_u$, follows it.

For an axis $k$ and a sublattice $S$, the $k$-lines of $S$ are indexed
by their two transverse coordinates $(\alpha, \beta)$, each of the
parity of $S$, and every such pair is a line. Write $h^S_k(\alpha,
\beta)$ for the number of vertices of type $k$ on the line, as in
Theorem 5. A plane $\{x_n = c\}$ of $S$, with $n \neq k$, is $k$-free
if no line in it has a vertex of type $k$, and full if every line in
it has one.

**Lemma 22.** Let a frozen state have every hole oriented and let axis
$k$ be two-way on $S$. Then there is an axis $n \neq k$ such that
$h^S_k$ is a function of $x_n$ alone; every plane $\{x_n = c\}$ of $S$
is $k$-free or full, its lines all carry the same number of vertices
of type $k$, and those vertices have one sign.

*Proof.* This is the proof of Theorem 6 read once more. The counts $P
= (h + s)/2$ and $Q = (h - s)/2$ of the two signs are separable by
Theorem 5, non-negative, with $PQ = 0$ by Theorem 4, and neither is
identically zero because both signs occur on $S$. Lemma 4 makes both
functions of one coordinate $x_n$, so $h = P + Q$ is one too, and on
each plane at most one of $P(c)$, $Q(c)$ is positive. $\square$

**Lemma 23 (the two sublattices share the normal).** Let a frozen
state have every hole oriented, let axis $k$ be two-way, and let both
sublattices carry type $k$. Then there is one axis $n \neq k$ such
that $h^A_k$ and $h^B_k$ are both functions of $x_n$ alone, every plane
$\{x_n = c\}$ of either sublattice is $k$-free or full with one sign,
and two adjacent non-empty planes, one of each sublattice, have the
same sign.

*Proof.* Three cases, which exhaust the ways in which a two-way axis
can be carried by two sublattices.

*Both sublattices two-way.* Lemma 22 gives normals $n$ for A and $m$
for B. Suppose $m \neq n$, so that $\{n, m\}$ are the two transverse
axes. A has a full plane $x_n = c$ of sign $+$ and B a full plane $x_m
= d$ of sign $-$. The B-line at $(x_n, x_m) = (c + 1, d)$ exists,
carries a vertex of type $k$ of sign $-$, and is a diagonal neighbour
of the A-lines $(c, d \pm 1)$, which carry vertices of type $k$ of sign
$+$. Theorem 3 is contradicted, so $m = n$. If the B-plane $c + 1$ is
not empty, each of its lines is a diagonal neighbour of lines of the
A-plane $c$, and Theorem 3 gives it the sign of that plane.

*A two-way, B of one sign $\sigma$.* Lemma 22 gives $n$ for A, and A
has a plane $x_n = c$ of sign $-\sigma$. Every B-line at $x_n = c \pm
1$ is a diagonal neighbour of lines of that plane, so by Theorem 3 it
has no vertex of type $k$. By Theorem 5 the empty lines of B form a
product $I \times J$, which contains $\{c - 1, c + 1\} \times Y_B$, so
$J = Y_B$; then $F(c + 1) + G(\beta) = 0$ for every $\beta$ makes $G$
constant, and $h^B_k$ is a function of $x_n$ whose non-empty planes
are full. The case with A and B exchanged is the same.

*A of one sign $\sigma$, B of one sign $-\sigma$.* This is the second
case of the proof of Theorem 7, which uses Theorems 3 and 5 and not
oddness: the empty lines of A form complete planes normal to an axis
$n$, the same holds for B with the same $n$, and full planes of A and
B are never adjacent. With the empty set of the form $X_A \times J$
the separable $h^A_k$ has its first summand constant and is a function
of $x_n$, and likewise $h^B_k$. $\square$

**Lemma 24 (the killed profile).** Let $P(x)$, $Q(y)$ and $R(z)$ be the
profiles of Theorem 15 on $S$, so that $h_y/\ell_y = P - R$, $h_z/\ell_z
= Q - P$ and $h_x/\ell_x = 1 + R - Q$. If $h^S_k$ is a function of
$x_n$ alone, $n \neq k$, then the profile of the third coordinate,
$i(k) \notin \{k, n\}$, is constant on $S$.

*Proof.* Take $k = x$, so that $h_x/\ell_x = 1 + R(z) - Q(y)$ on all
pairs $(y, z)$ of the parity of $S$, and every pair occurs. If this
does not depend on $z$ then $R$ is constant, and if not on $y$ then $Q$
is. The other two axes are the same. $\square$

**Lemma 25 (full lines carry one sign).** Let a frozen state have every
hole oriented. If every $k$-line of both sublattices has a vertex of
type $k$, then axis $k$ is one-way.

*Proof.* Join two $k$-lines when they are diagonal neighbours. The
lines of both sublattices are the pairs $(\alpha, \beta)$ with $\alpha
+ \beta$ even, and the steps $(\pm 1, \pm 1)$ generate that set, so the
graph is connected on every torus. Along an edge Theorem 3 gives equal
signs to the vertices of type $k$ on the two lines, and every line has
one. $\square$

*Proof of Theorem 1.* Let the state be frozen and odd and assume
Theorem U, so that every hole is oriented. If some type is absent its
axis is empty. Otherwise all three types occur, and by Theorem $M'$
both sublattices carry all three, since a sublattice lacking a type
that the other has would make the curl even. Suppose every axis is
two-way. Lemma 23 gives each axis $k$ a normal $n(k) \neq k$, the same
for A and B, and by Lemma 24 the profile of the third coordinate $i(k)
\notin \{k, n(k)\}$ is constant on each sublattice. Now $i(x) \in \{y,
z\}$, $i(y) \in \{x, z\}$ and $i(z) \in \{x, y\}$, so the three values
$i(x), i(y), i(z)$ are not all equal. If they are all different, every
profile is constant and so is every count $h_k$. If they take two
values $a$ and $b$, the profiles of $a$ and $b$ are constant, and the
count $h_c$ of the third axis $c$ is $\ell_c$ times a difference of
those two profiles plus a constant, so it is constant on each
sublattice. In either case some axis $c$ has $h^A_c$ and $h^B_c$
constant, and the constants are at least 1 because both sublattices
carry type $c$. So every $c$-line of both sublattices has a vertex of
type $c$, and by Lemma 25 axis $c$ is one-way, which contradicts the
supposition. Some axis is therefore not two-way, and since it is not
empty it is one-way. $\square$

Theorem U enters through Theorems 3 and 4 and through the second
statement of Theorem 5, for the two-way axes only. Oddness enters
through Theorem U and through Theorem $M'$. Neither $K_u$, the wall of
Theorem 7, Theorem 8 nor Theorem 19 is used; the third case of Lemma
23 repeats the argument of the second case of Theorem 7. On a cell
with an extent of one the methylenes $O \pm 2e_k$ of a hole coincide;
such a cell is covered by Lemma 21, since a periodic repetition
preserves frozenness, oddness, the moments, the types carried by each
sublattice, which axes are two-way and the charge of every hole, the
charge being counted over the six methylene positions. Theorem $M'$ is
used with the standing the first section gives it on cells that are
not cubic and at extent two.

The argument makes one prediction that can be tested on odd states
whose axes are not all two-way. If the state has all three types, a
one-way axis $c$ and two two-way axes $a$ and $b$, Lemmas 24 and 25
forbid the normals of $a$ and $b$ from making $a$ or $b$ the axis of
constant count, so $n(a) = b$ and $n(b) = a$. In the 429 states of the
corpus of the cubic cells of side three and four with this pattern the
two two-way axes are each other's normals in every one, and the
constant profile is the one the argument names.

## The earlier proof, through $K_u$

Let the state be frozen and odd, on a cell on which $K_u$ holds for
uniform chains of all three axes, and assume Theorem U, so that every
hole is oriented. If an axis is
empty or one-way there is nothing to prove. Otherwise all three types
occur and every axis is two-way. Take any axis $k$. Theorems 3 and 4
hold at every separation, so Theorem 7 gives a wall $F$ with a
neighbouring plane that has a vertex of type $k$, Lemma 5 gives the
hypothesis of Theorem 8 at $F$ on that side, and Theorem 8 gives a
uniform chain. By $K_u$ a direction is absent, which contradicts the
assumption that every axis is two-way. $\square$

Oddness enters twice, through Theorem U and in Theorem 8, where
Theorem $M'$ excludes a complete plane of one type. The signs of the
moments enter through Lemma 3 and the bond rule. The
argument names one axis and one wall, and it does not use the trails of
odd hexagons, the run laws or the statements on three planes that the
project's earlier reports pursued. The wall's normal is produced by
Theorem 6 and cannot be chosen, which is why $K_u$ is needed for
chains of every axis. This proof was written on 27 September 2026,
before Theorem 15 was found, and the two results it combines with
$K_u$, Theorems 6 and 15, were not put together across the three axes
until 30 September.

# Theorem H on the cubic cells of side four to eight, and on four cells that are not cubic

Theorem U follows from a statement about four vertices. By the
enumeration after Lemma 3 an unoriented hole has both rods of type $k$,
a bridgehead of type $a$ on one side and a bridgehead of type $b$ on
the other, where $a$ and $b$ are the other two axes.

**Theorem $U'$ (certified for the cubic cells $L = 4$ to 8 and for
$(3,3,9)$, $(4,4,8)$, $(3,3,12)$ and $(6,6,9)$).** A state of the type
model, that is, an assignment of types satisfying (T2), that has a hole
with both rods of type $k$, one bridgehead of type $a$ on its lower
side and one of type $b$ on its upper side, has even curl on every
hexagon.

The type model has no signs and is weaker than the ice rule, so the
theorem proves more than Theorem U needs. Its negation was written as
a formula in conjunctive normal form for each position of the two
bridgeheads, each order of the two types and each sublattice, refuted
by CaDiCaL with a DRAT proof, and the proof checked by drat-trim.

| statement | $L$ | formulas | longest solve | proof size | drat-trim |
|---|---|---|---|---|---|
| Theorem $U'$ | 4 | 16 | 2.4 s | 36 to 45 MB | all verified |
| Theorem $U'$ | 5 | 16 | 9.5 s | 114 to 147 MB | all verified |
| Theorem $U'$ | 6 | 4 | 22 s | 315 to 385 MB | all verified |
| diagonal law | 4, 5, 6 | 16, 20, 24 | 6.6 s | up to 12 MB | all verified |
| line law | 4, 5, 6 | 4, 6, 8 | 3.8 s | up to 7 MB | all verified |

At side six the four formulas are one for each sublattice and order,
and the sixteen hypotheses were checked to form one orbit of the
symmetries of the formula. The diagonal and line laws were certified
directly on these cells, in the model with signs and without any
hypothesis of oddness, before Theorem 9 was found. They are recorded
because they do not depend on it. Every formula has a control, the same
formula without the negated conclusion, which is satisfiable, and the
witness was decoded and checked against the definitions. The encoding
was tested on 1,357 odd frozen states found earlier, each of which
satisfies the hypothesis part of every formula wherever the pattern
occurs.

On 1 October 2026 the same statement was run on the cheapest cells on
which Theorem U was open, as a search for a counterexample: a
satisfiable formula would have been an odd state of the type model
with an unoriented hole, to be lifted to the bond model and tested
against Theorem H. The encoding was generalised to any cell (on the
cubic cells of side four and five its clauses are identical to the
earlier encoding's), and tested on odd corpus states repeated onto
$(3,3,9)$ and $(4,4,8)$, which satisfy its hypothesis part and in
which the full pattern of $U'$ occurs nowhere. A query is a rod axis,
a sublattice, an order of the two other types and a position of each
bridgehead, sixteen per axis; on a cubic cell the cyclic permutation
of the axes is a symmetry of the formula (checked as a clause-set
automorphism at sides seven and eight) and the sixteen hypotheses on
one axis form one orbit, as at side six; on a cell that is not cubic
the transposition of the two unequal axes is not a symmetry, and the
forty-eight hypotheses fall into three orbits (the two bridgehead
diagonals on the short axes, and the long axis), so all forty-eight
were run. Every query was unsatisfiable, with a satisfiable control
whose witness was decoded and checked. Certificates were then written
for every query on the three small cells, for one query per orbit on
$(6,6,9)$, and for one per sublattice and order at sides seven and
eight.

| cell | queries run | formulas certified | longest solve | proof size | drat-trim |
|---|---|---|---|---|---|
| $(3,3,9)$ | 48 | 48 | 2.7 s | 17 to 35 MB | all verified |
| $(3,3,12)$ | 48 | 48 | 4.4 s | 18 to 50 MB | all verified |
| $(4,4,8)$ | 48 | 48 | 8.7 s | 73 to 151 MB | all verified |
| $(6,6,9)$ | 48 | 3 | 35 s | 753 to 900 MB | all verified |
| $(7,7,7)$ | 16 | 4 | 48 s | 0.9 to 1.3 GB | all verified |
| $(8,8,8)$ | 16 | 4 | 124 s | 2.0 to 2.9 GB | all verified |

Two hundred and twenty-four queries, none satisfiable, none timed out;
about 106 minutes of solving and checking in all. The search found no
near miss: every control is satisfiable in under half a second and
every query is refuted in at most about two minutes, and the solving
time on the cubic cells grows smoothly with the side, 2.4, 9.5, 22, 48
and 124 seconds from side four to side eight. By Lemma 21 the
certificates also give Theorem H on every cell whose extents divide
one of these six, up to a permutation of the axes, among them
$(3,6,9)$, $(4,8,8)$ and $(2,8,8)$.

Theorem 2 follows from Theorem 1 and these certificates of Theorem
$U'$ alone. The first form of Theorem 1 needed $K_u$ on these three
cells as well, and, as the first section says, $K_u$ on a cubic cell
needs its first step on the whole slab, which the certificates of 11
September did not provide. It was provided by the following
certificates, which are kept as certified facts about $K_u$ and are
no longer steps of the proof of Theorem 2: on the whole torus, with the
ice rule at every vertex and (T2) on every hexagon, a uniform chain
and a chain of the second family in a neighbouring slab with a vertex
of the other sense are contradictory.

| statement | $L$ | formulas | longest solve | proof size | drat-trim |
|---|---|---|---|---|---|
| first step of $K_u$, whole slab | 4 | 2 | 0.2 s | 0.3 to 0.5 MB | verified |
| | 5 | 2 | 1.1 s | 4 MB | verified |
| | 6 | 2 | 6.9 s | 26 to 27 MB | verified |
| | 7 | 2 | 32 s | 122 to 125 MB | verified |
| | 8 | 2 | 164 s | 704 to 734 MB | verified |

The two formulas are for the slab above the chain and the slab below
it, each with a satisfiable control. They are written for one uniform
chain, and the others follow by the symmetries of the cubic cell. The
cubic cells of side one, two and three follow from Theorem 2 by
Theorem 24.

One fact about the first step of $K_u$ was found on 30 September 2026
and is recorded although the step is no longer needed. The step is not
a window lemma of bounded radius even when the hypotheses that the
earlier proof of Theorem 1 has at the point of use are added (a
$k$-free wall, one sign on the planes beside it, orientation, oddness,
the uniform chains of Theorem 8): every window that does not contain
the uniform chain is satisfiable. When the chain is in the window and
every hole is oriented, the statement is local in a cone: a vertex of
a column of a neighbouring slab at transverse distance $d$ from the
chain is forced to the sense of the chain by a window of transverse
radius $d$ about it and about $d$ grids of extent along the axis of the
chain on each side, and by nothing smaller (solver, five cells, 572
windows per extent, to $d = 7$). Orientation does the work; the wall
adds nothing. This is the shape of Theorem 3 on the causal diamond,
and the closed-form certificate exists: the first step of $K_u$ at a
vertex $t$ of a neighbouring column at transverse distance $d \geq 2$
from the chain, given orientation, is the sum of two identities of
Theorem 9 on two causal diamonds of separation $2d - 1$ along the axis
of the chain's moment, whose lower apices are the holes above two
vertices of the chain. The first diamond ends at the hole below $t$,
so $t$ cannot carry the moment opposite to the chain's (Theorem 3).
The second ends at a hole whose corner extreme in the third direction
is the single hole beside $t$, and its lower apex is already the one
corner that the corner law allows, so $t$ cannot carry the moment of
the third axis either. The distances 0 and 1 follow from the bond rule.
So, given Theorem U, the first step of $K_u$ holds by hand on every
cell, with no dependence on the side, and with the later steps, which
hold on every cell, $K_u$ given U is a theorem on every cell (found by
one agent on 30 September 2026 and checked exactly on the infinite
lattice for $d = 2$ to 30; confirmed on 1 October by an independent
checker with its own code, which proved the three geometric facts for
every $d$, among them that the extreme corner is unique, found the
multipliers identical row for row, and wrote the hand lemma; no human
reader). It is recorded as a fact about $K_u$, since Theorem 1 does not
use it.

# Cells with a coprime pair of extents

This section proves Theorem H, with
no conjecture, on every cell $(a, b, c)$ in which two of the three
extents are coprime. The proof does not pass through Theorem U or
$K_u$. It rests on a statement about the types of one sublattice, which
holds in every solution of the type model and so needs neither the
signs nor a hexagon of odd curl. The cubic cells are not covered, and
the last subsection but one says what is different on them.

## The parametrisation

The type model on the cell $(a, b, c)$ is an assignment of types that
satisfies (T2) on every hexagon, with coordinates modulo $(4a, 4b,
4c)$. Write $X$, $Y$ and $Z$ for the indicators of the three types.
The project's working note proves, for every cell, that every real
solution of the one-hot equations and of (T2) has the form
$$Y(v) = F_x(v) - F_z(v) + \sigma_v \alpha, \qquad Z(v) = F_y(v) -
F_x(v) + \sigma_v \beta, \tag{C}$$
where a real weight is attached to every chain, $F_k(v)$ is the sum of
the weights of the two chains of axis $k$ through $v$, $\sigma_v = \pm
1$ on A and B, and $\alpha$ and $\beta$ are constants. The chains of
axis $x$ have steps $(0, 2, 2)$ and $(0, 2, -2)$, those of axis $y$
have $(2, 0, 2)$ and $(2, 0, -2)$, and those of axis $z$ have $(2, 2,
0)$ and $(2, -2, 0)$. A chain of axis $x$ lies in two neighbouring
planes $x = $ const and closes after $2bc/\gcd(b, c)$ steps, so each
such pair of planes holds $\gcd(b, c)$ chains of its family. When
$\gcd(b, c) = 1$ it holds one, and $F_x(v) = \Phi(x_v)$ is a function
of the plane of $v$.

On a plane $z = z_0$ of a sublattice $S$ the vertices are $v_0 + m(2,
2, 0) + n(2, -2, 0)$. The chain of axis $z$ through such a vertex with
step $(2, 2, 0)$ is labelled by $n$ and the one with step $(2, -2, 0)$
by $m$, so on this plane
$$F_z = P(n) + Q(m), \qquad x = x_0 + 2(m + n),$$
with $P$ and $Q$ of period $g_z = \gcd(a, b)$. The translations of the
plane act transitively on its vertices, the step $(2, 2, 0)$ fixes the
class of $n$ and moves that of $m$ by one, and the other step does the
reverse. Every pair of classes therefore occurs at a vertex of the
plane. The same holds on a plane $y = y_0$, with period $g_y = \gcd(a,
c)$, and on a plane $x = x_0$.

## Three lemmas on sums of functions

**Lemma 8.** Let $\varepsilon(i, j) = \alpha(i) + \beta(j)$ take the
values 0 and 1 on a product $I \times J$. Then $\alpha$ or $\beta$ is
constant.

*Proof.* If $\alpha(i_1) \neq \alpha(i_2)$, the two differ by $\pm 1$,
and for every $j$ the values $\varepsilon(i_1, j)$ and
$\varepsilon(i_2, j)$ are 0 and 1 in an order that does not depend on
$j$. That determines $\beta(j)$. $\square$

**Lemma 9.** Let $\varepsilon(m, n) = \gamma(m + n) + \alpha(n) +
\beta(m)$ take the values 0 and 1 on $\mathbb{Z}^2$, with $\alpha$,
$\beta$ and $\gamma$ real and periodic, and suppose that the jumps
$\gamma(k+1) - \gamma(k)$ are integers. Then either $\gamma$ is
constant and $\varepsilon$ is a function of $m$ alone or of $n$ alone,
or $\alpha$ and $\beta$ are constant and $\varepsilon$ is a function of
$m + n$.

*Proof.* Let $p$, $q$ and $c$ be the jumps of $\alpha$, $\beta$ and
$\gamma$. Since $\varepsilon(m+1, n) - \varepsilon(m, n) = q(m) + c(m
+ n)$, the function $q$ takes integer values, and so does $p$. Also
$\varepsilon(m, n+1) - \varepsilon(m+1, n) = p(n) - q(m)$ lies in
$\{-1, 0, 1\}$. The jumps of a periodic function add to zero over a
period. If $p$ is not zero it therefore has a value at least 1 and a
value at most $-1$, and then $0 \leq q(m) \leq 0$ for every $m$. So
$\alpha$ or $\beta$ is constant. If $\beta$ is constant, $\varepsilon$
is the sum of a function of $k = m + n$ and a function of $n$, and the
pair $(k, n)$ runs over $\mathbb{Z}^2$, so Lemma 8 makes $\gamma$ or
$\alpha$ constant. $\square$

The hypothesis on the jumps cannot be dropped. On $\mathbb{Z}_3 \times
\mathbb{Z}_3$ take $\alpha = \beta = (\tfrac23, \tfrac13, 0)$ and
$\gamma = (-\tfrac13, 0, -\tfrac23)$. The sum $\alpha(i) + \beta(j) +
\gamma(i + j)$ is 1 at the three points $(0,0)$, $(0,1)$ and $(1,0)$
and 0 at the other six, and it is a function of none of $i$, $j$ and
$i + j$. On $\mathbb{Z}_2 \times \mathbb{Z}_2$ every function with
values 0 and 1 has this form. The project's report of 18 September
2026 stated the lemma without the hypothesis, and the proof of Theorem
R1 used it in that form. The next lemma supplies the hypothesis where
Theorem R1 and this section need it, so Theorem R1 stands.

**Lemma 10.** Let $\gcd(b, c) = 1$, let $S$ be a sublattice, and let
$\Phi_S$ be the restriction of $\Phi$ to the planes $x = $ const of
$S$. In a solution of the type model the jumps $\Phi_S(x + 2) -
\Phi_S(x)$ are integers.

*Proof.* On a plane $z = z_0$ of $S$, (C) gives $Y = \gamma(m + n) -
P(n) - Q(m)$ up to a constant, with $\gamma(k) = \Phi_S(x_0 + 2k)$.
Let $c$ and $q$ be the jumps of $\gamma$ and of $Q$, so that $c(m + n)
- q(m)$ lies in $\{-1, 0, 1\}$ for all $m$ and $n$. Suppose some value
of $c$ is not an integer, and let $\theta$, with $0 < \theta < 1$, be
its fractional part. Every value of $q$ is then congruent to $\theta$
modulo 1, and so is every value of $c$. Each of the two functions has
sum zero over a period and no value zero, so each has a value at least
$\theta$ and a value at most $\theta - 1$. Since $\max c - \min q \leq
1$ and $\min c - \max q \geq -1$, both take the values $\theta - 1$ and
$\theta$ and no others. If $j$ of the $g_z$ values of $q$ in a period
equal $\theta$, then $j\theta + (g_z - j)(\theta - 1) = 0$, so $g_z
\theta$ is an integer. On a plane $y = y_0$ of $S$ the same argument,
applied to $Z$, shows that $g_y \theta$ is an integer. The greatest
common divisor of $g_y$ and $g_z$ is $\gcd(a, b, c)$, which is 1, so
$\theta$ is an integer. $\square$

## The theorem on one sublattice

**Theorem 12.** Let $\gcd(b, c) = 1$. In every solution of the type
model on the cell $(a, b, c)$, and in particular in every frozen state,
each sublattice $S$ satisfies one of the following.

1. $S$ has no vertex of type $x$, and every plane $x = $ const of $S$
   is entirely of type $y$ or entirely of type $z$.
2. $S$ has no vertex of type $y$.
3. $S$ has no vertex of type $z$.

So no sublattice carries all three types. By the permutations of the
axes the same holds on every cell in which some pair of extents is
coprime.

*Proof.* Absorb the constants of (C) on $S$ into the heights, so that
on $S$ we have $Y = \Phi_S(x) - F_z$ and $Z = F_y - \Phi_S(x)$.

Suppose first that $\Phi_S$ is not constant. On a plane $z = z_0$ of
$S$, Lemma 9 applies to $Y$, by Lemma 10, and its function $\gamma$ is
not constant, so $P$ and $Q$ are constant on that plane. Hence $Y(v) =
\Phi_S(x_v) - \kappa(z_v)$ on $S$. Every pair $(x, z)$ of coordinates
of the parity of $S$ belongs to a vertex of $S$, so Lemma 8 applies,
and $\kappa$ is constant. In the same way $Z(v) = \kappa' -
\Phi_S(x_v)$ with $\kappa'$ constant. The two values of $\Phi_S$ are
$\kappa$ and $\kappa + 1$ by the first formula and $\kappa' - 1$ and
$\kappa'$ by the second. So $\kappa' = \kappa + 1$ and $Y + Z = 1$ on
$S$, which is the first case.

Suppose now that $\Phi_S$ is constant. On a plane $z = z_0$ of $S$ the
indicator $Y$ is a constant minus $P(n) + Q(m)$, and by Lemma 8 it is a
function of $n$ alone or of $m$ alone. Every vertex $u$ of type $y$ of
$S$ therefore lies on a line $\{u + t(2, 2\epsilon, 0)\}$, $\epsilon =
\pm 1$, all of whose vertices are of type $y$. In the same way every
vertex $r$ of type $z$ of $S$ lies on a line $\{r + s(2, 0,
2\epsilon')\}$ all of type $z$. Two such lines have a common vertex.
Write $u - r = (d_x, d_y, d_z)$, whose entries are even and add to a
multiple of 4. A common vertex needs $t \equiv -\epsilon d_y/2$ modulo
$2b$, $s \equiv \epsilon' d_z/2$ modulo $2c$, and $t - s \equiv
-d_x/2$ modulo $2a$. The first two fix $t - s$ up to multiples of
$2\gcd(b, c) = 2$, and its parity is that of $(d_x + d_y + d_z)/2$,
which is even. So $t - s$ can be given the value required. A common
vertex would have two types, so $S$ lacks type $y$ or type $z$.
$\square$

The hypothesis $\gcd(b, c) = 1$ is used to have one chain of axis $x$
in each pair of planes. The last step of Lemma 10 and the meeting of
the two lines need only $\gcd(a, b, c) = 1$.

**Theorem 13.** Let $\gcd(a, b) = \gcd(a, c) = 1$. In every solution of
the type model each sublattice $S$ has one of three forms.

1. $S$ has types $x$ and $y$ only, and its vertices of type $x$ are
   those on a set of planes $z = $ const.
2. $S$ has types $x$ and $z$ only, and its vertices of type $x$ are
   those on a set of planes $y = $ const.
3. $S$ has no vertex of type $x$, and on each plane $x = $ const of $S$
   the type is constant along the chains of axis $x$ of one of the two
   families.

*Proof.* Now $F_y$ is a function of $y$ and $F_z$ a function of $z$.
By (C), $X = 1 + F_z - F_y$ up to a constant on $S$, a sum of a
function of $z$ and a function of $y$ on the set of all pairs $(y, z)$
of the parity of $S$. By Lemma 8 it is a function of $z$ alone or of
$y$ alone. Suppose it is a function of $z$ alone and is not zero. Then
$F_y$ is constant on $S$, some plane $z = z_1$ of $S$ is all of type
$x$, and $Z = F_y - F_x + \sigma\beta$ is, on each plane $x = x_0$ of
$S$, a sum of a function of the chain of one family and a function of
the chain of the other. By Lemma 8 it is constant along the chains of
one family. The line $z = z_1$ of that plane has its vertices 4 apart
in $y$, and the chains of each family are the classes of $y - z$ or of
$y + z$ modulo $4\gcd(b, c)$, which divides $4b$, so the line meets
every chain of both families. On the line $Z = 0$. Hence $Z = 0$ on the
plane and on $S$, which is the first form. The second form arises in
the same way, and when $X = 0$ on $S$ the same use of Lemma 8 gives the
third. $\square$

## Theorem H

**Theorem 14.** On a cell in which some pair of extents is coprime,
every odd frozen state lacks one of the three types. Theorem H
therefore holds on the cell. If $\gcd(a, b) = \gcd(a, c) = 1$ the type
that is absent is $x$.

*Proof.* By Lemma 1 an odd state has a corner $O$. Its two rods are
methylenes of $O$, so they are vertices of the sublattice $S$ of $O$,
and they have two different types $j$ and $k$. By Theorem 12, $S$ has
no vertex of the third type $i$. If the other sublattice had one,
Theorem $M'$ would give even curl. So no vertex has type $i$, and the
axis $i$ is empty.

Let $\gcd(a, b) = \gcd(a, c) = 1$. A corner of $S$ cannot have a rod of
type $x$. In the first form of Theorem 13 the rod of type $x$ and the
other rod, which is of type $y$ and lies on the line through the hole
along $y$, have the same coordinate $z$, and the plane of that
coordinate is all of type $x$. The second form is excluded in the same
way. So the rods of a corner have types $y$ and $z$, and its
sublattice has the third form. This gives a second proof of the
theorem on these cells, which does not use Theorem $M'$. Let $(O,
\sigma)$ be the odd hexagon at the corner $O$, and $O' = O + \sigma$,
a hole of the other sublattice $S'$. By (T2) none of the vertices $b_k
= O' - 2\sigma_k e_k$ has type $k$. If $S'$ had the first form, $b_y$
would be of type $x$, the plane $z = z_{O'}$ of $S'$ would be all of
type $x$, and $b_x$, which lies in that plane, would be of type $x$.
The second form is excluded by $b_z$ and $b_x$. So $S'$ has the third
form and no vertex has type $x$. $\square$

With Lemma A and Theorem P, every frozen zero-flux state of a cell with
a coprime pair of extents, all of them at least two, is invariant under
a nonzero translation. The cells $(L, L, L+1)$ are of this kind for
every $L \geq 2$, with two coprime pairs. The thin cells $(1, b, c)$
have a coprime pair and are excluded for the reason given in the first
section: on them the conclusion fails.

Theorem U holds on these cells as well. The unoriented cage has
bridgeheads of two types on one sublattice, which by Theorem 12 has no
vertex of the type of the rods, and Theorem $M'$ gives even curl.
Theorem 10 below is the case in which the coprime pair is transverse to
the rods. Theorem 11 is not contained in this section, since it holds
on cells such as $(15, 6, 10)$ that have no coprime pair.

The first proof of Theorem 14 uses $K_u$ nowhere and Theorem U
nowhere. It does use Theorem $M'$, whose proof rests on lemmas about
four hexagons with DRAT certificates. Those lemmas are statements
about finitely many vertices of the lattice and hold on every torus.
The second proof uses no certificate.

## The fractions of a type on the three lines through a vertex

Theorem 5 has a sharper form, which holds on every cell. For a vertex
$v$ let $h_k(v)$ be the number of vertices of type $k$ on the line
$\{v + 4n e_k\}$ and $\ell_k$ the number of vertices of that line.

**Theorem 15.** In a solution of the type model there are, on each
sublattice, functions $P$, $Q$ and $R$ of one coordinate with
$$\frac{h_y}{\ell_y} = P(x) - R(z), \qquad \frac{h_z}{\ell_z} = Q(y) -
P(x), \qquad \frac{h_x}{\ell_x} = 1 + R(z) - Q(y),$$
so that the three fractions at any vertex add to one.

*Proof.* Average (C) along the line through $v$ in the direction $y$.
The chains of axis $x$ are labelled by $y - z$ or $y + z$ modulo
$4\gcd(b, c)$, which divides $4b$, so along the line the chain of each
family runs equally often over all the chains of its pair of planes,
and the average of $F_x$ is a function $P(x)$. The average of $F_z$ is
a function $R(z)$ for the same reason. Along the line in the direction
$z$ the average of $F_x$ is the same $P(x)$ and that of $F_y$ is a
function $Q(y)$. Along the line in the direction $x$ the average of
$F_x$ is not a function of one coordinate, but it cancels from $X = 1
- Y - Z$. The constants of (C) are absorbed on each sublattice.
$\square$

By Lemma 1 a frozen state has even curl exactly when every fraction is
0 or 1.

## The cells with no coprime pair

The other cells are those in which every two extents have a common
factor. The cubic cells of side at least two are among them, and so
are $(2,2,4)$, $(4,4,6)$ and $(6,10,15)$. On such a cell
every pair of planes holds at least two chains of each family and no
height is a function of one coordinate. Theorem 12 is false there.
Frozen states with an odd hexagon and all three types present exist on
$(2,2,2)$, $(2,2,4)$, $(2,4,6)$, $(3,3,3)$ and $(4,4,6)$ (solver, with
the sign field). Of the 1,357 odd states of the cubic cells of side
three and four that the project has collected, 356 have two types on
each sublattice and an empty axis, and 1,001 have all three types on
both sublattices. Each of the 1,001 has an axis that is one-way and not
empty. On these cells Theorem H is therefore a statement about the
signs of the moments, and no statement about the types alone proves it.
The next section gives the linear structure of the signed moments,
which holds on every cell. The section after it proves Theorem H on
the first family of these cells, those with two chains in every pair
of planes. On the rest the reduction through Theorem U and $K_u$ is
the route that is known.

## Checks

The proofs of this section were written by the main session of the
project and read by a separate agent as checker, which found no gap.
The checker wrote its own programs. It confirmed the counterexample to
the lemma on three families in exact arithmetic, and enumerated the
meeting of the lines of Theorem 12 on twelve cells. In the type model
the statement that one sublattice has a vertex of each type is
unsatisfiable on $(2,3,3)$, $(4,3,3)$, $(5,3,3)$, $(3,4,4)$, $(5,2,4)$,
$(5,4,4)$, $(6,2,3)$, $(6,3,4)$, $(6,2,9)$ and $(7,3,6)$, by two
encodings, and satisfiable on $(3,3,3)$, $(4,4,6)$ and $(2,2,4)$. On
$(10,4,5)$ the solver gave no verdict. On 258 sampled solutions of
seven cells with a coprime pair, the case of Theorem 12, the forms of
Theorem 13 and the integrality of Lemma 10 had no exception, and
Theorem 15 held exactly on 495 sampled solutions of ten cells that are
not cubic and on the 1,357 states of the cubic cells. These
computations are tests of the proofs and are not steps of them.

# The linear structure of the signed moments

The parametrisation (C) describes the types of a frozen state by
weights on the chains. The signed moments have a description of the
same kind in any state whose holes are all oriented, which by Theorem
U is every odd state on the cells where that theorem is known. On the
cells with no coprime pair Theorem H is a statement about signs, so a
proof there has to use this structure. The next section uses it for
the cells with two chains in every pair of planes.

## Notation

A chain of the family $f = \{i, j\}$ alternates bonds of the directions
$d_i$ and $d_j$, and its step is $u_f = d_i - d_j$. The six steps are
$$\begin{aligned}
u_{01} &= (0,2,2), & u_{02} &= (2,0,2), & u_{03} &= (2,2,0), \\
u_{23} &= (0,2,-2), & u_{13} &= (2,0,-2), & u_{12} &= (2,-2,0),
\end{aligned}$$
two for each axis, and the step of a chain has no component along the
axis of the chain. Two distinct directions have $d_r \cdot d_s = -1$,
so $d_r \cdot u_f$ is $4$ for $r = i$, $-4$ for $r = j$ and $0$ for the
two directions that the chain does not use.

Let $\Lambda$ be the lattice of translations of A, generated by the
steps, and $G$ its quotient by the periods of the cell $(a, b, c)$, a
group of order $4abc$. A character of $G$ extends to $\chi(p) =
\xi^{p_1} \eta^{p_2} \zeta^{p_3}$ with $\xi^{4a} = \eta^{4b} =
\zeta^{4c} = 1$. Fix one extension for each character, and put
$\lambda_r = \chi(d_r)$. The functions $\chi \mathbf{1}_A$ and $\chi
\mathbf{1}_B$ form a basis of the complex functions on the vertices.
Every linear system below has integer coefficients and is invariant
under $\Lambda$. It therefore acts on each plane spanned by $\chi
\mathbf{1}_A$ and $\chi \mathbf{1}_B$ separately, and its real
solutions are known once its complex solutions are known for every
character.

Say that the family $f$ is supported at $\chi$ if $\chi(u_f) = 1$, that
is, if $\lambda_i = \lambda_j$. The indicator of a chain of the family
$f$ has a component at $\chi$ only if $f$ is supported there, and the
component is then a multiple of $(1, 1/\lambda_i)$ in the basis above.

**Lemma 11.** The families supported at a character are the pairs
inside the blocks of the partition of $\{0, 1, 2, 3\}$ by the value of
$\lambda$. There are five cases: no family; one family; the two
families of one axis; three families, one of each axis, when three of
the $\lambda_r$ are equal; and all six, which happens for the trivial
character only.

*Proof.* The complementary pairs $\{01, 23\}$, $\{02, 13\}$ and $\{03,
12\}$ are the pairs of families of the axes $x$, $y$ and $z$. If all
four $\lambda_r$ are equal, $\chi$ is trivial on every step and hence
on $\Lambda$. $\square$

## One cage law

**Lemma 12.** The indicator of a chain of an axis other than $k$
satisfies law $P^k$ at every hole, and so do $\mathbf{1}_A$ and
$\mathbf{1}_B$.

*Proof.* Take $k = x$ and the A-hole $O = a + 2e_x$. Its bridgeheads
are $a + d_0$ and $a + d_1$ on the lower side and $a + 4e_x + d_2$ and
$a + 4e_x + d_3$ on the upper, so the law reads
$$K(a + 4e_x) - K(a) = K(a + 4e_x + d_2) + K(a + 4e_x + d_3) - K(a +
d_0) - K(a + d_1).$$
Let $C$ be a chain of the family $\{0, 2\}$. A vertex $b$ of B lies on
$C$ exactly when $b - d_0$ does, and exactly when $b - d_2$ does. So
$K(a + d_0) = K(a)$ and $K(a + 4e_x + d_2) = K(a + 4e_x)$ for $K =
\mathbf{1}_C$. The two remaining terms are the values of $K$ at $a +
d_1$ and $a + 4e_x + d_3$, which lie on $C$ exactly when $a +
(0,-2,-2)$ and $a + (4,-2,2)$ do. These two points differ by $2u_{02}$,
so the terms are equal. The three other families of the axes $y$ and
$z$ are the same computation. For the constants both sides vanish. The
inversion carries the law at a B-hole to the law at an A-hole and each
family to itself, and the permutations of the coordinates permute the
laws. $\square$

**Theorem 16.** On every cell the real solutions of law $P^k$, taken at
every hole, are the span of the indicators of the chains of the two
axes other than $k$ and of $\mathbf{1}_A$ and $\mathbf{1}_B$. For $k =
x$ the dimension is
$$4b \gcd(a, c) + 4c \gcd(a, b) - 4 \gcd(a, b, c) + 2.$$

*Proof.* Take $k = x$. On the plane of a character the law at the
A-holes and at the B-holes is the matrix
$$M = \begin{pmatrix} \Delta & -\Theta \\ -\Theta' & \Delta
\end{pmatrix}, \qquad \Delta = \xi^2 - \xi^{-2}, \quad \Theta = \xi p -
\xi^{-1} q, \quad \Theta' = \xi q - \xi^{-1} p,$$
with $p = \eta/\zeta + \zeta/\eta$ and $q = \eta\zeta +
1/(\eta\zeta)$. Write $X_\xi = \xi^2 + \xi^{-2}$ and likewise for
$\eta$ and $\zeta$. Then $pq = X_\eta + X_\zeta$ and $p^2 + q^2 = 4 +
X_\eta X_\zeta$, so
$$\det M = \Delta^2 - \Theta\Theta' = (X_\xi - X_\eta)(X_\xi -
X_\zeta),$$
and $X_\xi - X_\zeta = \xi^{-2} (\chi(u_{02}) - 1)(\chi(u_{13}) - 1)$,
$X_\xi - X_\eta = \xi^{-2} (\chi(u_{03}) - 1)(\chi(u_{12}) - 1)$. The
determinant vanishes exactly when some family of the axes $y$ and $z$
is supported. If $\Delta = 0$ then $\xi^2 = \varsigma = \pm 1$, and
$\xi\eta\zeta\, \Theta = -(\eta^2 - \varsigma)(\zeta^2 - \varsigma)$
and $\xi\eta\zeta\, \Theta' = \varsigma (\eta^2 - \varsigma)(\zeta^2 -
\varsigma)$. So $M = 0$ exactly when $\xi^2 = \eta^2 = \pm 1$ or
$\xi^2 = \zeta^2 = \pm 1$, which says that both families of $z$, or
both families of $y$, are supported.

By Lemma 12 the component of every supported chain of $y$ or $z$ lies
in the kernel of $M$. If no such family is supported the kernel is
zero. If some are supported but not both families of one axis, the
kernel is a line and any supported chain spans it. If both families of
$y$ are supported, the kernel is the whole plane, and the two
components $(1, 1/\lambda_0)$ and $(1, 1/\lambda_1)$ are independent
unless $\lambda_0 = \lambda_1$. In that case all four $\lambda_r$ are
equal, the character is trivial, and the two constants span the plane.
If both families of $z$ are supported the same holds with $\lambda_0 =
\lambda_3$ and $\lambda_1 = \lambda_2$. So the kernel is the span at
every character.

The dimension is the number of characters with $\det M = 0$ plus the
number with $M = 0$. The characters at which a given family of $y$ is
supported number $2b\gcd(a, c)$, which is the number of chains of the
family, and $2c\gcd(a, b)$ for a family of $z$. Both families of $y$
are supported at $2b$ characters and both of $z$ at $2c$. A family of
$y$ and a family of $z$ are supported together at $\gcd(a, b, c)$
characters, those trivial on a plane of $\Lambda$ normal to one of the
$d_r$. Any three conditions force the fourth, and all four hold at the
trivial character only. Counting by inclusion and exclusion gives the
formula. $\square$

## The three laws and the bond rule

By Lemma 3 the component $n_k$ of the moments obeys law $P^k$ at every
oriented hole. The moments also obey the bond rule, $d \cdot n(v) = d
\cdot n(v + d)$ on every bond, which is linear in $n$.

**Theorem 17.** On every cell the real vector fields $n$ on the
vertices whose components obey the three laws $P^x$, $P^y$ and $P^z$ at
every hole, and which obey the bond rule on every bond, are exactly the
fields
$$n = \tfrac12 \sum_C g(C)\, u_C\, \mathbf{1}_C,$$
the sum being over all chains, with real weights $g$ and $u_C$ the step
of the chain. The dimension of the space is $4(a\gcd(b, c) + b\gcd(a,
c) + c\gcd(a, b)) - 4\gcd(a, b, c) + 1$.

So each chain carries a current along itself, and the moments of a
state with every hole oriented are a sum of such currents.

*Proof.* The field $\tfrac12 u_f \mathbf{1}_C$ obeys the bond rule. On
a bond of a direction that $C$ does not use both sides vanish, and a
bond of the direction $d_i$ or $d_j$ with one end on $C$ has both ends
on $C$, where both sides equal $\tfrac12 d \cdot u_f$. Its component
along the axis of $C$ is zero, and each of the two others is a multiple
of $\mathbf{1}_C$, which obeys the law of that component by Lemma 12.

Conversely, fix a character and write $n_A$ and $n_B$ for the two
amplitudes, vectors of three components. The bond rule reads $d_r
\cdot n_A = \lambda_r\, d_r \cdot n_B$ for $r = 0, \dots, 3$, and the
laws say that each pair of components lies in the kernel of the matrix
of Theorem 16 for its axis. Take the cases of Lemma 11 in turn. If no
family is supported, every determinant is non-zero and $n = 0$. If one
family $f = \{i, j\}$ of axis $m$ is supported, then $n_m = 0$, the
laws of the two other components give $n_B = n_A / \lambda_i$, and the
bond rule becomes $(1 - \lambda_r/\lambda_i)\, d_r \cdot n_A = 0$. For
the two directions $r$ outside $f$ the factor is not zero, so $n_A$ is
orthogonal to both and is a multiple of $u_f$. If both families of the
axis $m$ are supported, with values $\lambda = \mu$ on one and
$\lambda = \nu$ on the other, then $n_m = 0$, the laws of the two other
components say nothing, and the bond rule leaves two independent
equations on four unknowns. The solutions form a plane, and the
currents of the two families are two independent vectors of it. If three families
are supported, with $\lambda_r = \mu$ for $r \neq \ell$, the laws give
$n_B = n_A/\mu$, and the bond rule on the direction $d_\ell$ gives
$n_A \cdot d_\ell = 0$, a plane spanned by the steps of the three
families. At the trivial character the laws say nothing and the bond
rule gives $n_A = \lambda n_B$, three dimensions, spanned by the six
steps. In every case the solutions are the currents. The dimension is
the number of chains less the number of relations. There is one
relation at each non-trivial character at which three families are
supported, $4(\gcd(a, b, c) - 1)$ in all, and there are three at the
trivial character.
$\square$

In components, with $G_f(v)$ the weight of the chain of the family $f$
through $v$,
$$\begin{aligned}
n_x &= G_{02} + G_{13} + G_{03} + G_{12}, \\
n_y &= G_{01} + G_{23} + G_{03} - G_{12}, \\
n_z &= G_{01} - G_{23} + G_{02} - G_{13}.
\end{aligned}$$
The two families of an axis enter the two transverse components with
different signs, one with $(+, +)$ and the other with $(+, -)$. In (C)
both families of an axis enter the two transverse types with $(+, -)$.
No constant on one sublattice alone occurs, as the terms with
$\sigma_v$ do in (C). A field that is constant on all the vertices is
a sum of currents: $e_x$ is the sum over the chains of the two
families of axis $y$ with every weight $\tfrac12$. Neither system
implies the other:
the three laws never imply the bond rule, and the bond rule implies the
laws on the cell $(1,1,1)$ only.

**Theorem 18.** In a frozen state with every hole oriented, each of the
six indicators of a direction is a sum of weights over the chains
through the vertex, and a constant on each sublattice. Each chain
carries two weights. Each weight belongs to a pair of directions
transverse to the axis of the chain whose difference is half the step
of the chain, and enters the indicator of one with the sign $+$ and
that of the other with $-$.

*Proof.* Let $f(C)$ be the weights of (C) and $g(C)$ those of Theorem
17, which applies by Lemma 3. The indicator of the direction $\pm e_k$
is $\tfrac12(K_k \pm n_k)$. For a chain of the family $\{0, 1\}$ the
directions transverse to its axis fall into the pairs $\{+e_y, -e_z\}$
and $\{+e_z, -e_y\}$, in each of which the difference is $\pm(0, 1,
1)$. Giving the first pair the weight $\tfrac12(f + g)$ and the second
$\tfrac12(g - f)$ reproduces the contribution of the chain to the
types, which is $f(C)$ to $Y$ and $-f(C)$ to $Z$, and its contribution
$\tfrac12 g(C) u_C$ to $n$. The other
families are the same. $\square$

The theorem is linear and says nothing about integers. It does not
contain the relation $|n_k| = K_k$ between the two sets of weights.

## The signed fractions on the lines through a vertex

Let $\sigma_k(v)$ be the sum of $n_k$ over the line $\{v + 4ne_k\}$
divided by the number of its vertices.

**Theorem 19.** In a frozen state with every hole oriented there are
six functions of one coordinate, $F_{01}$ and $F_{23}$ of $x$, $U_{02}$
and $U_{13}$ of $y$, $W_{03}$ and $W_{12}$ of $z$, with
$$\begin{aligned}
\sigma_x &= [U_{02} + U_{13}](y) + [W_{03} + W_{12}](z), \\
\sigma_y &= [F_{01} + F_{23}](x) + [W_{03} - W_{12}](z), \\
\sigma_z &= [F_{01} - F_{23}](x) + [U_{02} - U_{13}](y)
\end{aligned}$$
at the vertices of A, and with the same six functions at the vertices
of B, evaluated at $x - 1$, $x + 1$, $y - 1$, $y + 1$, $z - 1$ and $z +
1$ in the order in which they are named.

*Proof.* Average the components of Theorem 17 along the line, as in the
proof of Theorem 15. The average of $G_f$ is the mean weight of the
chains of the family $f$ in the pair of planes of $v$, and the pair of
planes of a family lies above a vertex of A and below a vertex of B, or
the reverse, according to the sign of the component of $d_i$ along the
axis. $\square$

The separability of each $\sigma_k$ is the second statement of Theorem
5. What is added is that the three share their profiles, and that the
fractions on B are those on A up to constants, which has no counterpart
for the types. The three signed fractions at a vertex do not add to a
constant. Their sum on A is $2F_{01}(x) + 2U_{02}(y) + 2W_{03}(z)$, and
it is constant in 86 of the 1,357 odd states of the cubic cells of side
three and four.

## States with charged holes, and one sublattice

By Lemma 3 the component $n_k$ fails law $P^k$ at a charged hole by the
charge, on every axis $k$ and not only on the axis of the rods of the
hole. In 62 frozen states of even curl sampled by solver on four cells,
45 of them with charged holes, the types obeyed the laws at every hole,
the signed components failed by exactly the charge, and $n_k$ lay in
the span of Theorem 16 exactly when no hole was charged. So Theorems 17
to 19 are statements about oriented states and fail without that
hypothesis.

Theorem 12 has no counterpart for directions. On the cells $(4,3,3)$,
$(6,2,3)$ and $(5,2,4)$ one sublattice of a frozen state can carry any
pattern of absent, one-way and two-way axes on two of the three axes
(solver, with a satisfiable control for each query), so the signs add
nothing on one sublattice to what Theorem 12 says about the types. A
statement of the kind of $K_u$, that some direction is absent, has to
couple the two sublattices, and Theorem 19 is one place where they are
coupled.

## Checks

The theorems of this section were found and proved by an agent of the
project. The main session redid the algebra of the determinant and of
the cases of Theorem 17 and ran the agent's programs again. Exact ranks
modulo a prime agree with Theorem 16 on twenty cells and with Theorem
17 on twenty-two, among them cells of extent one and two, cells with a
coprime pair and cells with none, and for Theorem 17 an independent
count over the characters gives the same dimensions. Every one of the
1,357 odd states of the cubic cells of side three and four, and 48
sampled odd states of four cells that are not cubic, satisfies the
three laws and the bond rule, and Theorem 19 holds exactly on all of
them. A separate agent then read the section as checker, with its own
programs, and found no gap. It made three corrections of wording, which
are in the text above: on constants, on the sum of the three signed
fractions, and on one case of the proof of Theorem 16. Its exact ranks
agree with Theorems 16 and 17 on sixteen cells, and Theorem 19 holds
exactly on 837 odd states of nine cells and fails on 773 of them when
the six shifts are reversed.

# Cells with two chains in every pair of planes

This section concerns the cells $(2a', 2b', 2c')$ in which $a'$, $b'$
and $c'$ are pairwise coprime, such as $(2,2,2)$, $(2,4,6)$,
$(4,6,10)$ and $(6,10,14)$. Every two extents of such a cell have
greatest common divisor 2, so no pair is coprime and the section on
cells with a coprime pair does not apply. Every pair of neighbouring
planes holds exactly two chains of each family, for each of the three
axes. The section proves statement (V) on these cells, and with it
Theorem U, and then Theorem H. Neither proof uses $K_u$. They are the
first proofs of (V) and of Theorem H on cells with no coprime pair,
and the first proof of Theorem H in which an axis that is one-way and
not empty is produced by an argument and not by a certificate.

## Signs, classes and chains

At a vertex $v = (x, y, z)$ of A put $\rho_x = (-1)^{x/2}$, $\rho_y =
(-1)^{y/2}$, $\rho_z = (-1)^{z/2}$ and $\pi = (-1)^{(x + y + z)/4}$. At
a vertex of B put $\rho_x = (-1)^{(x-1)/2}$, likewise $\rho_y$ and
$\rho_z$, and $\pi = (-1)^{(x + y + z - 3)/4}$. The periods of the cell
are multiples of 8, so these are defined on the cell, and $\rho_x
\rho_y \rho_z = 1$ at every vertex. The four triples of signs divide
each sublattice into four classes. A vertex and its translate by
$4e_k$ lie in the same class and have opposite $\pi$.

The two chains of a family in a pair of planes are the two classes
modulo 8 of $y - z$ or of $y + z$, and likewise for the other axes.
They are told apart by a sign that is constant along the chain. At the
vertices of A it is $\pi \rho_z$ for the family $\{0,1\}$, $\pi
\rho_x$ for $\{0,2\}$, $\pi \rho_y$ for $\{0,3\}$, and $\pi$ for
$\{2,3\}$, $\{1,3\}$ and $\{1,2\}$. For instance $\pi \rho_z = (-1)^{(x
+ y - z)/4}$, and $x + y - z$ is unchanged by the step $(0, 2, 2)$ and
changes by 4 from one chain of the pair of planes to the other. Write
the weight of the chain of the family $f$ whose vertices of A lie on
the plane $n$ and whose sign is $s$ as $m_f(n) + s\, e_f(n)$.

**Theorem 20.** For a plane $n$ of A and a sign $\sigma$ put
$$\begin{aligned}
E^A_x(n, \sigma) &= \sigma e_{01}(n) + e_{23}(n), \\
E^A_y(n, \sigma) &= \sigma e_{02}(n) + e_{13}(n), \\
E^A_z(n, \sigma) &= \sigma e_{03}(n) + e_{12}(n),
\end{aligned}$$
and for a plane $n'$ of B put $E^B_x(n', \sigma) = \sigma e_{01}(n' -
1) - e_{23}(n' + 1)$, and likewise for $y$ and $z$. Let $\Phi^A_x(n) =
m_{01}(n) + m_{23}(n)$ and $\Phi^B_x(n') = m_{01}(n' - 1) + m_{23}(n' +
1)$, and likewise for $y$ and $z$. Then on each sublattice $S$
$$\begin{aligned}
F_x &= \Phi_x(x) + \pi E_x(x, \rho_z), \\
F_y &= \Phi_y(y) + \pi E_y(y, \rho_x), \\
F_z &= \Phi_z(z) + \pi E_z(z, \rho_y),
\end{aligned}$$
and every real solution of the one-hot equations and of (T2) is
$$Y = a_y + \pi b_y, \qquad Z = a_z + \pi b_z, \qquad X = a_x + \pi
b_x,$$
with $a_y = \Phi_x(x) - \Phi_z(z) + \sigma_S \alpha$, $a_z = \Phi_y(y)
- \Phi_x(x) + \sigma_S \beta$, $a_x = 1 - a_y - a_z$, and $b_y = E_x -
E_z$, $b_z = E_y - E_x$, $b_x = E_z - E_y$, each $E_k$ being taken at
the plane and the sign of the vertex.

*Proof.* At a vertex of A the chain of $\{0,1\}$ through $v$ has its
vertices of A on the plane $x$ and sign $\pi \rho_z$, and the chain of
$\{2,3\}$ has the same plane and sign $\pi$, which gives $F_x$. The
two other axes are the same. At a vertex $w$ of B the chain of
$\{0,1\}$ contains $w - d_0$, on the plane $x - 1$ of A, and its sign
there is $(-1)^{(x + y - z - 1)/4}$, which is $\pi \rho_z$ at $w$
because the two exponents differ by the even number $z - 1$. The chain
of $\{2,3\}$ contains $w - d_2$, on the plane $x + 1$, with sign
$(-1)^{(x + y + z + 1)/4} = -\pi$. The other four families are the
same computation. Substituting in (C) gives the rest. $\square$

Since $\rho_y = \rho_x \rho_z$, the function $b_y$ depends on $x$ and
$z$ only, and likewise $b_z$ on $x$ and $y$ and $b_x$ on $y$ and $z$.
Four consequences follow for a solution of the type model.

*Lines.* Along a line $\{v + 4ne_k\}$ the two transverse coordinates
are fixed and $\pi$ alternates. The indicator $K_k$ takes the values 0
and 1, so the pair $(a_k, b_k)$ is $(0, 0)$, $(1, 0)$ or $(\tfrac12,
\pm\tfrac12)$. The type $k$ is absent from the line, fills it, or
occupies every second vertex. The number $a_k$ is the fraction of
Theorem 15.

*Profiles.* By Theorem 15 there are functions $p$, $q$ and $r$ of one
coordinate on $S$ with $2a_y = p(x) - r(z)$, $2a_z = q(y) - p(x)$ and
$2a_x = 2 + r(z) - q(y)$. Every pair of values of two coordinates
occurs at a vertex of $S$, so the differences are integers, and the
profiles can be taken to be integers. Since the fractions are not
negative,
$$\max r \leq \min p, \qquad \max p \leq \min q, \qquad \max q \leq
\min r + 2.$$
The three gaps in these inequalities and the three spreads $\max -
\min$ of $r$, $p$ and $q$ are six integers, none negative, that add to
2. In particular the three spreads add to at most 2.

*Parity.* A line has fraction $\tfrac12$ exactly when $|b_k| =
\tfrac12$. So $|E_x - E_z| = \tfrac12$ at a vertex if $p(x) - r(z)$ is
odd and $E_x = E_z$ if it is even, and likewise $|E_y - E_x|$ with $q
- p$ and $|E_z - E_y|$ with $r - q$.

*The two sublattices.* Put $\Delta_k(n) = E_k(n, +) - E_k(n, -)$ and
$\Sigma_k(n) = E_k(n, +) + E_k(n, -)$. By the definitions
$$\Delta^B_k(n') = \Delta^A_k(n' - 1), \qquad \Sigma^B_k(n') =
-\Sigma^A_k(n' + 1).$$
The functions $E$ of B are those of A, moved by one plane. The
profiles $p$, $q$, $r$ of B are not tied to those of A.

## The unoriented cage

Take the cage in the position of Theorem 11, with the hole $O = (2, 0,
0)$, the rods $v = (0,0,0)$ and $v' = (4,0,0)$, the lower bridgeheads
$\beta = (1,1,1)$ and $\beta' = (1,-1,-1)$ and the upper bridgeheads
$\gamma = (3,1,-1)$ and $\gamma' = (3,-1,1)$.

**Theorem 21.** On a cell $(2a', 2b', 2c')$ with $a'$, $b'$, $c'$
pairwise coprime, let a solution of the type model have $v$ and $v'$ of
type $x$, $\beta$ and $\beta'$ of type $y$, and $\gamma$ and $\gamma'$
not of type $y$. Then sublattice B has no vertex of type $x$, its plane
$x = 1$ is entirely of type $y$, and its plane $x = 3$ is entirely of
type $z$.

*Proof.* The profiles and the functions $E$ without a superscript are
those of A in the first two steps.

*The rod line.* The rods lie on one line in the direction $x$ and have
opposite $\pi$. Both are of type $x$, so the line is full, $a_x = 1$ on
it, and $q(0) = r(0)$. The inequalities give $r(0) \leq \min p \leq
\max p \leq q(0)$, so $p$ is a constant $c$ on A, $r \leq c$ with
equality at $z = 0$, and $q \geq c$ with equality at $y = 0$. On A the
fraction $a_y$ is a function of $z$ and $a_z$ a function of $y$, and
both vanish at 0.

*The lines through the origin.* At the vertices of A with $z = 0$ the
fraction $a_y$ is zero, so $b_y = 0$, and there $\rho_z = 1$ and
$\rho_y = \rho_x$. Hence $E_x(x, +) = E_z(0, \rho_x)$. So $E_x(n, +)$
has one value $\kappa = E_z(0, +)$ on the planes $n \equiv 0$ and one
value $\lambda = E_z(0, -)$ on the planes $n \equiv 2$ modulo 4. At the
vertices with $y = 0$, $a_z = 0$ gives $E_y(0, \rho_x) = E_x(x,
\rho_x)$, so $E_x(n, -)$ has one value $\mu = E_y(0, -)$ on the planes
$n \equiv 2$, and $E_y(0, +) = \kappa$.

*The bridgeheads.* The classes $(\rho_x, \rho_y, \rho_z)$ of $\beta$,
$\beta'$, $\gamma$ and $\gamma'$ are $(+,+,+)$, $(+,-,-)$, $(-,+,-)$
and $(-,-,+)$, and $\pi$ is $+$, $-$, $+$ and $+$. By Theorem 20, with
the profiles and the functions of B,
$$\begin{aligned}
Y(\beta) + Y(\beta') - Y(\gamma) - Y(\gamma') = {} & p^B(1) - p^B(3) \\
& + \Delta^B_x(1) - \Sigma^B_x(3) + \Sigma^B_z(-1) - \Delta^B_z(1).
\end{aligned}$$
The left side is 2. By the relation between the two sublattices the
last four terms are $\Delta^A_x(0) + \Sigma^A_x(4) - \Sigma^A_z(0) -
\Delta^A_z(0)$, and $\Sigma^A_z(0) + \Delta^A_z(0) = 2\kappa$. With the
values just found for $E_x(0, +)$ and $E_x(4, +)$ this gives
$$p^B(1) - p^B(3) = 2 + E^A_x(0, -) - E^A_x(4, -). \tag{$\star$}$$
The spread of $p^B$ is at most 2. If the two values of $E^A_x$ in
($\star$) are equal, the spread is 2, so the five other integers
vanish: $r^B$ is the constant $p^B(3)$ and $q^B$ the constant $p^B(1) =
r^B + 2$. Then $a_x = 0$ on B, the fraction $a_y$ is 1 on the plane $x
= 1$, and $a_z$ is 1 on the plane $x = 3$, which is the theorem. It
remains to prove that the two values are equal. At odd length of the
rod axis Theorem 11 had a vertex $P$ of the rod line for this step,
and at even length there is none.

*The case in which some plane is integral.* Suppose some plane $z =
z_0$ of A with $z_0 \equiv 2$ modulo 4 has $a_y = 0$ or 1. The
vertices $(n, y, z_0)$ with $n \equiv 0$ are in the class $(+,-,-)$,
and $b_y = 0$ there, so $E_x(n, -) = E_z(z_0, -)$ for every $n \equiv
0$, and the two values are equal. The same holds if some plane $y =
y_0$ with $y_0 \equiv 2$ has $a_z = 0$ or 1, by $b_z = 0$ at the
vertices $(n, y_0, z)$.

*The case in which none is.* Suppose $a_y = \tfrac12$ on every plane $z
\equiv 2$ of A and $a_z = \tfrac12$ on every plane $y \equiv 2$. In
the class $(+,-,-)$ the fraction $a_x$ is then zero, so $E_z(z, -) =
E_y(y, +)$ for all $y, z \equiv 2$, and both are a constant $\theta$.
In the same class $|b_y| = \tfrac12$, so $E_x(n, -) = \theta \pm
\tfrac12$ for $n \equiv 0$. The difference in ($\star$) is therefore
$-1$, 0 or 1. It is not 1, since the spread of $p^B$ is at most 2, and
if it is 0 the proof is finished. Suppose then that $E_x(0, -) =
\theta - \tfrac12$ and $E_x(4, -) = \theta + \tfrac12$, so that
$p^B(1) - p^B(3) = 1$. Three further facts hold on A. In the class
$(-,+,-)$, $E_z(z, +) = \mu + \tfrac12 \psi(z)$ with $\psi(z) = \pm 1$,
for $z \equiv 2$. In the class $(-,-,+)$, $E_y(y, -) = \lambda +
\tfrac12 \varphi(y)$ with $\varphi(y) = \pm 1$, for $y \equiv 2$. And
for a plane $n \equiv 0$ in the direction $z$, the numbers $E_z(n, +) -
\kappa$ and $E_z(n, -) - \lambda$ are $b_y$, up to sign, in the classes
$(+,+,+)$ and $(-,-,+)$, so both are zero or both are $\pm\tfrac12$,
and likewise $E_y(n, +) - \kappa$ and $E_y(n, -) - \mu$.

From the relation between the sublattices and the values found,
$$E^B_x(1, \sigma) - E^B_x(5, \sigma) = \tfrac{\sigma}{2}, \qquad
E^B_x(3, \sigma) - E^B_x(-1, \sigma) = -\tfrac12,$$
for both signs $\sigma$. Take a plane $z'$ of B and a class of B that
contains vertices of it, with $\rho_x = 1$. The vertices of that class
on the planes $x = 1$ and $x = 5$ have $b_y = E^B_x(1, \rho_z) - h$
and $E^B_x(5, \rho_z) - h$, where $h = E^B_z(z', \rho_y)$. These two
numbers differ by $\tfrac12$ and each is 0 or $\pm\tfrac12$, so one of
them is 0 and $h$ is $E^B_x(1, \rho_z)$ or $E^B_x(5, \rho_z)$. For a
class with $\rho_x = -1$ the planes $x = 3$ and $x = -1$ do the same.
For $z' \equiv 1$ modulo 4 the two classes are $(+,+,+)$ and
$(-,-,+)$, and this gives
$$E^B_z(z', +) - E^B_x(1, +) \in \{0, -\tfrac12\}, \qquad E^B_z(z', -)
- E^B_x(-1, +) \in \{0, -\tfrac12\}.$$
Since $E^B_x(1, +) - E^B_x(-1, +) = \kappa - \lambda$, the difference
$\Delta^A_z(z' - 1) = \Delta^B_z(z')$ is $\kappa - \lambda$ or differs
from it by $\tfrac12$. By the third fact it differs from $\kappa -
\lambda$ by 0 or $\pm 1$, so it equals it. For $z'' \equiv 3$ the
classes are $(+,-,-)$ and $(-,+,-)$, and the same argument, with
$E^B_x(1, -) + E^B_x(-1, -) = -\kappa - \lambda$, gives $\Sigma^A_z(z''
+ 1) = \kappa + \lambda$. Every plane $n \equiv 0$ is $z' - 1$ for one
$z'$ and $z'' + 1$ for one $z''$. So $E^A_z(n, +) = \kappa$ and
$E^A_z(n, -) = \lambda$ for every $n \equiv 0$, and in the same way
$E^A_y(n, +) = \kappa$ and $E^A_y(n, -) = \mu$.

Now let $z' \equiv 1$ and $n = z' + 1$. On the plane $x = 1$ of B the
vertices with coordinate $z'$ are in the class $(+,+,+)$ and those
with $z' + 2$ in the class $(+,-,-)$, and the values found give
$$\begin{aligned}
E^B_x(1, +) - E^B_z(z', +) &= \tfrac14 (1 + \psi(n)), \\
E^B_x(1, -) - E^B_z(z' + 2, -) &= \tfrac14 (\psi(n) - 1).
\end{aligned}$$
Exactly one of these is $\pm\tfrac12$ and the other is 0. By the rule
of parity $p^B(1) - r^B(z')$ and $p^B(1) - r^B(z' + 2)$ have different
parities, so $r^B$ is not constant. In the same way, with $\varphi$ in
place of $\psi$, $q^B$ is not constant, and $p^B(1) - p^B(3) = 1$. The
three spreads of B are each at least 1 and add to at least 3. This
contradicts the inequalities. $\square$

The proof uses the parametrisation (C) and the count of two chains in
a pair of planes. It uses that the types are integers through the
three values of a fraction and the rule of parity, and that they are
not negative through the inequalities on the profiles. It uses no
certificate and no other result of this note.

*Other positions.* The inversion $w \mapsto (1,1,1) - w$ exchanges the
sublattices. The half-turn $(x, y, z) \mapsto (4 - x, -y, z)$ fixes
the hole, preserves the sublattices, the bonds and the types, and
exchanges the two lower bridgeheads with the two upper. The exchange
of $y$ and $z$ carries the cell to $(2a', 2c', 2b')$ and exchanges the
two types of the bridgeheads. A permutation of the coordinates
carries rods along $y$ or $z$ to rods along $x$. Each maps the family
to itself, so the theorem holds for every unoriented cage of every
cell of the family.

**Theorem 22.** On a cell $(2a', 2b', 2c')$ with $a'$, $b'$, $c'$
pairwise coprime, every hole of an odd frozen state is oriented.

*Proof.* A frozen state with an unoriented hole has an unoriented cage,
and by Theorem 21 the sublattice of its bridgeheads has no vertex of
the type of its rods. The other sublattice has one, so Theorem $M'$
gives even curl. An odd state has therefore no unoriented straight
hole, and its corners are oriented by Lemma 2. $\square$

Theorem H follows from Theorem 22 and Theorem 1 on every cell of the
family, since Theorem 1 in its form of 30 September needs no $K_u$.
(In its first form it did, and $K_u$ is established on these cells:
the first step covers the slab when the greatest common divisor of the
two extents transverse to the chain is at most 2, which is the case
for every axis here, and the windows of its certificates were recorded
for extents of at least three along the chain and four across it.) The
next subsection gives the proof of Theorem H on these cells that was
found first, on 28 September, and which does not pass through Theorem
1; it is kept because its case analysis says more than Theorem 1 does
about which axis is one-way.

On the cells of the family with an extent of 2, among them $(2,2,2)$
and $(2,4,6)$, Theorem $M'$ is used at an extent of 2. There it has
been argued from lemmas on the infinite lattice. It has also been
tested by solver in the type model on $(2,2,2)$, $(2,2,6)$, $(2,4,6)$,
$(4,2,6)$ and $(2,6,10)$, for every axis and both sublattices, with
satisfiable controls.

The proof of Theorem 21 does not extend as it stands to a cell such as
$(4,4,6)$, in which the chains of one axis number four in a pair of
planes. There the type $y$ on a line of A need not have period 8.
Statement (V) is true on $(4,4,6)$ and $(8,4,6)$ by solver.

## Theorem H on these cells

Take an odd frozen state on a cell of the family. If some type is
absent its axis is empty, so suppose that all three types occur. If
one sublattice lacked a type that the other has, Theorem $M'$ would
give even curl. So both sublattices carry all three types. By Theorem
22 every hole is oriented, so Theorems 17 to 19 apply.

For a sublattice $S$ write $R$, $P$ and $Q$ for the spreads of the
profiles $r$, $p$ and $q$, and $g_{rp} = \min p - \max r$, $g_{pq} =
\min q - \max p$ and $g_{qr} = \min r + 2 - \max q$ for the three gaps.
The six integers are not negative and add to 2.

**Lemma 13 (six cases).** If $S$ carries all three types, exactly two
of the six integers are 1, and they are either two of the spreads or a
spread and the gap between the two other profiles. Name the cases by
the coordinate $k$ whose profile is constant in the first kind, and
whose lines all alternate in the second.

| case | equal to 1 | fractions |
|:--|:--|:-------------|
| (i)$_x$ | $R$, $Q$ | $a_y$ depends on $z$, and $a_z$ on $y$ |
| (i)$_y$ | $R$, $P$ | $a_z$ depends on $x$, and $a_x$ on $z$ |
| (i)$_z$ | $P$, $Q$ | $a_x$ depends on $y$, and $a_y$ on $x$ |
| (ii)$_x$ | $P$, $g_{qr}$ | $a_x = \tfrac12$; $a_y$ and $a_z$ depend on $x$ |
| (ii)$_y$ | $Q$, $g_{rp}$ | $a_y = \tfrac12$; $a_z$ and $a_x$ depend on $y$ |
| (ii)$_z$ | $R$, $g_{pq}$ | $a_z = \tfrac12$; $a_x$ and $a_y$ depend on $z$ |

In a case (i)$_k$ the two fractions named take the values 0 and
$\tfrac12$ each, and $a_k$ is one less their sum, so it depends on
both transverse coordinates. In a case (ii)$_k$ the two fractions
named add to $\tfrac12$ and each takes both values.

*Proof.* The greatest value of $p - r$ is $R + g_{rp} + P$, so type
$y$ occurs on $S$ exactly when that sum is at least 1. In the same way
type $z$ needs $P + g_{pq} + Q \geq 1$ and type $x$ needs $Q + g_{qr} +
R \geq 1$. The six integers lie round a circle in the order $R$,
$g_{rp}$, $P$, $g_{pq}$, $Q$, $g_{qr}$, and the three conditions are on
the three arcs of three consecutive terms that begin and end at a
spread. A spread lies on two arcs and a gap on one. Two units must
meet all three arcs. Two units on one term meet at most two. Two
units on two spreads meet all three. A unit on a spread and one on a
gap meet all three exactly when the gap lies on the arc that the
spread does not. The fractions follow from $2a_y = p - r$, $2a_z = q -
p$ and $2a_x = 2 + r - q$. $\square$

**Lemma 14 (one sign on a line).** In a frozen state with every hole
oriented, on a cell of the family, $n_k(v + 8e_k) = n_k(v)$ for every
vertex, and the vertices of type $k$ on a line $\{v + 4ne_k\}$ have one
sign.

*Proof.* By Theorem 17, $n_x$ is a sum of weights of the chains of the
axes $y$ and $z$ through the vertex. The translation by $8e_x$ maps
each of these chains to itself. For a chain of the family $\{0, 2\}$
it is $t$ steps of $(2, 0, 2)$ with $t \equiv 4$ modulo $2a$ and $t
\equiv 0$ modulo $2c$, which has a solution because $\gcd(2a, 2c) =
4$, and the three other families are the same. So $n_x$ has period 8
along $x$. A line in the direction $k$ has fraction 0, $\tfrac12$ or
1. If it is $\tfrac12$ the vertices of type $k$ are 8 apart. If it is
1, two consecutive vertices are the rods of a straight hole, which is
oriented, so they have the same sign. $\square$

So $\sigma_k = \pm a_k$ on every line. With the functions of Theorem 19
put $F_\pm = F_{01} \pm F_{23}$, $U_\pm = U_{02} \pm U_{13}$ and $W_\pm
= W_{03} \pm W_{12}$, so that on A
$$\sigma_x = U_+(y) + W_+(z), \qquad \sigma_y = F_+(x) + W_-(z), \qquad
\sigma_z = F_-(x) + U_-(y).$$
The three pairs $(U_+, W_+)$, $(F_+, W_-)$ and $(F_-, U_-)$ are each
determined by the fractions of A up to a constant added to one member
and taken from the other.

**Lemma 15 (the fractions of B).** On B
$$\begin{aligned}
2\sigma_x &= U_+(y{-}1) + U_+(y{+}1) + U_-(y{-}1) - U_-(y{+}1) \\
&\quad + W_+(z{-}1) + W_+(z{+}1) + W_-(z{-}1) - W_-(z{+}1), \\
2\sigma_y &= F_+(x{-}1) + F_+(x{+}1) + F_-(x{-}1) - F_-(x{+}1) \\
&\quad + W_+(z{-}1) - W_+(z{+}1) + W_-(z{-}1) + W_-(z{+}1), \\
2\sigma_z &= F_+(x{-}1) - F_+(x{+}1) + F_-(x{-}1) + F_-(x{+}1) \\
&\quad + U_+(y{-}1) - U_+(y{+}1) + U_-(y{-}1) + U_-(y{+}1),
\end{aligned}$$
and the right sides do not change when the constants are moved.

*Proof.* Theorem 19 gives the fractions of B as those of A with
$F_{01}$, $U_{02}$ and $W_{03}$ taken one plane lower and $F_{23}$,
$U_{13}$ and $W_{12}$ one plane higher. Substitute $F_{01} = \tfrac12
(F_+ + F_-)$, $F_{23} = \tfrac12 (F_+ - F_-)$ and the like. $\square$

Two remarks are used several times. If $a_k$ on $S$ depends on one
transverse coordinate and vanishes on some plane of it, then $\sigma_k$
vanishes on that plane, and the part of $\sigma_k$ that depends on the
other coordinate is constant. And if a function $f$ on the planes of
one sublattice has $f(t - 1) - f(t + 1)$ the same for every $t$, the
sum round the circle shows that the difference is zero and $f$ is
constant.

**Lemma 16 (an axis with both signs).** If the axis $k$ is two-way on
$S$, then $a_k$ on $S$ depends on one transverse coordinate only.

*Proof.* The functions $\tfrac12 (a_k + \sigma_k)$ and $\tfrac12 (a_k -
\sigma_k)$ are the fractions of the two directions on the lines of
$S$. They are not negative, they are separable by Theorems 15 and 19,
their product is zero by Lemma 14, and neither vanishes identically.
By Lemma 4 both depend on the same single coordinate. $\square$

**Lemma 17 (the two sublattices).** The mean of $\sigma_k$ over the
lines of A equals its mean over the lines of B. So an axis that is
one-way on A and one-way on B, with vertices on both, is one-way.

*Proof.* As $y$ runs over the odd values, $y - 1$ and $y + 1$ each run
over the even values, so the mean of $U_{02}(y - 1) + U_{13}(y + 1)$
over B is the mean of $U_+$ over A, and the same holds for the other
functions. If the axis had opposite signs on the two sublattices the
two means would have opposite signs. $\square$

**Lemma 18 (a case of the first kind).** If $S$ is in the case
(i)$_k$, the axis $k$ is one-way on $S$. If A is in the case (i)$_k$
and B carries all three types, B is in the case (i)$_k$.

*Proof.* Take $k = x$. The fraction $a_x$ depends on both $y$ and $z$,
so by Lemma 16 the axis is not two-way on $S$, and it is not empty.

For the second statement let $\varsigma$ be the sign of the axis $x$ on
A, so that $\sigma_x = \varsigma (1 - a_y(z) - a_z(y))$ on A, and after
moving a constant $U_+(y) = -\varsigma\, a_z(y)$ up to a constant
$c_1$. The fraction $a_y$ of A depends on $z$ and vanishes on some
plane, so $F_+$ is constant, and $a_z$ depends on $y$ and vanishes on
some plane, so $F_-$ is constant. Write $f_+$ and $f_-$ for the two
constants. Then $\sigma_z = f_- + U_-(y)$ on A is a function $t(y)$
with $|t| = a_z$. Put $\nu_\pm(y) = \tfrac12 (a_z(y) \pm t(y))$, which
take the values 0 and $\tfrac12$ and have product zero.

By Lemma 15 the parts of $\sigma_y$ and $\sigma_z$ on B that depend on
$x$ are the constants $f_+$ and $f_-$. So on B the fraction $a_y$
depends on $z$ only and $a_z$ on $y$ only, and $p$ is constant on B.
By Lemma 13 B is in one of the cases (i)$_x$, (ii)$_y$ and (ii)$_z$.

Suppose B is in the case (ii)$_z$, so that $|\sigma_z| = \tfrac12$ on
every line of B. Substituting $U_+ = c_1 - \varsigma(\nu_+ + \nu_-)$
and $U_- = \nu_+ - \nu_- - f_-$ in Lemma 15 gives, on B,
$$\sigma_z = \nu_+(y + 1) - \nu_-(y - 1) \ \text{ if } \varsigma = 1,
\qquad \sigma_z = \nu_+(y - 1) - \nu_-(y + 1) \ \text{ if } \varsigma =
-1.$$
Take $\varsigma = 1$. For every odd $y$ exactly one of $\nu_+(y + 1)$
and $\nu_-(y - 1)$ is $\tfrac12$. Let $y_0$ be a plane of A with
$a_z(y_0) = 0$. Then $\nu_-(y_0) = 0$, so $\nu_+(y_0 + 2) = \tfrac12$.
If $\nu_+(y_0 + 2m) = \tfrac12$ then $\nu_-(y_0 + 2m) = 0$, and so
$\nu_+(y_0 + 2m + 2) = \tfrac12$. Going round the circle gives
$\nu_+(y_0) = \tfrac12$, which contradicts $a_z(y_0) = 0$. For
$\varsigma = -1$ the same argument runs in the other direction.

Suppose B is in the case (ii)$_y$, so that $|\sigma_y| = \tfrac12$ on
every line of B. Now $W_+(z) = -\varsigma\, a_y(z)$ up to a constant,
and $\sigma_y = f_+ + W_-(z)$ on A is a function $t'(z)$ with $|t'| =
a_y$. With $\nu'_\pm = \tfrac12 (a_y \pm t')$ Lemma 15 gives $\sigma_y =
\nu'_+(z - 1) - \nu'_-(z + 1)$ on B if $\varsigma = 1$ and $\nu'_+(z +
1) - \nu'_-(z - 1)$ if $\varsigma = -1$, and the argument round the
circle of the planes $z$, from a plane on which $a_y$ vanishes, gives
the same contradiction. $\square$

**Lemma 19 (two cases of the second kind with one axis).** If A and B
are both in the case (ii)$_k$, the axis $k$ is one-way.

*Proof.* Take $k = z$. On A the fractions $a_y$ and $a_x$ depend on
$z$ and each vanishes on some plane, so $F_+$ and $U_+$ are constant.
The same holds on B, so by Lemma 15 the functions $F_-(x - 1) - F_-(x
+ 1)$ and $U_-(y - 1) - U_-(y + 1)$ are constant, and then $F_-$ and
$U_-$ are constant. So $\sigma_z$ is a constant on A, of modulus
$\tfrac12$, and by Lemma 15 it is the same constant on B. $\square$

**Lemma 20 (two cases of the second kind with different axes).** On a
cell of the family no solution of the type model has $a_z = \tfrac12$
on every line of A in the direction $z$, $a_x = \tfrac12$ on every
line of B in the direction $x$, and a vertex of type $y$ on A. So if A
and B carry all three types and are both in cases of the second kind,
they are in the same case.

*Proof.* The second statement follows from the first by a permutation
of the coordinates, which maps the family to itself and carries any
two different axes to $z$ and $x$.

Number the classes $c_0 = (+,+,+)$, $c_1 = (+,-,-)$, $c_2 = (-,+,-)$
and $c_3 = (-,-,+)$. Each value $E^A_z(n, \sigma)$ is the value of
$E_z$ at the vertices of A of one class, the one with $\rho_y =
\sigma$ and $\rho_z$ given by $n$, and likewise each $E^A_y(n,
\sigma)$. For a class $c$ write $b^c_x(y, z) = E_z - E_y$ at its
vertices with those coordinates. Expand $b_x$ at a vertex $(x', y',
z')$ of B by the relation between the sublattices, and collect the
eight values of A by class. At a vertex of the class $(+,+,+)$ of B
this gives
$$2 b_x = b^{c_0}_x(y'{-}1, z'{-}1) - b^{c_1}_x(y'{+}1, z'{+}1) -
b^{c_2}_x(y'{-}1, z'{+}1) - b^{c_3}_x(y'{+}1, z'{-}1),$$
and at a vertex of the class $(-,+,-)$
$$2 b_x = -b^{c_0}_x(y'{-}1, z'{+}1) - b^{c_1}_x(y'{+}1, z'{-}1) +
b^{c_2}_x(y'{-}1, z'{-}1) - b^{c_3}_x(y'{+}1, z'{+}1).$$

On A every line in the direction $z$ alternates, so $q = p + 1$ are
constant, the fractions $a_x$ and $a_y$ depend on $z$, and each plane
$z$ of A has $a_x = \tfrac12$ and $a_y = 0$, or $a_x = 0$ and $a_y =
\tfrac12$. Call the planes of the first kind $Z_x$ and those of the
second $Z_y$. There is a vertex of type $y$, so $Z_y$ is not empty.
By the rule of parity $|b^c_x(y, z)|$ is $\tfrac12$ for $z$ in $Z_x$
and 0 for $z$ in $Z_y$. On a plane of $Z_x$ the fraction $a_y$
vanishes, so $E_x = E_z$ at its vertices, and in each class $E_z$ has
the same value on every plane of $Z_x$. So $b^c_x(y, z)$ does not
depend on $z$ in $Z_x$. On B every line in the direction $x$
alternates, so $|b_x| = \tfrac12$ at every vertex of B.

Two planes $z_0$ and $z_0 + 2$ cannot both be in $Z_y$, since at a
vertex of B with $z' = z_0 + 1$ every term of the expansion would
vanish. Take $z_0$ in $Z_y$. Then $z_0 - 2$ and $z_0 + 2$ are in
$Z_x$. They are congruent modulo 4, and two of the four classes have
vertices on them, $c_0$ and $c_3$ if they are multiples of 4 and $c_1$
and $c_2$ if not. Fix $y' \equiv 1$ modulo 4. The planes $z_0 - 1$ and
$z_0 + 1$ of B have opposite $\rho_z$, so with this $y'$ one has
vertices of the class $(+,+,+)$ and the other of the class $(-,+,-)$.
In each of the two expansions the two terms on the plane $z_0$ vanish,
and the two others are the same two numbers $u$ and $u'$ in both, each
$\pm\tfrac12$, since $b^c_x$ does not depend on the plane of $Z_x$.
They enter one expansion with the same sign and the other with
opposite signs. So $|u + u'| = 1$ and $|u - u'| = 1$, which is
impossible. $\square$

**Theorem 23.** On a cell $(2a', 2b', 2c')$ with $a'$, $b'$ and $c'$
pairwise coprime, every odd frozen state has an axis that is empty or
one-way. If all three types occur, both sublattices are in the same
one of the six cases of Lemma 13, and the axis of that case is
one-way.

*Proof.* Suppose all three types occur. Both sublattices carry all
three, and each is in one of the six cases. If A is in a case
(i)$_k$, so is B, by Lemma 18, the axis $k$ is one-way on each, and
by Lemma 17 it is one-way. If B is in a case (i)$_k$ the inversion,
which exchanges the sublattices and preserves the cases, gives the
same. Otherwise both are in cases of the second kind, of the same
axis by Lemma 20, and Lemma 19 applies. $\square$

**Corollary.** On these cells every frozen zero-flux state is
invariant under a nonzero translation.

*Proof.* A state with even curl has a one-cube period by Theorem P. In
a zero-flux state each axis has as many moments of one sign as of the
other on each sublattice, so an axis that is one-way is empty. An odd
state has therefore an empty axis, and Lemma A applies. $\square$

The proof of Theorem 23 uses Theorem 22, Theorem $M'$, Theorem 20,
Theorems 17 and 19 and Lemma 4. It does not use $K_u$, Theorem 1, the
walls or the diagonal law. The types enter through the six cases and
through Lemma 20, and the signs through Lemmas 14 to 19. Two
statements that hold in every state examined are not proved. In a
case of the second kind all three axes were one-way in each of 112
sampled states, and the theorem gives one. And the two sublattices
have the same case already in the type model, by solver, while the
proof above uses the signs for the cases of the first kind.

## Checks

Theorems 20 to 22 were found and proved by one agent of the project,
and Lemmas 13 to 20 with Theorem 23 by another. The main session
recomputed both proofs from the definitions. Two separate agents then
read them as checkers, each with its own programs, and found no gap.
The first corrected the account of the other positions of the cage,
which had named a reflection that is not a symmetry of the lattice,
and the text above has the correction. The second wrote out in full
the two parts of Lemmas 18 and 20 that are given here by reference to
a parallel argument, and removed steps that the proofs did not need.

Theorem 20 and its consequences hold exactly on 164 sampled solutions
of $(2,2,2)$, $(2,4,6)$ and $(4,6,10)$, and the tests fail when a sign
is deliberately changed. The identity ($\star$) holds as an identity
of linear forms in the weights on five cells. The case of Theorem 21
in which no plane is integral cannot occur together with the
bridgeheads, so it was tested by an enumeration of the values of the
functions $E$ that it allows, which found no exception to either
conclusion. In the type model the cage with a vertex of the type of
the rods on the other sublattice is unsatisfiable on four cells in all
eight positions and for all three axes, with every control
satisfiable.

On 784 odd states of seven cells of the family Lemmas 14, 15 and 17
hold exactly, and the second statement of Theorem 23 holds on each of
the 574 of them that have all three types, 462 in a case of the first
kind and 112 in one of the second. The hypotheses of Lemma 20 are
unsatisfiable in the type model for all six ordered pairs of axes on
five cells, with satisfiable controls. A search by solver for an odd
state with three types in which the sets of constant profiles differ
on the two sublattices found none on four cells.

# A state repeated periodically, and the cubic cells of side one to three

**Lemma 21.** A frozen state of the cell $(a, b, c)$, repeated
periodically, is a frozen state of the cell $(k_1 a, k_2 b, k_3 c)$
for any positive integers $k_1$, $k_2$, $k_3$. It has an odd hexagon
exactly when the original has, and the same set of moments. So Theorem
H on the larger cell implies Theorem H on the smaller.

*Proof.* The projection of the larger cell onto the smaller carries
bonds to bonds of the same direction, so the repeated state obeys the
ice rule. A hexagon is a closed walk of six bonds with no displacement
on the lattice, so the projection carries the hexagons of the larger
cell to those of the smaller, with the same directions in the same
order. A hexagon of the repeated state therefore circulates exactly
when its projection does, and has the curl of its projection. Every
hexagon of the smaller cell is a projection. The moment at a vertex is
that at its projection. An odd frozen state of the smaller cell with
every axis two-way would give one of the larger. $\square$

**Theorem 24.** Theorem H holds on the cubic cells of side one, two
and three.

*Proof.* By Lemma 21 and Theorem 2 at side six. $\square$

Side two is also a case of Theorem 23. The lemma gives nothing towards
a proof by hand on a cubic cell. Every cell that the cubic cell of
side $L$ repeats to has extents that are multiples of $L$, so it has
at least $L$ chains in every pair of planes, and none has a coprime
pair. It also gives nothing beyond the certificates, and the cubic
cells of side seven and more need something else.

The lemma was checked exactly on saved states. The hexagons of
$(6,6,6)$ project to hexagons of $(3,3,3)$ with the same axis at each
vertex, and for each of 686 states of $(3,3,3)$ the repeated state has
(T2) on every hexagon, eight times as many odd hexagons, the repeated
sign field, and the same axes empty, one-way and two-way. The same
holds for 54 states of $(2,2,2)$ repeated to $(4,4,4)$ and 25 repeated
to $(6,6,6)$.

# Three chains in every pair of planes

On the cells $(3a', 3b', 3c')$ with $a'$, $b'$ and $c'$ pairwise
coprime, among them $(3,3,3)$, $(3,3,6)$ and $(6,9,15)$, every pair of
planes holds three chains of each family. The method of the last
section does not prove statement (V) on them. This section records how
far it goes. It reports the work of one agent of the project. The main
session ran its programs again and did not recompute its proofs, and
no checker has read them. The proofs are in the report named under
Artefacts and are not reproduced here.

The description of a solution goes over. The three chains of a pair
of planes are told apart by a label modulo 3, and the weight of a
chain is the mean of its pair of planes and a complex number
multiplied by a power of $\omega = e^{2\pi i/3}$. Along a line in the
direction $k$ the indicator of the type $k$ is
$$K_k = a_k + 2\,\mathrm{Re}\,[\omega^s \beta_k],$$
where $s$ is $(x + y + z)/4$ on A and advances by one at each step,
and $a_k$ and $\beta_k$ are functions of the two transverse
coordinates. A line has period 3 and carries one of the eight patterns
of three values 0 and 1. Its fraction $a_k$ is 0, $\tfrac13$,
$\tfrac23$ or 1, and $3\beta_k$ is 0 or one of the six units of the
ring $\mathbb{Z}[\omega]$. The rule of parity becomes a rule of
colour: $3\beta_k$ is congruent to $3a_k$ modulo $1 - \omega$, where
the quotient of the ring by $1 - \omega$ is the field of three
elements. There are integer profiles with $3a_y = p(x) - r(z)$, $3a_z
= q(y) - p(x)$ and $3a_x = 3 + r(z) - q(y)$, and the three spreads and
three gaps add to 3. The data of B are those of A moved by one plane,
with a factor $\omega$ on three of the six families. All of this holds
exactly on 776 sampled solutions of three cells.

Of the five steps of the proof of Theorem 21, three go over in a
changed form. When the line of the rods is full, the profile $p$ of A
is constant, and the lines through the rods leave one real number
$\tau(x)$ free on each plane $x$ of A. The identity of the bridgeheads
becomes
$$p^B(1) - p^B(3) = 3 - 6\,\Sigma(0), \qquad \Sigma(0) = \tau(0) +
\tau(2) + \tau(4),$$
with a sum over three consecutive planes, one of each class, in place
of a difference within one class. If $\Sigma(0) = 0$ the conclusions
of Theorem 21 follow. If some plane of A of a class other than that
of the rods has an integral fraction, a sum over the three classes
gives $\Sigma(0) = 0$. In every case $\Sigma(0)$ is 0 or $\tfrac13$.

Two steps fail, and each leaves a statement that is true by solver on
the six cells tried and is not proved.

**Statement R.** Two rods of type $x$ four apart, a lower bridgehead
of type $y$ and the upper bridgehead on the other side not of type
$y$ make the whole line of the rods of type $x$.

At two chains the line has period 2 and the two rods fill it. At three
it has period 3, the rods fix two positions of three, and the rods
alone do not force the third.

**Statement S.** If the line of the rods is full, then $\Sigma(0) =
0$.

At two chains the corresponding case was closed by a count: all three
profiles of B would be non-constant, and their spreads add to at most
2. At three chains the spreads add to at most 3, and three spreads of
1 are allowed. The rule of colour gives three different residues for
$p^B(1)$, $p^B(3)$ and $p^B(5)$ and no bound on the spreads of the
two other profiles.

Neither statement follows from the linear programme. Each follows
from it when a few lines are required to be integral, one line for R
and four for S, and the linear parts are then certificates for each
cell, of 20 to 47 rows, in which no structure was found. The one for
S needs fifteen layers along the rod axis and the whole transverse
torus. With both statements, (V) holds on these cells in every
position of the cage. Theorem H would need $K_u$ in addition, or a
counterpart of Theorem 23, and neither was attempted.

The method used that a function on three points with values 0 and 1
has one complex coefficient apart from its mean. With five chains or
more a line has several, and the condition that its values are 0 and
1 couples them, so the rule of colour has no counterpart of the same
kind. The work gives no sign that the method of the last section
reaches the cubic cells of general side.

# Theorem U

Theorem U is proved on the cells with a coprime pair of extents and on
the cells with two chains in every pair of planes, and it is certified
on the cubic cells of side four to eight and on the cells $(3,3,9)$,
$(4,4,8)$, $(3,3,12)$ and $(6,6,9)$. On every other cell it
is open, and since 30 September 2026 it is the one open statement
between the record and Theorem H, and the periodicity of frozen
zero-flux states, on every cell (Theorem 1). This section and the next
are about those cells. They were written before the sections on the
two families, and they record what computation has found about the
statement and which routes it has closed.

The statement has several forms, equivalent in a frozen state by the
results above.

1. An odd state has no charged hole.
2. In an odd state two consecutive vertices of type $k$ on a $k$-line
   have the same sign.
3. A state with an unoriented cage has even curl.
4. (V) In a state with the four vertices of Theorem $U'$, the
   sublattice of the bridgeheads has no vertex of type $k$. Even curl
   then follows from Theorem $M'$.

The solver decides it in seconds, 0.2 s at side three and 22 s at side
six, and the pattern forces a great deal. Every vertex of the other
sublattice is forced not to be of type $k$, the line of the two rods is
forced to be entirely of type $k$, and the two planes of bridgeheads
normal to $k$ on either side of the hole are forced to be entirely of
type $a$ and entirely of type $b$. States with even curl and unoriented
holes exist, among them states with all six directions. In them the
unoriented holes sit in pairs of opposite charge on complete lines of
rods.

The following facts were established by computation on the cells named
in the reports, and each closes a route to a proof.

1. On the cubic cell, with (T2) imposed only on the hexagons within $R$
   layers of the hole along the rod axis, the pattern forces nothing
   until $R = 2L - 2$ of the $2L$ available, and the transverse torus
   is needed in full. No ball, tube, slab or box short of these
   suffices. The deletion-minimal sets of hexagons contain only a fifth
   to a third of the lattice, but they meet every plane in every
   direction. This does not mean that the statement needs the circle
   of the rod axis, and the symmetric window is not the smallest. On a
   cell with extents $(a, b, c)$ and the rod axis of length $a$, put $g
   = \gcd(b, c)$. For $g \geq 4$ the smallest windows of layers $[-p,
   q]$ about the hole that force the conclusion are $(p, q) = (3, 2g +
   1)$, $(2g - 2, 2g - 2)$ and $(2g + 1, 3)$, whatever the value of
   $a$. For $g \leq 2$ the window $(3, 3)$ suffices, and at $g = 3$ the
   smallest are $(3, 7)$, $(4, 5)$ and their reflections. The cubic
   cell has $g = L$, so there the symmetric threshold $2L - 2$ looks
   like most of the circle, but the window $(3, 2L + 1)$, which is $2L
   + 5$ of the $4L$ grids, suffices at side five, six and seven. So (V)
   is a statement about a slab of $2g + 5$ grids over the closed
   transverse torus, and no window in the transverse directions
   suffices on any cell tried: removing the hexagons through a single
   transverse grid leaves the negation satisfiable. (Added on 27
   September 2026 after the note was first issued. Solver, on twenty
   transverse tori with $g$ from 1 to 8, confirmed by an independent
   checker with its own implementation, with and without the sign
   field. The corners at side four and five are in the report of 22
   September on the core of (V), and the dependence on $g$ was found on
   16 and 17 September for an earlier form of the statement.)
2. The next cage along the line of the rods is forced to be straight
   and its bridgeheads are free. No other hole of either sublattice is
   forced to be oriented or to be unoriented. Charges are neutral on
   every plane of holes, which is the flux identity, so an unoriented
   hole has partners, and none of them is determined.
3. When the types are relaxed to non-negative reals subject to the
   linear equations, the largest possible amount of type $k$ on the
   plane of bridgeheads is $26/3$, $178/9$ and $299/9$ at side three,
   four and five. The cage laws span the linear consequences of (T2),
   so no weighted sum of laws proves the theorem on these cells. Adding
   the signs, the bond rule and Lemma 3 lowers these numbers by less
   than one. On cells whose two transverse extents are coprime the
   largest amount is zero, on every such cell tried, so there (V) does
   follow from a weighted sum of laws, and the first case that needs
   more is $g = 2$. The weighted sum needs more room than the solver
   does. On a long rod axis it needs a slab that grows with the torus,
   of 3, 7, 9 and 13 layers either side for the tori $(3,4)$, $(4,5)$,
   $(5,6)$ and $(7,8)$, and on a short one it uses the circle of the
   rod axis. (Added on 27 September 2026. Computed in floating point by two
   implementations, and verified in exact arithmetic by the independent
   checker on the cells $(6,3,4)$, $(6,4,5)$ and $(2,4,5)$.)
4. Every window that fails without the sign field fails with it.
5. With the indicators of one type on one sublattice required to be 0
   or 1 and everything else relaxed, the optimum is zero. At side three
   the charges of the holes of one sublattice suffice. A case split on
   six vertices at side three, and on nine at side four, leaves linear
   programmes that are all infeasible.
6. If the line law at gap one is assumed as an axiom, the reach along
   the rod axis falls from $2L - 2$ to $2\lceil L/3 \rceil + 1$. The
   proofs of the line laws given here assume orientation, so this is
   circular.
7. The obstruction is the closure of a sheet, and no quantity that
   has been tried carries it. One grid short of the window
   $(3, 2g + 1)$ the negation of (V), in its four-literal form, has
   exactly two solutions for the set of vertices of type $x$, at
   every $g$ from 3 to 7, given by one formula in the labels of the
   chains of axis $x$ modulo $4g$: a sheet on a plane normal to a bond
   direction through the rod, advancing one chain label per cube,
   with two defects that ride on a chain of axis $y$ and a chain of
   axis $z$. The two solutions are the two senses of the advance. On
   every shorter window the solutions are many and dense, and no
   Fourier coefficient of the types on the chain labels, no count on
   the chains or on their cells and no winding of the set of type $x$
   is defined on all of them, or constrained on those on which it is
   defined; the only exact relations between grids are linear laws.
   Opening the transverse torus does not remove $g$: on a cylinder
   the reach is set by the number of chain labels of the circle that
   is left closed, and on the plane the statement is false. On a
   window the integer solutions of the negation span an affine space
   much smaller than the real solutions, of dimension 90 against 210,
   152 against 333 and 234 against 484 on the cells $(12,4,4)$,
   $(12,5,5)$ and $(12,6,6)$ with the windows $[-3, 2g - 2]$, cut out
   by variables that are fixed in every solution and by equations
   between two variables, which depend on the window. (Added on 30
   September 2026. Solver and exact computation by two agents on 28
   and 29 September, a sample run again by the main session; no
   independent checker.)
8. Three facts of 30 September 2026, each by solver with controls, a
   sample run again by the main session. First, the zero-flux sector
   does not shorten the statement: with $W = 0$ imposed on the torus
   the least one-sided window that forces (V) is $[-3, 2g]$ in place
   of $[-3, 2g + 1]$ at $g = 4$, 5 and 6, so the sector removes exactly
   the grid of the two rigid solutions of item 7, which carry flux,
   and nothing more. Second, the statement that the two rods fill
   their whole line (Statement R of the section on three chains) has
   on the torus exactly the reach of (V), one-sided $\max(6, 2g + 1)$
   and symmetric $\max(6, 2g - 2)$, and follows from (V) in two lines
   (Lemma 6 and law $P^x$); but it is strictly weaker, since it
   survives the removal of a transverse grid along one axis, where (V)
   does not, and its first step, that the third rod position is of
   the type of the rods, is forced inside a box over one closed
   transverse circle, $x \in [-3, 2b + 1]$ and $|z| \leq 2b - 1$ with
   the $y$-circle of the cell $(a, b, c)$ whole, whatever $a$, $c$ and
   $\gcd(b, c)$; DRAT certificates of this box lemma exist for $b = 3$
   to 6. Third, in the heights of (C) the statement R has no linear
   content: the difference $h_y - h_z$ at the $j$th position of the
   line depends on $j$ only through $j$ modulo $\gcd(a, c)$ and
   modulo $\gcd(a, b)$, so on a cubic cell the parametrisation relates
   no two positions, which is the feasible linear programme of the
   section on three chains said in another language; R, like (V), is
   an integrality statement. A correction to the record made the same
   day: the weights of (C) can be taken integral on 19 of the 637 odd
   states of the cubic cell of side three and 20 of the 720 of side
   four, and on none of 60 sampled solutions of the type model, with
   least denominators from 27 to 96 otherwise; the report of 10
   September that says they can be taken integral "on every state
   examined" had examined those 19.
9. Facts of 1 October 2026, each by solver with controls or by exact
   computation, a sample run again by the main session, which close
   the plan that item 8 suggested (Statement R first, then a
   monodromy in the weights of (C) along the rod axis, then an
   integrality step). First, Statement R assumed on the whole rod line
   shortens the one-sided reach of (V) from $2g + 1$ to $2g - 1$ on
   five cells with $g$ from 4 to 8, and the single literal that the
   third rod position is of type $k$ gives the same $2g - 1$ on every
   cell: R contributes nothing else inside a window, and (V) given R
   is false on the cylinder with a transverse grid removed along
   either axis, so R supplies neither transverse circle. One grid
   short of the threshold the solutions of the negation given R are
   many and are not label classes of either family of chains of the
   rod axis. Second, on the grid of the bridgeheads of every cell
   whose two transverse extents divide the extent along the rod axis,
   every cubic cell among them, each chain of the two transverse axes
   meets the grid once, and the parametrisation (C) restricted to the
   grid is onto: it imposes no linear condition on the type of the
   rods' axis on a grid, the pair of labels of the two transverse
   chains through a vertex of the grid is never a product on any
   cell, and Lemma 8 has nothing to act on. Third, the weights of (C)
   seen from successive grids along the rod axis are sheared by one
   label per cube and return after the least common multiple of
   $\gcd(a, c)$ and $\gcd(a, b)$ cubes, which is 4 on $(12, 8, 8)$,
   where (V) given R needs 15 grids; so the $g$ of the reach law is
   the modulus of the labels $y - z$ and $y + z$ of the chains of the
   rod axis on the grids normal to it, and no monodromy in the weights
   of (C) along the rod axis is the mechanism on every cell. Any proof
   of U must be integral from the first line, and the integral object
   is the set of those labels, of both families, on each pair of
   grids. Fourth, Theorem 9's method applied to the box lemma of
   Statement R: the box lemma has no linear content, every integral
   family of vertices that closes its linear programme at one $b$
   fails at the next for $b = 3$ to 5, and the exact certificates of
   its branches are of two kinds, local ones that are identical for
   every $b$ and are finite lemmas on two cages, and global ones that
   use the whole closed circle and grow with $b$, in which no rule was
   found. Fifth, the search of this date for a counterexample to U on
   the cheapest open cells, recorded in the section on the cubic
   cells, found none, with no near miss.

Theorem U belongs to a family of statements of the project in which a
pattern on a few vertices forces a complete plane. One member of the
family has a proof, Theorem $M'$ with the sheet theorem behind it, and
that proof is two integrations round the transverse torus followed by
the integrality step of Lemma 4.

# Ideas for Theorem U

This section is of 27 September 2026 and is kept as it was written,
apart from the notes of later dates that it carries. None of the ideas
after the first subsection has been tried unless it says so. The first
subsection led to the three sections on the cells with a coprime pair,
on the signed moments and on the cells with two chains. Those sections
did not come from the ideas that follow it. They came from looking for
quantities that the geometry makes separable, and not for certificates
or case splits. The second idea, an induction in the number of chains,
is what the section on three chains tried, and it stops there.

## Cells that are not cubic

This subsection was the first to separate the length of the rod axis
from the size of the transverse torus. Theorem 14 has since settled
Theorem H on every cell with a coprime pair of extents, and Theorem 23
on the cells with two chains in every pair of planes, so what this
subsection says about Theorem H on the easier members is superseded.
Theorems 10 and 11 and their proofs stand. Theorem 11 reaches holes of
cells that neither of the two later theorems covers, such as those of
$(15, 6, 10)$ with rods along the first axis.
The cubic cell of side $L$ is the member $g = L$ of a family of cells
$(a, b, c)$ indexed by $g = \gcd(b, c)$, and in that member the height
of the slab, the number of parallel chains in a layer and the depth of
the case split all grow together. The family has easier members. At $g
= 1$ the statement is linear and is proved below. At $g = 2$ the
statement needs integrality and lives on seven layers, on tori of any
size. The relative W$_r$ of the fifth idea
below is not of this kind: its reach along the normal of its plane is
twice the extent of the cell along the axis of the type of its
bridgeheads, with no dependence on a greatest common divisor, so it has
no easier members. The induction of the second idea is then
an induction on $g$ and not along a line of holes. A state on a cubic
cell lifts only to cells whose extents are multiples of $L$, so a proof
on the easier members does not give the cubic cell directly. The measurements and an assessment of each idea below are in the report
named under Artefacts.

The reduction itself does not need the cell to be cubic. An audit of
every step on the cell $(a, b, c)$ found that Theorem 1 holds whenever
$K_u$ holds for uniform chains of all three axes. A second reader
confirmed this, and corrected the audit's conclusion that the recorded
scope of $K_u$ gives it when each extent is at least four: as the
first section says, the certificates give $K_u$ for
chains of an axis only when the two transverse extents have greatest
common divisor at most two. The proofs of
this note go through with two changes of wording: in Theorem 5 the sum
is over the $a_k$ holes of a line, and a chain of axis $k$ has four
times the least common multiple of the two other extents as its number
of vertices. In the proof of Theorem $M'$ the step that says a band of
edges meets a plane of kinks exactly once is true only when the two
transverse extents are equal, and what the proof uses is that it meets
the plane at least once, which holds on every cell. The scope of $K_u$
is not symmetric: its three is the extent along the axis of the chain,
and the wall of Theorem 7 fixes that axis, so cells with an extent of
three are not covered. On a cell whose three extents are pairwise
coprime no frozen state is odd, by Theorem R1 of the project's reports,
and Theorem H holds there with no conjecture. (Audit by an agent, with
solver checks on nine cells, a sample of them run again by the main
loop, and read by a second agent, which confirmed Theorem $M'$ on
every cell by both of its proofs and prefers the one that does not
count crossings.)

**Theorem 10 (the coprime case; added on 27 September 2026).** On a
cell with extents $(a, b, c)$ and $\gcd(b, c) = 1$, a frozen state with
an unoriented hole whose rods lie along $x$ has even curl. So in an odd
state of such a cell every hole with rods along $x$ is oriented.

The proof uses the parametrisation of the project's working note,
proved there for every cell. Attach a real weight $f(C)$ to every chain
$C$, and for a vertex $v$ and an axis $k$ let $F_k(v)$ be the sum of the
weights of the two chains of axis $k$ through $v$. Then every real
solution of the one-hot equations and of (T2), and in particular the
indicators $Y = [\tau = y]$ and $Z = [\tau = z]$ of a frozen state, has
the form
$$Y(v) = F_x(v) - F_z(v) + \sigma_v \alpha, \qquad Z(v) = F_y(v) -
F_x(v) + \sigma_v \beta,$$
with $\sigma_v = \pm 1$ on A and B and constants $\alpha$, $\beta$. A
chain of axis $x$ lies in two neighbouring planes $x = $ const, its
vertices of one sublattice are $p + n(0, 2, \pm 2)$, and it closes after
$2bc/g$ steps, so each such pair of planes holds $g$ chains of its
family. When $g = 1$ it holds one, and $F_x(v) = \Phi(x_v)$ depends only
on the plane of $v$.

*Proof.* Let the hole be $O$, with rods $v = O - 2e_x$ and $v' = O +
2e_x$ of type $x$, lower bridgeheads $\beta = v + d_0$ and $\beta' = v
+ d_1$ of type $y$, and upper bridgeheads $\gamma = v' + d_2$ and
$\gamma' = v' + d_3$ of type $z$, which is the unoriented cage up to
the symmetries that fix the axis $x$. Write $\Phi(n)$ for $\Phi$ on the
plane $x = x_O + n$. The chains of axis $z$ are those of the pairs of
directions $\{d_0, d_3\}$ and $\{d_1, d_2\}$. The vertex $\beta$ lies
on the first through $v$ and $\gamma'$ on the first through $v'$, and
$\beta$ and $\gamma'$ lie on one chain of the second kind, through $O +
2e_z$. Likewise $\beta'$ and $\gamma$ lie on the chains of the second
kind through $v$ and $v'$ and share one of the first kind, through $O -
2e_z$. Subtracting the formula for $Y$ at $\gamma'$ from that at
$\beta$, and at $\gamma$ from that at $\beta'$, and adding,
$$2 = 2\bigl(\Phi(-1) - \Phi(1)\bigr) - \bigl(F_z(v) - F_z(v')\bigr).$$
The rods have $Y = 0$, so $F_z(v) - F_z(v') = \Phi(-2) - \Phi(2)$, and
$$\Phi(-1) - \Phi(1) = 1 + \tfrac12 \bigl(\Phi(-2) - \Phi(2)\bigr).$$
Now choose an integer $m$ with $\gcd(a, b) \mid m$ and $\gcd(a, c) \mid
m + 1$, which exists because the two divisors are coprime, and put $P =
v' + 4me_x$. The vertices of A on the chains of axis $z$ through $v'$
are $v' + n(2, \pm 2, 0)$, and $P$ is among them, for both signs,
exactly when $\gcd(a, b)$ divides $m$. In the same way $P = v + 4(m +
1)e_x$ lies on both chains of axis $y$ through $v$. So $F_z(P) =
F_z(v')$ and $F_y(P) = F_y(v)$, and since $Y(v') = Z(v) = 0$,
$$Y(P) + Z(P) = \bigl(\Phi(x_P) - \Phi(2)\bigr) + \bigl(\Phi(-2) -
\Phi(x_P)\bigr) = \Phi(-2) - \Phi(2).$$
Finally add the formula for $Y$ over a plane of B. A chain of axis $z$
advances by 2 in $x$ at every step and closes after a multiple of $2a$
steps, so it meets every plane of B equally often, and the sum of $F_z$
over a plane of B is the same for every such plane. With $N = 2bc$ the
number of vertices of a plane and $n_y(n)$ the number of type $y$ on the
plane $x_O + n$,
$$n_y(-1) - n_y(1) = N\bigl(\Phi(-1) - \Phi(1)\bigr) = N + \tfrac N2
\bigl(Y(P) + Z(P)\bigr) \geq N.$$
Since $n_y(-1) \leq N$ and $n_y(1) \geq 0$, the plane of the lower
bridgeheads is entirely of type $y$. This is (V). By Lemma 6 sublattice
B has no vertex of type $x$, A has one, and Theorem $M'$ gives even
curl. $\square$

The argument is linear. It uses that the types are non-negative and sum
to one, and not that they are integers, which is the content of the
third item of the list above for these cells. It goes once round the
circle of the rod axis, through the vertex $P$ and through the sums over
planes, so it is a proof on the torus and says nothing about a slab. It
proves Theorem U for the holes of one axis at a time. All the holes of
a cell are covered only when the three extents are pairwise coprime,
where there are no odd states at all, so the theorem gives no new case
of Theorem H. It is the first statement of this class with a proof. The
identity behind it, that the number of vertices not of type $y$ on the
lower plane, plus the number of type $y$ on the upper plane, plus
$\tfrac N2 (Y(P) + Z(P))$, is zero, was verified in exact arithmetic on
thirty-five cells by the agent that found it and by an independent checker
with its own implementation, which also read the proof and confirmed
it. At $g = 2$ the same identity fails for every choice of $P$.

**Theorem 11 (greatest common divisor two, odd length; added on 27
September 2026).** On a cell with extents $(a, b, c)$, $\gcd(b, c) = 2$
and $a$ odd, a frozen state with an unoriented hole whose rods lie
along $x$ has even curl.

At $g = 2$ a pair of neighbouring planes holds two chains of axis $x$
of its family, and $F_x$ is no longer a function of the plane. Since
$b$ and $c$ are even, the periods $4b$ and $4c$ are multiples of 8, so
$y - z$ and $y + z$ are defined modulo 8 on the cell. A chain of the
family $\{d_0, d_1\}$ has steps $(0, 2, 2)$ and constant $y - z$, and
one of the family $\{d_2, d_3\}$ has steps $(0, 2, -2)$ and constant $y
+ z$. On a plane the residue takes two values, exchanged by the
translation $(0, 4, 0)$, so each residue class has $bc$ vertices, which
is the length of a chain. The two chains of a pair of planes are
therefore the two residue classes.

*Proof.* Notation as in Theorem 10, with $O = (2, 0, 0)$. Let $A_0$ be
the chain of $\{d_0, d_1\}$ through $v$. It contains $\beta$ and
$\beta'$, and its vertices on the plane $x = 1$ are the half $H_1$ of
that plane with $y - z \equiv 0$. Let $B_3$ be the chain of $\{d_2,
d_3\}$ through $v'$. It contains $\gamma$ and $\gamma'$, and meets the
plane $x = 3$ in the half $H_3$ with $y + z \equiv 0$. The other chains
of axis $x$ through $\beta$ and $\beta'$ are the two chains of the
planes 1 and 2, with $y + z \equiv 2$ and 6, and those through $\gamma$
and $\gamma'$ are the two chains of the planes 2 and 3. Write $S_1$ and
$S_2$ for the sums of the weights of these two pairs. The first step of
the proof of Theorem 10 now reads
$$2\bigl(f(A_0) - f(B_3)\bigr) + S_1 - S_2 = 2 + D, \qquad D = F_x(v) -
F_x(v'),$$
and the second, in which the weights of the chains of axis $x$ through
$P$ cancel, gives $D = Y(P) + Z(P)$ unchanged. Here $\gcd(a, b)$ and
$\gcd(a, c)$ are odd and coprime, because $a$ is odd and $\gcd(b, c) =
2$, so $P$ exists.

Two counts are needed. Each of the two chains of the planes 1 and 2
has its vertices of the plane 1 alternately in $H_1$ and outside it,
because a step changes $y - z$ by 4, and it has an even number $bc$ of
them, so half lie in $H_1$. And a chain of axis $y$ or $z$ has as many
vertices in $H_1$ as in the other half of the plane $x = 1$. For a
chain of axis $z$ the vertices of B are $u + n(2, \pm 2, 0)$, those on
one plane are $2a$ steps apart, and there are $b / \gcd(a, b)$ of them,
an even number. Between consecutive ones $y$ changes by $4a$, which is
$4$ modulo 8 because $a$ is odd, so they lie alternately in the two
halves. The same holds for a chain of axis $y$, with $c$ and $z$, and
on the plane $x = 3$ with $H_3$.

Adding the formula for $Y$ over $H_1$ and over $H_3$, the sums of $F_z$
are half of the sums over the planes, which are equal, and
$$\sum_{H_1} Y - \sum_{H_3} Y = \tfrac N4 \Bigl[ 2\bigl(f(A_0) -
f(B_3)\bigr) + S_1 - S_2 \Bigr] = \tfrac N2 + \tfrac N4 \bigl(Y(P) +
Z(P)\bigr).$$
Since $H_1$ has $N/2$ vertices, every vertex of $H_1$ is of type $y$.
On B the indicator of type $x$ is $1 - Y - Z = 1 - F_y + F_z + \alpha +
\beta$, in which $F_x$ does not occur, so by the second count the
number of vertices of type $x$ on the plane $x = 1$ is twice the number
in $H_1$, which is zero. By Lemma 6 sublattice B has no vertex of type
$x$, and Theorem $M'$ gives even curl. $\square$

The parity of $a$ enters through the second count. In general the
difference between the two halves of a plane, for the chains of axis
$y$ and $z$, changes sign from a plane to the next plane of the same
kind, four layers on, so round the circle it is multiplied by $(-1)^a$
and vanishes when $a$ is odd. When $a$ is even it survives, the vertex
$P$ does not exist, and the relaxation to real types has solutions with
type $x$ on the lower plane, on the whole cell and on every slab. The
proof gives less than (V): the other half of the lower plane is not
forced to be of type $y$ by any weighted sum of laws. The theorem was
found by an agent, read by the main loop, and confirmed by an
independent checker, and its identity was verified in exact arithmetic
on thirty-three cells by two implementations. At $g = 3$ and 4 with $a$
odd, and at $g = 2$ with $a$ even, the relaxation has solutions and
integrality is needed. No integral statement that would replace the
second count has been found. The obvious one, that the vertices of
type $x$ of a plane are divided equally between its halves, is false in
frozen states with $a$ even.

Theorems 10 and 11 together give Theorem U for every hole of a cell in
which one extent is odd and coprime to the other two, and those two are
even with greatest common divisor two. On the cell $(5, 4, 6)$ of this
kind, however, no odd state has a vertex of type $x$ (solver, by a
split into five cases), so every odd state lacks a type and Theorem H
holds for it without any argument. The
two theorems are proofs of statements of the class of (V), and they
give no case of Theorem H that needed them. Theorem H on these cells
has a shorter proof. When two of the three pairs of extents are
coprime, Theorem R1 puts the two rods of every corner on a chain of
the third axis, so every corner has that axis as the one it does not
use. The project's Theorem C of 24 September, which holds on every
cell with the length of a chain in place of $4L$, then makes the rods
of the trail of corners two complete uniform chains, and $K_u$ for
chains of that one axis gives a missing direction. This needs $K_u$
where its certificates reach, that is, when the third pair of extents
has greatest common divisor at most two.

## A closed form for the branch certificates

The diagonal law stood
as a family of machine-found certificates, one for each separation,
until the dual solutions were made canonical, by minimising the $L^1$
norm and imposing the symmetries of the pair, and the multipliers
tabulated against the local position of each equation relative to the
diamond. The closed form of Theorem 9 then had four rules. Reading the
raw certificates had found nothing. The corresponding objects exist for
Theorem U, where after a case split on a few vertices every branch is
an infeasible linear programme. The differences are that the support is
the whole torus, so the closed form would be written in terms of $L$
and of position relative to the planes through the hole, and that the
number of branches grows with $L$. The first computation is to find the
thinnest family of indicators whose integrality closes the programme
at sides four, five and six, as was done for a neighbouring statement
where one line of $2L$ indicators suffices and the split at side four
is on a single vertex. The second is to make the branch certificates
canonical and tabulate them. A family of certificates whose multipliers
depend only on a bounded signature would be a proof.

## An induction along one line

For a $k$-free
plane with a hole whose bridgeheads disagree, Theorem 5 turns
repetition into the conclusion. If the disagreement recurs at every
hole of one line of holes, two neighbouring lines of the other
sublattice have counts $L$ and 0, separability forces two complete
planes, and Lemma 6 and Theorem $M'$ finish. The step from one hole of
the line to the next is an identity from $P^k$, and it fails only if
one named vertex has type $k$. That vertex is not locally controlled,
so the induction is not local. It does give the case split its shape,
one vertex for each step along the line, and suggests that the branches
of the first idea should be ordered along that line.

## Corners and charges as two kinds of defect

A corner is a hole where a loop of rods turns,
and a charged hole is one where its direction reverses. Theorem U says
that no frozen state has both. The two live on the same lattice of
holes, the charges on its vertices and the odd hexagons on its edges,
and every linear relation between them is excluded by the computations
above. An identity that is quadratic in the indicators, a product of a
count of corners and a count of charges, is not excluded, and the fact
that integrality of one family suffices is what such an identity would
look like to a linear programme. One experiment is to relax the two
indicators separately and find the largest product of the two counts
that the relaxation allows on small cells.

## The weaker statement that the reduction needs

Theorem 1 uses orientation at every
hole, but it is applied only to states in which all three axes are
two-way. It would be enough to prove Theorem U for those. The extra
hypothesis is a disjunction over the torus and is unlikely to shorten
any window, but it changes the target. In the structure that the
unoriented cage forces, one sublattice has no vertex of type $k$, so
both signs of $k$ must occur on the other. Whether the forced structure
is compatible with both signs of all three axes is a finite question on
each cell and has not been asked.

This idea is withdrawn (27 September 2026). Given Theorem 1 and $K_u$,
the statement restricted to states with three two-way axes is
equivalent to Theorem H, because H says that no odd state satisfies its
hypothesis, so it is no easier than H. The question in the last
sentence is also answered by the section on Theorem U, which records
that states of even curl with unoriented holes and all six directions
exist.

## The relatives without oddness

Two statements close to Theorem U hold in
every frozen state, with no hypothesis of oddness, by solver at sides
three, four and five. A rod with its two bridgeheads of a second type
on one side forces a free plane through the hole, and a pair of
vertices of type $k$ with opposite signs and a common neighbour forces
a free plane through the line of that neighbour. They have the same
reach as (V) and the same resistance to counting. They are simpler in
one respect, since a frozen state is either odd or a sum of three
one-dimensional profiles, and in the second case the types are
explicit functions of the profiles. A proof of one of them in the odd
case, without orientation, would be the first proof of a statement of
this class.

## Further cells

Theorem 9 removes two of the three certificates
from the proof of H at a given side, leaving Theorem $U'$. Its proofs
grow from 40 MB at side four to 350 MB at side six and its solving
time from 2 s to 22 s, so sides seven to ten are within reach of a
workstation. This extends Theorem 2 and proves nothing uniform. By
Lemma 21 a certificate at one side gives Theorem H at every side that
divides it, and at no other, so each further side needs a certificate
at that side or at a multiple of it. The first step of $K_u$ is
already certified at sides seven and eight, so Theorem $U'$ at those
sides would give Theorem H there. (Done on 1 October 2026, as a search
for a counterexample that found none: Theorem $U'$ is certified at
sides seven and eight and on four cells that are not cubic, with
proofs of 0.9 to 2.9 GB; see the section on the cubic cells.)

# Relation to the earlier reductions

The earlier note wrote H as two statements, that an odd state has a
chain without kinks and that such a chain forces a direction to be
absent. The second was certified for uniform chains as $K_u$, and the
first was proved by hand on 24 and 25 September 2026 for most of a
corpus of odd states, through the trails of odd hexagons and their
runs. The chains produced there are uniform, so those states were
already cases of H. The statements that remained from that work, on the
runs of a trail, on three free planes, on the bridgeheads at a free
plane and on the existence of a free plane on a two-way axis, are no
longer needed. The last is a consequence of Theorem 7 and the third of
Lemma 5, in odd states and given Theorem U.

Theorems 14 and 23 are a third route, which does not pass through a
chain without kinks. They use the parametrisation of the types by
weights on the chains, which the working note proved on 17 September
2026, and its counterpart for the signs. The proof of Theorem 1 given
on 30 September belongs to the same route: it takes from the
parametrisation only Theorem 15, and it makes the chain without kinks
unnecessary altogether, since the axis it produces is one-way by the
law for neighbouring lines and not by $K_u$. One lemma of that date, on a
function of two coordinates that is a sum of functions of three linear
forms, was stated without a hypothesis that it needs, and Theorem R1
was proved from it. Lemma 9 states it with the hypothesis and Lemma 10
supplies the hypothesis, so Theorem R1 stands.

# Related work

The Coulomb phase of spin ice and its emergent gauge field are
reviewed by @henley-2010-coulomb-phase-frustrated-systems and
@castelnovo-et-al-2012-spin-ice-fractionalization-topological-order.
The flux identity used here, that the net moment through a plane is the
same for every parallel plane, is the conservation law of that field.
The $\langle 110 \rangle$ chains are the strings of the Kasteleyn
transition in a $[100]$ field
[@jaubert-et-al-2008-three-dimensional-kasteleyn-transition-spin-ice].
Separable height functions and the six-vertex rule that appears at a
free plane belong to the theory of the six-vertex model
[@duminil-copin-et-al-2024-six-vertex-height-delocalization]. The
literature on fully packed loops has not been searched for the
structure of this note, in which two interpenetrating systems of loops
are coupled through the hexagons, and a search should precede any
claim of novelty.

# Certification

The results of this note have four kinds of standing.

Proved by an argument written out here: law C, law $P^k$, Lemmas 1, 2,
4, 5 and 6, Theorems 4 to 8 and Theorem 1 in both its forms; Lemmas 8
to 25 and Theorems 12 to 23. Each was read by a separate agent as
checker, with its own programs, and no gap was found, except Lemma 21,
which was written by the main session, tested exactly on repeated
states and read by no checker. Lemmas 22 to 25 and the proof of
Theorem 1 of 30 September were written by one agent, re-derived by the
main session from the theorems they cite before their scripts were
read, and then read by an independent checker, which confirmed them
with corrections of wording that are in the text; their one prediction
about odd states was tested on the corpus with no exception. The table
gives what each group rests on from outside this note.

| results | rest on |
|---|---|
| Lemmas 22 to 25, Theorem 1 | Theorem $M'$; Lemma 3 through Theorems 3 to 6; the parametrisation (C) through Theorem 15 |
| Lemmas 8 to 10, Theorems 12, 13 and 15 | the parametrisation (C) |
| Theorem 14 | Theorem 12 and Theorem $M'$; on cells with two coprime pairs that share an extent, Theorem 13 alone |
| Lemmas 11 and 12, Theorems 16 to 19 | Lemma 3 |
| Theorems 20 and 21 | the parametrisation (C) |
| Theorem 22 | Theorem 21 and Theorem $M'$ |
| Lemmas 13 to 20, Theorem 23 | Theorems 17, 19, 20 and 22, Lemma 4 and Theorem $M'$ |
| Lemma 21 | nothing |
| Theorem 24 | Lemma 21 and Theorem 2 |

Theorem $M'$ and the parametrisation (C) are from the project's
earlier record. Theorem $M'$ has two proofs, with lemmas on four
hexagons that carry DRAT certificates, and one second reader. The
parametrisation was proved by a symbolic computation and confirmed by
exact ranks on cells; on 1 October 2026 an independent checker, with
its own model of the hexagons and its own stratification of the unit
torus, reproduced the proof for every cell (the same 68 components)
and the exact ranks on twelve cells, and closed one expository gap in
the companion kernel result. The section on three chains in every pair of
planes reports work that has had no checker, and states no theorem.

Proved by an argument that rests on a finite enumeration of the size of
one or two cages: Lemma 3 (1,200 patterns) and Lemma 7 (6,192
patterns), each run by at least two independent programs, and Theorem
9, whose finite parts are the fifty intersections of the tetrahedron
and whose identity was also verified exactly for separations up to 101.

Certified by DRAT proofs checked by drat-trim: Theorem $U'$ and hence
Theorems U and 2 at sides four to eight and on the cells $(3,3,9)$,
$(4,4,8)$, $(3,3,12)$ and $(6,6,9)$, and with Lemma 21 Theorem 24. The
114 formulas of 27 September and the 155 of 1 October, with the proofs
under 50 MB, are regenerated by the scripts named below. Their SHA-256
sums and verdicts are in the repository, and the files themselves, 738
MB and 2.9 GB, are not; the proofs of 1 October over 50 MB were deleted
after checking and are recorded by hash and size. Also
certified, and since 30 September no longer steps of any proof here:
the first step of $K_u$ on the whole slab at sides four to eight, and
the box lemma of Statement R for $b = 3$ to 6.

Taken from the project's earlier record and, on 1 October 2026, read
again by an independent checker with its own programs: Lemma L and
Lemma A are confirmed on every cell (Lemma A needs one line the earlier
note leaves out, that $(0, 2g, 2g)$ with $g = \gcd(b, c)$ is a nonzero
element of its lattice of translations); Lemma 21 is confirmed by an
exact re-test on eight pairs of cells; Theorem P is confirmed with the
hypothesis that every extent is at least two, which the earlier note
states and the first draft of this note dropped, and the chain from
Theorem H to periodicity is corrected accordingly, with the thin cells
as witnesses that the hypothesis is needed. What remains unread in
Theorem P is the proof of its first step (every even-curl state is a
slab sum): its two linear-algebra steps, the completeness of the chain
parametrisation and the kernel of the match operator, were written by
agents on 17 September 2026, re-run by the main session, and have had
no checker; the checker of 1 October read the rank lemma of the second
and found no gap, and did not read the first. In the earlier form of
Theorem 1 only, $K_u$ was also taken from the record; it was found to
have a gap on cubic cells when a checker did read it, as the first
section says, and one lemma of the record was found to be false as it
was stated.

The proofs were written by language-model agents working from the
project's reports, each with a separate agent as checker that was asked
to find a gap, wrote its own programs from the definitions and did not
use the author's. The checkers confirmed the reduction and the
certificate of Theorem 9 with corrections to a citation, to the
orientation of one equation and to one bound, and found no gap. Every
statement was also tested on the corpus of 1,357 odd frozen states and
on 186 further states at sides five and six. Two statements that the
corpus supported without exception were refuted during the same work by
solver witnesses, because the corpus contains odd states only, and the
note relies on the corpus for no statement that could fail in a state
of even curl. No human has yet read the proofs line by line.

In the work of 27 and 28 September 2026 the checkers found a step
missing from $K_u$, a lemma stated without a hypothesis it needs, a
reflection named as a symmetry that is not one, and a claim that a
proof used no certificate when a theorem it cited does. Each is
corrected in the text. They are recorded here because they show both
that the checks find errors and that errors of this kind are common in
the work.

# History of this note

The note was first issued on 27 September 2026 with the reduction of
Theorem H to Theorem U and $K_u$, Theorem 2, and the sections on
Theorem U and on ideas for it. It was amended the same day: the scope
of the first step of $K_u$ was corrected, the first and third closed
routes for Theorem U were revised, the subsection on cells that are
not cubic was added with Theorems 10 and 11, and the fourth idea was
withdrawn. On 28 September 2026 four sections were added, on cells
with a coprime pair of extents, on the signed moments, on cells with
two chains in every pair of planes, and on a state repeated
periodically, with a section on three chains in every pair of planes.
The title, the abstract and the first section were rewritten to state
what is now proved, and the note was given this history in place of
dated remarks in the abstract. On 30 September 2026 the seventh item
of the section on Theorem U was added, recording the two rounds of 28
and 29 September on the closure of the sheet, which found no proof.
Later the same day Theorem 1 was given its present form, with Lemmas 22
to 25, and $K_u$ ceased to be a step of the reduction; the earlier
proof is kept under its own heading, the eighth item of the section on
Theorem U records the day's three facts about (V) and Statement R and
a correction on the integrality of the weights, the title, abstract,
first section and certification were revised accordingly, and the PDF
was rebuilt. On 1 October 2026 six agents ran. The chain from Theorem
H to periodicity was read by two independent checkers: Lemma L, Lemma
A and Lemma 21 confirmed on every cell, Theorem P corrected to require
every extent at least two (the thin cells are counterexamples to the
conclusion without it), and the two linear-algebra steps of its first
step, the parametrisation (C) among them, confirmed as proofs for
every cell by an independent stratification. The plan of 30 September
for Theorem U was closed by the facts of the ninth item of its
section, and the closed-form certificate of the first step of $K_u$
was confirmed. A search for a counterexample to Theorem U on the
cheapest open cells found none and left Theorem $U'$ certified at
sides seven and eight and on four cells that are not cubic, so that
Theorem 2 now reaches side eight. The abstract, the first section, the
section on the cubic cells, the section on Theorem U and the
certification were revised, and the PDF rebuilt.

# Artefacts

- `docs/reports/2026-09-27-synthesis.md`: the map of the argument and
  the record of the checks.
- `docs/reports/2026-09-27-opus-rphand.md`, `-lines.md`, `-cone.md`:
  the reduction, the line law and the certificate of Theorem 9, with
  the checkers' reports `-check.md` and `-check2.md`.
- `docs/reports/2026-09-27-opus-cert.md`: the certificates. Hashes and
  verdicts in `experiments/08_frozen_structure/scratch_h/certs/h28x_*`;
  regenerate with `h282_certify.py`.
- `docs/reports/2026-09-22-orient.md`, `-ucore.md`, `-uhand.md`,
  `2026-09-27-opus-uwall.md` and `-vsign.md`: the record on Theorem U.
- `docs/reports/2026-09-27-aniso.md`: (V) on cells that are not cubic,
  and the assessment of the ideas. Scripts `h330_aniso.py` and
  `h331_aniso_lp.py`.
- `docs/reports/2026-09-28-attack-proposal.md` and
  `2026-09-28-opus-check7.md`: the section on cells with a coprime
  pair of extents, and its check. Scripts `h420`–`h423` and
  `h430`–`h432`.
- `docs/reports/2026-09-28-opus-scomp.md`: the section on the signed
  moments. Scripts `h440`–`h448`.
- `docs/reports/2026-09-28-opus-twochain.md` and
  `2026-09-28-opus-check8.md`: Theorems 20 to 22, and their check.
  Scripts `h450`–`h460` and `h470`–`h476`.
- `docs/reports/2026-09-28-opus-dfour.md` and
  `2026-09-28-opus-check9.md`: Lemmas 13 to 20 and Theorem 23, and the
  check of them and of the section on the signed moments. Scripts
  `h480`–`h485` and `h530`–`h539`.
- `h550_lift.py`: the check of Lemma 21.
- `docs/reports/2026-09-28-opus-cubethree.md`: the section on three
  chains in every pair of planes. Scripts `h500`–`h518`.
- `docs/reports/2026-09-28-opus-sheet.md` and
  `2026-09-29-opus-moment.md`: the seventh item of the section on
  Theorem U. Scripts `h560`–`h569` and `h570`–`h579e`.
- `docs/reports/2026-09-30-fable-zeroflux.md` and
  `2026-09-30-opus-check10.md`: Lemmas 22 to 25 and the proof of
  Theorem 1 of 30 September, and their check. Scripts `h600`–`h605`
  and `h670`–`h672`.
- `docs/reports/2026-09-30-opus-kuwall.md`: the first step of $K_u$
  beside a wall and its cone. Scripts `h580`–`h589`.
- `docs/reports/2026-09-30-fable-rodline.md`: Statement R, the box
  lemma and its certificates (`certs/h633_R_b*`, hashes in the
  report), the heights, and the integrality count. Scripts
  `h630`–`h633`. The zero-flux reach of (V): `h620_vflux.py`.
- `docs/reports/2026-10-01-opus-falsify.md`: the counterexample
  search and the certificates of Theorem $U'$ at sides seven and eight
  and on the four cells that are not cubic. Hashes and verdicts in
  `certs/h74x_results.jsonl` and `certs/h74x_sha256_2026-10-01.txt`;
  regenerate with `h741_uprime.py --drat`. Scripts `h740`–`h744`.
- `docs/reports/2026-10-01-fable-screw.md` and
  `2026-10-01-opus-rbox.md`: the ninth item of the section on Theorem
  U. Scripts `h700`–`h703` and `h680`–`h688`.
- `docs/reports/2026-10-01-kucone-partial.md` and
  `2026-10-01-opus-kucheck.md`: the closed-form certificate of the
  first step of $K_u$ and its check. Scripts `h650`–`h656` and
  `h720`–`h724`.
- `docs/reports/2026-10-01-opus-pacheck.md` and
  `2026-10-01-opus-p1check.md`: the checks of Lemma L, Lemma A,
  Theorem P, Lemma 21 and the chain to periodicity, and of the two
  linear-algebra steps of the first step of Theorem P. Scripts
  `h730`–`h737` and `h750`–`h753`.
- `docs/theorem-h-2026-09-06.md`: the working note, with $K_u$ and
  Theorem P.
- Scripts `h240`–`h249` (reduction), `h270`–`h272` (its check),
  `h290`–`h299` (line laws), `h310`–`h319` (Theorem 9), `h320`–`h326`
  (its check), all in `experiments/08_frozen_structure/scratch_h/`.
