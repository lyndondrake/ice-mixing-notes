---
title: "The dynamical exponent of the single-hexagon-flip chain on pyrochlore spin ice"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
bibliography: ../../paper/refs/ice-mixing.json
abstract: |
  The generator of the single-hexagon-flip chain on pyrochlore spin ice is the Rokhsar--Kivelson-point Hamiltonian of quantum spin ice, so its spectral gap is that Hamiltonian's excitation gap and its mixing exponent is the dynamical exponent Henley predicted to be 2 in 2004. On $L \times L \times L$ conventional cubic cells at zero winding I measure the relaxation time of the transverse polarisation at the smallest wavevector over thirteen sizes from $L = 2$ to $L = 24$, the largest cell holding 221,184 spins, with 512 to 1024 replicas at each size, and obtain $z = 2.004 \pm 0.060$ from the exponential autocorrelation time and $z = 1.996 \pm 0.040$ from the integrated one. The leading correction to scaling is $1/L^{2}$ rather than $1/L$, and a naive power law over the same data returns 1.912, which is not the result. An independent test at fixed size, with no extrapolation in it, compares $\tau(q_{\min})/\tau(2q_{\min})$ against the diffusive value 4 and gives $3.973 \pm 0.014$ at $L = 24$, implying 1.99. Nothing here is certified in the sense that this project's frozen-state results are. What stands behind the number is exact spectral gaps on four enumerable cells, which anchor the estimator and calibrate its finite-series bias correction against known answers; an observable panel carrying both parities under global arrow reversal, since a slow mode of the wrong parity is invisible by symmetry rather than by statistics; and the fixed-size ratio test. All statements attach to the dynamically accessible component of the zero-winding sector.
---

# The chain, and what its exponent means

Pyrochlore spin ice states are the two-in--two-out configurations of Ising spins on the pyrochlore lattice [@bramwell-gingras-2001-spin-ice-state], equivalently the Eulerian orientations of the diamond lattice, whose bonds carry the spins and whose sites are the tetrahedron centres. A single spin flip breaks the ice rule and creates a monopole pair [@castelnovo-et-al-2008-magnetic-monopoles-spin-ice], and the smallest move preserving the rule reverses the six arrows around a hexagonal plaquette.

The chain studied here is the obvious one. Pick a hexagon uniformly at random; if its arrows run head to tail, reverse all six with probability $1/2$; otherwise do nothing. Flipping is an involution and the hexagon is drawn from a fixed distribution, so the transition matrix is symmetric and the chain reversible with the uniform stationary distribution on each flux sector. Under Henley's classical-to-quantum correspondence at Rokhsar--Kivelson points [@henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points; @rokhsar-kivelson-1988-superconductivity-quantum-hard-core-dimer-gas] its generator is, up to normalisation, the ring-exchange Hamiltonian of pyrochlore spin ice at its RK point [@hermele-et-al-2004-pyrochlore-photons-u1-spin-liquid]. That is an identity rather than an analogy, so the chain's spectral gap $\Delta$ is the Hamiltonian's excitation gap.

Half the expected answer is a theorem: Masaoka, Soejima and Watanabe prove $\Delta \lesssim L^{-2}$, hence $z \ge 2$, for gapless frustration-free systems, a class containing the RK point here [@masaoka-et-al-2025-rigorous-lower-bound-dynamical-exponents-gapless-frustration-free-systems], and the same bound was known much earlier for the two-dimensional dimer plaquette chain by a variational argument [@henley-1997-dimer-covering-relaxation-time]. The matching bound $\Delta \gtrsim L^{-2}$ is open. The physical expectation is $z = 2$ exactly, since the coarse-grained polarisation is locally conserved and should relax diffusively, and Henley says as much for the diamond-lattice ice model in the paper that establishes the correspondence [@henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points]. What was missing on this lattice was the number, its error bar, and the form of the corrections that carry it.

# Construction and conventions

