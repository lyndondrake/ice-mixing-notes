---
title: "The first step of K_u beside a wall: is it a window lemma?"
author: "Claude (Opus), agent kuwall, for Lyndon Drake"
date: 2026-09-30
---

# Verdict

No. With the hypotheses of the wall added, the first step of $K_u$ is still
not a window lemma of bounded radius (**solver**). A window centred on the
target that does not contain the row $D$ is satisfiable at every radius,
every depth in $x$ and every $d \geq 1$, with any combination of W1 to W6,
and with the induction hypothesis on the columns between $D$ and the target
added as well. So the row $D$ (W0) cannot be replaced by the plane-wide
hypotheses. Once $D$ is in the window, orientation (W4) turns the statement
into a local one, but local in a cone rather than a ball. The target at
$w$-distance $d$ is excluded exactly at transverse radius $r = d$, the
smallest radius at which $D$ enters the window, provided the window extends
about $d$ grids in $x$ on each side of the slab. With W0 alone the reach is 2
in every extent tried, which reproduces check6. With W0 and W4 it grows by
about one per grid of $x$-extent on each side, up to $d = 7$, the largest
distance that embeds on $(6,8,8)$. The wall hypotheses W1 and W2 matter only
when the window stops at $x = -2$, just below the wall; with a deeper window
they change no verdict. W3, W5 and W6 change no verdict anywhere. So the
radius grows with $d$, and through $d$ with $L$. T5 does not apply, and I
stopped as instructed.

# Statement tested

The coordinates are those of h334. The chain axis $x$ is the wall normal,
and $(u, w) = ((y+z)/2, (y-z)/2)$. $D$ is the row (family {0,1}) through the
origin: A vertices on $x = 0$, B vertices on $x = 1$, $w = 0$. The target is
the column vertex at $(u, w) = (1, d)$ in slab **up** (grids 1, 2; on plane 1
if $d$ is even, plane 2 if odd), or at $(0, d)$ in slab **down** (grids $-1$,
0; on plane 0 if $d$ is even, plane $-1$ if odd). The window is grids
$x_0..x_1$ and transverse sup-radius $r$ about the target, as in `window.py`
(the nearest image in $(u, w)$), with $r \leq L - 1$ so that it embeds. Always
on are the ice rule at the window's vertices (k40's filter) and the two-arc
rule (T2) on the window's hexagons, in the bond model with signs. Each group
below is guarded by its own selector:

- **W0**: every vertex of $D$ in the window has moment $+y$.
- **W1**: no vertex of plane $x = -1$ in the window has type $y$.
- **W2**: no vertex of planes $x = 0, 1$ in the window has moment $-y$.
- **W3**: no vertex of plane $x = -2$ in the window has moment $+y$.
- **W4**: for every axis $k$ and every pair $v$, $v + 4e_k$ both in the
  window, not (both of type $k$ with opposite signs).
- **W5**: some hole with at least two methylenes in the window has two of them
  as rods on different axes.
- **W6**: along every row segment of row slab 0 (planes 0, 1) in the window,
  the indicator of type $y$ is constant.
- **IND** (added by me): no column vertex of the target's slab in the window
  with $0 \leq w < d$ (or $d < w \leq 0$) is a $-$ pass-through. This is the
  induction hypothesis of a proof by steps outward from $D$.
- **NEG**: both column bonds at the target have sense $-$.

