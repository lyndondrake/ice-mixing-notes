---
title: "Frozen pyrochlore ice and the $\\mathbb{Z}_2$ curl: a reduction of the periodicity conjecture, with proofs in one dimension and two and certificates in three"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  A state of pyrochlore spin ice is frozen when no hexagon of the
  diamond lattice can be flipped. Every frozen zero-flux state of the
  cubic cells of side two and three is invariant under a nonzero
  translation, and the conjecture is that this holds at every side.
  This note reduces the conjecture to a parity statement. The curl of a
  state on a hexagon is the parity of the number of its six bonds
  oriented from one sublattice to the other; a circulating hexagon has
  odd curl, so a state with even curl everywhere is frozen. Four
  statements are proved in full: a missing dipole axis forces a
  half-box translation symmetry (Lemma A); every hexagon of a frozen
  state has exactly two reversals of its flow, by a count over the whole
  torus (Lemma L); on a cell one cube thick, where the model is square
  ice with dominoes as its moves, a frozen state with a single kink has
  even curl everywhere and such states are classified by their
  diagonals (Theorem 2D); and a state that is a sum modulo two of three
  one-dimensional profiles, one per axis, has a one-cube period whenever
  it obeys the ice rule (the profile lemma). Two statements carry
  machine-checked certificates rather than proofs: that a frozen state
  with all six dipole directions has even curl (Theorem H, DRAT proofs
  checked by drat-trim on five cells), and that an ice state with even
  curl has a one-cube period (Theorem P, DRAT proofs on six cells
  including the cubic cell of side four, together with linear algebra
  over $\mathbb{F}_2$ and solver checks showing that every even-curl ice
  state on those cells is a sum of profiles). Together H and P give the
  conjecture on every cell whose extents are all at least two, and
  describe every frozen state with six directions as three
  one-dimensional profiles. What remains is a proof of H in three
  dimensions and of the profile description in general.
---

# The model and the language of dipoles

The diamond lattice has vertices on two sublattices, A and B, with
$B = A + (1,1,1)$ in units of a quarter of the conventional cubic edge,
and four bonds at each vertex along $d_0 = (1,1,1)$, $d_1 = (1,-1,-1)$,
$d_2 = (-1,1,-1)$, $d_3 = (-1,-1,1)$. A state assigns an arrow to every
bond, and the ice rule requires two arrows in and two out at every
vertex. On a periodic cell of $a \times b \times c$ conventional cubes
there are $8abc$ vertices, $16abc$ bonds and $16abc$ hexagons, the
hexagons being the closed six-bond walks of zero displacement (on a
small torus the graph has other six-cycles, which wind around the cell
and are excluded). Flipping a hexagon reverses its six arrows; the move
preserves the ice rule exactly when the arrows circulate, and it
preserves the flux, the net arrow count through each coordinate plane.
A state is **frozen** when no hexagon circulates.

A vertex with two arrows in and two out has a net moment along one of
$\pm e_x, \pm e_y, \pm e_z$: with the out-bonds at an A vertex (in-bonds
at a B vertex) forming the pair $\{i,j\}$, the moment is proportional to
$d_i + d_j$, so $\{0,1\}$ and $\{2,3\}$ give $\pm e_x$, $\{0,2\}$ and
$\{1,3\}$ give $\pm e_y$, and $\{0,3\}$ and $\{1,2\}$ give $\pm e_z$.
The axis of the moment is the **type** of the vertex. An ice state is
exactly a field of moments $n(v)$ in which every bond of direction $d$
satisfies $[d \cdot n(A) > 0] = [d \cdot n(B) > 0]$ at its two ends.

The bonds form chains along the six $\langle 110 \rangle$ directions:
a chain of the family $\{i,j\}$ alternates bonds of directions $d_i$
and $d_j$ and steps by $d_i - d_j$, so the families $\{0,1\}$ and
$\{2,3\}$ lie in the $(100)$ planes, $\{0,2\}$ and $\{1,3\}$ in $(010)$,
and $\{0,3\}$ and $\{1,2\}$ in $(001)$; call them the $x$-, $y$- and
$z$-chains. A vertex is a **kink** of a chain when both of the chain's
bonds at it point in or both point out, and a pass-through otherwise.
A vertex is a kink of exactly the two chains perpendicular to its type
and a pass-through of the other four. Along a chain the flow keeps its
sense between kinks and reverses at each, and kinks alternate between
sources and sinks. Every chain is closed on the torus.

