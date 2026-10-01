---
title: "Probe of a phase quantity Q on the solutions of the negation of (V′): none of the listed candidates is defined or constrained on the dense solutions; the integer solutions of a window span a much smaller affine space than the real solutions, cut out by a backbone and two-variable equations"
author: "Claude (Opus 5), agent moment, for Lyndon Drake"
date: 2026-09-29
---

Tags: **proved**, **computed** (exact arithmetic or direct evaluation on saved solutions), **solver** (CaDiCaL or HiGHS verdict under a hard cap), **conjecture**.

New scripts, all in `experiments/08_frozen_structure/scratch_h/`: `h570_lib.py`, `h570_worker.py`, `h571_sample.py`, `h572_fourier.py`, `h573_batch.py`, `h574_chains.py`, `h575_detail.py`, `h576_pairs.py`, `h577_hull.py`, `h578_worker.py`, `h578_implied.py`, `h579_eqs.py`, `h579b_rel.py`, `h579c_pairs.py`, `h579d_verify.py`, `h579e_classify.py`. They import the geometry, the pattern and the encoders from `h560_lib` / `h360_lib`, unchanged. Saved samples: `.tmp/h571_*.pkl`; hull points: `.tmp/h578_*.pkl`, `.tmp/h579d_*.pkl`; logs `.tmp/h572_*.log`, `.tmp/h573_*.log`, `.tmp/h574_*.log`, `.tmp/h579e_*.log`.

Setting as in the sheet report: cell $(a,b,c)$, rods along $x$, $g=\gcd(b,c)$, hole $O=(2,0,0)$, the four literals, the negation "some B-vertex of grid $dx=-1$ is of type $x$" (or a fixed target of that grid), (T2) on the hexagons of the window $[-P,Q]$ only, closed transverse torus. On a grid, $s=y+z$ and $d=y-z$ modulo $4g$ (relative to $O$).

## 1. Verdict

