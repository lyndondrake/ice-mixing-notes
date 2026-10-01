---
title: "The giant-component conjecture for the hexagon-flip graph of pyrochlore ice"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  The local Markov chain on zero-flux pyrochlore ice states, which reverses the
  six arrows of a hexagon whenever they run head to tail, has a disconnected
  state space: frozen states, with no flippable hexagon, exist at every cell
  size and are isolated vertices of the flip graph. This note states and tests
  the conjecture that they are the only obstruction in cubic geometry, so that
  in every cubic cell the zero-flux states with at least one flippable hexagon
  form a single component. The five enumerable cells are censused exactly. At
  $(1,2,2)$, the only one with a two-dimensional cross-section, 221,628
  zero-flux states fall into 205 components, a giant of 221,424 and 204
  singletons, every singleton frozen, which makes the conjecture exhaustively
  true there; the quasi-one-dimensional cells shatter instead, so the
  restriction to thick geometry is doing real work. Beyond enumeration the
  evidence is 27,000 random zero-flux starts at cubic $L = 2$ and $L = 3$, half
  fresh and half manufactured next to the frozen set by loop reversals: 13
  landed frozen, and every one of the remaining 26,987 was given an explicit
  path of hexagon flips to the reference state, with none left uncertified.
  This is a conjecture with computational evidence and no certificate. Nothing
  here is a proof, and because neither sampler is uniform the evidence does not
  even bound the density of a hypothetical second non-frozen component.
---

# The model and the flip graph

Pyrochlore ice is an arrow field on the bonds of the diamond lattice. Each
bond carries one bit, read as an arrow, and the ice rule requires exactly two
of the four arrows at each diamond site to point in. The cells used here are
$a \times b \times c$ conventional cubic cells with periodic boundaries,
carrying $16abc$ bonds, $8abc$ sites and $16abc$ hexagons; the cubic cell of
side $L$ is the case $a = b = c = L$, with $16L^3$ spins. Hexagons are derived
from adjacency together with displacement rather than taken as any six-cycle,
which matters because the smallest cell has 96 six-cycles against 16 true
hexagons.

Because the arrow field is divergence-free, the net arrow flux through each of
the three coordinate cut planes is conserved by any move that reverses a
closed loop. Write $\mathbf{W} = (W_x, W_y, W_z)$ for that flux. All the work
below is in the sector $\mathbf{W} = \mathbf{0}$, the largest one.

The chain's only move is the hexagon flip. A hexagon is *flippable* when its
six arrows run head to tail around the cycle in one sense or the other, and
the move reverses all six; in bit terms the six bond bits alternate around the
cycle, and the flip is an exclusive-or with the hexagon's mask. The move
preserves the ice rule and $\mathbf{W}$, and it is its own inverse, so it
defines an undirected graph. The *flip graph* has the
$\mathbf{W} = \mathbf{0}$ ice states of a cell as its vertices and one edge per
flippable hexagon per state. A state with no flippable hexagon is *frozen*,
and is an isolated vertex. In Rokhsar–Kivelson language a frozen state is an
exact zero-energy eigenstate degenerate with the equal-weight superposition
over its sector, so its existence is a statement about the ground-space
degeneracy and not merely about an algorithm [@rokhsar-kivelson-1988-superconductivity-quantum-hard-core-dimer-gas].

Frozen zero-flux states exist at every cell size. Two constructions give them,
periodic tiling of the twelve states of the $(1,1,1)$ cell and a Klein-type
$4 \times 4$ matrix construction, and both are theorems with hand proofs and
machine-checked unsatisfiability certificates for their cell instances. So the
zero-flux sector is never connected, its spectral gap is exactly zero at every
size, and every mixing statement about this chain is a statement about one
component.

# The conjecture

Frozen implies isolated, trivially. The conjecture is the converse at the
level of components.

> **(NF$\Rightarrow$G).** In every cubic cell, every non-frozen zero-flux ice
> state lies in one and the same component of the flip graph. Equivalently:
> the subgraph induced on the non-frozen zero-flux states is connected, and
> the zero-flux flip graph has exactly one more component than the cell has
> frozen zero-flux states.

