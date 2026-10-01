---
title: "A pseudoscalar slow mode in pyrochlore ice dynamics: the emergent magnetic helicity at a thin cell"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  At the pyrochlore ice cell $(1,2,2)$, small enough to enumerate exactly, the
  slowest mode of the single-hexagon-flip chain is even under global arrow
  reversal and so invisible to the polarisation, the observable on which the
  chain's dynamical exponent is measured. This note identifies it. Its
  character under the cell's 256-element affine automorphism group is the
  determinant of the group element, so it is a pseudoscalar, and the natural
  bilinear pseudoscalar of a divergence-free field is the emergent magnetic
  helicity $\mathbf q\cdot(\mathbf P^{*}\times\mathbf P)$. One helicity
  observable has overlap $0.759$ with the eigenvector and the family spans
  $0.835$ of it against a total degree-two content of $0.853$, while every
  member of the project's earlier panel has overlap below $10^{-25}$, a zero
  forced by symmetry rather than by amplitude. The helicity reaches
  $\tau_{\exp}=389.45$ attempts against an exact $1/\Delta=389.95$, where the
  best earlier member reaches $263.13$. The effect is geometric: measured in
  cubic cells at $L=2$ to $16$, the ratio of helicity to polarisation
  relaxation times falls monotonically to $0.4988\pm0.0025$, the two-photon
  value, so no slow helicity mode survives a third thick direction. The
  verification is an exact spectrum by diagonalisation of the two parity
  blocks, symmetry analysis under arrow reversal and the derived point group,
  exhaustive parity checks on all 221,424 accessible states, and measured
  autocorrelations in cubic geometry. There is no formal certificate.
---

# The chain and the cell

Pyrochlore spin ice states are the two-in-two-out configurations of Ising
spins on the pyrochlore lattice [@bramwell-gingras-2001-spin-ice-state], equivalently the Eulerian
orientations of the diamond lattice whose bonds carry the spins. The smallest
ice-preserving move reverses the six arrows around a hexagonal plaquette, a
single spin flip creating a monopole pair instead [@castelnovo-et-al-2008-magnetic-monopoles-spin-ice]. The
chain studied here picks a hexagon uniformly at random and, if its arrows run
head-to-tail, reverses all six with probability $1/2$. It is reversible with
the uniform stationary distribution on each flux sector, and under Henley's
classical-to-quantum correspondence its generator is the ring-exchange
Hamiltonian of pyrochlore ice at its Rokhsar–Kivelson point
[@henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points; @rokhsar-kivelson-1988-superconductivity-quantum-hard-core-dimer-gas; @hermele-et-al-2004-pyrochlore-photons-u1-spin-liquid].

Cells are blocks of $(a,b,c)$ conventional cubic cells with periodic
boundaries, holding $16abc$ spins and as many hexagons, the hexagon set
derived from the coordinates rather than read off the quotient graph. The
winding $\mathbf W$ is conserved and everything below sits at $\mathbf W=0$, a
sector never connected because frozen states exist in it at every size, so the
object of study is its dynamically accessible component. At $(1,2,2)$, 64
spins and 64 hexagons give 221,628 zero-winding states in 205 components: a
giant component of 221,424 states, whose transition matrix has 2,651,888
nonzeros, and 204 frozen singletons. That component is small enough to
diagonalise rather than sample.

# What an observable can see

Global arrow reversal $R$ complements every arrow bit. It commutes with the
transition matrix $P$, and on the giant component it has no fixed point, so
it acts as a free involution with 110,712 two-element orbits. Taking one
representative $r_j$ per orbit and its partner $p_j$, the vectors
$(e_{r_j}\pm e_{p_j})/\sqrt2$ span the even and odd subspaces, and
$P^{\pm}[j,k]=P[r_j,r_k]\pm P[r_j,p_k]$ are two symmetric blocks of size
110,712 whose spectra partition the spectrum of $P$.