**NO.** None of the candidates listed in the brief, nor the three of my own, is a quantity $Q$ with properties (i) to (iii). On the dense solutions of the negation (one-sided windows $[-3,q]$ with $q\le 2g-2$, symmetric windows, a fixed target), the label phases on the Lemma-11 lines ($\chi_d$, $\chi_s$, all $j$), every other character of the transverse torus, the chain and cell counts, the graph winding and the layer sums are either undefined in some solutions (the coefficient is exactly 0 in 0 to 9% of the pairs (solution, grid)) or unconstrained (the increment of the argument from grid to grid takes as many distinct values as there are solutions, of both signs, and the total winding takes both admissible values). The only exact relations of the label coefficients between two grids are $F_j(dx+2g/\gcd(j,g))=\pm F_j(dx)$, and these are linear laws (in the row space of the window's equations), so they cannot carry integrality. On the extreme models the candidates behave as the formula of the sheet says, which checks the code. The affine hull (Step 3) gave the one positive result: on four settings the integer solutions span an affine space of dimension 90, 152, 112 and 234 inside real solution spaces of dimension 210, 333, 332 and 484 (exact, with every extra equation verified by the solver). The extra equations are a backbone (variables fixed in every solution) and two-variable equations $t_i=t_j$ or $t_i=1-t_j$, in classes of up to 74 variables that span the whole window. They are listed in §5. None of them is a phase, and I did not use them to build one (that would be a new route).

## 2. The models

`h571_sample.py` (via `h573_batch.py`): for each setting several solver runs (fresh CaDiCaL, random phases reseeded before every solve, blocking on the type-$x$ set of the window), merged and deduplicated on that set. A second pass (`--hamming 40`) makes each later model differ from every earlier one of the same run on at least 40 type-$x$ literals of the window (sequential-counter encoding). Solver models are not a uniform sample. The frequencies below describe the sample only and are not probabilities.

Cells: $(12,4,4)$, $(12,4,8)$ ($g=4$); $(12,5,5)$, $(12,5,10)$ ($g=5$); $(12,6,6)$ ($g=6$); $(16,7,7)$ ($g=7$). Windows: one-sided $[-3,q]$ for $q=2g, 2g-2, \dots, \ge g$; symmetric $[-(2g-3),2g-3]$ and $[-(2g-2),2g-3]$ (one short of the symmetric corner); with a fixed target, near $(1,-3)$ and far $(2g+1,1-2g)$, on $[-3,2g-2]$ and $[-(2g-2),2g-3]$. That is 54 settings in the plain pass and 20 in the Hamming pass.

| kind | distinct models per setting | pairwise distance of type-$x$ sets (min / median / max), typical |
|---|---|---|
| $[-3,2g]$ (extreme) | 2 (enumeration complete) | $132$ ($g=4$) to $404$ ($g=7$) |
| $[-3,q]$, $q\le 2g-2$ | 58 to 75 (plain), 34 to 50 (Hamming) | e.g. $(12,5,5)$ $[-3,8]$: 12 / 220 / 364; Hamming: 24 / 224 / 358 |
| symmetric | 18 to 71 | e.g. $(12,6,6)$ $[-9,9]$: 19 / 353 / 509 |
| far target | 8 to 75 | e.g. $(16,7,7)$ $[-3,12]$: 112 / 368 / 588 |
| near target | 4 to 75 on $[-3,2g-2]$; **1** at $[-(2g-2),2g-3]$ for every $g$ (enumeration complete) | |
| hull samples | 337 ($g=4$), 1066 ($g=5$), 2251 ($g=6$, merged with solver witnesses) | |

The two extreme models I sampled on $(12,4,4)$ $[-3,8]$ are identical, on the type-$x$ set of the window, to the saved models of agent sheet (`h561_g4a`), which `h569_formula.py` fits to the formula (computed).

## 3. The candidates

All are computed on the saved models by `h572_fourier.py` (every character of the transverse torus), `h574_chains.py` (counts, cells, Lemma-11 lines, winding, own candidates), `h575_detail.py` (per-grid detail) and `h576_pairs.py` (exact relations between two grids).

**Extreme models first (code check).** On $[-3,2g]$, $g=4$ to $7$: on every grid the type-$x$ set is a union of cells and a graph over the classes of $s$, with $n_x=2bc/g$ per grid. $\chi_s$ vanishes identically (one cell in each class of $s$) and $\chi_d$ ($j=1$) never vanishes. Its argument on the A-grids follows $d=\pm x$ with the defects, and the total winding over the A-grids $-2..2g$ is $\pm 0.547, \pm 0.551, \pm 0.547, \pm 0.543, \pm 0.540$ turns (the two orientations). Example, $(12,5,5)$, arguments in units of $2\pi/20$: $1.76, 2.69, 3.31, 4.24, 8.0, 8.24, 7.31$ and their negatives (computed). This is the sheet.

**(a) Counts on chains and cells.** Per grid, $n_x$ ranges widely on the dense models (e.g. $(16,7,7)$ $[-3,12]$: 14 to 58 on A-grids, against 14 in the extreme). The type-$x$ set is a union of whole cells on 10/365 to 44/737 of the (model, grid) pairs, and a graph over $s$ on at most 22/737. With a fixed target it is never a union of cells (0/450, 0/600). So the counts per chain are not the indicator of a graph, and the "phase of the graph" is undefined on almost every grid (computed).

**(b) Fourier coefficients, all characters, all types.** For each sublattice and each type $x,y,z$: the characters whose coefficient is non-zero on every grid of every model, and those whose increment of argument from grid to grid takes at most two values across the models (two orientations allowed; any per-grid frame allowed, because the test compares models at the same step). On every dense one-sided setting ($q\le 2g-2$) and every symmetric setting without a fixed target, **no character passes both** except the real characters ($\pm1$-valued, e.g. $(m,n)=(b,c)$ on the non-square cells), which is a parity count with increments $0$ or $\pi$ by construction. This includes the characters that are functions of $z$ alone or of $y$ alone, which are the counts along the chains of axes $y$ and $z$ in any frame (computed; `.tmp/h572_all.log`, `.tmp/h572_h.log`).

**(c) The Lemma-11 lines ($\chi_d$, $\chi_s$), $j=1$, type $x$, A-grids.** Examples (computed; "zero" = fraction of (model, grid) with coefficient exactly 0; "inc" = increments $>0$ / $<0$ / $=0$; "nd" = largest number of distinct increments at one step across the models):

| setting | models | $\chi_d$: zero, inc, nd, winding range | $\chi_s$: zero, inc, nd, winding range |
|---|---|---|---|
| (12,4,4) [−3,6] | 58 | 0.07; 108/60/32; 19; −0.5..0.5 | 0.08; 108/84/16; 22; −0.5..0.5 |
| (12,5,5) [−3,8] | 71 | 0.01; 173/130/44; 58; −0.5..0.5 | 0.03; 162/175/8; 65; −0.5..0.5 |
| (12,5,10) [−3,8] | 71 | 0.00; 186/165/4; 70; −0.5..0.5 | 0.03; 135/210/0; 68; −0.5..0.5 |
| (12,6,6) [−3,10] | 71 | 0.02; 158/216/38; 46; −0.5..0.5 | 0.03; 229/168/13; 59; −0.5..0.5 |
| (16,7,7) [−3,12] | 71 | 0.00; 273/224/0; 71; −0.5..0.5 | 0.03; 238/245/0; 69; −0.5..0.5 |
| (12,6,6) [−9,9] | 65 | 0.03; 200/296/5; 33; −0.83..0.83 | 0.03; 248/248/5; 37; −0.96..0.94 |
| same, Hamming pass | 48 each | same picture: zero 0.00–0.09, both signs, nd = 32–48 | same |

So on the dense models the modulus vanishes in some solutions (the argument is undefined there), and where it is defined the argument moves by an arbitrary amount in either sense. Per grid the number of distinct arguments is close to the number of models: e.g. $(12,5,5)$ $[-3,8]$, $\chi_d$: 49, 41, 60, 52, 57, 48 distinct arguments of 71 on the six A-grids, one to three zeros per grid (`h575_detail.py`).

The winding range "−0.5..0.5" is not a free value. `h576_pairs.py` finds, on every dense setting, the exact relations $F_j(dx+2g)=(-1)^jF_j(dx)$ (and $F_j(dx+2g/\gcd(j,g))=\pm F_j(dx)$ when $\gcd(j,g)>1$) for both families and both sublattices, on every pair of grids of the window at that distance, and no others. `h579b_rel.py` shows that all of them lie in the row space of the window's equations {one-hot, (T2), literals} (float rank: $E$ 750, $E$ plus the 24 relations 750, on $(12,4,4)$ $[-3,6]$). They are **linear laws** (computed). So over one circuit of $2g$ grids the label coefficient turns by exactly half a turn, in either sense, and this holds on the real relaxation as well. It cannot give the contradiction.

**Fixed targets.** With the far target, one-sided, the increments of $\chi_s$ are mostly negative (375/375 on $(12,5,10)$ and 525/525 on $(16,7,7)$, but 5 positive of 375 on $(12,5,5)$, 1 positive and 5 zero of 450 on $(12,6,6)$, 17 positive of 300 on $(12,4,8)$), with 51 to 75 distinct values per step (e.g. $(12,5,10)$: increments from $-7.62$ to $-0.29$ units of $2\pi/20$). So there is no monotone rule without exceptions, and no fixed rate. At the symmetric near-corner $[-(2g-2),2g-3]$ with the far target, $\chi_s$ has one increment at every step in every model, $+1/(2g)$ turn per A-step, total $(2g-3)/(2g)$ turn at $g=4,5,6,7$ (8 to 49 models; computed). This is a rigid, near-extreme regime of the same kind as the sheet (with the near target there is only one model). Without the target the same window gives $\chi_s$ with 4 distinct increments of both signs, and $\chi_d$ with 15 to 48.

**(d) Own candidate 1, the layer sum** (A-grid $dx$ plus B-grid $dx+1$, B shifted): the same as (c). E.g. $(12,5,5)$ $[-3,8]$: zero 0.01; increments 140/104/33; nd 58.

**(e) Own candidate 2, the field $[y]-[z]$** (the orientation of the sheet) on $\chi_d$, $\chi_s$: zero 0.00 to 0.01, nd 70 to 74 of 71 to 75, windings in $[-1.5,1.55]$ turns. Unconstrained.

**(f) Own candidate 3, the graph winding** $\sum_s (D(s+1)-D(s))/4g$ on grids where the type-$x$ set is a graph over $s$: it is defined only on those grids (at most a few per cent of the dense pairs). Where it is defined it is 0 on the one-sided windows and 0 or 1 (once 2) on the symmetric ones. It is undefined on the dense solutions.

**Winding numbers or moments of the type-$x$ set on the label torus.** The first moment on the label circle is the $j=1$ coefficient (c). A winding of the type-$x$ set round the label torus is defined only when the set is a closed curve of cells, that is on the graph grids (f).

Verdict of Step 2: no candidate is defined on every dense solution, and none obeys a rule from grid to grid on them (computed, on the sampled models; the counter-examples are genuine solutions, so each "undefined" or "two different increments" is certain, not a sampling artefact).

## 4. Step 4

No candidate survived Step 2, so no lemma was stated or tested. The negative statements in §3 rest on explicit solutions of the window (solver models) and need no further test.

## 5. The affine hull (Step 3)

Variables: $t(v,k)$ for the vertices of the window. Real solution space: one-hot, (T2) as "the six sum to 2" (exact for 0/1), the four literals, and the target when fixed. Ranks are taken modulo $p=2^{31}-1$. Since $\mathrm{rank}_\mathbb{Q}\ge\mathrm{rank}_p$, $n-\mathrm{rank}_p(E)$ bounds the real dimension from above and $\mathrm{rank}_p$ of the differences of the points bounds the hull from below.

First attempt (`h577_hull.py`, $(12,4,4)$ $[-3,6]$, 344 samples): hull at least 89, real space at most 210, so not equal. Then `h578_implied.py` (HiGHS `milp`, random directions in the complement) found 2 new points, after which min = max along a random direction: hull 90 (solver: milp, one direction). I then replaced this by an exact check. `h579d_verify.py` takes every variable that is constant on the points and every pair of columns that are equal or complementary on the points, and tests each with CaDiCaL: the violating assignment is added as assumptions to {one-hot, (T2) on the window, negation} under the four literals. A SAT answer adds a point and the loop repeats; the final state has every query UNSAT and the control SAT. Then, if $\mathrm{rank}_p$(points) $= n-\mathrm{rank}_p(E+\text{backbone}+\text{pairs})$, the hull is exactly this space: the verified equations bound it from above over $\mathbb{Q}$, the points from below.

| setting | $n$ | real dim ($n-\mathrm{rank}\,E$) | integer hull dim | backbone equations beyond $E$ | two-variable equations beyond those | status |
|---|---|---|---|---|---|---|
| (12,4,4) [−3,6] | 960 | 210 | **90** | 83 | 37 | exact (solver) |
| (12,5,5) [−3,8] | 1800 | 333 | **152** | 115 | 66 | exact (solver) |
| (12,5,5) [−3,8], target (11,−9) | 1800 | 332 | **112** | 220 | 0 | solver: equations verified; the last point came from milp (h578), then the points span the bound 112 |
| (12,6,6) [−3,10] | 3024 | 484 | **234** | 139 | 111 | exact (solver); needed 2251 points |

So the linear functionals that are constant on the integer solutions are **not** only the laws. For the one-sided dense windows they are exactly the laws, plus the backbone, plus the two-variable equations. Neither Step 3 outcome of the brief holds as stated: the hull is strictly smaller, and the extra equations are these. What they look like (`h579e_classify.py`; full lists in `.tmp/h579e_v4466.log`, `_v5588.log`, `_v66610b.log`):

- **Backbone** (by grid, type, value). On $(12,5,5)$: grid $-3$: 6 vertices not $x$. Grid $-2$: the rod $v$ is $x$; 6 not $x$, 12 not $y$, 2 fixed $y$, 5 not $z$, 4 fixed $z$. Grid $-1$: 2 not $x$, 2 fixed $y$ (the bridgehead and its partner), 4 not $z$. Grid $1$: 30 not $y$, 2 fixed $z$. Grid $2$: the rod $v'$, 9 not $z$. And so on to the far end. The pattern is the same at $g=4,5,6$, with counts growing with $g$ (grid 1, not $y$: 20, 30, 44).
- **Two-variable equations.** Classes of equal or complementary variables (105 classes at $g=4$, 209 at $g=5$, 382 at $g=6$), the largest of 56, 64 and 74 variables spanning **every grid of the window**. The largest class at every $g$ contains $t((0,0,\pm2),x)$ and $t((-2,\pm2,\mp2),x)$ and, complementary to them, $t((0,0,\pm2),y)$ and $t((-2,\pm2,\mp2),z)$. It is one Boolean switch next to the hole whose value is copied to vertices on every grid. It is **not** the orientation of the sheet: both extreme models have the same value, $(y,y,z,z)$ on those four vertices. Smaller classes join grids at distance exactly $2g$ by a translation along a chain of axis $y$. E.g. at $g=4$: $t((-2,0,4),x)=t((0,0,6),x)=t((6,0,-4),x)$ and $t((-2,-8,-4),x)=t((2,-8,0),x)=t((6,-8,\pm4),x)$.
- These equations depend on the window: at $[-3,6]$ on $(12,5,5)$ the big switch is not rigid (models with $(0,1,2,2)$ and $(1,0,2,2)$ on the four vertices exist), and with the near target the switch takes the other value in every model. So they are not local laws. They are integer consequences of the whole window.

What this does and does not settle: it closes nothing about linear $Q$ in the sense of the brief. The laws alone do not describe the integer solutions; the backbone and the switches do. But none of the extra functionals is a phase: each one is a constant or a copy of a bit.

## 6. What failed

- Every phase candidate on the dense solutions (§3).
- The first affine-hull comparison, by sampling alone: the solver's samples missed points (2 at $g=4$ and $g=5$ were found only by the targeted queries), and at $g=6$ the first 870 points spanned only 211 of the 234 dimensions. More samples closed it; `milp` on 3024 binaries was stopped by its 300 s cap without an answer.
- The random-direction `milp` test is only as good as HiGHS's tolerances (default relative MIP gap). I did not rely on it for the exact results. It supplied two points and a consistency check.

## 7. Rules

- One solver or optimiser process at a time: kept. Every run was sequential in the foreground, and nothing ran in the background.
- Every solve and every `milp` ran in a child process under `subprocess.run(timeout=...)`, as in `h560_lib.run_job`. One `milp` hit the cap (300 s, $g=6$).
- Every UNSAT in §5 has a SAT control on the same clause set (the first query of each batch).
- Script names: the brief allows `h570_*` to `h579_*`. Four of mine are `h579b_`, `h579c_`, `h579d_`, `h579e_`, which is a stretch of that pattern. I also ran four short inline `python -c` checks (comparing saved model sets, the ratio $F(\text{end})/F(\text{start})$, and the switch values; no solver). Heredocs: none. Nothing under `docs/`, no LOG, HANDOVER or README, no git. I edited my own new scripts after first use (h570_lib, h572, h573, h578, h579d); no existing script was modified.

## 8. Commands (from the repository root, `PYTHONPATH` and `TMPDIR` as in the brief)

| command | wall | result |
|---|---|---|
| `h571_sample.py 12,4,4 3 8 g4_q8 --k 6 --seeds 1` | 0.4 s | 2 models (the sheet's) |
| `h573_batch.py 4` | 22 s | 18 settings, g = 4 |
| `h573_batch.py 5 6` | 75 s | 28 settings |
| `h573_batch.py 7` | 115 s | 10 settings |
| `h573_batch.py 4 5 6 --only one --hamming 40 --suffix _h --seeds 2` | 160 s | 16 settings |
| `h573_batch.py 7 --only one --hamming 40 --suffix _h --seeds 2` | 134 s | 4 settings |
| `h572_fourier.py GLOB:1*`, `GLOB:*_h` | ~2 min, ~1 min | §3 (b) |
| `h574_chains.py GLOB:1*`, `GLOB:*_h` | ~2 min, ~1 min | §3 (a), (c)–(f) |
| `h575_detail.py` (4 calls), `h576_pairs.py` (5 settings) | < 30 s | §3 (c) |
| `h571_sample.py ... H_12_4_4_m3_6 --k 60 --seeds 20`; `H_12_5_5_m3_8`; `H_12_6_6_m3_10 --seeds 25` | 16 s; 27 s; 72 s | hull samples |
| `h577_hull.py H_12_4_4_m3_6 12_4_4_m3_6` | 5 s | 89 vs 210 |
| `h578_implied.py H_12_4_4_m3_6` (twice, 2 and 4 rounds) | 89 s, 86 s | +2 points; 90 (milp) |
| `h579_eqs.py`, `h579b_rel.py`, `h579c_pairs.py` on h4466 | < 20 s each | 83 backbone + 37 pairs; relations are laws |
| `h579d_verify.py H_12_4_4_m3_6` | 8 s | exact 90 / 210 |
| `h579d_verify.py H_12_5_5_m3_8` | 16 s | exact 152 / 333 |
| `h579d_verify.py 12_5_5_m3_8_far`; `h578_implied.py far5 --from-verify v5588far` | 23 s; 101 s | 112 / 332 |
| `h579d_verify.py 12_6_6_m3_10` | 270 s | 211 of bound 234 |
| `h578_implied.py g6 --from-verify v66610 --rounds 1 --cap 300` | 300 s CAPPED | no answer |
| `h579d_verify.py H_12_6_6_m3_10 --merge v66610 --cap 500` | 18 s | exact 234 / 484 |
| `h579e_classify.py` on v4466, v5588, v66610b | < 5 s | §5 lists |
