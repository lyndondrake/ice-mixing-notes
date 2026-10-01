---
title: "Flux sectors of pyrochlore ice: log-concave counts, an octahedral winding support, and a certified failure of real-rootedness"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  The ice states of a periodic pyrochlore cell are graded by the flux vector
  $\mathbf{W}$ through the three coordinate cut planes, which every hexagon
  flip preserves, and $N(\mathbf{W})$ counts the states in one sector. Three
  facts are reported on six cells, from $(1,1,1)$ with 16 spins to
  $(1,2,3)$ with 96 spins and $3.08 \times 10^{9}$ ice states. The counts
  are log-concave with interval support along every lattice line in
  thirteen directions, and so are the 24 one-dimensional marginals, in
  exact integer arithmetic on the primitive vector of the support lattice.
  The support of $N$ is exactly $2\mathbb{Z}^{3}$ intersected with the
  octahedron $a|W_x| + b|W_y| + c|W_z| \le 4abc$, the containment proved
  from the ice rule and the parity of the cut-plane crossing number, the
  realisation of every such point checked at all six cells. And the
  log-concavity is not inherited from real-rootedness, since only seven of
  the 24 marginals have all roots real and none beyond degree eight. The
  counts come from two independent exact enumerators whose whole histograms
  agree entry by entry wherever both run, and the counts of distinct real
  roots of all 24 marginals are certified in Isabelle/HOL by the Archive of
  Formal Proofs implementation of Sturm's theorem, independently of the
  Python computation they agree with. For thirteen of the marginals, the
  seven that are real-rooted and six of the failures, the verdict itself is
  certified; for the other eleven the step from the count to the verdict
  rests on a squarefreeness check that Isabelle did not finish and Python
  supplies.
---

# The model and the flux grading

Pyrochlore spin ice puts a spin on each bond of the diamond lattice, whose
sites are the centres of the corner-sharing tetrahedra, and admits the
configurations in which exactly two of the four arrows at every site point
inwards [@bramwell-gingras-2001-spin-ice-state; @castelnovo-et-al-2008-magnetic-monopoles-spin-ice]. An $(a,b,c)$ block of conventional
cubic cells with periodic boundaries holds $8abc$ sites and $16abc$ spins.
Positions are integers in units of $a/4$, so the box is $(4a,4b,4c)$ and
each of the four A-to-B nearest-neighbour displacements has all components
$\pm 1$.

The smallest ice-preserving move reverses the six arrows around a hexagonal
plaquette, and is available only when they already run head to tail, which
makes the resulting chain the Rokhsar–Kivelson Hamiltonian of quantum spin
ice at its RK point [@rokhsar-kivelson-1988-superconductivity-quantum-hard-core-dimer-gas; @henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points; @hermele-et-al-2004-pyrochlore-photons-u1-spin-liquid]. What matters
here is its conservation law. A hexagon bounding a face of the infinite
lattice is contractible, so reversing it moves no net flux across any cut
plane, and the flux vector

$$\mathbf{W} = (W_x, W_y, W_z), \qquad
  W_j \;=\; \frac{1}{4c_j} \sum_{b} \sigma_b \operatorname{sgn}(d_{bj}),$$

is constant along every trajectory. Here $\sigma_b = \pm 1$ is the arrow
variable of bond $b$, $d_{bj}$ the $j$th component of its A-to-B
displacement, and $(c_x,c_y,c_z) = (a,b,c)$; the divisor turns a
polarisation sum into a flux, since a bond spans a quarter of a cubic edge
along each axis. A second routine, counting the signed arrows across the
single plane $x = 1/2$, agrees with that formula on sampled states at
$(1,1,1)$ and $(1,1,2)$ (`tests/test_enumerate.py`,
`test_winding_by_polarisation_matches_cut_plane`). The ice manifold is
therefore graded, and the object of this note is the integer histogram $N(\mathbf{W})$, which in the Coulomb phase is the
distribution of the emergent gauge field's flux [@henley-2010-coulomb-phase-frustrated-systems].

# Counting a sector exactly

