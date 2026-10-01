---
title: "Checker kucheck on kucone's construction: the first step of K_u given orientation is the sum of two Theorem 9 identities"
author: "Claude (Opus), agent kucheck, for Lyndon Drake"
date: 2026-10-01
---

# Verdict

**CONFIRMED.** The construction is correct as the main loop reconstructed it
(`docs/reports/2026-10-01-kucone-partial.md`). C1 holds by hand for general
$d \geq 2$, with the two symmetries. C2: my own code (h720, which imports nothing
of kucone's) reproduces the identity exactly for $d = \pm 2$ to $\pm 12$ in both
slabs, and its multipliers are identical, row for row, to kucone's on every
sampled $d$. C4 is written below. Remarks, none of which changes the
statement:

1. The proviso in the reconstruction ("provided the star of $t$ meets the
   first diamond only in its apex hole and the second only in its corner
   hole") is true but **not needed**. Neither the identity nor the hand proof
   uses it, and the same goes for disjointness of the two diamonds
   (**proved**, below).
2. Only **two** vertices of the uniform row are used, $v$ and $v'$
   (**proved**; the certificate has exactly two `hypD` rows).
3. `h656 delete` is settled (**computed**). Orientation on the holes of
   $D_a \cup D_b$ alone is enough at every $d = 2$ to $6$ (slab up). It is
   **not minimal**. At $d = 2$ the window system is infeasible with no
   orientation row at all. For $d \geq 3$ some single deletions keep it
   infeasible: 2 of 4 holes at $d = 3$, 6 of 12 at $d = 4$, 12 of 28 at
   $d = 5$ and 28 of 52 at $d = 6$.
4. The cases $d \in \{0, \pm 1\}$, which the construction leaves out, follow
   directly from $D$ and the bond rule (**proved**, below), so the lemma covers
   every column vertex of both slabs.

# C1. The construction, by hand

**Coordinates (from h650, checked against the note).** $D$ is the row
$\{(0, 2j, 2j)\} \cup \{(1, 2j+1, 2j+1)\}$, a chain of axis $x$ (its two bonds
at $(0,2j,2j)$ are $d_0$ and $d_1$, which agree in $x$), with every vertex of
moment $+y$. Write $u = (y+z)/2$ and $w = (y-z)/2$. A column (family
$\{2,3\}$, bonds $d_2$ and $d_3$ at A) has fixed $u$ and runs along $w$. Slab
up is the pair of grids $x = 1$ (B) and $x = 2$ (A), and its columns sit at odd
$u$. The translation by $(0,2,2) \in A$ preserves both sublattices and $D$, so
the column at $u = 1$ is general. The target is
$t = (x_t, 1+d, 1-d)$, with $x_t = 1$ (B) for even $d$ and $2$ (A) for odd $d$.

**The sense table (proved).** At $t$ the column bonds are $\pm(1,-1,1)$ and
$\pm(1,1,-1)$ (B case) or $d_2$ and $d_3$ (A case). Sense $-w$ means that the
bond lowering $w$ is the outgoing one, so the moment
$n = \tfrac12 \sum(\text{outgoing})$ is that bond plus one of the two non-column
bonds. In both cases this gives $n(t) \in \{+z, -y\}$, which is kucone's
NEG row $p_z(t) + m_y(t) = 1$.

**The diamonds, $d \geq 3$.**
$v = (x_t - 1, 2-d, 2-d)$, $v' = (1,1,1)$, $w' = (2x_t - 2, 2d, 0)$.

- $v \in D$: an A vertex $(0, 2j, 2j)$ for even $d$ and a B vertex
  $(1, 2j+1, 2j+1)$ for odd $d$. $v' \in D$ is a B vertex. $w'$ is an A
  vertex (sum $2d$ or $2 + 2d$, $\equiv 0 \bmod 4$ for the right parity of
  $d$). No hypothesis is placed on $w'$.
- $t - v = (1, 2d-1, -1)$ and $w' - v' = (2x_t - 3, 2d-1, -1)$. Both pairs
  have separation $s = 2d - 1 \geq 5$, odd, along $y$, with transverse offsets
  $(\pm1, \pm1)$ in $(x, z)$. That is exactly the scope of Theorem 9 and
  Theorem 3 (offset one, $s \geq 5$).
- $D_a$ is the causal $y$-diamond from $h_v = v + 2e_y$ to $t - 2e_y$, and
  $D_b$ the one from $v' + 2e_y = (1,3,1)$ to $w' - 2e_y$. Each has
  $n = 2d - 5$ steps.

**$d = 2$.** $v = (0,-2,-2)$ and $w' = (0,6,2)$, so $t - v = (1,5,1)$ and
$w' - v' = (-1,5,1)$, both with $s = 5$. The general formula would give $s = 3$,
outside Theorem 9. Here $D_b = \{(1,3,1), (0,4,2)\}$, and its $-z$ extreme is
its lower apex $(1,3,1) = t + 2e_z$, one hole with two corner roles (see C4).

**Structure of a $y$-diamond (proved).** A step from an A-hole uses
$\tau \in \{\pm1\}^3$ with $\tau_x\tau_y\tau_z = +1$, and from a B-hole one with
product $-1$. Steps alternate between hole types. With $\tau_y = +1$, an
A-step changes $a = x + z$ by $\pm 2$ and fixes $b = x - z$, and a B-step does
the reverse. So the holes of a diamond at level $j$ form a product of an
interval in $a$ and an interval in $b$. The bounds are
$|a - a_{lo}| \leq 2\alpha(j)$ and $|a_{hi} - a| \leq 2(\alpha_{tot} - \alpha(j))$,
and the same for $b$ with $\beta$, where $\alpha(j)$ and $\beta(j)$ count the
A-steps and B-steps among the first $j$.

**Fact 1: the $-z$ extreme of $D_b$ is unique and equals $c = t + 2e_z$
(proved).** $D_b$ starts at the B-hole $(1,3,1)$, so $a_{lo} = 2$ and
$b_{lo} = 0$, with $\beta_{tot} = d - 2$ and $\alpha_{tot} = d - 3$. The
smallest $z = (a - b)/2$ needs the least $a$ and the greatest $b$ on one level.

- Even $d$ ($a_{hi} = b_{hi} = 0$). The least $a$ over all levels is $4 - d$,
  attained only at $\alpha = d/2 - 1$. The greatest $b$ is $d - 2$, attained
  only at $\beta = d/2 - 1$.
- Odd $d$ ($a_{hi} = b_{hi} = 2$). The least $a$ is $5 - d$, only at
  $\alpha = (d-3)/2$. The greatest $b$ is $d - 1$, only at $\beta = (d-1)/2$.

In both cases the two are attained together only at level $j = d - 2$
(which is at most $n$ exactly when $d \geq 3$). That gives the unique hole
$(x_t, d+1, 3-d)$, which is $t + 2e_z$, a B-hole for even $d$ and an A-hole
for odd $d$, as it must be.

**Fact 2: the star of $t$ (proved, not needed).** $D_a$ lies in the past of
$t - 2e_y$, so every hole of $D_a$ has $y \leq d - 1$. Every hole of the star of
$t$ other than $t - 2e_y$ has $y \geq d$. Every hole of $D_b$ has
$z \geq 3 - d$. Every hole of the star other than $t + 2e_z$ has
$z \leq 2 - d$.

**Fact 3: $D_a \cap D_b = \emptyset$ (proved, not needed).** A common hole
would put $t - 2e_y$ in the causal future of $(1,3,1)$. That needs
$|\Delta z| \leq \Delta y$, but $\Delta z = -d$ and $\Delta y = d - 4$.

**Theorem 9 without the hypothesis on the upper vertex (proved from the
note).** Theorem 9 is an identity in the variables:
$\Lambda + (p(v) - 1) + (m(w) - 1) = -1 - \sum_4 \text{lateral corners}$, where
$\Lambda$ is the combination of one-hot, (T2), bond and orientation rows. The
hypotheses enter only as the two added rows, and the proof uses them only to
cancel $p_z(v)$ and to fix the constant. Moving them across gives
$\Lambda = 1 - \sum_6 \text{corners}$, an identity of the relaxation. Every
state satisfying the rows of $\Lambda$ then has exactly one corner variable
equal to 1, which is the note's corner corollary. So using the identity
without the hypothesis on $w$ is legitimate. h720 checks
$\Lambda = 1 - \sum_6$ directly for every diamond it builds, $s = 5$
included.

**The sum (proved).** With $\Lambda_a = 1 - p_y(v) - m_y(t) - C_a$ and
$\Lambda_b = 1 - p_y(v') - m_y(w') - p_z(t) - C'_b$ (where $C_a$ is the four
lateral corners of $D_a$, $C'_b$ the three lateral corners of $D_b$ other
than $c$, and $p_z(t)$ the $-z$ corner of $D_b$ by Fact 1):
$$\Lambda_a + (p_y(v)-1) + \Lambda_b + (p_y(v')-1) + (p_z(t)+m_y(t)-1) =
-1 - C_a - C'_b - m_y(w').$$
That is $-1$ minus eight variables, which matches the "slack 8" of every
h655 row.

**Symmetries (proved).**

- **Slab down:** $M(x,y,z) = (1-x, y-1, z-1)$. It exchanges the sublattices,
  maps $D$ onto $D$, preserves $w$, sends $u \mapsto u - 1$ and slab up to slab
  down, and acts on moments by $n_x \mapsto -n_x$. So $+y$ on $D$ and the set
  $\{+z, -y\}$ are invariant, and every row type maps to its own type.
- **$d < 0$:** $R(x,y,z) = (x, 2-y, 2-z)$ followed by the global reversal.
  $R$ preserves the sublattices and $D$, maps $u = 1$ to itself and $w$ to
  $-w$, and the moment of $R$ composed with reversal fixes $+y$ and the set
  $\{+z, -y\}$. The reversal takes "out" orientation rows to "in" rows.
  h654/h720 rewrite these by Law C as
  $\mathrm{in}(h) = \tfrac12\sum_{4\,\mathrm{hex}} T2 - \tfrac12\sum_{\mathrm{bridgeheads}}
  \text{one-hot} - \mathrm{out}(h)$, an identity checked exactly in h720. So
  orientation in the note's form is all that is used.

# C2. Own-code exact verification (computed)

`h720_kucheck.py` (own lattice, hexagons from the note's $(O, \sigma)$
definition, diamonds by forward and backward reachability, Theorem 9's
multipliers from the note's statement, $\nu$ counted from the bonds of the
hexagons with both holes in $D$) checks, in `Fraction` arithmetic on the
infinite lattice, for $d = \pm 2$ to $\pm 12$ in both slabs (44 rows):

- (i) for each diamond alone, $\Lambda = 1 - \sum$ of its six corner variables
  exactly, with the corners computed from the geometry and their extremes
  asserted unique;
- the roles: $p_y(v)$ and $m_y(t)$ are corners of $D_a$, and $p_y(v')$ and
  $p_z(t)$ are corners of $D_b$;
- (ii) the $K_u$ combination is $-1$ minus a non-negative combination with
  exactly 8 negative coefficients;
- (iii) Facts 1 to 3.

All 44 pass, along with the Law C substitution (log `.tmp/h720_2_12.log`,
3.5 s). Row counts and $L^1$ norms agree with kucone's logs. For example,
$d = 2$ has 48 rows and $L^1$ 25, $d = 12$ has 3,832 and 2,676, and $d = -12$
has 3,239 and 2,284.

`h721_compare.py` rebuilds kucone's $\lambda$ through `h655_verify.construct`
and `h654_family.substitute_Or`, then compares dictionaries. At
$d = 2, 3, 5, 8, 12, -2, -3, -7, -12$, both slabs (18 rows), the multipliers
are **identical** and kucone's check is exact (log `.tmp/h721.log`, 2 s). A
direct re-run of `h655_verify.py 2,7,12,-5,-12` gave ALL EXACT on 10 rows
(`.tmp/h655_kucheck_sample.log`, 1.7 s). The 30-row sweep was not re-run.

# C3. `h656 delete` settled (computed, LP, floating point)

`h722_minimal.py` is my own version, run through the timeout wrapper
`h723_run.py`. The window is kuwall's cone about $t$ (grids $-(d+1)$ to $d+3$,
sup-radius $d$ in $(u,w)$), joined with every vertex of every hexagon and
every methylene of the holes of $D_a \cup D_b$, so that each diamond hole is
complete. This matters: h656 used the bare cone, where some diamond holes may
be incomplete. The rows are one-hot, (T2) and bond everywhere in the window,
$p_y = 1$ on every $D$ vertex of the window, NEG, and orientation only at the
holes of $D_a \cup D_b$. Slab up:

| $d$ | window | holes of $D_a \cup D_b$ | orientation there only | single deletions feasible |
|---|---|---|---|---|
| 2 | 65 v | 4 | INFEAS | 0 of 4 (INFEAS with no orientation at all) |
| 3 | 135 v | 4 | INFEAS | 2 of 4 |
| 4 | 259 v | 12 | INFEAS | 6 of 12 |
| 5 | 454 v | 28 | INFEAS | 16 of 28 |
| 6 | 725 v | 52 | INFEAS | 24 of 52 |

With the window padded by 2 the pattern for $d = 2, 3, 4$ is unchanged.

- **The holes that can go.** At $d = 3$ they are the two lower apex holes
  $(1,1,-1)$ and $(1,3,1)$, the holes above $v$ and $v'$. At $d = 4$ they are
  those two, plus the apex $t - 2e_y$, the corner $t + 2e_z$, and $(1,1,-1)$
  and $(0,4,2)$.
- **Greedy irreducible subsets** (`h724_greedy.py`, order-dependent, not
  minimum): 0 of 4 at $d = 2$, 2 of 4 at $d = 3$ (keeping $t - 2e_y$ and
  $t + 2e_z$), 7 of 12 at $d = 4$, 19 of 28 at $d = 5$.
- **One diamond is not enough:** for $d = 3$ to $5$ it is feasible with orientation on $D_a$ alone, $D_b$ alone, or none.

So the answer to h656's question:

- Restricting orientation to the two diamonds suffices (**computed** here,
  and **proved** by the certificate, whose rows lie in that set).
- It is not minimal. The extra rows of the window (the whole row $D$, and the
  (T2) and bond rows round the diamonds) make some diamond holes redundant,
  unlike Theorem 9 alone, where the note records every hole as needed.
- At $d = 2$, orientation is not needed at all in the relaxation. This agrees
  with kuwall's and check6's "reach 2 with W0 alone".

These are finite-window LP statements: feasibility after a deletion shows only
that no certificate exists in that window.

# C4. The hand lemma

**Lemma (first step of $K_u$ at one vertex).** Let a frozen state on the
lattice, or the lift of one on any cell, have two vertices
$v, v' \in D$ of moment $+y$, with $v$ and $v'$ as above for the target
$t = (x_t, 1+d, 1-d)$, $d \geq 2$, and suppose every hole of the causal
diamonds $D_a$ (from $v + 2e_y$ to $t - 2e_y$) and $D_b$ (from $v' + 2e_y$ to
$w' - 2e_y$) is oriented. Then $n(t) \notin \{+z, -y\}$: $t$ is a kink or a
$+$ pass-through of its column. The same holds in slab down (by $M$) and for
$d \leq -2$ (by $R$ and the global reversal, with the diamonds above $t$).

*Proof.*

1. **$t$ does not have moment $-y$.** If $t$ had type $y$, then $v$ and $t$,
   of type $y$ on diagonally neighbouring $y$-lines with separation
   $s = 2d - 1 \geq 5$ (5 at $d = 2$), would have equal signs by Theorem 3,
   whose diamond is $D_a$. So $\varepsilon(t) = +1$. Equivalently, apply the
   corner law to $D_a$: its lower-apex corner holds ($p_y(v) = 1$), so its
   upper-apex corner $m_y(t)$ fails.
2. **$t$ does not have moment $+z$.** Apply the corner corollary of Theorem 9
   to $D_b$. Exactly one of its six corner holes has its inward rod on its own
   axis on the outer side. The lower apex does, since $v'$ has moment $+y$ and
   points into $v' + 2e_y$. The $-z$ corner of $D_b$ is the unique hole
   $c = t + 2e_z$ (Fact 1), and its inward rod on the outer side is $t$ with
   moment $+z$. So $p_z(t) = 0$.

For $d = 2$ (and $d = 3$ at the upper apex) $c$ is also an apex of $D_b$. The
corner law is still a statement about six distinct variables, and at
$d = 2$ orientation of the single hole $c$ already forbids two inward rods,
$v'$ and $t$. $\square$

**The remaining distances (proved).** At $d = 0$ the target is $v'$ itself
(slab up) or $(0,0,0)$ (slab down), and is a $+$ pass-through. At $d = \pm 1$
the target is bonded to a vertex of $D$:

- slab up: $(2,2,0) = (1,1,1) + (1,1,-1)$, bond $d_3$; $(2,0,2)$, bond $d_2$;
- slab down: $(-1,1,-1)$ ($d = 1$) and $(-1,-1,1)$ ($d = -1$) to $(0,0,0)$, bonds $d_2$ and
  $d_3$.

The bond rule $d \cdot n(a) = d \cdot n(b)$ with $n = +y$ at the $D$ end gives
$d_3 \cdot n(t) = -1$ or $d_2 \cdot n(t) = +1$. Both $+z$ and $-y$ give the
opposite value.

**Hypotheses used, and their availability.**

| hypothesis | where | available given Theorem U on an odd state? |
|---|---|---|
| one-hot, bond rule | every vertex and bond of the cages of $D_a$, $D_b$ | yes, any ice state |
| (T2) | hexagons with a hole in $D_a$ or $D_b$ | yes, any frozen state (Lemma L) |
| $p_y = 1$ at $v$, $v'$ only | two vertices of the uniform chain | yes, the hypothesis of $K_u$ |
| orientation | every hole of $D_a \cup D_b$ ($2d^2$-order many) | yes: Theorem U makes every hole oriented; on an even-curl state it is not supplied |
| Theorem 9, $s \geq 5$, offset $(\pm1,\pm1)$ | both diamonds | proved in the note, as already checked |

On a cell: the state lifts to a periodic frozen state on the lattice. Every
lifted hole is oriented, and the uniform chain lifts to $D$ and its
translates. Any column vertex of the two slabs has a lift at some integer $d$,
so the lemma applies with no condition on the side or on whether the diamonds
wrap. With check6's later steps, $K_u$ given Theorem U then holds for odd
frozen states on every cell. That combination is not re-checked here (out of
scope).

**What a reader still has to check.** The coordinates of $v$, $v'$, $w'$ and the two separations; the
$a/b$ product structure of a $y$-diamond and Fact 1 (the one non-trivial geometric fact); the identification
of the corner variables $m_y(t)$ and $p_z(t)$; the sense table; the symmetries $M$ and $R$ with reversal; and
that Theorem 9 and its corollary carry over to $y$-diamonds and a B lower vertex by the cyclic permutation
of axes and the inversion, both of which preserve the system. Theorem 9 itself is not re-proved here.

# Scripts and timings

All in `experiments/08_frozen_structure/scratch_h/`, Mac `.venv`, about 2.5 min of compute in all.
`h720_kucheck.py 2:12` (own exact check, 44 rows, 3.5 s, `.tmp/h720_2_12.log`, multipliers in
`.tmp/h720_lam_*.pkl`); `h721_compare.py` (identical to kucone, 2 s, `.tmp/h721.log`); `h655_verify.py
2,7,12,-5,-12` re-run (1.7 s, `.tmp/h655_kucheck_sample.log`); `h722_minimal.py` via `h723_run.py`
($d = 2,3,4$ 2.4 s; $d = 5,6$ 103 s; padded $d = 2,3,4$ about 20 s; `.tmp/h722.log`); `h724_greedy.py` via
h723 ($d = 2,3,4$ 2.4 s; $d = 5$ 13 s; `.tmp/h724.log`).

# Rules kept or broken

Kept: Mac only, no Sparks; one LP process at a time, under `subprocess.run(timeout=...)` (h723), with h720
and h721 pure arithmetic of seconds in the foreground; no job over ten minutes; new scripts h720 to h724
only, each with its header and usage line, no existing script modified; temporary files in `.tmp/`; no git
commits; the 30-row sweep not re-run; later steps of $K_u$, Theorem H and Theorem U not touched.
Minor: scripts written with zsh heredocs, which worked in this sandbox.