A hexagon omits one bond direction and uses one chain of each of the
three axes twice, at antipodal pairs of its vertices. It circulates
exactly when every one of its six vertices is a pass-through for the
chain the hexagon uses there, with a consistent sense. In terms of
moments, the circulating pattern on the hexagon $A_1B_1A_2B_2A_3B_3$
that omits $d_3$ is $n(A_1) \in \{+x,+z\}$, $n(B_1) \in \{+y,+z\}$,
$n(A_2) \in \{-x,+y\}$, $n(B_2) \in \{-x,-z\}$, $n(A_3) \in \{-y,-z\}$,
$n(B_3) \in \{+x,-y\}$, or the negative of that.

# Lemma A: a missing axis forces a half-box symmetry

**Lemma A.** Let $S$ be an ice state on the cell $(a,b,c)$, with box
$B = (4a,4b,4c)$, in which no vertex has type $x$. Then $S$ is invariant
under every translation in
$$\Lambda_x = (\mathbb{Z}(0,2,2) + B\mathbb{Z}^3) \cap (\mathbb{Z}(0,2,-2) + B\mathbb{Z}^3).$$
For a cubic cell of side $L$ that lattice modulo the box is
$\{0, (0,2L,2L)\}$, the half-box shift in the two coordinates other
than $x$. The same holds for $y$ and $z$.

*Proof.* A vertex is a kink of a $\{0,1\}$ chain iff its type is $x$.
With no such vertex every $\{0,1\}$ chain is kink-free, so its sense is
constant along it, so every $d_0$ bond on it carries the same arrow and
so does every $d_1$ bond. Consecutive $d_0$ bonds of a chain are related
by the step $(0,2,2)$, and every $d_0$ or $d_1$ bond lies on such a
chain, so the arrows of all $d_0$ and $d_1$ bonds are invariant under
$(0,2,2)$. The $\{2,3\}$ chains make the arrows of all $d_2$ and $d_3$
bonds invariant under $(0,2,-2)$. A translation that is a multiple of
$(0,2,2)$ modulo the box and a multiple of $(0,2,-2)$ modulo the box
fixes every bond. For the cubic box, $k(0,2,2) \equiv m(0,2,-2)$ needs
$k \equiv m$ and $k \equiv -m \pmod{2L}$, so $k \equiv 0 \pmod L$.
$\square$

Neither freezing nor zero flux is used. Zero flux is the statement
that on each sublattice every axis carries as many $+$ as $-$ moments
(the kinks of a closed chain alternate source and sink, and a $+x$ kink
is a source at an A vertex and a sink at a B vertex), so a zero-flux
state in which every axis occurs has all six directions. That is how
the six-direction hypothesis of Theorem H enters: with Lemma A it turns
the periodicity conjecture into a statement free of flux.

# The curl

For a state $s \in \mathbb{F}_2^{E}$, with $s_e = 1$ when the arrow on
bond $e$ points from A to B, define the **curl** on a hexagon $h$ as
$\kappa_h(s) = \sum_{e \in h} s_e \bmod 2$. Walking a hexagon in cycle
order, consecutive vertices lie on opposite sublattices, so a
circulating hexagon has its bits alternating and exactly three of them
set.

**Lemma C.** A state with even curl on every hexagon is frozen.
$\square$

The converse fails: the states of Lemma A with a missing axis are
frozen with odd hexagons, and so are frozen states in nonzero flux
sectors. Theorem H below says the converse holds once all six
directions are present.

Orient a hexagon cyclically and read each of its bonds as forward or
backward along the cycle. A vertex of the hexagon is a **reversal**
when the two hexagon bonds at it point both in or both out, that is,
when it is a kink of the chain the hexagon uses there. In bits, a
vertex is a reversal iff its two hexagon bonds carry equal bits, again
because consecutive vertices alternate sublattice. The number of
reversals is even, and zero reversals is circulation. The three B
vertices contribute an odd number of bit changes between the bit and
the forward/backward reading, so **a hexagon has odd curl iff its
number of forward bonds is even**.