The second form is the useful one for testing, because it turns a statement
about a giant component into an exact count. At the first cubic cell,
$(2,2,2)$, the number of frozen zero-flux states is known to be 612, obtained
by frozen-constrained SAT enumeration and independently certified by a
proof-logging model counter. Under the conjecture the $(2,2,2)$ zero-flux flip
graph therefore has exactly 613 components, one of them holding all
$\sim 2 \times 10^{11}$ remaining states. Nobody can check that count directly;
it is recorded because it is the sharpest form the conjecture takes at a cell
whose frozen set is fully known.

Two cautions belong with the statement. The phrase 'giant component' has to be
read by size rather than by label, since global arrow reversal permutes the
components and non-singleton components therefore come in equal-size pairs at
most cells. And the restriction to cubic geometry is not decoration: the
census below shows the conjecture failing outright on the
quasi-one-dimensional cells, so no proof can rest on the ice rule alone.

# The exact census

Five cells have a zero-flux sector small enough to enumerate with a 64-bit
state word. For each, the sector is enumerated by depth-first search with
winding pruning (`icemix.enumerate.enumerate_ice_states` with
`zero_winding_only`), the flip graph is built as a sparse adjacency matrix
with the closure of the state set under every flippable move asserted
(`icemix.chain.build_flip_graph`), and components are taken with SciPy
(`icemix.chain.components`). The full multiset of component sizes was
recomputed from scratch for this note; it agrees with the stage-1 census in
every entry, and with the stage-4 recomputation at $(1,2,2)$.

| cell | spins | $\mathbf{W}=\mathbf{0}$ | components | giant | giant frac. | frozen |
|---|---:|---:|---:|---:|---:|---:|
| $(1,1,1)$ | 16 | 12 | 12 | 1 | 8.3 % | 12 |
| $(1,1,2)$ | 32 | 388 | 70 | 160 | 41.2 % | 68 |
| $(1,1,3)$ | 48 | 15,024 | 540 | 3,360 | 22.4 % | 528 |
| $(1,2,2)$ | 64 | 221,628 | 205 | 221,424 | 99.91 % | 204 |
| $(1,1,4)$ | 64 | 637,988 | 5,492 | 43,008 | 6.7 % | 5,412 |

Writing $s^{m}$ for $m$ components of size $s$, the full size multisets are
$1^{12}$ at $(1,1,1)$; $1^{68}, 160^{2}$ at $(1,1,2)$;
$1^{528}, 432^{2}, 864^{8}, 3360^{2}$ at $(1,1,3)$;
$1^{204}, 221424^{1}$ at $(1,2,2)$; and
$1^{5412}, 832^{2}, 2496^{66}, 21120^{2}, 42240^{8}, 43008^{2}$ at $(1,1,4)$.

Several things can be read off. Singleton components are exactly the frozen
states at every cell, with no exceptions in either direction. Non-singleton
sizes occur with even multiplicity everywhere except $(1,2,2)$, where the
giant is a single component that global arrow reversal maps to itself. No
component straddles two flux sectors, checked over all 25, 69 and 137 sectors
of the three smallest cells.

The cell that carries the conjecture is $(1,2,2)$, the only enumerable cell
with a two-dimensional cross-section. There the 204 components outside the
giant are all singletons and all frozen, so (NF$\Rightarrow$G) is
exhaustively true, and the giant holds 99.91 % of the sector. The
quasi-one-dimensional cells behave in the opposite way: at $(1,1,3)$ twelve
non-singleton components share the sector, and at $(1,1,4)$ there are 66
components of size 2,496 and eight of size 42,240, none of them frozen and
none the giant. Disconnection at those cells is an aspect-ratio effect, which
is why the conjecture is stated for cubic cells only.

The first cubic cell is already out of reach, with roughly
$2 \times 10^{11}$ zero-flux states at $(2,2,2)$. The next anisotropic cell up,
$(1,2,3)$, has 196,465,480 of them and is blocked three ways: its 96 bonds
exceed the 64-bit state word that the enumerator and the component machinery
both assume, the depth-first enumeration projects to about 8.5 hours at the
measured leaf rate, and the flip graph would carry some $9.4 \times 10^9$
edges. The exact route stops here, so the evidence at cubic cells has to be of
a different kind.

# Random starts, and what a flip path certifies

The probe is simple. Draw a zero-flux state at random, and if it is not frozen
try to build an explicit path of hexagon flips from it to a fixed reference
state $R$. A path found certifies that the two states share a component. A
path not found is inconclusive, and is never reported as a negative result.

