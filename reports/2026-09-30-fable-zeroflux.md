---
title: "Z(L) given Theorem U, and more: Theorem U implies Theorem H on every cell without K_u. The stripe structure of every two-way axis on both sublattices (Theorem 6 with Lemma 4, all three cases of Theorem 7), the profiles of Theorem 15 that it kills, and the diagonal law on full lines give the contradiction over the three axes; neither W = 0, the walls, the uniform chains nor per-grid balance is needed. Every ingredient checked with 0 exceptions on the 1,357 odd cubic states, 48 oriented odd states of four other cells and 11 odd W = 0 states"
author: "Claude (Fable), agent zeroflux, for Lyndon Drake"
date: 2026-09-30
---

Status tags: **proved**, **computed**, **solver**, **conjecture**. Scripts `scratch_h/h600`–`h605`.
Everything below was written by one agent and checked by its own programs only; the main loop is to
re-derive Lemmas Z-2 (cases II and III) and Z-3 before anything is built on them.

## Verdict

**PROVED, and more than asked.** Given Theorem U, Z(L) holds on every cubic cell; the same argument
proves **Theorem H itself given Theorem U, on every cell, with no use of K_u** (Corollary Z-6). The
hypotheses W = 0, (Z1) and (Z2) were not needed: they only served to make every axis two-way on both
sublattices, and Lemma Z-2 covers the two other cases (Theorem 7's mixed case and its second case)
directly. The reduction of Theorem 1 therefore rests on Theorem U alone, and the first step of K_u on
the whole slab is no longer an open statement on the path to H. The brief anticipated this outcome as
"surprising and to be checked against the corpus": every ingredient was checked on the 1,357 odd
states of the cubic cells of side 3 and 4, on 48 oriented odd states of $(2,2,4)$, $(2,4,6)$,
$(4,3,3)$, $(4,4,6)$ and on 11 odd zero-flux states, with 0 exceptions in about 1.9 million
checks, and the argument's one non-obvious prediction on the corpus (which pairs of normals the two
two-way axes of a three-type state can have) holds in all 429 such states with no exception.

Why it was not seen before: Theorem 6 (27 September) and Theorem 15 (28 September) were never
combined across the three axes at once. The main loop's unchecked observation (i) of 28 September
(two constant profiles on a sublattice with three two-way axes) is the first half of Lemma Z-3; its
observation (ii), that the line fractions alone do not exclude three two-way axes, is right, and
Lemma Z-4 is what the fractions lack: the diagonal law on a full set of lines.

## Hypotheses used

- Frozen state; Theorem U (every hole oriented), through Theorems 3, 4, 5 (second statement) and 6.
- Theorem 5 (first statement), Lemma 4, Theorem 15 and Theorem $M'$, all proved on every cell.
- Lemma 1 and Lemma 8, only in Lemma Z-7 (even-curl states), which is not part of the proof.
- **Not used:** W = 0, (Z1), (Z2), Lemma 5, Lemma 6, Theorems 7, 8, 19, $K_u$, oddness except through
  U and $M'$.
- Answer to the brief's question on (Z2): the per-grid identity $M_k(t) = \Phi_k$ of the signed report
  (§1, Theorem (v)) is proved for **every ice state**, by flux conservation across the planes
  $x_k = t \pm \tfrac12$ and the ice rule alone; neither freezing nor orientation enters. Its proof was
  re-read and the identity re-verified on all 1,357 corpus states (W ≠ 0) and 28 zero-flux states.
  (Z1) is its sum over one sublattice, $N_k^A = N_k^B = L W_k$, also for every ice state.

## Lemmas with proofs

Notation as in the note. For axis $k$ and sublattice $S$ the $k$-lines of $S$ are indexed by their two
transverse coordinates $(\alpha, \beta) \in X_S \times Y_S$, each of the parity of $S$; every pair
occurs. $h^S_k(\alpha, \beta)$ is the number of type-$k$ vertices on the line. A plane $\{x_n = c\}$
of $S$ is $k$-free if it has none, and full if every one of its $k$-lines has one.