# Lemma L: exactly two reversals

**Lemma L.** In a frozen state every hexagon has exactly two reversals.

*Proof.* Twelve hexagons pass through a vertex $v$, two for each of the
six pairs of bonds at $v$. The vertex is a reversal for a hexagon iff
the hexagon's pair at $v$ is one of the two chains kinked at $v$, so
$v$ is a reversal for exactly four hexagons. Summing over vertices, the
reversals number $4|V| = 32abc = 2|H|$. A frozen state has no
circulating hexagon, so every hexagon has at least two reversals, hence
exactly two. $\square$

The count is an average over the torus, and the lemma is not a local
one: on the $(4,4,4)$ cell a hexagon with four reversals is consistent
with freezing on the 610 hexagons within three steps of it, and only
the whole torus excludes it. With exactly two reversals the two runs of
the flow have lengths $(1,5)$, $(2,4)$ or $(3,3)$, and by the parity
count **an odd hexagon has its two reversals at distance two, an even
one has them adjacent or antipodal**. Every hexagon of a frozen state
therefore has one source and one sink, with both arcs directed from the
one to the other, and every vertex is the source of two hexagons (those
through its out-chain) and the sink of two.

**The chain form of the curl.** Fix a two-step path $v_k, v_{k+1},
v_{k+2}$ along an $E$-chain, with bond directions $i$ and $j$. Two
hexagons contain it, one for each of the two remaining directions $n$;
the one with parameter $n$ uses the chain $\{i,n\}$ at $v_k$ and
$\{j,n\}$ at $v_{k+2}$, and the axes of those two chains are the two
axes other than $E$, in one order for one choice of $n$ and the other
order for the other. In a frozen state that hexagon is odd iff its two
reversals are $v_k$ and $v_{k+2}$, by Lemma L, iff $v_k$ has the axis of
$\{i,n\}$ and $v_{k+2}$ the axis of $\{j,n\}$. Hence:

**Proposition.** A frozen state has even curl everywhere iff along
every chain any two pass-through vertices at distance two have the
same type.

Both directions were also checked by solver on $(2,2,2)$, $(2,3,3)$ and
$(3,3,3)$. So Theorem H, stated below, says that in a frozen state with
all six directions the types of the pass-through vertices along a chain
change only across a kink of that chain.

# One cube thick: square ice with domino moves

Project along $x$ and write $u = (y+z)/2$, $w = (y-z)/2$. The vertices
of the cell $(a,b,c)$ lie on $4a$ grids $x = 0, \dots, 4a-1$, grid $x$
being one parity class of $(u,w)$ on the torus
$T = \mathbb{Z}^2 / \langle (2b,2b), (2c,-2c) \rangle$. Each bond joins
grids $x$ and $x+1$ and projects to a unit step. The bonds between grids
$x$ and $x+1$, the **slab** $x$, are unit $u$-steps on the lines
$w \equiv x/2 \pmod 2$ when $x$ is even and unit $w$-steps on the lines
$u \equiv (x+1)/2$ when $x$ is odd, and these lines are exactly the
$x$-chains. Every hexagon is a $2 \times 1$ **domino**: two consecutive
steps on each of two adjacent parallel lines, in slabs $x-1$ and $x+1$,
closed by one step on each of two consecutive lines of slab $x$. The
count is $4bc$ dominoes per middle slab, $16abc$ in all.

On a thin cell, $a = 1$, every line occurs once, so **the thin cell is
square ice on $T$ whose flip moves are the dominoes rather than the
plaquettes**; a unit plaquette is a non-contractible four-cycle around
$x$ and flipping it changes the flux. The six vertex types of square
ice are the six moments: with $\sigma_u, \sigma_w$ the senses of the row
and column through a pass-through, $+y = (+,+)$, $-y = (-,-)$,
$+z = (+,-)$, $-z = (-,+)$; the type-$x$ vertices are the $c$-vertices,
where the row sense and the column sense both flip. In six-vertex
language type $y$ is an $a$-vertex, type $z$ a $b$-vertex.