The lattice is $L \times L \times L$ conventional cubic cells of the diamond lattice with periodic boundaries: $16L^{3}$ spins, which are the bonds, $8L^{3}$ sites and $n_{\mathrm{hex}} = 16L^{3}$ hexagons. Anisotropic cells $(a,b,c)$ with $16abc$ spins serve as exactly solvable anchors. The ice rule requires two of the four arrows at each site to point in, making the arrow field divergence-free, so the winding $\mathbf{W}$, the net arrow flux through the three coordinate cut planes, is conserved by every flip. The measurement lives entirely in $\mathbf{W} = 0$, the largest sector. Conservation is asserted after every applied move, and across the campaign the counts of ice-rule and winding violations are zero and zero. The hexagon set is derived from adjacency together with displacement, and the derived counts (six per bond, twelve per site, $16abc$ in all) asserted against a hand derivation, for reasons given under traps below.

One *sweep* is $n_{\mathrm{hex}}$ attempts, the continuous time in which each hexagon attempts at unit rate, which is the normalisation in which the generator is the RK Hamiltonian; every $\tau$ below is in sweeps unless marked otherwise. The units differ by $16L^{3}$, so an exponent quoted in attempt units would be larger by 3.

The observable is the coarse-grained polarisation $\mathbf{P}(\mathbf{q})$, the arrow field averaged onto sites and Fourier transformed, at $q_{\min} = 2\pi/L$, resolved into components transverse and longitudinal to $\mathbf{q}$. The longitudinal part is near zero by the divergence-free constraint, and the transverse part $P_{\perp}(q_{\min})$ carries the slow physics.

# The estimator

From each replica's sampled series the analysis takes the integrated time $\tau_{\mathrm{int}} = 1/2 + \sum_{t \ge 1}\rho(t)$ with Sokal's automatic windowing, and the exponential time $\tau_{\exp}$ from a weighted straight-line fit to $\log\rho$ on the tail with a window-stability spread. Both are carried through and fitted separately. Errors are jackknifed over *blocks* of the engine rather than over replicas, because sixty-four replicas share the bit positions of a 64-bit word and consume one shared hexagon index per attempt with an independent acceptance coin each: lanes within a block are coupled, blocks share nothing. The within-block equal-time correlation is $3.4 \times 10^{-4}$, giving 1003 effective independent series out of 1024. Every run starts at the canonical reference state of a constructive start convention, so membership of the accessible component is true by construction, and burns in for 40 to 50 relaxation times.

## Why the panel needs both parities

The relaxation time of an observable is the slowest mode it couples to, so it bounds $1/\Delta$ from below and equals it only when the coupling survives. Symmetry can remove the coupling exactly, and here it demonstrably does. At $(1,2,2)$ the accessible component is closed under global arrow reversal $R$ and small enough to enumerate. Its three slowest eigenvectors are all even under $R$ while $\mathbf{P}(\mathbf{q})$ is odd, the overlap vanishes identically, and the polarisation's relaxation time is 242.07 attempts against a true $1/\Delta$ of 389.95. No amount of sampling closes that gap.

The campaign therefore carried seven observable families at every size, four odd under $R$ ($P_{\perp}$ and $P_{\parallel}$ at $q_{\min}$ and $2q_{\min}$) and three even (the flippability structure factor, the total flippable count and $|P_{\perp}(q_{\min})|^{2}$), taking the slowest as the headline. In cubic geometry $P_{\perp}(q_{\min})$ is slowest at all thirteen sizes, by factors of 20 to 55, and $|P_{\perp}|^{2}$ relaxes at exactly half the polarisation time, as a squared observable should. An eighth family was added afterwards, the helicity $h_k(\mathbf{q}) = \operatorname{Im}(P_i(\mathbf{q})^{*}P_j(\mathbf{q}))$ with $(i,j,k)$ cyclic and $\mathbf{q}$ along axis $k$, because the $(1,2,2)$ even mode proved to be exactly that pseudoscalar and every original member is orthogonal to it; its ratio to the polarisation time falls from 0.6813 at $L = 2$ to $0.4988 \pm 0.0025$ at $L = 16$, approaching one half from above as a two-photon composite should. A panel bounds only what it measures, so every time below remains a lower bound on $1/\Delta$.

## Finite-series bias, corrected and validated

