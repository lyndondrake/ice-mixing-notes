---
title: "A sign-gauge obstruction to negative association in pyrochlore ice"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  A rapid-mixing proof for the single-hexagon-flip chain on pyrochlore ice
  would plausibly begin by showing its bond indicators negatively
  associated, and so import the strongly Rayleigh and Lorentzian machinery
  that bounds down-up walks. It cannot begin. The polarity of a bond
  indicator is a convention, so the property has to hold in one of the
  $2^{m}$ sign gauges, and none works. On the sixteen-spin cell, whose
  ninety ice states are the 2-factors of $K_{4,4}$, the unnormalised
  covariance of two bond indicators is $-675$ when the bonds meet at a
  diamond site and $+225$ when they do not, so one bond with a neighbour at
  each of its ends forces a sign to be both equal to and different from
  another. The certificate is three bonds long, is checkable by hand, and is
  reproduced by the repository code by three independent decision
  procedures, one an exhaustive scan of all $2^{15}$ gauges. It recurs at
  four cells and eleven cell-measure combinations. What this closes is the
  entry to a mixing bound through negative association. The log-concavity of
  the flux-sector counts, and every route not passing through pairwise
  negative correlation, is untouched.
---

# The model

Pyrochlore spin ice puts an Ising spin on every bond of the diamond
lattice, the diamond sites being the centres of the corner-sharing
tetrahedra and each spin an arrow along its bond [@bramwell-gingras-2001-spin-ice-state]. A
conventional cubic cell of diamond holds eight sites and sixteen bonds, so
an $(a,b,c)$ block of such cells with periodic boundaries holds $8abc$ sites
and $m = 16abc$ spins. The lattice is bipartite. Writing A and B for its
sublattices, set $x_e = 1$ when the arrow on bond $e$ runs from its A end to
its B end and $x_e = 0$ otherwise. The ice rule asks that exactly two arrows
point into every site, which at an A site means $x = 0$ and at a B site $x =
1$, so the rule takes one form everywhere: exactly two of the four bonds at
a site carry $x = 1$. Two consequences are used below. Summing over the
$4abc$ A sites, every ice state has exactly $8abc$ indicators set, so the
generating polynomial $f(z) = \sum_{\text{states}} \prod_{e\,:\,x_e = 1}
z_e$ is multi-affine and homogeneous of degree $8abc$; and at each site the
six products $x_i x_j$ over pairs of incident bonds sum to one in every
state.

The chain picks a hexagonal plaquette uniformly at random and, if its six
arrows already run head to tail around the ring, reverses them all with
probability one half. Every flip preserves the net flux $\mathbf{W}$ through
the three cut planes of the cell, so the chain decomposes into flux sectors
and is reversible with the uniform stationary measure on each. Frozen ice
states, those with no flippable hexagon, exist at every size, so a mixing
statement attaches to the giant component of a sector rather than to the
sector. Three measures are therefore tested: the uniform measure on the full
ice manifold (A), on the zero-flux sector (B), and on the giant flip
component of the zero-flux sector (C).

# The route, and the sign gauge

A measure $\mu$ on $\{0,1\}^{m}$ is *negatively associated* when
$\mathbb{E}[FG] \le \mathbb{E}[F]\,\mathbb{E}[G]$ for increasing $F$ and $G$
depending on disjoint sets of coordinates. Taking $F = x_i$ and $G = x_j$
gives non-positive covariance for every pair, the weakest consequence of the
property and the one tested here. It is *strongly Rayleigh* when its
multi-affine generating polynomial is real stable, having no zero with every
coordinate in the open upper half-plane. Borcea, Brändén and Liggett showed
that strongly Rayleigh measures are negatively associated, that the class is
closed under conditioning on the value of a coordinate and under external
fields, and that it contains the determinantal measures [@borcea-et-al-2009-negative-dependence-polynomial-geometry]. A
homogeneous stable polynomial with non-negative coefficients is Lorentzian
[@branden-huh-2020-lorentzian-polynomials, Prop. 2.2], and Lorentzian generating polynomials are the
input to the Anari, Liu, Oveis Gharan and Vinzant bound on the down-up walk
over the bases of a matroid [@anari-et-al-2021-log-concave-polynomials-entropy-matroids; @anari-et-al-2024-log-concave-polynomials-high-dimensional-walks].

That machinery does not attach directly. Choosing at each A site which two
of its four bonds carry $x = 1$ is a partition matroid of rank $4abc$, the
same choice at the B sites is a second one, and the ice states are the
common bases of the two. That is a matroid intersection rather than a
matroid, and the down-up walk theorem does not cover it [@anari-et-al-2024-log-concave-polynomials-high-dimensional-walks]. A favourable answer would in any case
have bounded a walk through states violating the ice rule, needing a
comparison step [@randall-tetali-2000-glauber-dynamics-markov-chain-comparison] to reach the hexagon chain, and would have
yielded polynomial mixing rather than the $\Delta \gtrsim L^{-2}$ the
project wants. It was worth testing because it was the only analytic tool in
hand that speaks to a mixing proof at all, and its cheapest necessary
condition is exactly computable.