For a unit square $Q$ with edge senses $\beta$ (bottom), $\rho$
(right), $\tau$ (top), $\lambda$ (left), write $P(Q) = \beta\rho\tau\lambda$.
The product of the senses around a domino is $P(Q_L)P(Q_R)$ (the
shared rung cancels), a circulating domino has product
$\sigma^3(-\sigma)^3 = -1$, and $P(Q) = y(BL)\,y(TR)$ where
$y(v) = r(v)t(v)$ is the product of the right and upper senses at $v$,
which equals $+1$ exactly at the $a$-vertices. So $P \equiv +1$ says the
$a$-vertices form complete NE diagonals of $T$, and equally that the
$b$-vertices form complete SE diagonals.

**Theorem 2D.** *(i)* If every unit square has $P = +1$ the state is
frozen. *(ii)* If the state is frozen and has a $c$-vertex, every unit
square has $P = +1$.

*Proof of (i).* The senses around a domino multiply to $+1$ and a
circulating domino has product $-1$. $\square$

*Proof of (ii).* At a $c$-vertex the right and upper senses satisfy
$r\,t = -1$, the left and lower being $-r$ and $-t$. Consider two
adjacent rows $w, w+1$ carrying opposite constant senses $\sigma, -\sigma$
on a run of edges $I$, with rungs $t_u$ the column edges between them.

(AP) The domino $[u_0, u_0+2] \times [w, w+1] \subset I$ circulates iff
$t_{u_0} = -\sigma$ and $t_{u_0+2} = \sigma$, for either orientation, so
along $I$ at each parity of $u$ the rungs form a word
$\sigma^*(-\sigma)^*$.

(END) If $I$ is maximal, its ends $p$ (left) and $q$ (right) are
$c$-vertices of row $w$ or row $w+1$, and $t_p = -\sigma$, $t_q = \sigma$
in all four cases: a $c$ of row $w$ at $p$ has $r = \sigma$ hence
$t = -\sigma$; a $c$ of row $w+1$ at $p$ has $r = -\sigma$, hence
$t = \sigma$ and the rung $d = -t = -\sigma$; symmetrically at $q$.

(ALT) By (AP) and (END) all rungs at the parity of $p$ equal $-\sigma$
and all at the parity of $q$ equal $\sigma$; so $q - p$ is odd and
adjacent rungs alternate along $I$. Since on $I$ one has
$P(Q_{u,w}) = \sigma(-\sigma)t_u t_{u+1} = -t_u t_{u+1}$, every unit square
of an anti-parallel run with an endpoint is good. On a parallel run
(both rows $\sigma$), $P(Q_{u,w}) = t_u t_{u+1}$. The same three facts
hold for columns, with rungs the row edges.

Let $Q$ be a bad square with no $c$-corner. Rows and columns pass
through all four corners, so $P = [\beta = \tau][\lambda = \rho]$ in
$\pm 1$, and exactly one of the row pair and the column pair is
anti-parallel at $Q$. If the rows are, (ALT) shows their run has no
endpoint, so rows $w$ and $w+1$ are $c$-free constant lines. By (AP)
applied cyclically the rungs are constant at each parity, and the bad
square makes the two parities equal: every column has sense $\rho$ on
the edge $(w, w+1)$, hence, passing through the $c$-free rows, on
$[w-1, w+2]$. The rungs between rows $w+1$ and $w+2$ are then all
$\rho$. A run of row $w+2$ with sense $\sigma$ bounded by two
$c$-vertices of row $w+2$ is an anti-parallel run whose endpoint rungs
are $\sigma$ and $-\sigma$ by (END), and both equal $\rho$, which is
impossible. So row $w+2$ has no such run and is $c$-free and constant,
the same follows for its rungs with row $w+3$, and inductively every
row is $c$-free, against the hypothesis. The column case is identical.