Estimating an autocorrelation with the *sample* mean subtracts $2\tau_{\mathrm{int}}C(0)/N$ from every lag, pushing the tail negative and the fitted time low. The effect is common-mode across series of the same length, so jackknife bars do not cover it. The correction applied throughout is $\rho \to \rho(1-\delta) + \delta$ with $\delta = 2\tau_{\mathrm{int}}/N$, and it was validated against exact answers rather than argued for. At the two enumerable cells where the same observable's autocorrelation can be computed exactly on the same component, with the same estimator and fit window, the raw error at $N = 2000$ samples is $-4.84\%$ at $(1,2,2)$ and $-3.74\%$ at $(1,1,4)$; corrected these become $-0.69 \pm 0.60\%$ and $+0.16 \pm 0.81\%$, and corrected residuals stay consistent with zero at every length from 2000 to 40,000 samples while raw errors scale as $1/N$. On the campaign the correction is 1.5 to 2.2 per cent and essentially size-independent, so it moves the amplitude and not the exponent.

## Exact anchors

The cubic $L = 2$ cell has roughly $2 \times 10^{11}$ sector states and cannot be enumerated, so the exact anchors are a ladder of anisotropic cells. None enters the fit for $z$. They test the generator, the gap machinery and the estimators against answers that are known rather than sampled.

| cell | $\lvert D\rvert$ / $\lvert$giant$\rvert$ | $1/\Delta$ (att.) | $1/\Delta$ (sweeps) | slowest mode | $\tau_{\mathrm{asym}}(P)\,\Delta$ |
|---|---:|---:|---:|:--:|:--:|
| $(1,1,2)$ | 160 / 160 | 132.47 | 4.140 | odd | 0.996 |
| $(1,1,3)$ | 3,360 / 3,360 | 310.56 | 6.470 | odd | 0.998 |
| $(1,2,2)$ | 221,424 / 221,424 | 389.95 | 6.093 | **even** | **0.621** |
| $(1,1,4)$ | 42,240 / **43,008** | 2287.95 | 35.749 | --- | 1.000 |

Exact gaps on the accessible component $D$, with the last column giving the fraction of $1/\Delta$ that the polarisation can see. Dense diagonalisation and deflated Lanczos agree to double precision where both ran, and the $(1,2,2)$ value was re-verified to twelve significant figures by 60,000 power iterations on the deflated operator. At $(1,1,4)$, where the coupling is present, the Monte Carlo estimator recovers the exact time of the same observable to 0.4 per cent, $2276.4 \pm 4.3$ attempts against an exact 2285.7 under the matched estimator and window. The production engine, a bit-sliced C kernel packing 64 replicas into 64-bit words, was itself validated bit for bit against a definition-level reference over 9.6 million per-attempt state comparisons at each of three cells, with zero mismatches.

# The campaign

Sizes up to $L = 12$ used 1024 replicas and 6000 samples per replica, covering 600 relaxation times after a burn-in of 50; $L = 14$ and 16 used 512 replicas over the same 600, burn-in 40; $L = 20$ and 24, 512 replicas over 500. The ladder cost 2874 s of wall time on one desk-side GB10 Grace--Blackwell machine, 16 threads of 20 cores, no GPU.

| $L$ | spins $= n_{\mathrm{hex}}$ | replicas | $\tau_{\exp}$ (sweeps) | $\tau_{\mathrm{int}}$ (sweeps) | $\tau(q_{\min})/\tau(2q_{\min})$ |
|---:|---:|---:|---:|---:|---:|
| 2 | 128 | 1024 | 1.803(4) | 1.692(4) | 1.829(6) |
| 3 | 432 | 1024 | 3.472(5) | 3.366(5) | 2.614(5) |
| 4 | 1,024 | 1024 | 5.804(9) | 5.698(8) | 3.077(6) |
| 5 | 2,000 | 1024 | 8.814(13) | 8.734(13) | 3.365(7) |
| 6 | 3,456 | 1024 | 12.43(3) | 12.36(2) | 3.524(8) |
| 7 | 5,488 | 1024 | 16.75(3) | 16.68(3) | 3.648(8) |
| 8 | 8,192 | 1024 | 21.81(4) | 21.73(4) | 3.734(9) |
| 10 | 16,000 | 1024 | 33.94(8) | 33.83(4) | 3.836(10) |
| 12 | 27,648 | 1024 | 48.42(9) | 48.35(9) | 3.866(9) |
| 14 | 43,904 | 512 | 65.56(18) | 65.64(15) | 3.886(13) |
| 16 | 65,536 | 512 | 85.93(21) | 85.78(23) | 3.929(10) |
| 20 | 128,000 | 512 | 133.5(2) | 133.0(2) | 3.944(9) |
| 24 | 221,184 | 512 | 193.3(6) | 193.4(5) | 3.973(14) |