The autocorrelation of an observable $O$ is
$\rho(t)=\langle y,P^ty\rangle/\langle y,y\rangle$ with $y=O-\langle O\rangle$,
a sum of decaying exponentials weighted by the squared overlaps of $y$ on the
eigenvectors, so an observable of definite parity has overlap exactly zero on
every eigenvector of the opposite parity and its $\tau_{\exp}$ is only a lower
bound on $1/\Delta$. That an observable's autocorrelation time is not the
chain's is standard [@sokal-1997-monte-carlo-statistical-mechanics]. What is unusual here is that a symmetry
makes the shortfall exact, so no series length and no system size closes it.

The natural observable is the coarse-grained polarisation: with
$\sigma_b=2x_b-1$, $\mathbf d_b$ the bond's A-to-B displacement and
$\mathbf q^{(k)}=(2\pi/4c_k)\,\mathbf e_k$,
$P_j^{(k)}=N^{-1}\sum_b \sigma_b d_{bj}e^{i\mathbf q^{(k)}\cdot\mathbf r_b}$,
whose transverse components $j\neq k$ carry the Coulomb-phase slow mode
[@henley-2010-coulomb-phase-frustrated-systems; @isakov-et-al-2004-dipolar-spin-correlations-pyrochlore]. Every $\sigma_b$ changes sign under $R$, so
$\mathbf P$ is odd, and at $(1,2,2)$ the three slowest eigenvectors are even.
The project's response was a panel of both parities at every size, the slowest
member taken as the headline and reported as a lower bound. Its three even
members were the flippability structure factor $F(\mathbf q)$, the total
flippable count, and $|\mathbf P_\perp|^2$. None of those sees the slow mode
either, for a second reason beyond parity.

# The exact spectrum, and a pseudoscalar character

Lanczos on each parity block, $k=14$, with the uniform vector deflated in the
even block, took 930 and 973 matrix-vector products. Merged, the three
slowest modes of the chain are even and the fourth is odd. Per attempt
$\Delta_{\mathrm{even}}=2.5644358\times10^{-3}$ and
$\Delta_{\mathrm{odd}}=4.1225073\times10^{-3}$, a ratio of $0.622057$, so
$1/\Delta=389.949$ attempts against the $242.571$ the polarisation can reach.
The slowest even eigenvector, written $v$ below, is simple, separated from the
second even mode by $1.229\times10^{-3}$ in $\lambda$, so every reading of it
is a property of the chain. The slowest odd eigenvalue is fourfold
degenerate, which is why the odd readings here are multiplet invariants.
Against an independently banked earlier spectrum the maximum difference over
the top ten eigenvalues is $5.44\times10^{-15}$, all ten parities agree, and
the lifted eigenvectors satisfy $\lVert Pv-\lambda v\rVert<10^{-14}$.

The cell's affine automorphisms are derived from the coordinates rather than
assumed: maps $p\mapsto Mp+t$ modulo the box, with $M$ a signed axis
permutation, are accepted only if they permute the site set, carry every bond
to a bond, and carry the derived hexagon set to itself, and where the map
exchanges the A and B sublattices the arrow bit complements. At $(1,1,1)$ the
construction returns 192 automorphisms, the number of general positions of
$Fd\bar3m$ in one conventional cubic cell, asserted as a test, and at $(1,2,2)$ it
returns 256, all acting on the giant component and each verified to commute
with $P$. The character $\chi(g)=\langle v,gv\rangle$ is $\pm1$ on every one
of them, and

$$\max_g\;\bigl|\chi(g)-\det M_g\bigr| \;=\; 2.66\times10^{-14}$$