**Lemma Z-1 (one sublattice; B1(a)). Proved.** Let a frozen state have every hole oriented and let axis
$k$ be two-way on $S$. Then there is $n = n_S(k) \neq k$ such that $h^S_k$ is a function of $x_n$
alone; every plane $\{x_n = c\}$ of $S$ is $k$-free or full, its lines all carrying the same number
$h(c) \geq 1$ of type-$k$ vertices, all of one sign.

*Proof.* In the proof of Theorem 6 the counts $P = (h + s)/2$ and $Q = (h - s)/2$ of the two signs are
separable (Theorem 5, both statements), non-negative, with $PQ = 0$ (Theorem 4) and neither zero.
Lemma 4 makes both functions of one coordinate $x_n$, and $h = P + Q$ is then a function of $x_n$.
$\square$

The brief's route through a $k$-free plane also works when the plane belongs to $S$: $F(c_0) +
G(\beta) = 0$ for all $\beta$ makes $G$ constant. When the only $k$-free planes lie in $S'$ that route
says nothing about $S$, and Lemma 4 is what gives $S$ its structure. Both situations occur
(computed: of 1,814 two-way axis instances on the corpus, 1,626 have $k$-free planes in both
sublattices, 89 in A only, 99 in B only).

**Lemma Z-2 (both sublattices; B1(c)). Proved.** Let a frozen state have every hole oriented, let axis
$k$ be two-way, and let both sublattices carry type $k$. Then there is one axis $n(k) \neq k$ such
that $h^A_k$ and $h^B_k$ are both functions of $x_{n(k)}$ alone, every plane $\{x_{n(k)} = c\}$ of
either sublattice is $k$-free or full with one sign, and two adjacent non-empty planes (one of each
sublattice) have the same sign.

*Proof.* Three cases by the sublattice patterns.

*Case I, both sublattices two-way.* Lemma Z-1 gives normals $n$ for A and $m$ for B. Suppose $m \neq n$.
A has a full plane $x_n = c$ of sign $+$, B a full plane $x_m = d$ of sign $-$. The B-line at
$(x_n, x_m) = (c + 1, d)$ exists, carries type $k$ of sign $-$, and is a diagonal neighbour of the
A-lines $(c, d \pm 1)$, which carry type $k$ of sign $+$: Theorem 3 is contradicted. So $m = n$.
Adjacent non-empty planes: every line of the B-plane $c + 1$ is a diagonal neighbour of lines of the
full A-plane $c$, and Theorem 3 gives the sign.

*Case II, A two-way, B of one sign $\sigma$.* Lemma Z-1 gives $n$ for A. A has a plane $x_n = c$ of
sign $-\sigma$. Every B-line at $x_n = c \pm 1$ is a diagonal neighbour of lines of that plane, so by
Theorem 3 it has no vertex of type $k$. The empty lines of B form a product $I \times J$ (Theorem 5),
which contains $\{c - 1, c + 1\} \times Y_B$, so $J = Y_B$; then $F(c + 1) + G(\beta) = 0$ for all
$\beta$ makes $G$ constant, and $h^B_k$ is a function of $x_n$ whose non-empty planes are full. The
sign statements are Theorem 3 again.

*Case III, A of one sign $\sigma$, B of one sign $-\sigma$.* This is the second case of the proof of
Theorem 7, which shows that the empty lines of A form complete planes normal to an axis $n$, that
the same holds for B with the same $n$, and that full planes of A and B are never adjacent. With the
empty set $I \times Y_A$ the separable $h^A_k$ has $G$ constant, so it is a function of $x_n$, and
likewise $h^B_k$. $\square$

Case III has never been seen in a computed state (unsatisfiable at sides 3 and 4, per the note); case
II occurs in the corpus (91 axis instances) and case I is the common one (1,723).

**Lemma Z-3 (the killed profile; B2). Proved.** Let $P(x)$, $Q(y)$, $R(z)$ be the profiles of Theorem 15
on $S$, so that $h_y/\ell_y = P - R$, $h_z/\ell_z = Q - P$, $h_x/\ell_x = 1 + R - Q$. If $h^S_k$
depends on $x_n$ alone, $n \neq k$, then the profile of the third coordinate $i(k)$ is constant on
$S$. Consequently, if every hole is oriented, both sublattices carry all three types and all three
axes are two-way, then with $n(k)$ from Lemma Z-2 the map $k \mapsto i(k)$ has the same image on A
and B, of two or three elements; if three, every profile and every $h_k$ is constant on both
sublattices; if two, $\{a, b\}$, the axis $c \notin \{a, b\}$ has $h^S_c$ constant on both
sublattices.