Relaxation times of $P_{\perp}(q_{\min})$ in sweeps, errors jackknifed over engine blocks, with the fixed-size diffusive ratio in the last column. The integrated time tracks the exponential one to within 0.1 per cent at every size, which is what a single dominant mode looks like and is worth having, since the two estimators fail differently.

# Fitting the exponent

A naive power law over all thirteen points returns $z = 1.912$ with $\chi^{2}/\mathrm{dof} = 550$. It is not the result, for two reasons pointing the same way: it sits below a proved floor, and it drifts monotonically upward as small sizes are dropped, through 1.937 and 1.957 to 1.998 when only $L \ge 14$ is kept. Drift under truncation is the signature of a correction to scaling. The local exponents between successive sizes say the same from the other end, rising monotonically from 1.616 across $L = 2 \to 3$ to 2.031 across $L = 20 \to 24$, approaching 2 from below. The third route fits $\tau = A L^{z}(1 + \text{corrections})$ by weighted nonlinear least squares.

| fit form | $z$ | correction coeff. | $A$ | points ($L_{\min}$) | $\chi^{2}/\mathrm{dof}$ |
|---|---:|---|---:|---:|---:|
| pure power law | 1.912 | --- | 0.4198 | 13 (2) | 550 |
| $+\,c/L$ | 2.114 | 1.69 | 0.2199 | 13 (2) | 33.7 |
| $+\,c/L^{2}$ | 2.000 | 1.42 | 0.3332 | 13 (2) | **1.61** |
| $+\,c_1/L + c_2/L^{2}$ | 2.004 | 0.054, 1.37 | 0.3281 | 13 (2) | 1.72 |
| $+\,c/L$ (tail) | 2.017 | 0.465 | 0.3109 | 9 (6) | 1.70 |
| $+\,c/L^{2}$ (tail) | 1.996 | 1.08 | 0.3377 | 9 (6) | 1.90 |

Fits to $\tau_{\exp}$. The same analysis on $\tau_{\mathrm{int}}$ gives $z \in [1.989, 2.001]$ among the forms that fit, with a headline of $1.996 \pm 0.040$.

Two features of that table identify the leading correction as $1/L^{2}$. The $1/L^{2}$ form fits with $\chi^{2}/\mathrm{dof} = 1.61$ where the $1/L$ form manages only 33.7, and when both terms are allowed the fit chooses between them itself, giving the $1/L$ coefficient 0.054 against 1.37 for $1/L^{2}$, consistent with zero, while the exponent barely moves. Restricting to forms that fit at all, meaning $\chi^{2}/\mathrm{dof} < 5$, excludes the pure power law and the pure $1/L$ correction and leaves four fits with $z \in [1.996, 2.017]$. This is an empirical identification and not a derivation. I have no argument for why the correction should be analytic in $1/L^{2}$ here, only the observation that one such term of order-unity amplitude absorbs the entire drift from $L = 2$ upward.

$$
z = 2.004 \pm 0.060 \quad (\tau_{\exp}), \qquad
z = 1.996 \pm 0.040 \quad (\tau_{\mathrm{int}}),
$$

with amplitude $A \approx 0.33$ sweeps. The quoted uncertainty is deliberately the unfiltered spread over fit forms, the badly fitting $1/L$ form included; the statistical component, propagated from the data's own error bars by parametric bootstrap, is $\pm 0.005$, and quoting that would be false precision by an order of magnitude. Both values are consistent with $z = 2$, with the theorem $z \ge 2$, and with the two-dimensional $2.01(2)$ obtained by the same technique at the square-lattice dimer RK point [@isakov-et-al-2011-dynamics-conformal-quantum-critical-points].

# An independent test with no fit in it