over 128 proper and 128 improper operations. So $v$ transforms in the
determinant representation, invariant under every proper operation and
sign-reversing under every improper one, with a stabiliser of exactly 128
elements. Under the two transverse translations its character is
$1.000000000000$, so it sits at zero momentum, while the trace characters
$0$, $0$ and $-4$ of the fourfold odd multiplet force those four states to
the transverse zone-boundary momenta. An even, zero-momentum, pseudoscalar
function of a divergence-free field has a short list of candidates, and the
first of them is the helicity.

# The emergent magnetic helicity

For a divergence-free field the natural bilinear pseudoscalar is
$\mathbf q\cdot(\mathbf P^{*}\times\mathbf P)$. With $\mathbf q$ along axis
$k$ and $(i,j,k)$ cyclic, the code computes

$$h_k(\mathbf q) \;=\; \operatorname{Im}\bigl(P_i(\mathbf q)^{*}P_j(\mathbf q)\bigr)
   \;=\; \operatorname{Re}P_i\cdot\operatorname{Im}P_j
       - \operatorname{Im}P_i\cdot\operatorname{Re}P_j ,$$

three multiplies and a subtraction on polarisation components the sampler
already records, with $P_i$ and $P_j$ transverse to $\mathbf q$ by
construction. The quantity is even under arrow reversal, being a product of
two odd factors, and changes sign under every improper lattice operation
because the cross product does. In the continuum it is the magnetic helicity
$\int\mathbf A\cdot\mathbf B$ of the emergent gauge field. Its parity is
measured rather than inferred: over all 221,424 states every helicity column
satisfies $h(Rs)=h(s)$ to a relative deviation below $10^{-12}$, and every
non-vanishing polarisation column satisfies $P(Rs)=-P(s)$. Of 259 named
observables whose overlap
$\langle v,O\rangle^2/(\lVert v\rVert^2\lVert O\rVert^2)$ with $v$ was
computed, the eight largest are all helicities.

| observable | overlap with $v$ | with the 2nd even mode |
|---|---|---|
| $h_y+h_z$ at $q_{\min}$ | **0.75859** | $2.4\times10^{-26}$ |
| $h_y$, $h_z$ at $q_{\min}$ | 0.43300 | $1.8\times10^{-22}$ |
| $h_x+h_y+h_z$ at $q_{\min}$ | 0.42149 | $1.3\times10^{-26}$ |
| $h_y+h_z$ at $2q_{\min}$ | 0.27991 | $9.8\times10^{-27}$ |
| $h_y-h_z$ at $q_{\min}$ | $2.3\times10^{-27}$ | $4.2\times10^{-22}$ |
| $h_x$ at $q_{\min}$ (thin axis) | 0.03464 | $1.6\times10^{-27}$ |

: Overlaps of the slowest even eigenvector with the helicity family, with the
second even mode as a control.

The span of the eleven independent helicity columns captures $0.83456$ of
$v$. A least-squares projection onto spin monomials $\sigma_S=\prod_{b\in
S}\sigma_b$, done as a genuine Gram solve because the monomials are not
orthogonal once restricted to an ice sector, puts the total degree-two content
of $v$ at $0.853223$, identical at rank cutoffs $10^{-8}$, $10^{-10}$ and
$10^{-12}$. The helicity family therefore accounts for 98 per cent of
everything of degree two in the mode, and the best non-helicity overlap is
$0.066707$. Two controls close the identification. The $y\leftrightarrow z$
swap has determinant $-1$, so it must send $v$ to $-v$, and geometrically it
exchanges $h_y$ with $h_z$ and flips the helicity's sign, so $h_y+h_z$ is odd
under it and matches, while $h_y-h_z$ is even and must be orthogonal, as the
measured $2.3\times10^{-27}$ says it is. And the matrix
$C_{ij}=\langle v,\sigma_i\sigma_j\rangle$ describing the degree-two content
has effective rank $18.35$ with leading eigenvalues in $\pm$ pairs at
$\pm0.002933$, the signature of an antisymmetric pairing rather than of the
square of a single bond-linear form, which would give a rank-one $C$ of one
sign.