The reference state is fixed by the convention `giant-start-1`. Starting from
the Klein zero-flux state, which is frozen at every cell, the construction
applies $4 n_{\text{spins}}$ contractible directed-loop reversals at fixed
$\mathbf{W} = \mathbf{0}$ to destroy the frozen tiling, then raises the
flippable-hexagon count by simulated annealing using hexagon flips only,
keeping the best of eight deterministic restarts. The annealing step is
component-preserving, so the accessible sector $D$ is defined as the component
of $R$ rather than assumed to be anything. At $(2,2,2)$ the resulting $R$ has
40 of its 128 hexagons flippable.

Two samplers supply the starts, because neither is uniform and they fail in
different directions. `sample_w0_dfs` runs a randomised ice-rule depth-first
search to a single leaf and then drives the flux to zero with
winding-changing loop reversals, giving a fresh state with no memory of any
flip component. `sample_w0_loops` applies $n$ contractible loop reversals to
the Klein frozen state, preserving both the ice rule and
$\mathbf{W} = \mathbf{0}$; with $n$ small this manufactures near-frozen
adversarial starts, which is what a hypothetical second non-frozen component
should be most exposed to. Loop reversal is used only to manufacture starts
and never in the measured dynamics, and the reason it is right here is the
reason it is forbidden there: it can move between flip components.

The certificate itself is `certify_connected`, an annealed descent on the
Hamming distance to $R$ with the inverse temperature swept from 0.02 to 6 over
$4 \times 10^6$ attempted moves and three restarts, and on failure a retry at
$6.4 \times 10^7$ moves with six restarts. Every accepted move is a legal
hexagon flip, checked against the alternation condition before it is applied,
so a run reaching Hamming distance zero has walked a genuine path in the flip
graph from the start state to $R$.

| cell | family | starts | frozen | certified | uncert. | med. flip. |
|---|---|---:|---:|---:|---:|---:|
| $(2,2,2)$ | DFS | 10,000 | 0 | 10,000 | 0 | 23 |
| $(2,2,2)$ | $n=1$ | 1,000 | 11 | 989 | 0 | 14 |
| $(2,2,2)$ | $n\le16$ | 6,000 | 0 | 6,000 | 0 | 20–24 |
| $(3,3,3)$ | DFS | 3,000 | 0 | 3,000 | 0 | 74 |
| $(3,3,3)$ | $n=1$ | 1,000 | 1 | 999 | 0 | 16 |
| $(3,3,3)$ | $n=2$ | 1,000 | 1 | 999 | 0 | 34 |
| $(3,3,3)$ | $n\le16$ | 5,000 | 0 | 5,000 | 0 | 47–77 |
| **total** | | **27,000** | **13** | **26,987** | **0** | |

'DFS' is the fresh sampler and $n$ is the number of loop reversals off the
Klein state; the $n \le 16$ rows aggregate $n \in \{2,3,4,6,8,16\}$ and
$n \in \{3,4,6,8,16\}$ respectively, of 1,000 starts each. Certified plus
frozen exhausts every row, so no start was left uncertified anywhere. The last
column is the median number of flippable hexagons, out of 128 at $L = 2$ and
432 at $L = 3$. The sweep shows the adversarial construction doing what it was
built to do. One loop reversal off the Klein state leaves a median of 14
flippable hexagons at $L = 2$ and 16 at $L = 3$, against equilibrium medians of
23 and 74. All thirteen frozen starts of the whole run came from $n = 1$ or
$n = 2$, and every near-frozen start that was not itself frozen certified.
Path lengths were
not retained in the summary file, so nothing is claimed about how long the
certifying walks were.

An earlier and smaller version of the same probe ran 780 zero-flux starts at
cubic $L = 2$: 300 from the depth-first sampler and 120 each at $n = 2, 8, 64$
and 512 loops. None was frozen, none had two or fewer flippable hexagons, all
780 certified, and the median residual Hamming distance was zero. The
27,000-start run extends that by a factor of 22 at $L = 2$ and reaches
$L = 3$, a cell of 432 spins, for the first time.

What makes the certificate worth quoting is that it was calibrated where the
truth is known. At $(1,2,2)$ and $(1,1,4)$ the same procedure was run on 330
starts each and every verdict compared against the exact component
decomposition. At $(1,2,2)$, 328 of 330 certified and all 328 were genuinely
in $R$'s component. At $(1,1,4)$ only 17 of 330 certified; each of those 17 was
genuinely in $R$'s component, and the remaining 313 genuinely were not. There
were no false positives and no false negatives at either cell. The fresh-DFS
group at $(1,1,4)$ certified 10 of 150, or 6.67 %, against the exact giant
fraction of 6.74 % there. The annealed descent is therefore not vacuously
permissive; it says no, correctly, 313 times out of 330 when the answer is no.

