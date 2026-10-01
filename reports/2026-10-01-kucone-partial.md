---
title: "Agent kucone (Opus, 30 September 2026), stopped before it reported: what its scripts and logs show. The first step of K_u given orientation is the sum of two Theorem 9 certificates, checked exactly on the infinite lattice for d = 2 to 30 in both slabs. Computed, no checker, not a result of the note"
author: "Claude (Fable), main loop, from the scripts and logs of agent kucone, for Lyndon Drake"
date: 2026-10-01
---

Status tags as in the note: **computed** (exact, no solver), **solver**, **conjecture**. Nothing here
has had a checker, and the agent that did the work never wrote its report: it was stopped by the main
loop on 30 September when Theorem 1 ceased to need $K_u$ (LOG, same date). This note is written from
its scripts `experiments/08_frozen_structure/scratch_h/h650_lib.py` to `h656_minimal.py` and the logs
they left in `.tmp` (`h651_up.log`, `h651_down.log`, `h652_up_*.json`, `h655_12.log`, `h655_30.log`,
`h656_l1.log`), read by the main loop and not re-run. It is recorded because the construction, if a
checker confirms it, is a hand proof of the first step of $K_u$ given Theorem U, uniform in the side.

## The statement

The first step of $K_u$: a uniform row $D$ (a chain of family $\{0,1\}$, axis $x$, A vertices on the
plane $x = 0$, every vertex of moment $+y$) forces every pass-through of every column (chain of family
$\{2,3\}$) of the two neighbouring column slabs to have sense $+$. On the torus it is DRAT-certified
for cubic sides 4 to 8 (`h334`). Agent kuwall showed on 30 September that, given orientation, it is
local in a cone of slope one about the row: the target at transverse distance $d$ is excluded by a
window of radius $d$ about it with about $d$ grids of $x$-extent (`docs/reports/2026-09-30-opus-kuwall.md`).

## What the logs show

**The linear relaxation on the cone window is infeasible given orientation (computed, floating point
then exact).** `h651_lp.py`, in Theorem 9's variables (one-hot, (T2), bond rule, orientation at every
hole of the window, $D$ uniform, the target a $-$ pass-through): for $d = \pm 1$ to $\pm 7$ and both
slabs, NEG is INFEAS and the three controls are FEAS (the system without the negation; without the
row; without orientation). Sample rows of `h651_up.log`: $d = -7$, $x$-extent $-8..10$, radius 7,
1,069 vertices, 5,065 rows, 634 orientation rows, INFEAS in 5.3 s, controls FEAS. `h656_minimal.py l1`
makes the Farkas certificates canonical by least $L^1$ norm: exact for every $d$, with $L^1$ norms
102, 525/2, 783/4, 1793/4 at $d = -5, 6, -6, 7$ and 26 to 84 orientation rows used.