Two enumerators produce $N$, sharing no code path. The first is a frontier
dynamic program over a bond schedule, whose key records the ice-rule
occupancy of the sites still open at the current cut together with the
running polarisation sums, with Python integers as values. Nothing is
materialised, so cost follows the peak number of live keys rather than the
number of states. The second packs a state into one 64-bit word, walks the
search tree depth-first, and reads the flux off by two population counts per
axis against precomputed masks. Where both run, the whole histogram is
compared entry by entry rather than just the totals, and they agree
everywhere; the exception is $(1,2,3)$, where 96 spins do not fit the packed
word and the enumerator refuses rather than truncating.

Table: Cells, exact counts, and the two-method gate; all figures from
`experiments/04_lorentzian_giant/results/results.json`.

| cell | spins | ice states | $N(\mathbf{0})$ | sectors | DP peak keys | agree |
|---|---:|---:|---:|---:|---:|---|
| $(1,1,1)$ | 16 | 90 | 12 | 25 | 72 | yes |
| $(1,1,2)$ | 32 | 3,618 | 388 | 69 | 368 | yes |
| $(1,1,3)$ | 48 | 181,122 | 15,024 | 137 | 904 | yes |
| $(1,1,4)$ | 64 | 9,765,378 | 637,988 | 229 | 1,680 | yes |
| $(1,2,2)$ | 64 | 2,891,562 | 221,628 | 217 | 42,160 | yes |
| $(1,2,3)$ | 96 | 3,076,306,362 | 196,465,480 | 453 | 123,432 | n/a |

The cubic $(2,2,2)$ cell, the smallest with genuinely cubic geometry, is out
of reach, since a bounded probe reached 8,661,950 live keys at 4.216 GB by
step 41 of 128, projecting a peak of $7.1\times10^{8}$ keys and 347 GB.

# The winding support

**Statement.** For the $(a,b,c)$ cell,
$$\operatorname{supp} N \;=\; 2\mathbb{Z}^{3} \;\cap\;
  \{\, \mathbf{W} : a|W_x| + b|W_y| + c|W_z| \le 4abc \,\}.$$

The containment $\subseteq$ is proved. For parity, the bonds crossing the
plane $x = 1/2$ number $4bc$, since $16abc$ bonds are shared equally among
the $4a$ half-integer planes perpendicular to $x$, the count recorded in
`icemix.frozen.winding_support`. If $P$ of them carry their arrow in the
positive sense and $Q$ in the negative then $W_x = P - Q = 4bc - 2Q$, which
is even, and likewise on the other axes.

The octahedron comes from the ice rule one tetrahedron at a time. The four
A-to-B displacements $(1,1,1)$, $(1,-1,-1)$, $(-1,1,-1)$, $(-1,-1,1)$ sum to
zero, so at an A site with two arrows out and two in the polarisation moment
$\sum_b \sigma_b \mathbf{d}_b$ is twice the sum of the two outward
displacements. Each of the six such pairs sums to $\pm 2$ along one
coordinate axis, so every A site contributes exactly $\pm 4\mathbf{e}_k$ for
a single $k$. Every bond has exactly one A end, so summing over the $4abc$ A
sites writes the polarisation vector $(4aW_x, 4bW_y, 4cW_z)$ as a sum of
$4abc$ vectors of $\ell^1$ norm 4, whence $4a|W_x| + 4b|W_y| + 4c|W_z| \le
16abc$. Setting two components to zero gives $|W_x| \le 4bc$, $|W_y| \le
4ac$ and $|W_z| \le 4ab$; each of those is attained at all six cells, and the
bound itself is pinned by `tests/test_enumerate.py`,
`test_winding_range_is_bounded_by_the_cut_size`.

The reverse containment is a check rather than a proof. At each of the six
cells the support of the computed histogram equals the set above, which is
what fixes the sector counts of Table 1 at 25, 69, 137, 229, 217 and 453
(`tests/test_frozen.py`, `test_winding_support_is_2z3_in_the_octahedron`).
That every admissible lattice point is realised on every cell is a
conjecture with six supporting cases. One consequence is needed below: the
lattice of differences of the support is exactly $2\mathbb{Z}^{3}$, of index
8 in $\mathbb{Z}^{3}$, since parity puts it inside and each
$\pm 2\mathbf{e}_j$ lies in the octahedron.