Neither sampler is uniform, and `sample_w0_dfs` rejects a fraction of its own
attempts, which biases it further. The frozen fractions in the table are
informative about the samplers and not about the uniform measure, and the
27,000 successes place no bound on the density of a hypothetical second
non-frozen component.

# Consequences for a mixing theorem

Since frozen states exist at every size, the spectral gap of the chain on the
full zero-flux sector is exactly zero for all $L$, and a rapid-mixing theorem
can only be stated on a component. That is a restriction on the statement, not
a caveat attached to it. The project's chains start at $R$ and move only by
hexagon flips, so membership of $D = \operatorname{comp}(R)$ holds by
construction; what has to be measured is whether $D$ is the giant.

It is not always. At $(1,1,4)$ the canonical reference state sits in a
component of 42,240 states while the giant has 43,008, and the exact gaps on
the two differ by a factor of 3.6. A state drawn uniformly from the zero-flux
sector at that cell is unreachable from the giant 93 % of the time.

If (NF$\Rightarrow$G) holds, all of this collapses in cubic geometry. The
accessible component is then the giant, characterising it reduces to
enumerating the frozen states, and the frozen states are the part of the
problem with structure: they are built by periodic tiling and by the Klein
construction, they are periodic at $(2,2,2)$ and at $(3,3,3)$ with checked
proofs, and their density falls with size, reaching 0.092 % already at
$(1,2,2)$. A dynamical question about connectivity becomes a static question
about a sub-extensive set. That is the reason to want the conjecture, and also
the reason not to assume it.

# What would refute it

One closed breadth-first search suffices. `icemix.component.bfs_component`
starts from a single state held as a Python big integer, so it is not bound by
the 64-bit word that limits the enumerators, and closes that state's component
under hexagon flips subject to a state cap and a wall-clock cap. The asymmetry
of the result is the point and is reflected in the return value. A search that
closes is a proof, since the component then has exactly the states found, so a
closed component containing a non-frozen state but not $R$ is a
counterexample; a search that hits either cap proves nothing and is reported
as inconclusive. In the 27,000-start run the search was armed at a cap of
$10^6$ states and 1,800 seconds and never fired, because no non-frozen start
went uncertified. It is tested against the exact decomposition at $(1,1,2)$,
where it reproduces the 160-state component, and against the twelve frozen
singletons at $(1,1,1)$.

The other refutation is an exact census at a cubic cell, which would settle
the matter rather than merely refute it, and which is out of reach for the
reasons given above. A cheaper intermediate target would be a census at a cell
with two thick directions and one thin one beyond $(1,2,2)$; the nearest such
cell, $(1,2,3)$, needs a new state representation before it needs anything
else.

Two negative observations bound what the current evidence can be asked to do.
The conjecture is false without the cubic restriction, as the $(1,1,c)$ rows
of the census show, so a proof has to use the geometry. And because neither
sampler is uniform, a second non-frozen component could exist at cubic $L = 2$
or $L = 3$ provided it is missed by both, which is a weaker thing to have
ruled out than the raw count of starts suggests.

# Related work

The graph-theoretic baseline is the cycle-reversal system. Reversing a
directed cycle in an orientation preserves every in-degree, and conversely two
orientations of a graph with the same in-degree sequence differ on a set of
edges that decomposes into directed cycles, so reversing all directed cycles
connects them; Gioan sets this inside the wider cycle–cocycle reversing system
and counts its classes [@gioan-2007-enumerating-degree-sequences-digraphs]. Ice states are exactly the orientations
with in-degree 2 everywhere, so the whole ice manifold is connected under
reversal of arbitrary directed cycles, and it is the restriction of the cycles
that creates the problem. On the torus, restricting to contractible cycles is
what preserves the flux; restricting further to the shortest contractible
cycles, the hexagons, is what admits frozen states. Read that way,
(NF$\Rightarrow$G) is a statement about how short the reversible cycles may be
before connectivity fails, and frozen states are the exact locus of the
failure. Counting Eulerian orientations, and the standard chain on them, go
back to Mihail and Winkler [@mihail-winkler-1996-eulerian-orientations-count]; in the planar case the chain that
reverses directed faces is ergodic classically, and its mixing time on
subgraphs of the triangular lattice is polynomial [@creed-2009-sampling-eulerian-orientations]. Connectivity
is not the only obstacle even when it holds, as the six-vertex model on
$\mathbb{Z}^2$ shows, where the local chain is torpidly mixing in the ordered
phases [@liu-2018-torpid-mixing-six-vertex-model; @fahrbach-randall-2019-slow-mixing-glauber-dynamics-six-vertex-model].