# The blind spot, in relaxation times

Autocorrelations were computed exactly by 4,000 sparse matrix-vector
products, so the numbers below carry no statistical error.

| observable | parity | $\tau_{\mathrm{int}}$ (att) | $\tau_{\exp}$ (att) | couples to |
|---|---|---|---|---|
| $P_\perp(q_{\min})$ | odd | 181.73 | 242.07 | slowest odd mode |
| $F(q_{\min})$ | even | 49.78 | — | nothing in the top 28 |
| $n_{\mathrm{flippable}}$ | even | 51.69 | 176.85 | a fast even mode |
| $\lvert P_\perp(q_{\min})\rvert^2$ | even | 105.77–124.64 | 263.13 | 2nd even mode |
| $h_y+h_z$ at $q_{\min}$ | even | **309.02** | **389.45** | the slowest mode |

: Exact relaxation times at $(1,2,2)$, against $1/\Delta=389.95$ attempts and
$\tau_{\exp}(\lambda_2)=389.45$.

The helicity's $\tau_{\exp}$ is the chain's true relaxation time to the last
digit, where the earlier panel tops out at $263.13$, short of the gap by a
factor $1.61$. Overlaps of the earlier panel's even members with $v$ are
$3.4\times10^{-29}$ and below for the four flippability channels,
$7.0\times10^{-30}$ for the flippable count, and $8.9\times10^{-27}$ and
below for the four squared-polarisation channels, with last digits that move
between runs. Those are symmetry-enforced zeros rather than small numbers,
because the observables are true scalars under improper operations and $v$ is
a pseudoscalar, which is stronger than suppression by powers of
$q_{\min}^2$. The stochastic estimator sees the mode too, which matters
because cubic cells can only be sampled: with 512 replicas and 20,000 samples
at 39 attempts it returns $\tau_{\exp}(h_y+h_z)=378.08\pm1.92$ attempts
against $377.55$ for the identical fit applied to the exact $\rho(t)$.

# Cubic geometry

Exact diagonalisation cannot reach cubic cells: cubic $L=2$ has of the order
of $2\times10^{11}$ states at $\mathbf W=0$. The question went to the Monte
Carlo instead, with the helicity added to the production panel as four even
families and left off by default so that the earlier panel reproduces bit for
bit. With the same seeds, sampling intervals, burn-ins, replica counts and
series lengths, $\tau_{\exp}(P_\perp)$ agrees with the banked campaign table
to between $8.8\times10^{-9}$ and $1.8\times10^{-6}$ relative at every size,
which is the rounding of the six-figure constants compared against, and
ice-rule and winding violations were zero throughout. Write
$R_h(L)=\tau_{\exp}(h,q_{\min})/\tau_{\exp}(P_\perp,q_{\min})$.

| $L$ | 2 | 3 | 4 | 6 | 8 | 12 | 16 |
|---|---|---|---|---|---|---|---|
| $R_h$ | 0.6813 | 0.5417 | 0.5131 | 0.5048 | 0.5026 | 0.5010 | 0.4988 |
| $\pm$ | 0.0051 | 0.0023 | 0.0018 | 0.0017 | 0.0019 | 0.0015 | 0.0025 |
| $\lvert P_\perp\rvert^2/P_\perp$ | 0.4608 | 0.4687 | 0.4847 | 0.4928 | 0.4958 | 0.4992 | 0.4972 |
| $\tau_{\exp}(P_\perp)$ (sw) | 1.8031 | 3.4722 | 5.8044 | 12.428 | 21.813 | 48.424 | 85.929 |

: Cubic ladder, 1024 replicas (512 at $L=16$), 6,000 samples per replica,
jackknifed over multi-spin-coding blocks.