# Log-concavity

A finite integer sequence $n_0,\dots,n_m$ read along consecutive points of a
line is *interval-supported* when its nonzero entries are contiguous and
*log-concave* when $n_k^2 \ge n_{k-1}n_{k+1}$ at every interior $k$; the
*discriminant* of the line is the exact integer $\min_k (n_k^2 -
n_{k-1}n_{k+1})$ over interior $k$.

Because the support lies in $2\mathbb{Z}^{3}$, the point $\mathbf{W} \pm
\mathbf{e}_j$ is not a lattice point, so the literal inequality holds as
$0 \ge 0$ everywhere and every axis line appears riddled with holes, which
makes a pass and a fail read off it equally worthless. The test therefore
has to be stated on the lattice itself, which is computed first by integer
row reduction, each direction $\mathbf{v}$ going in on its primitive lattice
vector, the least positive multiple $t\mathbf{v}$ that the lattice contains,
and that is $2\mathbf{v}$ throughout. The thirteen directions are the three axes, the
six face diagonals $\mathbf{e}_j \pm \mathbf{e}_k$ and the four body
diagonals $\mathbf{e}_x \pm \mathbf{e}_y \pm \mathbf{e}_z$, and every
maximal line of the support is tested, not only those through the origin.

**Result.** At all six cells, in all thirteen directions, on every line, the
sequence is interval-supported and log-concave, with the minimum
discriminants of Table 2. The single qualification is that at $(1,1,1)$
every body-diagonal line meets the support in at most two points, leaving no
interior term, which is recorded as vacuous rather than as a pass.

Table: Minimum discriminants of the joint histogram over all lines in each
class, and the symmetry reading. 'Symmetry' counts the signed axis
permutations preserving the cell extents that $N$ obeys, over those the
shape admits.

| cell | symmetry | $\mathbf{W} \to -\mathbf{W}$ | axis | face diagonal | body diagonal |
|---|---|---|---:|---:|---:|
| $(1,1,1)$ | 48/48 | yes | 52 | 3 | no interior |
| $(1,1,2)$ | 16/16 | yes | 160 | 10 | 138 |
| $(1,1,3)$ | 16/16 | yes | 324 | 21 | 56,184 |
| $(1,1,4)$ | 16/16 | yes | 544 | 36 | 15,251,160 |
| $(1,2,2)$ | 16/16 | yes | 592 | 10 | 523,840 |
| $(1,2,3)$ | 8/8 | yes | 1,272 | 5,112 | 2,790 |

The symmetry column is measured rather than assumed and comes out complete;
inversion holds because complementing every arrow maps the ice manifold to
itself and negates the flux. Four marginals are taken at each cell, the
three $W_j$ and the diagonal flux $s = W_x+W_y+W_z$, and all 24 are
log-concave with interval support on a support of step 2. The smallest cell
shows how tight that can be: each $W_j$ marginal at $(1,1,1)$ is $1, 16, 56,
16, 1$ with discriminant 200, while the $s$ marginal is $9, 24, 24, 24, 9$,
flat across its interior and log-concave with equality. Two negative
controls guard the reading, a planted diagonal violation and a planted
internal zero, each shown to be caught. The scope is finite: six cells, up
to 96 spins, and no theorem for general $(a,b,c)$. What it rules out is an
artefact of the smallest cell, the property surviving a cell with over three
billion states and 453 sectors.

# Real-rootedness, and why it would have mattered

The oldest reason for a log-concave combinatorial sequence is a real-rooted
generating polynomial. If $p(u) = \sum_k a_k u^k$ has non-negative
coefficients and only real roots, Newton's inequalities give $a_k^2 /
\binom{n}{k}^2 \ge (a_{k-1}/\binom{n}{k-1})(a_{k+1}/\binom{n}{k+1})$, which
is strictly stronger than log-concavity and also forbids internal zeros
[@branden-2014-unimodality-log-concavity-real-rootedness]. Had the marginals been real-rooted, the previous section
would have been a corollary.