Every number above depends on extrapolating in $L$. This one does not. At fixed $L$, diffusive relaxation $\tau \sim q^{-2}$ predicts $\tau(q_{\min})/\tau(2q_{\min}) = 4$, and both times come from the same run, the same configurations and the same estimator, with no finite-size fit between the data and the prediction. The ratio rises from 1.829 at $L = 2$ to $3.973 \pm 0.014$ at $L = 24$, an implied exponent climbing from 0.871 to 1.990. What makes this more than a second consistency check is that the approach is from below, at the same rate and over the same range as the local exponents approach 2: two routes with almost nothing in common see corrections of the same size and sign. A genuinely sub-diffusive exponent would have to be reproduced conspiratorially by the fixed-size ratio as well.

# What this establishes, and what it does not

What is established is that on the dynamically accessible component of the $\mathbf{W} = 0$ sector, over $L = 2$ to 24, the relaxation time of $P_{\perp}(q_{\min})$ grows as $L^{z}$ with $z = 2.004 \pm 0.060$ and a leading $1/L^{2}$ correction, the fixed-size ratio test implying 1.99 independently. Four things it is not.

It is not a proof of rapid mixing. A measured $z \approx 2$ is a prerequisite and evidence, but the matching lower bound $\Delta \gtrsim L^{-2}$ remains open, and no route to it is proposed here.

Every $\tau$ reported is an observable's relaxation time, hence a lower bound on $1/\Delta$. The panel found the polarisation slowest of its members at all thirteen sizes, and the helicity family closed the one blind spot exact diagonalisation had exposed, but a panel bounds only what it measures. At $(1,2,2)$ the bound is loose by a factor of 1.6 for a reason of symmetry, and the argument that cubic geometry hides no such mode, resting on the even sector being the two-photon sector and on the measured helicity ratio tending to one half, is supported by measurement rather than proved.

The restriction to the accessible component is not a formality. Frozen states, configurations with no flippable hexagon, exist in the $\mathbf{W} = 0$ sector at every cell size and are absorbing and isolated, since the chain can neither leave one nor reach one; in RK language each is an exact zero-energy eigenstate degenerate with the equal-weight superposition over its sector. The full sector's gap is therefore exactly zero at every $L$, and a statement about $\Delta$ that does not name a component is empty. The companion notes on frozen states in this series carry the constructions, the exact counts and the certificates. What matters here is that the start convention places every replica in the accessible component by construction, and that this component is not always the giant one: at $(1,1,4)$ it is not, and using the giant component instead would misstate $\Delta$ by a factor of 3.6.

And the quoted uncertainty is dominated by the choice of correction form rather than by statistics, so a longer campaign at the same sizes would not shrink it. A larger $L$, where the corrections are themselves smaller, would.

# Traps worth recording

*The quotient-graph trap.* Enumerating hexagons as six-cycles of the periodic quotient graph is wrong on small cells. At $(1,1,1)$ that graph is $K(4,4)$, with 96 six-cycles against 16 true hexagons. All 80 extras are non-contractible, all respect the ice rule, and all 80 changed $\mathbf{W}$ in the 80 cases tested. Flipping them corrupts the flux sector while leaving every downstream number plausible.

*The accessible component is not the giant component.* At $(1,1,4)$ it holds 42,240 states against the giant component's 43,008, and a start state drawn uniformly from $\mathbf{W} = 0$ fails to reach the giant component 93 per cent of the time. Hence the constructive start convention, with a connectivity certificate calibrated against exact enumeration: no false positives, no false negatives, and the 6.67 per cent accessible fraction at that cell correctly reported.

*A real bug, caught by a test.* The flippability structure factor grouped hexagon centres by quarter-lattice units, but a centre is the mean of six integers, so distinct phases were merged and $F(\mathbf{q})$ silently corrupted, until an exact $k/6$ key and a run-time assertion replaced the grouping. No reported result depended on $F$, which is luck and not design.

*Where the time goes.* Measuring the observable, not running the chain, was the bottleneck, at 132 ms per sample at $L = 16$, and a bit-sliced vertical-counter kernel cut that by roughly a factor of six, which is what made $L = 20$ and 24 affordable.

# Related measurements