One step is forced first. The definition of $x_e$ made the A-to-B direction
positive, and that choice has no physical content: the opposite reference on
a bond replaces $x_e$ by $1 - x_e$, and covariances transform as
$\operatorname{Cov}(y_i,y_j) = s_i s_j \operatorname{Cov}(x_i,x_j)$ with
$s_e = \pm 1$ according to whether the bond was left alone or complemented.
Call $s \in \{\pm1\}^{m}$ a *sign gauge*. Negative association is not
invariant under the relabelling, so the question that settles the route is
whether any gauge at all makes every pairwise covariance non-positive, and
the falsifier was registered in that form.

# The obstruction

Write $N$ for the number of states carrying the measure, $n_i$ for the
number with $x_i = 1$, and $n_{ij}$ for the number with $x_i = x_j = 1$, and
work with the integer

$$C_{ij} \;=\; N n_{ij} - n_i n_j \;=\; N^{2}\operatorname{Cov}(x_i, x_j),$$

which carries the sign of the covariance and needs no division. In the gauge
$s$ the pair covariance is $s_i s_j C_{ij}$, so a gauge works exactly when
the constraints $s_i s_j = -\operatorname{sign} C_{ij}$, one for each pair
with $C_{ij} \ne 0$, are consistent. That is a balanced-signed-graph
question: satisfiable if and only if no cycle of the constraint graph
carries an odd number of 'must differ' edges.

**Proposition 1.** *Under the uniform measure on the $N = 90$ ice states of
the $(1,1,1)$ cell, $n_i = 45$ for each of the sixteen bonds, and for $i \ne
j$*

$$C_{ij} = \begin{cases} -675 & \text{if bonds } i,\, j \text{ share a
diamond site},\\[2pt] +225 & \text{otherwise,}\end{cases}$$

*so that the correlation coefficient is $-\tfrac13$ on the 48 site-sharing
pairs and $+\tfrac19$ on the remaining 72.*

**Theorem 2.** *No $s \in \{\pm1\}^{16}$ makes $s_i s_j C_{ij} \le 0$ for
every pair, and three bonds show it. Bonds 0 and 1 meet at the A site at the
origin, bonds 0 and 15 meet at the B site at $(1,1,1)$ in units of a quarter
of the cubic edge, and bonds 1 and 15 meet nowhere. The first two pairs have
$C = -675$ and force $s_0 = s_1$ and $s_0 = s_{15}$. The third has $C = +225$
and forces $s_1 \ne s_{15}$.*

The three bonds are a path of length two in the pyrochlore lattice together
with the pair closing it, the smallest configuration in which the two signs
of covariance can meet. Nothing in the argument needs the cell to be the
smallest one:

**Lemma 3.** *In any cell, under any measure for which every pair of bonds
meeting at a diamond site has $C_{ij} < 0$ while some pair has $C_{ij} > 0$,
no sign gauge exists.*

*Proof.* The site-sharing pairs are the edges of the pyrochlore lattice,
whose vertices are the bonds, and that lattice is connected. Each such pair
imposes $s_i = s_j$, so all $m$ signs coincide, and any pair with $C_{ij} >
0$ then has $s_i s_j C_{ij} > 0$.

# Proof of Proposition 1

At $(1,1,1)$ the eight sites split into four A and four B sites and each of
the sixteen bonds joins a distinct A–B pair, so the quotient graph is
$K_{4,4}$. An ice state sets exactly two of the four bonds at every site,
hence $\{e : x_e = 1\}$ is a 2-factor of $K_{4,4}$. Indexing A sites by rows
and B sites by columns, ice states correspond to $4 \times 4$ matrices of
zeros and ones with every row sum and every column sum equal to $2$. There
are 90 of them, the external anchor this project uses to validate its
enumerators, and two bonds share a diamond site exactly when the
corresponding entries share a row or a column.

The measure is invariant under permuting rows and permuting columns. Each
row carries two ones among four entries, so an entry is $1$ with probability
$\tfrac12$ and $n_i = 45$. The support of a fixed row is a 2-subset of the
columns whose distribution is invariant under the symmetric group on the
columns, hence uniform on the six 2-subsets, so two entries of a row are
both $1$ with probability $\tfrac16$: $n_{ij} = 15$ and $C_{ij} = 90 \cdot
15 - 45^{2} = -675$. Transposing gives the same for a column. Each bond
meets six others at a site, three at each end, so there are $16 \cdot 6/2 =
48$ such pairs.