$R_h$ falls monotonically to one half, approaching from above and crossing to
$0.4988\pm0.0025$ at $L=16$, while the independent control
$|P_\perp|^2/P_\perp$ approaches the same value from below, the two meeting by
$L=8$. All four helicity families pass the resolution gate at every size, with
fit $r^2$ between $0.9891$ at $L=2$ and $1.0000$ for $L\geq6$, so no helicity
number here is a fit to noise. At the Gaussian fixed point the photons are odd
under arrow reversal, so the even sector is the sector of even photon number,
whose lowest state is two photons at $\pm q_{\min}$ relaxing at half the odd
time. The helicity is a two-photon composite and lands exactly there. It had
no obligation to, since it carries a different representation of the cubic
point group from $|P_\perp|^2$, and the two agreeing from opposite sides is
better evidence than either alone. In cubic geometry the odd polarisation
remains the slowest member of the panel at every size.

# Why the thin cell is different

Thinness alone is not the cause. Across the cells the enumerator can reach,
$\Delta_{\mathrm{even}}/\Delta_{\mathrm{odd}}$ sorts by cross-section rather
than by volume.

| cell | spins | giant | quasi-1D | $1/\Delta$ even | $1/\Delta$ odd | ratio |
|---|---|---|---|---|---|---|
| $(1,1,2)$ | 32 | 160 | yes | 35.67 | 132.47 | 3.71429 |
| $(1,1,3)$ | 48 | 3,360 | yes | 81.48 | 310.56 | 3.81136 |
| $(1,2,2)$ | 64 | 221,424 | **no** | 389.95 | 242.57 | **0.62206** |
| $(1,1,4)$ | 64 | 43,008 | yes | 161.85 | 628.03 | 3.88035 |

: $\Delta_{\mathrm{even}}/\Delta_{\mathrm{odd}}$ per attempt on the giant
component of each enumerable cell. The $(1,1,c)$ cells are
quasi-one-dimensional and were excluded from anchoring anything, and at
$(1,1,4)$ the giant component is not the component the production chain lives
in.

The three quasi-one-dimensional cells sit between $3.7$ and $3.9$ and rise
slowly with length. $(1,2,2)$ is the only reachable cell with two directions
of extent greater than one, and the only one where the even sector is
slowest. A helicity needs two independent transverse directions to have a
long wavelength, and the measurements say so directly: the helicity about the
thin axis has overlap $0.03464$ with $v$ against $0.75859$ for the
combination on the two thick axes. Momentum is the other half of the
geometry. With $b=c=2$ the smallest nonzero wavevector along a transverse
axis is already the zone boundary, where $e^{iq_{\min}a}=-1$, and that is
exactly where the character analysis puts the fourfold odd multiplet while
the helicity sits at zero momentum. A cell two units across has no interior to
its Brillouin zone, so the ordering of the two sectors is settled by a
two-point comparison a larger cell would not make. Adding a third thick
direction restores the Gaussian counting, and the cubic ladder shows that
happening.

# What remains open

The natural next cell is $(1,2,3)$, which would test whether the helicity
stays slowest when one transverse direction is lengthened. Its $\mathbf W=0$
count is known exactly, 196,465,480 states from a frontier dynamic programme
in $14.9$ seconds. The diagonalisation is what does not fit, at 31 to 243
hours of wall time, the binding constraints being the binary-search index
used to build the adjacency and the unaccelerated Lanczos iteration count.
That cell would still be one unit thick, so it would sharpen the thin-cell
statement rather than test cubic geometry.

The cubic result is a measurement supported by a field-theoretic argument,
and a panel bounds only what it measures. An eighth family finding nothing
slower than the polarisation at seven sizes narrows the space of hidden even
modes without emptying it. Nothing here is certified. The spectra are
floating-point computations with residual checks and cross-checks against
independently banked values, the symmetry statements are numerical characters
agreeing with $\det M_g$ to $2.7\times10^{-14}$, and the cubic result is
Monte Carlo with jackknife errors, which is a different epistemic status from
the project's SAT-certified and proof-assistant results.