*Proof.* $h_x/\ell_x = 1 + R(z) - Q(y)$ on all pairs $(y, z)$ of the parity of $S$. If it does not
depend on $z$ then $R(z) = R(z')$ for all $z, z'$, and if not on $y$ then $Q$ is constant; the two
other axes are the same. Now $i(k) \notin \{k, n(k)\}$, so $i(x) \in \{y, z\}$, $i(y) \in \{x, z\}$,
$i(z) \in \{x, y\}$, and the image cannot be a single axis. If it is $\{a, b\}$, the profiles of $a$
and $b$ are constant, and $h_c$ is $\ell_c$ times a constant plus the difference of those two
profiles. The normals are common to A and B by Lemma Z-2, so the image is too. $\square$

The eight assignments of normals fall into two classes under the symmetries of the cubic cell. In the
cyclic class ($n(x) = y$, $n(y) = z$, $n(z) = x$, or the reverse) every profile and every $h_k$ is
constant. In the other class two axes $a, b$ have each other as normal and the third, $c$, has
$n(c) \in \{a, b\}$; then $i(a) = i(b) = c$, the profiles of $c$ and of the axis $\{a,b\} \setminus
\{n(c)\}$ are constant, and the constant axis is $n(c)$.

**Lemma Z-4 (full lines carry one sign; B2/B3). Proved.** Let a frozen state have every hole oriented.
If every $k$-line of both sublattices has a vertex of type $k$, then axis $k$ is one-way.

*Proof.* The graph on the $k$-lines of both sublattices in which two lines are joined when they are
diagonal neighbours is connected: its vertices are the pairs $(\alpha, \beta)$ with $\alpha + \beta$
even, and the steps $(\pm 1, \pm 1)$ generate that set. Along any edge Theorem 3 gives equal signs to
any two vertices of type $k$ on the two lines, and every line has one. $\square$

**Theorem Z-5. Proved.** In a frozen state with every hole oriented in which both sublattices carry all
three types, some axis is not two-way.

*Proof.* Suppose all three axes are two-way. Lemma Z-2 applies to each. By Lemma Z-3 some axis $c$
has $h^A_c$ and $h^B_c$ constant, and the constants are at least 1 since both sublattices carry type
$c$. So every $c$-line of both sublattices has a vertex of type $c$, and by Lemma Z-4 axis $c$ is
one-way, which contradicts two-way. $\square$

**Corollary Z-6 (Theorem U implies Theorem H, without $K_u$). Proved.** On every cell, an odd frozen
state with every hole oriented has an axis that is empty or one-way. Hence Theorem U implies Theorem H
on every cell, and Z(L) given U is the special case W = 0.

*Proof.* If some type is absent its axis is empty. Otherwise, since the state is odd, Theorem $M'$
makes both sublattices carry all three types, and Theorem Z-5 gives an axis that is not two-way;
it is not empty, so it is one-way. For Z(L): W = 0 and three types give all six directions
(Corollary Z of the signed report), contradicting the one-way axis, so no such odd state exists.
$\square$

With Theorem P and Lemma A: on every cubic cell, Theorem U implies the periodicity of frozen zero-flux
states. On the cubic cells of side 4, 5, 6 the certificates of Theorem $U'$ alone now give Theorem
H; the $K_u$ certificates are not needed, and Theorem $U'$ at sides 7 to 10 (which the note says are
within reach) would give H there directly.

**Lemma Z-7 (no test set of even curl). Proved.** In a frozen state of even curl no sublattice carries
all three types. So the hypotheses of Theorem Z-5 are met only by odd states.