For the rest, every state has exactly eight entries equal to $1$, so for
fixed $i$

$$\sum_{j \ne i} n_{ij} \;=\; \sum_{\text{states with } x_i = 1}\ \sum_{j
\ne i} x_j \;=\; 45 \cdot (8-1) \;=\; 315 .$$

Six of the fifteen other entries share a row or column with $i$ and
contribute $6 \cdot 15 = 90$. The nine remaining lie in the other three rows
and other three columns and are permuted transitively by the subgroup fixing
$i$, so each has a common value $t$ with $90 + 9t = 315$, giving $t = 25$
and $C_{ij} = 90 \cdot 25 - 45^{2} = +225$.

One value follows without enumeration at all. The six pair products at a
site sum to one in every state, so the six covariances there sum to $N^{2} -
6(N/2)^{2} = -N^{2}/2$, and at $(1,1,1)$ symmetry makes them equal:
$-8100/12 = -675$.

# The computation, and how far it reaches

Every count below was produced twice by routes sharing no arithmetic, a
chunked $X^{\top}X$ over the dense state matrix and a packed bitset per bond
with $n_{ij} = \operatorname{popcount}(b_i \wedge b_j)$, and required to
agree bit for bit. Signability was decided three ways: union–find with
parity, an odd-cycle certificate from an independently built spanning
forest, and, at the smallest cell, an exhaustive scan of all $2^{15}$
gauges. All three agree.

| cell | spins | measure | $N$ | pairs | $C>0$ | $C<0$ | $C=0$ | certificate |
|---|---|---|---|---|---|---|---|---|
| (1,1,1) | 16 | A | 90 | 120 | 72 | 48 | 0 | 15, 0, 1 |
| (1,1,1) | 16 | B | 12 | 120 | 48 | 72 | 0 | 15, 0, 1 |
| (1,1,2) | 32 | A | 3,618 | 496 | 272 | 224 | 0 | 31, 0, 1 |
| (1,1,2) | 32 | B | 388 | 496 | 176 | 192 | 128 | 31, 0, 3 |
| (1,1,2) | 32 | C | 160 | 496 | 224 | 256 | 16 | 31, 0, 1 |
| (1,1,3) | 48 | A | 181,122 | 1,128 | 600 | 528 | 0 | 47, 0, 1 |
| (1,1,3) | 48 | B | 15,024 | 1,128 | 360 | 384 | 384 | 47, 0, 3 |
| (1,1,3) | 48 | C | 3,360 | 1,128 | 528 | 600 | 0 | 47, 0, 1 |
| (1,2,2) | 64 | A | 2,891,562 | 2,016 | 992 | 1,024 | 0 | 63, 0, 1 |
| (1,2,2) | 64 | B | 221,628 | 2,016 | 832 | 1,184 | 0 | 63, 0, 1 |
| (1,2,2) | 64 | C | 221,424 | 2,016 | 832 | 1,184 | 0 | 63, 0, 1 |

No cell or measure is signable, and every certificate returned is a triangle
rather than a longer cycle. Measure C is undefined at $(1,1,1)$, where all
twelve zero-flux states are frozen, so the eleven rows are the whole test.
Between 49 and 60 per cent of all pairs are strictly positive in the plain
gauge, and over all $2^{15}$ gauges at $(1,1,1)$ the smallest achievable
number of violated pairs is 40 out of 120, so the failure is not marginal.
From $(1,1,2)$ upwards the triangle has one site-sharing negative edge and
two pairs sharing no site, one negative and one positive. The dichotomy of
Proposition 1 belongs to the smallest cell, where every pair of bonds is
either adjacent or not.

The hypothesis of Lemma 3 holds at every cell in measures A and B and at
$(1,1,3)$ and $(1,2,2)$ in measure C, with all 48, 96, 144 and 192 site
pairs strictly negative. It fails once, and the exception corrects a natural
assumption. On the 160-state giant component at $(1,1,2)$, 64 site pairs are
negative and 32 strictly positive with $C = +320$ each: the two-of-four rule
forces the six covariances at a site to sum to $-N^{2}/2$ rather than each
to be negative, and here four pairs with $n_{ij} = 19$ and two with $n_{ij}
= 42$ realise that sum, since $4 \cdot 19 + 2 \cdot 42 = 160 = N$. That row
rests on its own triangle instead.

The result is therefore established at four cells and eleven measures rather
than for all $L$, and Lemma 3 says what a repair at larger $L$ would
require: that some pair of bonds meeting at a site cease to be negatively
correlated, which is the opposite of what the local constraint does under
the symmetric measures.

# What is closed, and what is not