Let $Q$ be bad with a $c$-corner. By the half-turn symmetry and
$P = y(BL)y(TR)$ we may take $BL = (u,w)$ a $c$-vertex and
$TR = (u+1, w+1)$ an $a$-vertex (if $TR$ is also $c$ the square is
good). Write $\beta, \lambda$ for the right and upper senses at $BL$,
so $\lambda = -\beta$, and $\rho, \tau$ for the lower and left senses at
$TR$, so $\rho = \tau$. If $BR$ and $TL$ are not $c$: when
$\beta = \rho$ the columns $u$ (sense $-\beta$ above $w$) and $u+1$
(sense $\beta$) are anti-parallel on a run starting at the $c$-vertex
$BL$ with $w+1$ in its interior, and (ALT) gives
$r_{w+1}(u + \tfrac{1}{2}) = -\beta$, but that edge is $\tau = \beta$; when
$\beta = -\rho$ the rows $w$ (sense $\beta$ right of $BL$) and $w+1$
(sense $-\beta$) are anti-parallel on a run starting at $BL$ with
$u+1$ interior, and (ALT) gives $t_{u+1} = \beta$, but
$t_{u+1} = \rho = -\beta$. If $BR$ is a $c$-vertex and $TL$ is not, the
$a$-condition at $TR$ and the $b$-condition forced at $TL$ give
$\tau = \rho = \beta$, the columns $u, u+1$ are anti-parallel above $w$
on a run starting at $BL$ with $w+1$ interior, and (ALT) again gives
$r_{w+1}(u + \tfrac{1}{2}) = -\beta \neq \tau$. The case $TL$ a $c$-vertex
is the reflection. If both $BR$ and $TL$ are $c$, the $c$-relations give
$\tau = -\beta$ and $\rho = \beta$, and $Q$ is good. $\square$

So on a thin cell, with a single kink, frozen is the same as even curl,
the $a$- and $b$-vertices lie on complete diagonals of the two
sublattices separately, and the state is determined up to the global
arrow reversal by its two sets of diagonals: on $(1,2,2)$ the 698
frozen states with a kink fall into 349 such classes of two, and on
$(1,3,3)$ the 12,026 into 6,013. The proof is global at one point, the
induction that runs around the torus, and the solver agrees that it
must be: a bad square forces none of its eight neighbouring squares
bad.

# Theorem H

**Theorem H (certified on five cells).** A frozen state in which all
six directions occur has even curl on every hexagon. Equivalently, in
such a state the types of the pass-through vertices along every chain
change only across a kink of that chain.

The negation, "frozen, all six directions present, some hexagon odd",
is unsatisfiable with DRAT proofs checked by drat-trim on $(1,2,2)$,
$(1,3,3)$, $(2,2,2)$, $(2,2,3)$ and $(2,2,4)$, and unsatisfiable without
proof logging on $(2,3,3)$ under the hypothesis that every chain
carries a kink. On $(3,3,3)$ and $(4,4,4)$ the solver gave no verdict in
four and ten hours. Theorem 2D is the case $a = 1$, where a single kink
replaces the six directions.

The hypothesis is sharp in a strong sense. A single distance-two type
change on a chain is compatible with any five of the six directions
($(2,2,2)$, $(2,2,4)$; pairs and triples also on $(3,3,3)$), and only
the full set of six is excluded; the per-axis hypotheses "both signs
of $x$" and "every $x$-chain kinked" do not suffice; and a single odd
hexagon forces no particular chain kink-free. So a proof of H cannot
exclude a direction locally, and, like Lemma L, must be an argument
over the whole torus. One local fact is available: in a frozen state an odd
hexagon always has an odd hexagon among the six that share two
consecutive bonds with it, the shared pair sitting at one of its four
pass-through vertices (solver-established with freezing on the 37
hexagons around it only, on $(3,3,3)$ and $(4,4,4)$), so the odd hexagons
form closed trails on the torus; the proof would show that such a trail
forces a direction to be absent. The two-dimensional proof is its model:
the facts (AP), (END) and (ALT) hold for any pair of adjacent parallel
chains, with the difference that in three dimensions a chain has rungs
to a given partner only at every second vertex, the other vertices'
rungs going to a partner in the next sheet, so (END) applies only to
kinks at rung positions.

# Theorem P and the slab sums

**Theorem P (certified on six cells).** An ice state with even curl on
every hexagon, in any flux sector and with no freezing hypothesis, on a
cell whose extents are all at least two, is invariant under a one-cube
coordinate shift $(4,0,0)$, $(0,4,0)$ or $(0,0,4)$.

The negation is unsatisfiable with DRAT proofs checked by drat-trim on
$(2,2,2)$, $(2,2,3)$, $(2,2,4)$, $(2,3,3)$, $(3,3,3)$ and $(4,4,4)$ (the
last in 959 s of CaDiCaL), and unsatisfiable on $(2,4,4)$ and $(3,3,4)$.
On thin cells the negation is satisfiable, as it must be: the
aperiodic frozen states of $(1,3,3)$ have even curl by Theorem 2D.