Each step-2 marginal is read as the coefficients of a polynomial in
$u = t^2$, a change of variable that leaves log-concavity alone. The number
of distinct real roots follows from Sturm's theorem over the rationals,
using the canonical sequence $p$, $p'$, $-\operatorname{rem}(p,p')$ and so
on evaluated at $\pm\infty$; the number of distinct complex roots is
$\deg p - \deg \gcd(p,p')$; the polynomial is real-rooted exactly when the
two agree. All arithmetic is in exact fractions.

**Result.** Of the 24 marginals, 7 are real-rooted and 17 are not. By
degree, 6 of the 7 marginals of degree 4, 1 of the 6 of degree 8, and none
of the 4 at degree 12, the 5 at degree 16 or the 2 at degree 24. The
real-rooted seven are $W_x$, $W_y$, $W_z$ at $(1,1,1)$, and $W_z$ at
$(1,1,2)$, $(1,1,3)$, $(1,1,4)$ and $(1,2,3)$.

The convenient summary 'real-rooted only up to degree four' has an exception
in each direction, since the $s$ marginal at $(1,1,1)$ has degree 4 and only
2 real roots while $W_z$ at $(1,2,3)$ has degree 8 and 8 real roots. What
holds without qualification is that no marginal of degree 12 or more is
real-rooted. Newton's inequalities are therefore not the route to Table 2,
and whatever accounts for the log-concavity of these counts has to survive
genuinely complex roots.

# The Isabelle/HOL certification

That verdict rests on a few dozen lines of hand-written exact arithmetic in
the `real_root_counts` routine of `icemix/logconcave.py`, so all 24 cases
were recomputed in
Isabelle/HOL 2025-2 against the Archive of Formal Proofs entry
`Sturm_Sequences` [@eberl-2014-sturms-theorem; @eberl-2015-univariate-real-polynomials-decision-procedure], an independent implementation of
the same classical theorem. Sturm's theorem gives the number of *distinct*
real roots in an interval as the drop in sign changes of the canonical chain
between the endpoints, and the AFP entry formalises it and exposes the proof
method `sturm`. Each polynomial receives `degree_*` ($\deg p = n$, by
`eval`, all 24), `sturm_*` ($\operatorname{card}\{x \in \mathbb{R} : p(x) =
0\} = k$, by `sturm`, all 24 including the two of degree 24), `sqfree_*`
($\gcd(p,p') = 1$ over $\mathbb{C}[x]$, by `eval`, 13 of 24) and a
`verdict_*`.

The verdicts take three forms, and the distinction is the substance of the
formalisation. The 7 real-rooted cases assert
$\operatorname{card}\{x : p(x) = 0\} = \deg p$. Six of the 17 failures get
something stronger than a count, namely some $z \in \mathbb{C}$ with
$p(z) = 0$ and $\operatorname{Im} z \ne 0$, from a general lemma proved once
(`Squarefree_Nonreal.nonreal_root_exists`): a squarefree complex polynomial
has exactly $\deg p$ distinct roots by the fundamental theorem of algebra,
and the real roots inject into those with $\operatorname{Im} z = 0$, so a
deficit forces a root off the real axis. Without squarefreeness the deficit
could be a repeated real root instead. The remaining 11, all of degree 12 or
more, carry only $\operatorname{card}\{x : p(x) = 0\} < \deg p$, since
deciding $\gcd(p,p') = 1$ by `eval` runs an executable subresultant-style
gcd that proved squarefreeness for every degree-8 case in 5 to 11 seconds,
including one with a coefficient of $2{,}218{,}493{,}976$, and timed out
beyond 240 seconds on every case of degree 12 or more, including one whose
largest coefficient is 56,222. That wall is degree rather than coefficient
size, and `sturm` itself met no such wall at any degree tested.

All 24 Isabelle root counts agree with the Python ones, and the agreement
means something because Isabelle proves each count itself while the Python
value only states the goal, so a mismatch would appear as a failed build.
Three things remain trusted: the coefficients, checked only by the two
enumerators against each other; the `eval` steps, which reflect into the
code generator and so rest on a wider base than a kernel proof; and the
generator that transcribes coefficient lists into the theory text, a step
visible in the theories and diffable against the results file. Rebuilding
needs the AFP session heap once, then the session:

```
isabelle build -b -o threads=6 Sturm_Sequences
isabelle build -d formal/isabelle -o threads=6 IceMixingSturm
```

The theories themselves are never edited by hand; `python3
formal/isabelle/gen_theory.py` regenerates them from the results file.

The recorded run of the second command took 10 minutes 8 seconds elapsed and
21 minutes 3 seconds of CPU on 6 threads, exiting 0 with no error lines.

# What stands

Three things are not established here: any theorem for general $(a,b,c)$, or
for a cubic cell beyond $(1,1,1)$; any proof that every admissible lattice
point carries a state; and any explanation of the log-concavity beyond the
elimination of its obvious candidate. A related question is settled
elsewhere, in the negative. Log-concavity along lines is the sort of shadow
a Lorentzian or negatively dependent structure would cast [@branden-huh-2020-lorentzian-polynomials;
@anari-et-al-2024-log-concave-polynomials-high-dimensional-walks], which makes it natural to ask whether the bond indicators of
the uniform ice measure are negatively correlated in some diagonal sign
gauge. They are not, and the obstruction is an unbalanced triangle on three
bonds of the 16-spin cell, so no larger cell can repair it
(`docs/reports/2026-09-04-stage4abc.md`, §3).

# Related work

Log-concavity and unimodality of combinatorial sequences have a long
catalogue, surveyed by @stanley-1989-log-concave-unimodal-sequences, updated by @brenti-1994-log-concave-unimodal-sequences-update, and treated
from unimodality through log-concavity to real-rootedness by @branden-2014-unimodality-log-concavity-real-rootedness,
where Newton's inequalities are the classical bridge from real roots to
ultra-log-concavity. The strongest recent framework is that of Lorentzian
polynomials [@branden-huh-2020-lorentzian-polynomials], whose coefficient arrays are log-concave
along lines in a normalised sense and whose sampling consequences drive the
matroid results of @anari-et-al-2024-log-concave-polynomials-high-dimensional-walks. The present histogram is a candidate object
for that theory, and the facts here bear on it in opposite directions, the
coefficients behaving as predicted while the pairwise negative dependence
that usually accompanies such behaviour fails.

Flux sectors are standard equipment in the statistical mechanics of
constrained models. In the Coulomb phase the flux is the coarse-grained
emergent field with a Gaussian distribution at large size [@henley-2010-coulomb-phase-frustrated-systems], a
picture made quantitative for spin ice by @jaubert-et-al-2013-spin-ice-curie-law-crossover. The dimer analogue
is the height function and its tilt, where counting becomes the surface
tension of the variational principle of @cohn-et-al-2001-variational-principle-domino-tilings, strictly convex on the
interior of the Newton polygon by @kenyon-et-al-2006-dimers-and-amoebae, with @kenyon-2009-lectures-on-dimers the
accessible account. What is reported here is the finite-cell, exact-integer
shadow of the concavity in tilt those results establish asymptotically in
two dimensions, with the octahedron playing the part of the Newton polygon.

# Appendix: Artefacts

Paths are relative to the repository root.

| path | contents |
|---|---|
| `icemix/lattice.py`, `icemix/enumerate.py` | the cell and the winding signs; `frontier_count`, `enumerate_ice_states`, `winding`, `winding_by_cut_plane` |
| `icemix/logconcave.py` | support lattice, primitive vector, line and marginal reports, `real_root_counts` |
| `icemix/frozen.py` | `winding_support` and the octahedron argument |
| `experiments/04_lorentzian_giant/results/results.json` | every number in Tables 1 and 2, under `items.4a` |
| `formal/isabelle/` | `ROOT`, `Squarefree_Nonreal.thy`, six generated `Marginals_*.thy`, `gen_theory.py`, `summary.json`, `final-build.log` |
| `tests/test_frozen.py`, `tests/test_stage4abc.py` | the winding-support test, the real-root pins, the log-concavity tests and their negative controls |
| `docs/reports/2026-09-04-stage4abc.md`, `docs/reports/2026-09-04-isabelle-sturm.md` | the stage-4a report with negative dependence in §3; the 24-row certification table and the squarefreeness scope cut |

# References