**The closed form is a sum of two Theorem 9 certificates (computed, exact).** `h653_closed.py` states
the idea: the negated conclusion at the target $t$ says that its moment is $+z$ or $-y$, and each
alternative is a corner term of a causal diamond along the axis $y$ whose lower apex is the hole $v +
2e_y$ above a vertex $v$ of $D$, into which $v$ points. The first, $m_y(t)$, makes $t$ the upper apex
vertex of a $y$-diamond from a vertex $v$ of $D$ (the diagonal law itself); the second, $p_z(t)$,
makes $t$ the outer rod of the corner of a $y$-diamond from another vertex $v'$ of $D$ that is extreme
in $-z$ (the corner law, the corollary of Theorem 9). Theorem 9's closed form for the axis $y$,
without its hypothesis on the upper vertex, gives each diamond an identity whose remainder is its
corner terms, and the sum of the two, with the two hypotheses $p_y(v) = p_y(v') = 1$ and the negation
at $t$, is identically $-1$ minus a non-negative combination, provided the star of $t$ meets the first
diamond only in its apex hole and the second only in its corner hole.

`h655_verify.py` builds the two diamonds by formula, with no search. For slab up and $d \geq 3$,
with $t = (x_t, 1 + d, 1 - d)$ and $x_t = 1$ for even $d$ and $2$ for odd $d$: the first diamond runs
from the hole above $v = (x_t - 1, 2 - d, 2 - d) \in D$ to the hole below $t$; the second from the
hole above $v' = (1, 1, 1) \in D$ to the hole below $w' = (2x_t - 2, 2d, 0)$; both have separation $2d
- 1$. For $d = 2$, $v = (0, -2, -2)$ and $w' = (0, 6, 2)$, separation 5. Slab down is the image under
$(x, y, z) \mapsto (1 - x, y - 1, z - 1)$, and negative $d$ the image under $(x, y, z) \mapsto (x, 2 -
y, 2 - z)$ with the global reversal. The script checks, in exact rational arithmetic on the infinite
lattice, that the combination equals $-1$ minus a non-negative combination of variables, and records
the geometric facts the hand proof would use (the two diamonds disjoint, the star of $t$ meeting each
as required, the corner extreme in $z$). `h655_30.log`: **ALL EXACT**, 116 of 116 rows, $d = \pm 2$
to $\pm 30$, both slabs; the support of the certificate at distance $d$ is $x$ from about $-d$ to $d +
1$ and transverse radius $d$, which is kuwall's cone. `h656_minimal.py delete` was written to test
whether orientation can be restricted to the holes of the two diamonds and whether deleting any one
hole's equation makes the system feasible; its log is not in `.tmp`, so that question is open.

## What it would mean

If a checker confirms the construction, the first step of $K_u$ follows, given Theorem U, from two
applications of the diagonal law and its corner corollary, by hand and for every cell: the vertex $t$
cannot have moment $-y$ because it would be the upper apex of an oriented diamond whose lower apex
vertex has moment $+y$ (Theorem 3), and cannot have moment $+z$ because it would be the extreme corner
of an oriented diamond whose lower apex vertex, on $D$, already is the one corner that the corner law
allows. With the later steps of $K_u$, which hold on every cell (check6), $K_u$ given U would then be a
theorem on every cell. Since Theorem 1 in its form of 30 September does not use $K_u$, this is of
interest for the record of $K_u$ and for the cubic cells' certificate tables, and is not on the path to
Theorem H.

## Standing

Computed by one agent, exact, no checker, never reported by the agent; read from scripts and logs by
the main loop, which has not re-run them. Not in the note. A checker's brief, if it is ever wanted:
re-derive the two-diamond construction from Theorem 9 as stated in the note, check the three
geometric facts by hand for general $d$, re-run `h655_verify.py` for a sample of $d$, and settle the
question of `h656 delete`.

**Update, later on 2026-10-01.** That brief was run. Agent kucheck (Opus; scripts `h720`–`h724`;
`docs/reports/2026-10-01-opus-kucheck.md`) **CONFIRMED** the construction with its own code, which
imports nothing of kucone's: the identity holds exactly for $d = \pm 2$ to $\pm 12$ in both slabs,
the multipliers are identical to kucone's row for row, the three geometric facts hold by hand for
every $d \geq 2$ (the one that takes work, that the $-z$ extreme of the second diamond is the single
hole $t + 2e_z$, is proved from the product structure of a $y$-diamond in the coordinates $x + z$ and
$x - z$), the use of Theorem 9 without its upper-vertex hypothesis is legitimate (the identity is the
corner law), the proviso about the star of $t$ and the disjointness of the diamonds are true but not
needed, only the two row vertices $v$ and $v'$ are used, and $d = 0, \pm 1$ follow from the bond rule.
`h656 delete` is settled: orientation on the holes of the two diamonds suffices and is not minimal.
The main loop re-ran `h720_kucheck.py 2:7` (both slabs, both signs): all checks pass. The hand lemma
is in the checker's section C4. Standing now: **computed and confirmed by an independent checker;
hand lemma written, no human reader.**