Any argument that begins by asserting the bond indicators pairwise
negatively correlated, whether to reach negative association, the strongly
Rayleigh property, or a Lorentzian generating polynomial, fails at the
sixteen-spin cell and at every larger cell and measure tested, and fails for
all $2^{m}$ conventions available for the sign of a bond variable. The
registered follow-up, a strong Rayleigh necessary condition under
conditioning on other bonds, was never run because its trigger was a
favourable answer here.

Four things survive. The exact joint winding histogram $N(W_x,W_y,W_z)$ is
log-concave along every axis and diagonal of its support lattice at all six
cells the frontier dynamic program reaches, a reading about the flux grading
rather than about bond variables. Only the $2^{m}$ diagonal gauges are ruled
out, so a different set of variables, or a non-diagonal change of them, is
untouched. A bound obtained for another chain and transferred by comparison
[@randall-tetali-2000-glauber-dynamics-markov-chain-comparison] needs no negative correlation at all. And the combinatorial
routes, canonical paths and coupling, and the connectivity question about
the giant component that any statement of the problem must settle first
[@gioan-2007-enumerating-degree-sequences-digraphs], are neither helped nor harmed.

# Related work

Borcea, Brändén and Liggett introduced strongly Rayleigh measures through
the stability of their generating polynomials and proved they satisfy the
negative-dependence properties sought for such a class, resolving
conjectures of Liggett, Pemantle and Wagner [@borcea-et-al-2009-negative-dependence-polynomial-geometry]. Pemantle's
earlier survey had set out why no analogue of the FKG theorem was available
on the negative side [@pemantle-2000-theory-of-negative-dependence]. Brändén and Huh place the homogeneous
stable polynomials inside the larger Lorentzian class, characterised by a
Hodge–Riemann condition on the Hessian and tied to matroids [@branden-huh-2020-lorentzian-polynomials],
and Anari, Oveis Gharan and Vinzant, then with Liu, turned the log-concavity
of a matroid's basis generating polynomial into approximate counting and
into rapid mixing of the down-up walk over bases [@anari-et-al-2021-log-concave-polynomials-entropy-matroids; @anari-et-al-2024-log-concave-polynomials-high-dimensional-walks].

That negative correlation of element indicators should control a
basis-exchange walk is older: Feder and Mihail called a matroid balanced
when every minor has the property that conditioning on one element present
makes any other less likely, and proved that the basis-exchange graph of a
balanced matroid expands [@feder-mihail-1992-balanced-matroids]. Their hypothesis is the conditioned
form of the test performed here. The closest methodological precedent is
Grimmett and Winkler on uniform forests, where negative association was
conjectured, resisted proof, and was settled computationally only for graphs
of at most eight vertices, or nine vertices and eighteen edges
[@grimmett-winkler-2004-negative-association-uniform-forests].

Two dimensions are more favourable in a way that sharpens what fails here.
The dimer model on a planar bipartite graph has determinantal edge
statistics from the Kasteleyn matrix [@kenyon-1997-local-statistics-lattice-dimers], and determinantal
measures sit inside the strongly Rayleigh class [@borcea-et-al-2009-negative-dependence-polynomial-geometry], so a
negative-dependence route to mixing is available in principle for the models
the hexagon-flip chain is usually compared with. Pyrochlore ice is not among
them. Its states are the Eulerian orientations of the diamond lattice
[@mihail-winkler-1996-eulerian-orientations-count], the Glauber dynamics of the related six-vertex model mix
slowly in the ordered phases [@fahrbach-randall-2019-slow-mixing-glauber-dynamics-six-vertex-model], and the dynamical exponent $z
\approx 2$ measured for this chain [@henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points] still has no matching lower
bound.

# Artefacts

Paths are relative to the project root. `icemix/signgauge.py` holds the pair
statistics by two routes, the balanced-signing test, the odd-cycle
certificate, the exhaustive scan, the site-pair check and the conditioned
check; `icemix/lattice.py` holds the cell construction, where the $(1,1,1)$
quotient graph being $K_{4,4}$ is documented and tested;
`experiments/04_lorentzian_giant/run_stage4abc.py` produced the table, with
every count quoted stored in `results/results.json` under
`items.4b.cells.<cell>.measures.<M>`; §3.3 of
`docs/reports/2026-09-04-stage4abc.md` gives the $(1,1,1)$ certificate with
its counts; the tests are in `tests/test_stage4abc.py`. Run
`run_stage4abc.py --items 4b` and then `make_summary.py` to reproduce the
item.

The covariance values $-675$ and $+225$, the counts $n_{ij} = 15$ and $25$,
and the classification of each certificate edge as site-sharing or disjoint
were recomputed from the repository code while this note was written, and
agree with the run report. One number is in no stored artefact and was
computed for this note alone with `icemix.signgauge`: the minimum of 40
violated pairs out of 120 at $(1,1,1)$ under measure A.

# References