Reading an RK Hamiltonian's spectrum off the autocorrelations of the corresponding classical chain is Henley's technique [@henley-2004-classical-to-quantum-dynamics-at-rohsar-kivelson-points], first used by Ivanov to extract a vison gap on the triangular lattice [@ivanov-2004-roksar-kivelson-dimer-model-vision-gap]. In two dimensions the measurement has been done properly: Isakov, Fendley, Ludwig, Trebst and Troyer ran the classical RK dynamics of the square-lattice quantum dimer model up to $L = 96$ and fitted $z = 2.01(2)$, alongside a continuously varying exponent along a $\mathbb{Z}_2$ line and $z = 2.170(3)$ at an Ising conformal quantum critical point [@isakov-et-al-2011-dynamics-conformal-quantum-critical-points]. The value here is the three-dimensional analogue by the same route, and its agreement is the external calibration one would want.

In three dimensions the nearest prior work is Läuchli, Capponi and Assaad, who ran the same stochastic dynamics at the RK point of the cubic-lattice dimer model in the zero-flux sector and saw the soft mode near $(\pi,\pi,\pi)$ disperse quadratically [@lauchli-et-al-2008-dynamical-dimer-correlations-at-rk-points] — an observation consistent with $z = 2$ at a single size, with no fitted exponent and no error bar, on the cubic dimer model rather than diamond-lattice ice. A measured local-dynamics exponent does exist for the three-dimensional cubic dimer model, $z = 1.92(1)$ from short-time critical dynamics [@peng-et-al-2026-short-time-critical-dynamics-cubic-dimer], but it belongs to the columnar--Coulomb critical point of an interacting model and should not be read against the value here.

For pyrochlore ice itself I have found no prior measurement, and the chain seems to have fallen between two literatures. The classical Monte Carlo community built loop and worm algorithms [@barkema-newman-1998-monte-carlo-ice-models; @shinaoka-2011-pyrochlore-heisenberg-spin-ice-loop-algorithm; @otsuka-2014-cluster-algorithm-spin-ice] in order to replace the slow local dynamics, and measured the dynamic exponents of those algorithms rather than of the chain they displaced; the quantum ice literature on this lattice measures flux-sector energies and photon dispersions in the liquid phase [@shannon-et-al-2012-quantum-ice-monte-carlo; @benton-et-al-2012-emergent-electromagnetism-quantum-spin-ice] rather than gap scaling at the RK point. The general lower bound that frames the result was proved only last year [@masaoka-et-al-2025-rigorous-lower-bound-dynamical-exponents-gapless-frustration-free-systems; @masaoka-et-al-2025-ising-dynamical-critical-exponent-bound].

# Appendix: artefacts {-}

All paths are in the repository at `github.com/lyndondrake/ice-mixing`. The engine is `icemix/msc.py` with its kernel `icemix/_msc.c`, its canonical RNG mapping documented in the module docstring and reproduced there by a pure-Python decoder, and `icemix/chain.py` as the definition-level reference it is validated against; then `icemix/autocorr.py` (estimators, windowing, bias correction), `icemix/taurun.py` (the two-pass $\tau$ measurement), `icemix/panel.py` (the panel and its parities), `icemix/zfit.py` (the fits and the fit-form uncertainty), with `icemix/lattice.py`, `icemix/start.py`, `icemix/component.py`, `icemix/spectrum.py` and `icemix/exact_ac.py` supporting them. The runs are `experiments/03_campaign/` (the ladder, the fits, the anchors, the bias validation), `experiments/02_calibration/` (bit-for-bit validation, the $(1,2,2)$ spectrum), `experiments/06_helicity_cubic/` (the helicity ratios) and `experiments/01_falsifiers/` (the census and the frozen states); each carries `results/results.json`, a generated `results/summary.md` in which every number is traceable to that JSON, and its runner. Every number in this note comes from one of those files or from the full working note, `paper/mixing-exponent-note.tex`. Tests are in `tests/test_msc.py`, `tests/test_campaign.py`, `tests/test_panel.py`, `tests/test_observables.py` and `tests/test_spectrum.py`; the bound $z \ge 2$ was carried as a test-suite tripwire throughout and fired once, on a naive fit of 1.859 at the calibration stage, which is how the correction-to-scaling analysis became a requirement of the campaign rather than an afterthought.

# References {-}