*Proof.* By Lemma 1 every line fraction is 0 or 1. If $P$ is not constant, Lemma 8 applied to $P - R$
and to $Q - P$ makes $R$ and $Q$ constant, so $h_x/\ell_x$ is a constant 0 or 1 and $S$ lacks $x$ or
lacks $y$ and $z$. If $P$ is constant, $a_y$ depends on $z$ and $a_z$ on $y$, and $a_x = 1 - a_y -
a_z \geq 0$ forces $a_z \equiv 0$ as soon as $a_y$ takes the value 1; so $S$ lacks $y$ or $z$.
$\square$ (Solver: "even curl and three types on A" is UNSAT at sides 3 and 4, controls SAT.)

**Lemma Z-8 (the planes beside a wall; B1(b)). Proved in the note as Theorem 8; written out here.** Let
the state have all three types and let $F = \{x_n = c_0\}$ be a wall of Theorem 7 (a $k$-free plane
whose neighbours do not have the same label) with the plane $c_0 + s$ non-empty. Then the type-$k$
set of the planes $c_0 + s$ and $c_0 + 2s$ is the union of $m$ uniform chains of axis $n$, all of one
family: the family with step $2e_i - 2e_k$ (coordinates $(i, n, k)$) when $s = +1$ and $F$ is a plane
of A, $2e_i + 2e_k$ when $F$ is a plane of B, and the reverse for $s = -1$. A chain meets every
$k$-line of its plane once and every grid $\{x_k = t\}$ once, so $m = h(c_0 + s) = h(c_0 + 2s)$ and
the two planes carry exactly $m$ type-$k$ vertices on every grid $t$. This is the form (Q) of Theorem
13 on two planes. Not used in the proof above; the hypothesis of three types is necessary (below).

**B1(d), the balance conditions in this language.** For axis $k$ with normal $n$, labels $\lambda(c)
\in \{0, +, -\}$ and counts $h(c)$: (Z1) $\sum_{c \in S} \lambda(c) h(c) = 0$ on each sublattice, that
is the full planes of sign $+$ and of sign $-$ of $S$ carry the same number of type-$k$ vertices;
(Z2) for every grid $t$, $\sum_c \lambda(c) a(c, t) = 0$; Lemma 6: $\sum_c a(c, t)$ is the same for
every $t$ of a sublattice. Checked (below); not needed for the proof.

**B3.** Per-grid balance does not replace $K_u$: nothing replaces it, because the step is not needed.
Theorem 1 fed the uniform chain to $K_u$ to make a direction absent. Lemmas Z-3 and Z-4 make an axis
one-way from Theorem 15 across the three axes and the diagonal law, with no wall, chain or balance.

## Checks on states

All checks by exact integer arithmetic on saved states; a violation count of 0 means every instance
passed. Corpus: the 1,357 odd states of $(3,3,3)$ and $(4,4,4)$ (637 + 720; 1,001 with three types).

| check (h600, corpus) | instances | exceptions |
|---|---|---|
| Theorem 15 on each sublattice (exact fit of $P, Q, R$) | 2,714 | 0 |
| Theorem 4, one sign per line | 414,072 lines | 0 |
| Theorem 3, diagonally neighbouring lines agree | 905,094 pairs | 0 |
| Z-1: $h^S_k$ a function of one coordinate when $k$ is two-way on $S$; Theorem 6 plane structure | 3,537 | 0 |
| Z-2: common $n(k)$ on both sublattices for a globally two-way axis (cases I 1,723, II 91, III 0) | 1,814 | 0 |
| Z-2: every plane normal to $n(k)$ one-signed; adjacent non-empty planes agree | 17,800; 12,895 | 0 |
| Theorem 7: some plane normal to $n(k)$ is $k$-free | 1,814 | 0 |
| Z-3: the profile of $i(k)$ constant on $S$ | 3,537 | 0 |
| Z-4: every line of both sublattices non-empty $\Rightarrow$ one-way (all 499 such axes are one-way) | 499 | 0 |
| two-way axis with every line of both sublattices non-empty | 1,814 | 0 found |

The prediction on the normals. In a three-type state with one-way axis $c$ and two-way axes $a, b$,
Lemma Z-3 with Lemma Z-4 forbids $(n(a), n(b))$ from making $a$ or $b$ the constant axis, leaving
$(n(a), n(b)) = (b, a)$ or $(c, c)$. Computed: OTT 152 states, all $(n(y), n(z)) = (z, y)$; TOT 138,
all $(z, x)$; TTO 139, all $(y, x)$; the forbidden assignments never occur, and $(c, c)$ occurs only
in the two-type states (ETT 74, TET 101, TTE 75, where $c$ is the empty axis). The constant profiles
match: OTT states have exactly $P$ constant on both sublattices (152 of 152), TOT exactly $Q$, TTO
exactly $R$.