The explanation is linear algebra over $\mathbb{F}_2$. Let $K$ be the
space of $s \in \mathbb{F}_2^E$ with $\sum_{e \ni v} s_e = 0$ at every
vertex and $\kappa_h(s) = 0$ on every hexagon. A slab meets every vertex
in zero or two bonds and every hexagon in zero or two, so the $4a + 4b
+ 4c$ slab indicators lie in $K$. Gaussian elimination gives:

| cell | $\dim K$ | slab rank | slabs span $K$ |
|---|---|---|---|
| (1,2,2) | 16 | 16 | yes |
| (2,2,2) | 26 | 20 | no |
| (2,2,3) | 32 | 24 | no |
| (2,2,4) | 42 | 28 | no |
| (2,3,3) | 28 | 28 | yes |
| (3,3,3) | 32 | 32 | yes |

The vectors of $K$ outside the slab span appear only with two even
extents and are ribbons, a single line per slab restricted to a
drifting band of four slabs. They carry no ice state: every even-curl
ice state enumerated is a slab sum (all 714 of $(1,2,2)$, all 1,266 of
$(2,2,2)$), and the formula "ice, even curl, some linear functional
vanishing on the slab span equal to one" is unsatisfiable on $(2,2,2)$,
$(2,2,3)$, $(2,2,4)$, $(2,4,4)$ and $(4,4,4)$. So on every cell tested:

**P1 (checked, not proved).** Every even-curl ice state is a slab sum,
$s_e = X_{x(e)} + Y_{y(e)} + Z_{z(e)} \pmod 2$, for three profiles
$X: \mathbb{Z}_{4a} \to \mathbb{F}_2$, $Y$, $Z$ on the layers, $x(e)$
being the $x$-slab of $e$.

For a slab sum the ice rule is a condition on the jumps
$\delta X_x = X_x + X_{x-1}$. At the A vertex $(x,y,z)$ the four bits are
$a{+}b{+}c$, $a{+}b'{+}c'$, $a'{+}b{+}c'$, $a'{+}b'{+}c$ with $a = X_x$,
$a' = X_{x-1}$ and likewise for $b, c$; they are all equal iff
$\delta X_x = \delta Y_y = \delta Z_z$, and the same holds at B vertices.
Since their sum is always even, the ice rule says exactly:

(ICE) $(\delta X_x, \delta Y_y, \delta Z_z)$ is not constant at any
vertex, the vertices being the even triples with $x + y + z \equiv 0$
and the odd triples with $x + y + z \equiv 3 \pmod 4$.

The type of a vertex is the axis whose jump is the odd one out, and a
one-cube period along $x$ is $X_{x+4} = X_x$.

**Profile lemma.** Every slab sum satisfying (ICE) has a $4$-periodic
profile.

*Proof.* Let $V_X(r) = \{\delta X_x : x \equiv r \pmod 4\}$, a nonempty
subset of $\{0,1\}$, and likewise $V_Y, V_Z$. (ICE) says the triple
intersection $V_X(r_x) \cap V_Y(r_y) \cap V_Z(r_z)$ is empty for the four
even residue triples $(0,0,0), (0,2,2), (2,0,2), (2,2,0)$ and the four
odd ones $(1,1,1), (1,3,3), (3,1,3), (3,3,1)$. The profile $X$ is
$4$-periodic iff all $V_X(r)$ are singletons $\{e_r\}$ with
$e_0 + e_1 + e_2 + e_3 = 0$.

If $V_X(0) = \{0,1\}$, the triples $(0,0,0)$ and $(0,2,2)$ force
$V_Y(0) = \{v\}$, $V_Z(0) = \{1-v\}$, $V_Y(2) = \{w\}$, $V_Z(2) = \{1-w\}$,
and $(2,0,2)$, $(2,2,0)$ force $v = w$, since $w = 1 - v$ would require
both $v \notin V_X(2)$ and $1 - v \notin V_X(2)$. So a doubleton on one
axis makes the other two axes constant on that parity class, with
opposite values; the odd class has the same structure.