Torus mode (T1, T4) uses the same groups on every vertex. SLABNEG says that
some vertex of some column of the slab is a $-$ pass-through (h334's query).

# T1 and T4: whole torus (solver)

`h581_torus.py`, one child process per query, cap 120 s.

| cell | query | verdict | wall |
|---|---|---|---|
| (3,4,4) | W0..W6, no negation | SAT | 0.2 s |
| (3,4,4) | W1..W6, no negation | SAT | 0.2 s |
| (3,4,4) | W0 W1 W2 W4 (control) | SAT | 0.2 s |
| (3,4,4) | W0 W1 W2 W4 + SLABNEG, up / down | UNSAT / UNSAT | 0.3 / 0.2 s |
| (3,4,4) | W0 + SLABNEG (= h334), up / down | UNSAT / UNSAT | 0.6 / 0.6 s |
| (3,4,4) | W1 W2 W4 + SLABNEG, up / down | SAT / SAT | 0.3 / 0.1 s |
| (4,4,4) | the same nine | SAT, SAT, SAT, UNSAT, UNSAT, UNSAT, UNSAT, SAT, SAT | 0.2 to 0.4 s each |

The hypotheses are consistent. `h582_verify.py` decoded the two
controls on each cell and checked them without the encoding: every vertex had
a moment, $D$ was uniform $+y$ in `ctrl_all`, W1 to W4 held, Law C held at
every hole, and there were 96 to 316 corners. The encoding agrees with h334.
On the torus, W1, W2 and W4 without W0 do not give the conclusion either:
some $-$ pass-through then exists.

# T2: windows centred on the target (solver)

`h584_sweep.py` drives `h583_window.py` over $d = -L..L$ and
$r = 1..\min(5, L-1)$ on (3,4,4), (3,5,5), (3,6,6), (3,8,8) and (6,6,6), both
slabs, for two $x$-extents: 572 windows each. Every UNSAT has a SAT control
(the same clause set without NEG). There were no timeouts, and the longest
batch took 0.4 s. The smallest UNSAT radius was the same on all five cells
wherever the radius embeds, so one table serves them all. An entry $r$
means UNSAT first at radius $r$ and at every larger radius tried; '-' means
SAT at every radius tried.

| variant | extent | slab | $\lvert d\rvert=0,1$ | 2 | 3 | 4 | $\geq 5$ |
|---|---|---|---|---|---|---|---|
| A = W1 W2 W4 | $-3..3$, $-3..5$ | both | - | - | - | - | - |
| B = W0 W1 W2 W4 | $-3..3$ | up | 1 | 2 | - | - | - |
| B | $-3..3$ | down | 1 | 2 | 3 | - | - |
| B | $-3..5$ | up | 1 | 2 | 3 | 4 | - |
| B | $-3..5$ | down | 1 | 2 | 3 | 4 | - |
| Bf = W0..W6 | both extents | both | as B | | | | |
| Cn = W1 W2 W4 IND | both extents | both | - | - | - | - | - |
| C = B + IND, F = Bf + IND | $-3..3$ | up | 1 | 2 | - | 4 ($L \geq 5$) | - |
| C, F | $-3..5$ | both | as B | | | | |

On (3,4,4) the entry for $\lvert d\rvert = 4$ is '-' because $r \leq 3$
there. The isolated UNSAT of C at $\lvert d\rvert = 4$ in slab up is not a
step of an induction, since the step at 3 fails in the same window. **The
UNSAT radius is always exactly $\max(\lvert d\rvert, 1)$**: a window that
does not contain $D$ never excludes the target. Where UNSAT fails, it fails
because of the $x$-extent and not because of $r$. The variants differ in how
far the extent lets them reach.

**Reach against $x$-extent** (`h586_reach.py`, `h587_cone.py`; cell (6,8,8),
$r = 7$, $d = 0..7$). The entry is the largest $d_0$ such that every
$d \leq d_0$ is UNSAT. All controls were SAT.

| $x_0..x_1$ | up: W0 W4 | up: W0 W1 W2 W4 | down: W0 W4 | down: W0 W1 W2 W4 |
|---|---|---|---|---|
| $-1..3$ | 2 | 2 | 2 | 2 |
| $-1..5$, $-1..7$, $-1..9$ | 3 | 3 | 2 | 2 |
| $-2..5$, $-2..7$, $-2..9$ | 3 | 4, 5, 5 | 2 | 4 |
| $-3..3$ | 2 | 2 | 3 | 3 |
| $-3..5$ | 4 | 4 | 4 | 4 |
| $-3..7$ | 5 | 5 | 4 | 4 |
| $-4..5$ | 4 | 4 | 4 | 4 |
| $-4..7$, $-4..9$, $-4..11$ | 5 | 5 | 4 | 4 |
| $-5..5$ | 4 | 4 | 5 | 5 |
| $-5..7$ | 6 | 6 | 6 | 6 |
| $-5..9$, $-5..11$ | 7 | 7 | 6 | 6 |
| $-6..9$, $-6..11$ | 7 | 7 | 6 | 6 |
| $-7..11$, $-7..13$ | 7 | 7 | 7 | 7 |

Here 7 is the ceiling set by $r \leq L - 1 = 7$. With W0 W4 the reach
grows by 2 for every two grids (one slab) of depth below the wall: in slab up
it is 3, 5 and 7 for $x_0 = -1$ or $-2$, $-3$ or $-4$, and $-5$ or $-6$, and
in slab down it is 2, 4 and 6. It grows by 1 for every grid of height above:
in slab up it is 2, 4 and 6 for $x_1 = 3, 5, 7$. The reach is the smaller of
the two limits, which gives a cone of slope about 1 in $(x, w)$. With $x$-extent $-7..13$, the smallest UNSAT radius is exactly
$r = d$ for $d = 0..7$, in both slabs and in both variants (`h586_rprof_*`).
Without W0, variants A and Cn and W1..W6 (with or without IND) are SAT at
$d = 1, 3, 5, 7$ even at $-7..13$, $r = 7$.

**The SAT models at the largest radius** (`h588_model.py`,
`h589_kinks.py`; (3,8,8) $d = 5$, $r = 5$, $-3..5$ with W0..W6; (6,8,8)
$d = 6$, $r = 7$, $-3..7$ with W0 W1 W2 W4; (6,8,8) down, $d = 5$).
Moving along the target's column, the bond senses read $+$ to within a few
bonds of the target, then a run of 3 to 7 bonds of $-$ containing the target.
The kinks (type $x$) of every plane from $x_0$ to $x_1$ concentrate on a
band of nearly constant $y = u + w$, about $y = 5..9$ when $d$ is 5 or 6. The
band therefore runs through all the planes at the same $y$. It separates
the target from $D$ inside the window, and it would meet $D$ at
$u \approx y$, at or just past the window's edge in $u$. The target sits in
the band, on plane 1 or 2, above the wall. With W6 the type-$y$ set on
planes 0 and 1 in the window is a union of full rows: $D$ alone, or $D$ and
the row $w = -2$. Without W6 there is one isolated type-$y$ vertex in one
model. In the (3,8,8) model the planes above the column slab carry a
second full row of $+y$ at $x = 4, 5$. This description is **computed** from
three models and is not a law.

# Which hypotheses matter (T3; solver)

Measured on (6,8,8), $r = 7$, $d = 0..8$, extents $-3..7$ and $-5..9$, both
slabs (`h586_reach.py t3_688*`), with 13 variants.

- **W0 is necessary.** Every variant without it is SAT at every $d \geq 1$,
  whatever else is added: A, Cn, W1 W2 W4 W6, and W1..W6.
- **W4 (orientation) does the work.** W0 alone reaches $d = 2$ in both
  extents, and W0 W2 also reaches 2. W0 W1 reaches 3 in slab up and 2 in
  slab down. W0 W1 W2 reaches 3 (up) and 2 (down) at $-3..7$, and 7 (up) and 6 (down) at $-5..9$. W0 W4
  reaches 5 (up) and 4 (down) at $-3..7$, and 7 (up) and 6 (down) at $-5..9$,
  which is the same as W0 W1 W2 W4 in every row.
- **W1 and W2 are not needed** once W4 holds and the window reaches down to
  $x = -3$ or lower. At $x_0 = -2$ they add about two to the reach (table
  above), acting as a substitute for depth below the wall.
- **W3, W5 and W6** do not change a single verdict in any row.
- **IND** (the induction hypothesis on the slab) does not make a bounded
  step: without W0 it is SAT everywhere, and with W0 it gives nothing that W0
  does not.

# Hand argument

None. There is no bounded window to certify, so T5 was not attempted. The one
structural fact the data support is the cone. Excluding the target at
distance $d$ needs $D$ at distance $d$ and roughly $d$ grids of state on
each side in $x$, and it needs orientation. That suggests information
carried from $D$ outward at unit speed in $(x, w)$ by the orientation law,
not by the wall. I have not tried to prove it (**conjecture**, and outside
this task).

# Scripts and timings

Everything is in `experiments/08_frozen_structure/scratch_h/`. The records
are in `.tmp/`.

| script | purpose | runs |
|---|---|---|
| `h580_lib.py` | encoding: region, W0..W6, IND, NEG, SLABNEG, each behind a selector | library |
| `h581_torus.py` | T1 and T4 on the torus | (3,4,4), (4,4,4); 0.1 to 0.6 s per query |
| `h582_verify.py` | decodes the torus controls and checks the hypotheses independently | 0.1 to 0.3 s |
| `h583_window.py` | T2/T3: one window, all variants with controls, one capped child process per batch (cap 240 s) | longest batch 0.6 s |
| `h584_sweep.py` | T2 driver; `.tmp/h584_x33.jsonl`, `h584_x35.jsonl` (572 windows each) | 2 min 12 s per extent |
| `h585_table.py` | smallest UNSAT $r$ per (cell, slab, $d$); flags non-monotone $r$, bad controls, timeouts | none flagged |
| `h586_reach.py` | reach against $x$-extent and ablations on (6,8,8); `.tmp/h586_*.jsonl` | 36 s for 8 extents |
| `h587_cone.py` | reach tables | exact |
| `h588_model.py`, `h589_kinks.py` | drawing and kink statistics of SAT models | 0.2 s |

Pre-flight (T1): one window query on (3,4,4) took 0.1 to 0.3 s and one torus
query 0.2 to 0.6 s, so the sweep was estimated at a few minutes and ran in
under five. Every verdict above is from CaDiCaL 1.9.5 through pysat in a
child process. No solve reached its cap.

# Rules kept or broken

- Kept: scripts only `h580` to `h589`, no existing script modified. I edited
  `h583` and `h584`, both my own, after creating them. No git, no commit.
- Kept: every solve in a child process with a hard `subprocess.run` timeout
  (h32_cap), one solver process at a time, no job over 10 minutes, nothing on
  the Sparks or through expq, `TMPDIR` in the repo's `.tmp`.
- Kept: every UNSAT reported with its SAT control on the same clause set
  without the negated conclusion.
- Beyond the brief: I used the cell (6,8,8) in addition to the five named
  cells, for $x$-extents larger than $a = 3$ allows, and added the IND
  variant. No DRAT proof was written, since no bounded lemma was found.