| other test sets | states | checks | exceptions |
|---|---|---|---|
| h601: oriented odd samples of $(2,2,4)$, $(2,4,6)$, $(4,3,3)$, $(4,4,6)$ (agent scomp's h447 saves; 0 charged) | 48 | Z-1 96, Z-2 50, Z-3 96, Z-4 3, Theorem 3 30,090, Theorem 15 96 | 0 |
| h603 kind O: odd, W = 0 (two types, four directions), $L = 3$ and 4, oriented | 11 | Z-1 44, Z-2 22, Z-3 44 | 0 |
| h603 kind E: even curl, W = 0, three types, $L = 3$ | 17 | six directions 17, even curl 17 | 0 |
| h603, both kinds: (Z1) $N_k^S = 0$ and (Z2) zero on every grid | 28 | 84 axes each | 0 |
| h603/h604: per-grid identity $M_k(t) = \Phi_k$ and Lemma 6 on the corpus (W ≠ 0) | 1,357 | 4,155 axes; 8,310 sublattice grids | 0 |
| h604: (Z1), (Z2), Lemma 6 in the wall language on the odd W = 0 states | 10 | 40; 240; 40 | 0 |

| h602, walls (corpus, three-type states) | instances | exceptions |
|---|---|---|
| non-empty planes normal to $n(k)$ one-signed; adjacent agree; a $k$-free plane exists | 17,800; 17,800; 1,814 | 0 |
| every empty plane is a Theorem 7 wall (no empty plane between two runs of the same sign) | 7,996 | 0 |
| Theorem 8: a chain of the slab beside a wall with a vertex of type $k$ is uniform | 8,566 chains | 0 |
| $m$ = number of uniform chains = $h(c_0 + s) = h(c_0 + 2s)$ | 6,892 wall sides | 0 |
| $a(c, t) = m$ on every grid, both planes beside the wall | 13,784 | 0 |
| family of the uniform chains by (side, sublattice of wall): $(+, A) \to -$, $(+, B) \to +$, $(-, A) \to +$, $(-, B) \to -$ | 8,566 chains | 0 |
| every full plane (not only beside a wall) has $a(c, t)$ the same on every grid | 17,800 planes | 0 |

In the 356 two-type states the plane beside a wall is sometimes entirely of type $k$ (1,514 wall
sides), and there 4,712 chains with a vertex of type $k$ are not uniform: Theorem 8's hypothesis of
three types (through Theorem $M'$) is necessary and was wrongly omitted in a first run of h602.

| solver (h605; CaDiCaL in an h32_cap child, cap 120 s) | $L = 3$ | $L = 4$ |
|---|---|---|
| Q1: even curl + three types on A | UNSAT 2.3 s | UNSAT 85.7 s |
| Q2: even curl + every hole oriented + three types on A and B + six directions | UNSAT 0.8 s | UNSAT 9.5 s |
| C1: even curl + six directions | SAT 0.2 s | SAT 0.2 s |
| C2: frozen + three types on A (odd allowed) | SAT 0.3 s | SAT 0.3 s |
| C3: even curl + oriented + types $y, z$ on A, both signs each | SAT 0.3 s | SAT 0.2 s |

Q1 and Q2 confirm Lemma Z-7 finitely; they are not steps of the proof.

## Where U enters

- Lemma Z-1: Theorem 4 (one sign per line: orientation of the holes of the line and of the diamonds
  of Theorem 3) and the separability of the signed count $s$ (Theorem 5, second statement: the total
  charge of every $k$-hole-line of $S'$ must vanish).
- Lemma Z-2: Theorem 3 at every odd separation and transverse offset $(\pm 1, \pm 1)$, in all three
  cases; case III also uses Theorem 7's second case, which is Theorems 3 and 5.
- Lemma Z-4: Theorem 3 only.
- Lemma Z-3, Theorem 15, Theorem $M'$: no orientation.
- Not used: Theorem 7's wall, Lemma 5, Theorem 8, Theorem 19.

**B4, the weakest form.** The argument needs, for each two-way axis $k$: (i) the line law, (ii) the
diagonal law for diagonally neighbouring $k$-lines, and (iii) total charge zero on every $k$-line of
holes. All three are consequences of U; (i) and (iii) follow from Lemma 3 summed along lines when the
holes there are oriented. No form of U strictly weaker than "every hole oriented" is obtained, because
the proof of Theorem 3 (Theorem 9) uses the orientation of every hole of the causal diamond, and the
note records that dropping any one hole's orientation equation makes the system feasible; corners
alone (Lemma 2, unconditional) do not suffice. What can be said is that the argument uses U only
through the conclusions of Theorems 3 and 4 and charge-neutral hole lines, for the two-way axes.

## What is left

- **Theorem U** is now the only open statement between the record and Theorem H on every cell (and
  the periodicity of frozen zero-flux states on every cubic cell). Nothing in this report touches it.
- **Verification.** The main loop should re-derive Lemma Z-2 cases II and III (the only places where
  Theorem 7's proof is reused) and Lemma Z-3, then a checker with its own programs should re-run the
  corpus checks. Suggested stop rule for the checker: if any of Z-1 to Z-4 fails on re-derivation,
  report the line and stop; if all pass, the note's Theorem 1 is to be restated as Corollary Z-6 with
  $K_u$ dropped from the reduction, and the certificates of $K_u$ moved to the record of certified
  facts rather than of steps.
- **Certificates.** Theorem $U'$ at sides 7 and 8 would now give Theorem H there (the $K_u$
  certificates at those sides are no longer the bottleneck). Not analytic; the note ranks it last.
- Not recommended: anything on the "Closed, do not re-run" list; kuwall's question on the first step
  of $K_u$ is no longer on the path to H, though its answer stays of independent interest.
- Two computed facts not used and not proved, recorded for the record: every full plane normal to
  $n(k)$ carries the same number of type-$k$ vertices on every grid (17,800 of 17,800), and no empty
  plane lies between two runs of the same sign (7,996 of 7,996).

## Scripts and timings

All from `experiments/08_frozen_structure/scratch_h`, project `.venv`, `PYTHONPATH` as prescribed,
`TMPDIR=.tmp`. New scripts only; none existing modified.

| script | what | wall |
|---|---|---|
| `h600_stripes.py` | Z-1 to Z-4, Theorems 3, 4, 6, 7, 15 on the odd corpus; normals and profiles tables | 6 s |
| `h601_othercells.py` | the same on the saved h447 samples of four non-cubic cells, oriented states only | 5 s |
| `h602_walls.py` | runs of planes, Theorem 7 walls, Theorem 8 chains and families, per-grid counts, Lemma 6 | about 60 s |
| `h603_zeroflux_states.py 3 40 120`, `4 30 150` | W = 0 states by solver (two batches per L, capped, killed at cap with finished queries kept), balance identities, Z-lemmas on the odd ones; saves `.tmp/h603_zf_L{3,4}.json` | 4 min; 5 min |
| `h604_evencurl_test.py 3 40 120` | even-curl samples (three batches, all SAT in under 1 s), Z-5 hypothesis table, balance in wall language | 5 s |
| `h605_even_sublattice.py 3`, `4` | Q1, Q2 with three controls | 4 s; 96 s |

Solver total under 12 minutes, one CaDiCaL process at a time, every batch in an `h32_cap` child with
a hard cap of 120 or 150 s, no job over 10 minutes, nothing on the Sparks.

## Rules kept or broken

Kept: compute from `scratch_h` with the prescribed interpreter, paths and `TMPDIR`; scripts numbered
`h600`–`h605`; no existing script modified; no commit, no git; solver only for generating test states
and two finite confirmations, each UNSAT with a SAT control, capped, one process at a time; status tags
on every claim; counts checked and exceptions given for every claim about states; report under 400
lines. No solver probe on the first step of $K_u$ (kuwall's task). Broken: none. One correction made
during the work: the first run of h602 omitted Theorem 8's hypothesis of three types and reported
4,712 false violations; the split by hypothesis is in the final script and the table above.