The dimer literature has met the same difficulty in the same dimension and has
the sharpest results on it. For three-dimensional domino tilings the flip move
alone does not connect a flux class; a second move, the trit, is needed, and
the obstruction to flip-connectivity is a genuine integer invariant, the
twist, rather than a pathology [@freire-et-al-2022-connectivity-3d-domino-tilings]. Hartarsky, Lichev and Toninelli
study which cycle lengths suffice for ergodicity of local dimer dynamics on
hypercubic boxes and show that in three dimensions every configuration admits
an alternating cycle of length at most six [@hartarsky-et-al-2024-local-dimer-dynamics-higher-dimensions], the same shape of
question as the one asked here and with the same answer, that short cycles are
almost but not quite enough. Klivans and Saldanha survey the higher-dimensional
picture and its open problems [@klivans-saldanha-2025-domino-tilings-beyond-2d]. Their general point, that beyond
the planar bipartite case there is no canonical height function and ergodicity
of the local dynamics stops being routine, applies directly to pyrochlore ice.

On the physics side the response to frozen and near-frozen configurations has
been to replace the local move rather than to characterise where it fails.
Melko, den Hertog and Gingras introduced loop moves for dipolar spin ice
precisely because single-spin dynamics freezes below about 0.4 K in
$\mathrm{Dy_2Ti_2O_7}$, and the loop move, being ice-rule preserving, restores
sampling of the quasi-degenerate manifold [@melko-et-al-2001-long-range-order-dipolar-spin-ice; @melko-gingras-2004-dipolar-spin-ice-monte-carlo]. The
classical Monte Carlo community built the loop and worm algorithms with the
same motivation [@barkema-newman-1998-monte-carlo-ice-models; @shinaoka-2011-pyrochlore-heisenberg-spin-ice-loop-algorithm; @otsuka-2014-cluster-algorithm-spin-ice]. Ergodicity
breaking in this family is observed as well as simulated, since real-space
imaging of vortex-frustrated artificial spin ice shows ergodicity transitions
directly [@saccone-et-al-2023-real-space-ergodicity-spin-ice]. The question in this note is the complementary one:
not how to repair the local chain, but whether the local chain is already
ergodic off the set where it manifestly is not.

# Artefacts {.appendix}

All paths are relative to the repository root.

| path | contents |
|---|---|
| `icemix/chain.py` | `build_flip_graph`, `components`, and `flippable_ref`, the definition-level predicate the fast one is tested against |
| `icemix/enumerate.py` | `enumerate_ice_states` with `zero_winding_only`; the frontier program used for counts beyond enumeration |
| `icemix/start.py` | the `giant-start-1` convention, the two samplers, `certify_connected`, `verify_reference_in_giant` |
| `icemix/component.py` | `bfs_component`, the bounded closure of one component at arbitrary spin count |
| `icemix/_msc.c` | `msc_anneal_to_target`, the annealed descent that applies only legal hexagon flips |
| `experiments/`&#8203;`04_lorentzian_giant/` | `run_stage4abc.py`, the 27,000-start run; `results/part_4c.json`, holding the second table, the recomputed $(1,2,2)$ census and the run provenance |
| `experiments/`&#8203;`02_calibration/` | `results/results.json`, holding the 780-start probe (`connectivity_cubic_L2`) and the certificate calibration (`connectivity_calibration`) |
| `docs/reports/` | `2026-09-04-stage4abc.md`, the run report with pre-flight, ledger and defects; `2026-08-11-stage1-falsifiers.md`, the original census; `2026-09-04-certificates-sat.md`, the certified frozen counts, including 612 at $(2,2,2)$ |

The census table was recomputed for this note by enumerating the zero-flux
sector at each of the five cells, building the flip graph and taking the full
multiset of component sizes. It takes about 28 seconds on one core for all
five cells, and reproduces the earlier numbers exactly.