Case 1, a doubleton exists, say $V_X(0) = \{0,1\}$, so $Y \equiv v$ and
$Z \equiv 1 - v$ on even coordinates. If some axis has an odd
doubleton, the other two are constant on odd coordinates, and one of
$Y, Z$ is then constant on each parity class with values $(v, v', v, v')$,
sum zero, hence periodic. If there is no odd doubleton, $Y$ has odd
values $(p, p')$ and $Z$ has $(q, q')$; if $p = p'$ or $q = q'$ we are
done; otherwise $p' = 1 - p$, $q' = 1 - q$, and the odd conditions read:
not $e_X(1) = p = q$; not $e_X(1) = 1-p = 1-q$; not $e_X(3) = p = 1-q$;
not $e_X(3) = 1-p = q$. If $p = q$ the first two exclude both values of
$e_X(1)$; if $p \neq q$ the last two exclude both values of $e_X(3)$.
A doubleton on an odd class is the mirror case.

Case 2, all twelve sets are singletons. For the even class write
$\sigma_\alpha = e_\alpha(0) + e_\alpha(2)$. If all three $\sigma_\alpha = 1$,
with $(p,q,r) = (e_X(0), e_Y(0), e_Z(0))$ the four even conditions are:
not $p = q = r$; not $q = r = 1-p$; not $p = r = 1-q$; not
$p = q = 1-r$; and every triple in $\mathbb{F}_2^3$ violates one of them.
If exactly two axes, say $X, Y$, have $\sigma = 1$ and $Z \equiv z$, the
conditions $(0,0,0)$ and $(0,2,2)$ force $e_X(0) = 1 - z$, then
$(2,0,2)$ forces $e_Y(0) = 1 - z$, and $(2,2,0)$ reads not $z = z = z$.
So at most one axis has $\sigma_\alpha = 1$, and likewise at most one
has $\sigma'_\alpha = e_\alpha(1) + e_\alpha(3) = 1$. If no axis were
periodic, $\sigma'_\alpha = 1 - \sigma_\alpha$ for all three, giving
$\sum_\alpha \sigma'_\alpha = 3 - \sum_\alpha \sigma_\alpha \geq 2$. So
some axis has $\sigma_\alpha = \sigma'_\alpha$, that is,
$e_0 + e_1 + e_2 + e_3 = 0$. $\square$

Brute force over all jump vectors confirms the lemma on $(1,2,2)$,
$(1,3,3)$, $(2,2,2)$, $(2,2,3)$ and $(2,3,3)$ (2,532 slab-sum ice
states on $(2,2,2)$ up to the three global constants, 27,492 on
$(2,3,3)$, none without a $4$-periodic profile). On an odd extent the
parity of $\sum_x \delta X_x$ makes all-singleton value sets periodic
at once, which is why odd cells carry no anti-periodic states, while
the even cells do: $X_{x+4} = X_x + 1$ is the case $\sum_r e_r = 1$ of
Case 2.

Theorem P is therefore proved for slab sums, and P1 is what stands
between the certificates and a proof for all cells.

# Consequences

Theorems H and P together give: a frozen state in which all six
directions occur has a one-cube coordinate period. With Lemma A and
the remark on zero flux, every frozen zero-flux state of a cell whose
extents are all at least two is invariant under a nonzero translation,
either the half-box diagonal shift or a one-cube shift. That is the
periodicity conjecture, and more: such a state is either the lift of a
state of a cell one cube thick, where Theorem 2D classifies it, or a
state of Lemma A. On the evidence of P1 the frozen states with six
directions are exactly the slab sums, three one-dimensional profiles
whose jumps are never all equal at a vertex.

At the cubic cell of side four, where a cube-and-conquer proof of the
conjecture left 407 of 23,153 leaf cubes unrefuted, Theorem P is
certified and the conjecture depends on the single certificate of
Theorem H at $(4,4,4)$.

# Related work