# Related work

Magnetic helicity entered fluid mechanics as a topological invariant. Woltjer
proved the invariance of $\int\mathbf A\cdot\mathbf B$ for a perfectly
conducting fluid and its role in characterising force-free fields
[@woltjer-1958-force-free-magnetic-fields-theorem]; Moffatt showed that the corresponding integral for a vortex
field measures the knottedness and linkage of the field lines [@moffatt-1969-degree-of-knottedness-tangled-vortex-lines];
Berger and Field made the topological reading precise for a magnetic field in
a bounded volume [@berger-field-1984-magnetic-helicity-topology]. The pseudoscalar character that does the
identifying work here is the property that makes helicity a linking number,
since a linkage changes sign under reflection.

The emergent electrodynamics of spin ice is why a helicity exists in this
model at all. The ice rule is a lattice divergence-free condition on the
coarse-grained field, which puts the classical model in a Coulomb phase with
dipolar correlations and pinch points in the structure factor
[@isakov-et-al-2004-dipolar-spin-correlations-pyrochlore; @henley-2010-coulomb-phase-frustrated-systems], and the excitations above it are deconfined
monopoles [@castelnovo-et-al-2008-magnetic-monopoles-spin-ice; @castelnovo-et-al-2012-spin-ice-fractionalization-topological-order]. At the Rokhsar–Kivelson point
the quantum model has an emergent photon [@hermele-et-al-2004-pyrochlore-photons-u1-spin-liquid], and the
classical-to-quantum correspondence [@henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points] makes the chain's spectrum
that Hamiltonian's spectrum. I have found no previous use of the helicity as
an observable in spin-ice Monte Carlo, classical or quantum: a literature
search on the emergent gauge field returns work on the transverse projector,
on monopoles and on photon signatures, and nothing on pseudoscalar bilinears.
That is a negative result from one search rather than a claim of priority.

The general point that an observable's autocorrelation time is not the
chain's is old [@sokal-1997-monte-carlo-statistical-mechanics], and the practical version is familiar in lattice
gauge theory, where the topological charge is a slow mode that couples weakly
to most observables and so leaves their error estimates too small
[@schaefer-et-al-2011-critical-slowing-down-lattice-qcd]. The pyrochlore case is sharper than weak coupling, because
the overlap is exactly zero and two symmetries in succession enforce it:
arrow reversal removes every odd observable, and the improper operations of
the point group remove every even scalar. Where that matters, the alternative
to guessing a better observable is to compute the subdominant eigenvalue of
the stochastic matrix itself, the route Nightingale and Blöte took for the
two-dimensional Ising model [@nightingale-blote-1996-ising-model-dynamic-exponent], and what the diagonalisation
here does at the one cell where it is affordable.

# Appendix: artefacts

All computation was CPU-only on a single GB10 machine, so no HPC service was
used and no acknowledgement is owed. `icemix/parity.py` supplies the parity
blocks, the derived automorphism group, the induced action on states and the
monomial projection; `icemix/observables.py` defines $P_j(\mathbf q)$;
`icemix/exact_ac.py` computes exact autocorrelations and overlaps;
`icemix/panel.py` carries the panel, the helicity families and
`helicity_ratio`. `experiments/05_thin_even/results/results.json` is the
source of every $(1,2,2)$ number here, from a run of 886.9 s at a peak
resident set of 4.45 GiB, and
`experiments/06_helicity_cubic/results/results.json` the source of every
cubic number, from a run of 3,413.5 s at 8.21 GiB. `tests/test_stage4d.py`
adds 26 tests and `tests/test_stage4f.py` 17, covering the parity and
symmetry machinery from definitions, the panel change and its bit-identity
against the pre-change module, and the recorded readings.
`docs/reports/2026-09-04-stage4d.md` and
`docs/reports/2026-09-04-stage4f.md` carry the full working record.

# References