The Coulomb phase of spin ice and its emergent gauge field are reviewed
by @henley-2010-coulomb-phase-frustrated-systems and @castelnovo-et-al-2012-spin-ice-fractionalization-topological-order; the hexagon-flip chain is the
classical face of the Rokhsar–Kivelson point of quantum spin ice
[@rokhsar-kivelson-1988-superconductivity-quantum-hard-core-dimer-gas; @hermele-et-al-2004-pyrochlore-photons-u1-spin-liquid; @henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points], and loop and hexagon updates
are the standard ergodic moves for ice models [@barkema-newman-1998-monte-carlo-ice-models]. The
$[100]$ projection used here, in which the diamond lattice is a stack of
square lattices whose rows and columns alternate between layers, is the
geometry of the Kasteleyn transition of spin ice in a $[100]$ field
[@jaubert-et-al-2008-three-dimensional-kasteleyn-transition-spin-ice], where the same $\langle 110 \rangle$ chains are the
strings that carry the transition; the kagome layers of the $[111]$
projection, in which the hexagons lie, are the geometry of the $[111]$
plateau [@moessner-sondhi-2003-spin-ice-111-magnetization-plateau; @fennell-et-al-2007-pinch-points-kasteleyn-transitions-kagome-ice]. Square ice with its height
function is the six-vertex model, whose height representation and its
delocalisation are treated by @duminil-copin-et-al-2024-six-vertex-height-delocalization; the domino moves of
the thin cell, as opposed to plaquette moves, are the moves of domino
tilings in the sense of @elkies-et-al-1992-alternating-sign-matrices-domino-tilings and @saldanha-et-al-1995-domino-tiling-spaces rather than of
square ice, and the classification of Theorem 2D by two families of
diagonals has the flavour of the frozen regions of those tilings.
Parity constraints on plaquettes of the kind the curl imposes are the
elementary objects of $\mathbb{Z}_2$ gauge theory [@wegner-1971-duality-generalized-ising-models] and of
Kasteleyn's treatment of dimer statistics [@kasteleyn-1963-dimer-statistics-phase-transitions]; the counting
argument of Lemma L, a global average forcing a local equality, is of
the kind used to show that local rules on a torus have no room to vary.
Frozen configurations under local moves are studied for triangulations
by @kownacki-2004-freezing-triangulations; for spin ice the dynamics that freezes at low
temperature is the monopole dynamics of @jaubert-holdsworth-2009-magnetic-monopole-signature-spin-ice and @melko-gingras-2004-dipolar-spin-ice-monte-carlo,
which is a different mechanism, since here the ice rule is never broken
and freezing is a property of the hexagon move itself.

# Certification

Every claim marked certified rests on a CNF formula built by the
repository code, an UNSAT verdict from CaDiCaL with a DRAT proof, and a
check of that proof by drat-trim, which accepts a proof only if every
clause it adds follows from the formula and the clauses before it by
reverse unit propagation or is a resolution asymmetric tautology, and
the empty clause is derived. What is trusted is the formula's
construction and the checker. The formulas are: for P, the ice rule
(exactly two of four bits set at every vertex), one parity constraint
per hexagon (even), and, for each one-cube shift, one auxiliary per bond
witnessing a disagreement between the bond and its translate, with the
clause that for every shift some witness is true; for H, the ice rule,
two six-clauses per hexagon forbidding the two circulating patterns,
one selector per hexagon implying odd parity with the clause that some
selector is true, and for each of the six directions one selector per
vertex implying that direction there with the clause that some vertex
carries it. The formulas, the drat-trim verdict files and the SHA-256
of each proof are in the repository; the proofs are regenerated by
`experiments/08_frozen_structure/certify_curl.py`, and the same
statements without proof logging, together with the $\mathbb{F}_2$
computations and the profile check, by the stages `curl`, `slabspace`
and `profiles` of `run_structure.py`.

The proofs in this note (Lemmas A, C and L, Theorem 2D, the chain form
and the profile lemma) are hand proofs; their finite instances were
also checked by solver as stated.

# Artefacts

- `docs/frozen-structure-2026-09-05.md`: the working note, every claim
  with its status.
- `icemix/cnf.py`: the encoding; `experiments/08_frozen_structure/structure_queries.py`:
  the curl, slab and profile helpers; `run_structure.py`: the stages;
  `certify_curl.py`: the DRAT certificates.
- `experiments/08_frozen_structure/results/curlP_*`, `curlH_*`,
  `curl_certificates.json`, `drat_sha256.txt`, `curl_*.json`,
  `slabspace.json`, `profiles.json`.
