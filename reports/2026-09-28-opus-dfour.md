---
title: "Package dfour: Theorem H proved by hand on every cell (2a', 2b', 2c') with a', b', c' pairwise coprime, thin members included, without K_u. In an odd frozen state with three types both sublattices carry the same one of six profile cases, (i)_k (the profile of coordinate k constant, the other two of spread 1) or (ii)_k (every k-line alternates), and axis k is one-way. The proof uses Theorem U on the family, Theorem M′, the profile description of twochain, the current description of the signed moments (Theorems 17 and 19 of the note) and Lemma 4. The case (i) and the equal case (ii) are settled by the signed line fractions, the mixed case (ii) by a parity argument on the E-data of the types. Theorem M′ is solver-UNSAT at extent 2 on (2,2,2), (2,2,6), (2,4,6), 18 of 18 with controls"
author: "Claude (Opus), agent dfour, for Lyndon Drake"
date: 2026-09-28
---

Status tags: **proved** (argument written out here in full), **computed** (exact, reproducible, no solver), **solver** (SAT verdict through `h32_cap`, a test and never a step of a proof), **conjecture**. New scripts `experiments/08_frozen_structure/scratch_h/h480_lib.py` to `h485_verify.py`. No existing file was modified; nothing was committed; all computation ran on this Mac.

## Status table

| # | statement | tag |
|---|---|---|
| 1 | **Theorem H on the family.** On every member (2a', 2b', 2c'), a', b', c' pairwise coprime, thin members included, every odd frozen state has an axis that is empty or one-way | **proved**, given the record: Theorem U on the family (twochain, check8), Theorem M′, Theorem P of twochain, Theorems 17 and 19 of the note, Lemma 4 of the note, (C). K_u, Theorem 1′, Theorems 3 to 9 and the walls are **not** used |
| 2 | **Statement S (the sharpened D4).** In an odd frozen state of a member in which all three types occur, both sublattices carry all three types and the same case label, (i)_k or (ii)_k (equivalently the same slack vector), and axis k is one-way, with one sign on A and B together | **proved** (it is what the proof of 1 establishes); **computed** on 388 unconstrained three-type states of six members and 109 constrained ones, 0 exceptions |
| 3 | L0 (classification): a sublattice with three types has one of six slack vectors, the cases (i)_x, (i)_y, (i)_z, (ii)_x, (ii)_y, (ii)_z | **proved** |
| 4 | L1: in an odd frozen state on a member every k-line of each sublattice has all its type-k vertices of one sign | **proved** given Theorem U and Theorem 17; **computed** 0 exceptions |
| 5 | L2: explicit formulas for the signed line fractions of B in terms of those of A (from Theorem 19) | **proved** from Theorem 19; **computed** exactly on 526 unconstrained + 171 constrained states, 0 exceptions; a deliberately wrong sign fails on 62 of 88 states of (2,4,6) |
| 6 | L3 (stripes): an axis two-way on one sublattice has its line fraction there depending on one transverse coordinate | **proved** (Lemma 4 of the note); **computed** 0 exceptions in 1,000 (state, sublattice, axis) cases |
| 7 | L4: the mean signed fraction of an axis is the same on A and on B; so an axis one-way on A and one-way on B is one-way | **proved** (from L2, or from the flux identity of the report of 22 September) |
| 8 | L5: case (i)_k on a sublattice makes axis k one-way there, and (i)_k on A forces (i)_k on B | **proved** |
| 9 | L6: case (ii)_k on both sublattices makes axis k one-way on each | **proved** |
| 10 | L7 (types only): no type-model solution on a member has every A z-line alternating, every B x-line alternating and a vertex of type y on A; so a mixed pair of cases (ii) is impossible | **proved**; **solver** UNSAT on five cells, controls SAT |
| 11 | Case equality holds already in the type model: 'every B z-line alternates, three types on A and on B, some A z-line does not' is UNSAT on (2,2,2), (2,2,6), (2,4,6) without signs and without oddness | **solver** (the proof above uses signs for the part with a case (i)); a type-only proof of that part is **open** |
| 12 | In case (ii)_k all three axes are one-way (twochain's D4 names the axes of the two constant profiles; only axis k is proved) | **computed** on 109 constrained + 3 unconstrained states, 0 exceptions; **conjecture** beyond that |
| 13 | In three-type states every two-way axis is two-way on each sublattice separately | **computed**, 309 of 309 two-way axes; not needed and not proved |
| 14 | Theorem M′ at extent 2: on (2,2,2), (2,2,6), (2,4,6), type model, 'odd, S has no type k, S′ has type k' UNSAT for all 3 axes × 2 sublattices; both controls (drop 'odd'; drop 'S has no type k') SAT in every case | **solver** (18 UNSAT, 36 SAT) |
| 15 | **Periodicity on the family.** Every frozen zero-flux state of a member is invariant under a nonzero translation | **proved** given 1, the flux identity, Lemma A and Theorem P of the curl-reduction note (record) |

## 0. Setting and notation

Member: $(a,b,c) = (2a',2b',2c')$ with $a',b',c'$ pairwise coprime, i.e. all three extents even and every pair with gcd exactly 2. Members include (2,2,2), (2,2,4), (2,2,6), (2,4,6), (2,6,10), (4,6,10), (6,10,14) and permutations. (2,2,4) **is** a member ($a'=b'=1$, $c'=2$; each pair of (2,2,4) has gcd 2): the task's remark was right to ask.

Everything below is in the notation of twochain's report (Theorem P) and of the note. On a sublattice $S$, the $k$-line fraction of type $k$ is $a_k$; Corollary P2 gives integer profiles with
$$2a_y = p(x) - r(z),\quad 2a_z = q(y) - p(x),\quad 2a_x = 2 + r(z) - q(y),$$
the chain inequality $\max r \le \min p$, $\max p\le\min q$, $\max q \le \min r + 2$, and the slack vector $s = (R, g_{rp}, P, g_{pq}, Q, g_{qr})$ = (spread $r$, $\min p - \max r$, spread $p$, $\min q - \max p$, spread $q$, $\min r + 2 - \max q$), six non-negative integers with sum 2. The $x$-lines of A are indexed by all pairs $(y,z)$ of even residues (mod $4b$, $4c$), those of B by all pairs of odd residues, and likewise for the other axes; so every line function is defined on a full product set.

Signs: $n_k(v) = \varepsilon(v)[\tau(v) = k]$. The **signed fraction** $\sigma_k^S(\ell)$ is the mean of $n_k$ over the $k$-line $\ell$ of $S$. Axis $k$ is one-way (two-way, empty) on $S$ when the type-$k$ vertices of $S$ have one sign (both, none). An axis one-way on A and on B may still be two-way.

Theorem 19 of the note (scomp, Theorem F): in a frozen state with every hole oriented there are six functions $F_{01}, F_{23}$ of $x$, $U_{02}, U_{13}$ of $y$, $W_{03}, W_{12}$ of $z$ with, on A,
$$\sigma_x = U_+(y) + W_+(z),\quad \sigma_y = F_+(x) + W_-(z),\quad \sigma_z = F_-(x) + U_-(y),$$
where $U_\pm = U_{02}\pm U_{13}$, $W_\pm = W_{03} \pm W_{12}$, $F_\pm = F_{01}\pm F_{23}$, and on B the same six functions at $x-1, x+1, y-1, y+1, z-1, z+1$ in the order named.

## 1. F1: the census, and the statement

Samples: odd frozen states (type model + (T2) + sign field + 'some hexagon odd', random assumption literals, **no condition on directions or types**), from twochain (h451), check8 (h471; states without a sign field are skipped: 1 on (2,2,2), 13 on (4,6,10)) and new samples (h482). States with an empty axis are included. Analysis `h485_verify.py`, exact.

| cell | odd states | with an empty axis | three types | labels A/B (three types) | three types: axis of the label one-way, same sign on A and B | three types: all three axes two-way |
|---|---|---|---|---|---|---|
| (2,2,2) | 78 | 15 | 63 | (i)x 21, (i)y 23, (i)z 17, (ii)y 1, (ii)z 1; all equal on A and B | 63/63 | 0 |
| (2,2,4) | 56 | 14 | 42 | (i)x 11, (i)y 16, (i)z 14, (ii)z 1; all equal | 42/42 | 0 |
| (2,2,6) | 145 | 34 | 111 | (i)x 37, (i)y 50, (i)z 24; all equal | 111/111 | 0 |
| (2,4,6) | 88 | 17 | 71 | (i)x 38, (i)y 13, (i)z 20; all equal | 71/71 | 0 |
| (2,6,10) | 118 | 28 | 90 | (i)x 60, (i)y 15, (i)z 15; all equal | 90/90 | 0 |
| (4,6,10) | 41 | 30 | 11 | (i)x 5, (i)y 2, (i)z 4; all equal | 11/11 | 0 |
| (2,2,2), (2,2,6), (2,4,6), constrained 'every A z-line alternates' | 171 | 62 | 109 | (ii)z on both, 109/109 | 109/109 (and all three axes one-way in all 109) | 0 |

Per axis pattern (overall, three-type states): every combination with at least one O occurs (OOO, OOT, OTO, TOO, OTT, TOT, TTO), and the O is always at the axis of the label in case (i). In every three-type state, a two-way axis is two-way on A and on B separately (309 of 309). No state has 'one-way on A, one-way on B, opposite signs' on any axis. Odd states with an empty axis have two types on each sublattice, the same two (M′), and sometimes different slack vectors on A and B.

**Statement S.** In an odd frozen state of a member in which all three types occur, both sublattices carry all three types, they carry the same label (i)_k or (ii)_k of Lemma L0 below, and axis $k$ is one-way (one sign on A and B together). This holds with no exception on 497 three-type states of six members (388 unconstrained, 109 constrained), it implies Theorem H, and it is proved in §2.

On twochain's two exceptional states (two constant profiles, 'pq' on (2,2,2) and (2,2,4) in its sample, and one 'pr'): these are exactly case (ii)_z and case (ii)_y. A statement of the form 'the axis of the constant profile is one-way' would there name axes $x$ and $y$ (or $z$ and $x$); Statement S names instead the axis whose lines all alternate. In the sample all three axes are one-way in every case-(ii) state, so both readings pass the data; only S is proved.

## 2. The proof

Throughout: a member $(a,b,c)$, an odd frozen state on it.

### 2.1 Reductions

If some axis is empty there is nothing to prove, so assume all three types occur. **Both sublattices carry all three types**: if $S$ had no vertex of type $k$ while $S'$ has one, Theorem M′ would give even curl. **Every hole is oriented**: Theorem U on the family (twochain §3, check8). So Theorems 17 to 19 of the note apply (Lemma 3 gives the three laws at every hole).

### 2.2 Lemma L0 (classification; proved)

*If $S$ carries all three types, its slack vector is one of*
$$\text{(i)}_x: (1,0,0,0,1,0),\ \ \text{(i)}_y: (1,0,1,0,0,0),\ \ \text{(i)}_z: (0,0,1,0,1,0),\ \ \text{(ii)}_x: (0,0,1,0,0,1),\ \ \text{(ii)}_y: (0,1,0,0,1,0),\ \ \text{(ii)}_z: (1,0,0,1,0,0).$$

*Proof.* Type $y$ occurs on $S$ iff $\max(p - r) > 0$, and $\max p - \min r = R + g_{rp} + P$. Likewise type $z$ iff $P + g_{pq} + Q \ge 1$, and type $x$ iff $\max(r + 2 - q) = R + g_{qr} + Q \ge 1$. So each of the three arcs $\{R, g_{rp}, P\}$, $\{P, g_{pq}, Q\}$, $\{Q, g_{qr}, R\}$ of the cycle of six slots carries a unit, with two units in all. A slot lies in two arcs if it is $R$, $P$ or $Q$, otherwise in one. Two units on one slot meet at most two arcs. So either the units are on two distinct slots among $R, P, Q$ (three vectors), or one is on a spread and the other on the only gap not in the two arcs of that spread ($P$ with $g_{qr}$, $Q$ with $g_{rp}$, $R$ with $g_{pq}$). $\square$

Read off with the shift $p = 0$ (other cases by the cyclic symmetry of the profile relations):

- **(i)_x**: $p$ constant; $r \in \{-1, 0\}$ and $q \in \{0, 1\}$, each taking both values. So $a_y = -r(z)/2 \in \{0,\tfrac12\}$ depends on $z$ only, $a_z = q(y)/2 \in \{0, \tfrac12\}$ on $y$ only, each takes both values, and $a_x = 1 - a_y(z) - a_z(y)$ depends on both $y$ and $z$.
- **(ii)_z**: $p, q$ constant with $q = p + 1$, $r \in \{p - 1, p\}$ taking both values. So $a_z \equiv \tfrac12$, and $a_y(z) = (p - r(z))/2$, $a_x(z) = \tfrac12 - a_y(z)$ depend on $z$ only, each taking both values 0 and $\tfrac12$. Write $Z_x$, $Z_y$ for the planes $z$ of $S$ with $a_x = \tfrac12$, resp. $a_y = \tfrac12$: a partition, both parts non-empty.
- (i)_k and (ii)_k in general: (i)_k means the profile of coordinate $k$ is constant and the other two have spread 1; (ii)_k means every $k$-line of $S$ alternates. The labels are invariant under the inversion $v\mapsto(1,1,1)-v$ (which exchanges A and B and replaces each profile $f(t)$ by $f(1-t)$) and are permuted with the axes by coordinate permutations.

### 2.3 Lemma L1 (one sign per line; proved given Theorem U and Theorem 17)

*Every $k$-line of either sublattice has all its vertices of type $k$ of one sign, and $n_k(v + 8e_k) = n_k(v)$.*

*Proof.* By Theorem 17, $n_x = G_{02} + G_{13} + G_{03} + G_{12}$, $G_f(v)$ the weight of the chain of family $f$ through $v$. The translation by $8e_x$ maps each chain of a family of axis $y$ or $z$ onto itself: the A vertices of a chain of $\{0,2\}$ are $v_0 + t(2,0,2)$, and $(8,0,0) \equiv t(2,0,2)$ modulo $(4a,4b,4c)$ needs $t \equiv 4 \pmod{2a}$, $t \equiv 0 \pmod{2c}$, which is solvable because $\gcd(2a,2c) = 4$; the same for $\{1,3\}$ and, with $\gcd(2a, 2b) = 4$, for $\{0,3\}, \{1,2\}$; the B vertices of a chain are its A vertices plus a fixed $d_i$. Hence $n_x(v + 8e_x) = n_x(v)$, and likewise for $y$, $z$. By P1 a $k$-line has $a_k \in \{0, \tfrac12, 1\}$. If $a_k = 1$, consecutive vertices $v$, $v + 4e_k$ are the two rods of the straight hole $v + 2e_k$, which is oriented, so they have one sign. If $a_k = \tfrac12$ the type-$k$ vertices of the line are $v + 8me_k$ for one $v$, all with the same $n_k$. (At extent 2 along $k$ a line has two vertices: a half line has one rod, a full line two rods joined by two straight holes; the argument is the same.) $\square$

So on each line $\sigma_k = \pm a_k$, and the direction fractions $\rho^k_\pm = (a_k \pm \sigma_k)/2 \ge 0$ satisfy $\rho^k_+\rho^k_- = 0$ line by line.

### 2.4 Lemma L2 (the signed fractions of B; proved from Theorem 19)

Substituting $U_{02} = (U_+ + U_-)/2$, $U_{13} = (U_+ - U_-)/2$ and so on into the B form of Theorem 19:
$$\begin{aligned}
\sigma_x^B(y,z) &= \tfrac12[U_+(y{-}1) + U_+(y{+}1)] + \tfrac12[U_-(y{-}1) - U_-(y{+}1)] + \tfrac12[W_+(z{-}1) + W_+(z{+}1)] + \tfrac12[W_-(z{-}1) - W_-(z{+}1)],\\
\sigma_y^B(x,z) &= \tfrac12[F_+(x{-}1) + F_+(x{+}1)] + \tfrac12[F_-(x{-}1) - F_-(x{+}1)] + \tfrac12[W_+(z{-}1) - W_+(z{+}1)] + \tfrac12[W_-(z{-}1) + W_-(z{+}1)],\\
\sigma_z^B(x,y) &= \tfrac12[F_+(x{-}1) - F_+(x{+}1)] + \tfrac12[F_-(x{-}1) + F_-(x{+}1)] + \tfrac12[U_+(y{-}1) - U_+(y{+}1)] + \tfrac12[U_-(y{-}1) + U_-(y{+}1)].
\end{aligned}\qquad(\mathrm{B})$$
The A fractions determine each pair $(U_+, W_+)$, $(F_+, W_-)$, $(F_-, U_-)$ up to adding a constant to one member and subtracting it from the other, and each right side of (B) is unchanged by such a change (checked term by term). So **the signed fractions of B are determined by those of A**, by (B). **Computed**: (B) holds exactly on every one of the 697 states of §1 (the A functions read off with a gauge, `h485`); with the sign of the $U_-$ term reversed it fails on 62 of 88 states of (2,4,6).

A remark used repeatedly: if $a^S_k$ depends on one transverse coordinate only and vanishes on some plane $c_0$ of that coordinate, then $\sigma_k^S = 0$ on that plane (L1), so the part of the separable function $\sigma_k^S$ in the other coordinate is constant. And if a periodic function $f$ on the even (or odd) residues satisfies $f(t-1) - f(t+1) = \kappa$ for all $t$, summing round the circle gives $\kappa = 0$, so $f$ is constant.

### 2.5 Lemma L3 (stripes; proved)

*If axis $k$ is two-way on $S$, then $a^S_k$ depends on one transverse coordinate only.*

*Proof.* $\rho_\pm = (a_k \pm \sigma_k)/2$ are non-negative functions on the product set of $k$-lines of $S$, separable ($a_k$ by P2, $\sigma_k$ by Theorem 19), with product zero (L1) and neither identically zero. Lemma 4 of the note: both depend on the same single coordinate. So does $a_k = \rho_+ + \rho_-$. $\square$

### 2.6 Lemma L4 (the sign of an axis is shared; proved)

*The mean of $\sigma_k$ over the $k$-lines of A equals its mean over those of B. So if axis $k$ has vertices on A and on B and is one-way on each, it is one-way.*

*Proof.* The $x$-lines of A are all pairs of even $(y,z)$, those of B all pairs of odd; the mean of $U_{02}(y-1) + U_{13}(y+1)$ over odd $y$ is the mean of $U_+$ over even $y$, and so on (Theorem 19). If $k$ were $+$ on A and $-$ on B the two means would be positive and negative. (Equivalently: the flux identity of the report of 22 September, $M_k(t)$ the same on every plane of both sublattices.) $\square$

### 2.7 Lemma L5 (case (i); proved)

*(a) If $S$ is in case (i)_k, axis $k$ is one-way on $S$. (b) If A is in case (i)_k and B carries three types, B is in case (i)_k.*

By a coordinate permutation (which maps a member to a member and preserves A, B, bonds, types, signs up to relabelling, oddness), take $k = x$.

*(a)* In (i)_x, $a_x = 1 - a_y(z) - a_z(y)$ with $a_y$ non-constant in $z$ and $a_z$ non-constant in $y$, so it depends on both. By L3 axis $x$ is not two-way on $S$; it occurs on $S$, so it is one-way there. $\square$

*(b)* Let $x$ have sign $s$ on A (by (a)), so $\sigma_x^A = s\,a_x^A = s(1 - a^A_y(z) - a^A_z(y))$ and, after a gauge, $U_+(y) = -s\,a_z^A(y) + c_1$.

*$F_+$ and $F_-$ are constant.* $a_y^A$ vanishes on some plane $z_1$, so $\sigma_y^A(x, z_1) = F_+(x) + W_-(z_1) = 0$ for all $x$. $a_z^A$ vanishes on some plane $y_1$, so $F_-$ is constant. Put $F_\pm \equiv f_\pm$. Then $\sigma_z^A(x,y) = f_- + U_-(y) =: \tau(y)$ depends on $y$ only, with $|\tau| = a^A_z(y) \in \{0, \tfrac12\}$; put $\rho_\pm(y) = (a^A_z(y) \pm \tau(y))/2 \in \{0,\tfrac12\}$, $\rho_+\rho_- = 0$.

*$p_B$ is constant.* With $F_\pm$ constant, the $x$-parts of $\sigma_y^B$ and $\sigma_z^B$ in (B) are constant, so $\sigma^B_y$ depends on $z$ only and $\sigma_z^B$ on $y$ only; by L1 so do $a^B_y = |\sigma^B_y| = (p_B(x) - r_B(z))/2$ and $a^B_z = (q_B(y) - p_B(x))/2$. Hence $p_B$ is constant. By L0 the cases with $p$ constant are (i)_x, (ii)_z and (ii)_y.

*B is not (ii)_z.* There $a^B_z \equiv \tfrac12$, so $|\sigma^B_z| = \tfrac12$ everywhere; and $a^B_x$ depends on $z$ only and vanishes on some plane, so the $y$-part of $\sigma_x^B$ is constant. Substituting $U_+ = -s(\rho_+ + \rho_-) + c_1$ and $U_- = \rho_+ - \rho_- - f_-$ into (B):

- $s = +1$: $y$-part of $\sigma^B_x$ $= c_1 - \rho_-(y-1) - \rho_+(y+1)$, and $\sigma^B_z = \rho_+(y+1) - \rho_-(y-1)$;
- $s = -1$: $y$-part $= c_1 + \rho_+(y-1) + \rho_-(y+1)$, and $\sigma_z^B = \rho_+(y-1) - \rho_-(y+1)$.

Take $s = +1$. For every odd $y$, $\rho_-(y-1) + \rho_+(y+1)$ is a constant $K$ and $|\rho_+(y+1) - \rho_-(y-1)| = \tfrac12$. The values lie in $\{0, \tfrac12\}$, so exactly one of the two is $\tfrac12$, for every odd $y$. Let $y_0$ be an even plane with $a^A_z(y_0) = 0$ (it exists in (i)_x). At $y = y_0 + 1$: $\rho_-(y_0) = 0$, so $\rho_+(y_0 + 2) = \tfrac12$. If $\rho_+(y_0 + 2m) = \tfrac12$ then $\rho_-(y_0 + 2m) = 0$ and, at $y = y_0 + 2m + 1$, $\rho_+(y_0 + 2m + 2) = \tfrac12$. After $2b$ steps, $y_0 + 4b \equiv y_0$ and $\rho_+(y_0) = \tfrac12$, against $a^A_z(y_0) = 0$. For $s = -1$ the same induction runs on $\rho_-(y_0 + 2m)$.

*B is not (ii)_y.* The same argument with $y$ and $z$ exchanged: $|\sigma^B_y| = \tfrac12$; $a_x^B$ depends on $y$ only and vanishes somewhere, so the $z$-part of $\sigma^B_x$ is constant; $W_+(z) = -s\,a^A_y(z) + c_2$, $\sigma^A_y(x,z) = f_+ + W_-(z)$ with modulus $a_y^A(z)$; the two expressions in (B) have exactly the shape above with $W$ for $U$, and $a^A_y$ vanishes on some plane $z_0$. $\square$

### 2.8 Lemma L6 (equal cases (ii); proved)

*If A and B are both in case (ii)_k, axis $k$ is one-way on A and on B.*

*Proof.* Take $k = z$. On A, $a^A_y(z)$ and $a^A_x(z)$ each vanish on some plane, so (remark in §2.4) $F_+ \equiv f_+$ and $U_+ \equiv u_+$. On B, $a_y^B$ and $a_x^B$ depend on $z$ only and each vanishes on some plane, so the $x$-part of $\sigma^B_y$, which is $f_+ + \tfrac12[F_-(x-1) - F_-(x+1)]$, is constant, and the $y$-part of $\sigma^B_x$, which is $u_+ + \tfrac12[U_-(y-1) - U_-(y+1)]$, is constant. By the circle remark $F_-$ and $U_-$ are constant. So $\sigma^A_z = F_- + U_-$ is constant, of modulus $a^A_z = \tfrac12$: axis $z$ is one-way on A. The inversion exchanges A and B, preserves the labels, oddness, frozenness, and carries signs along ($n'(v') = n(v)$ satisfies the bond rule, since the bond $(a, a+d)$ goes to the bond $((1,1,1)-a-d,\ (1,1,1)-a)$ of the same direction), so $z$ is one-way on B too. $\square$

### 2.9 Lemma L7 (mixed cases (ii); proved, types only)

*On a member, no solution of the type model has $a^A_z \equiv \tfrac12$ on every $z$-line of A, $a^B_x \equiv \tfrac12$ on every $x$-line of B, and a vertex of type $y$ on A.* Consequently, if both sublattices carry three types and are in cases (ii)_k and (ii)_{k'}, then $k = k'$: the coordinate permutations act simply transitively on ordered pairs of distinct labels, and they map the pair to $(z, x)$ on another member, where A (ii)_z has a vertex of type $y$.

*Setting.* Theorem P: at a vertex of $S$ in class $(\xi,\eta,\zeta)$, $X = a_x + \pi(E_z - E_y)$, $Y = a_y + \pi(E_x - E_z)$, $Z = a_z + \pi(E_y - E_x)$ with $E_x = E^S_x(x,\zeta)$, $E_y = E^S_y(y,\xi)$, $E_z = E^S_z(z,\eta)$. Parity rule: $|E_z - E_y| = \tfrac12[a_x = \tfrac12]$ and cyclically. Coupling: $E^B_k(n',\sigma) = \tfrac12(\sigma D^A_k(n'-1) - S^A_k(n'+1))$. Each value $E^A_k(n,\sigma)$ belongs to exactly one A class $c \in \{c_0,c_1,c_2,c_3\} = \{(+++), (+--), (-+-), (--+)\}$; write $e^c_x(x)$, $e^c_y(y)$, $e^c_z(z)$ for the values of class $c$, defined on the planes $X_c$, $Y_c$, $Z_c$ of the right residue mod 4; every triple in $X_c\times Y_c\times Z_c$ is a vertex of class $c$ (the residues add to $0 \bmod 4$ because the class has an even number of minus signs). Put $b^c_x(y,z) = e^c_z(z) - e^c_y(y)$.

*The table (computed, symbolic, `h484_classes.py`).* Expanding $2(E^B_z - E^B_y)$ at a B vertex of class $c'_j$ (the B class with the same sign triple as $c_j$) by the coupling and grouping the eight A values by class, each group is $\pm b^c_x$ at planes $y_c \in \{y'-1, y'+1\}$, $z_c \in \{z'-1, z'+1\}$, namely the plane of the residue that class $c$ uses. For the two B classes with $\eta' = +$:
$$\begin{aligned}
c'_0 = (+,+,+):\ & 2b^B_x = +b^{c_0}_x(y'{-}1, z'{-}1) - b^{c_1}_x(y'{+}1, z'{+}1) - b^{c_2}_x(y'{-}1, z'{+}1) - b^{c_3}_x(y'{+}1, z'{-}1),\\
c'_2 = (-,+,-):\ & 2b^B_x = -b^{c_0}_x(y'{-}1, z'{+}1) - b^{c_1}_x(y'{+}1, z'{-}1) + b^{c_2}_x(y'{-}1, z'{-}1) - b^{c_3}_x(y'{+}1, z'{+}1).
\end{aligned}$$
In both rows class $c$ uses the same $y$-plane, and the relative sign of the two terms of $\{c_0, c_3\}$ (and of $\{c_1, c_2\}$) is opposite in the two rows. (The script prints all four B classes and all three pairs of axes; every group has the form claimed.)

*Facts from the hypotheses.* On A, $a_z \equiv \tfrac12$, so (L0 reading) $a_x$, $a_y$ depend on $z$ only, and the even planes split into $Z_x$ ($a_x = \tfrac12$) and $Z_y$ ($a_y = \tfrac12$); type $y$ on A means $Z_y \neq \emptyset$. Parity on A: $|b^c_x(y,z)| = \tfrac12[z\in Z_x]$; and for $z \in Z_x\cap Z_c$, $|E_x - E_z| = \tfrac12[a_y = \tfrac12] = 0$ at every vertex of the plane, so $e^c_x(x) = e^c_z(z)$ for all $x \in X_c$: $e^c_x$ is constant and $e^c_z$ takes that same value on every plane of $Z_x\cap Z_c$. Hence **$b^c_x(y, z)$ is the same for all $z \in Z_x \cap Z_c$**. On B, $a_x \equiv \tfrac12$, so $|b^B_x| = \tfrac12$ at every B vertex.

*(★) No two adjacent planes of $Z_y$.* If $z_0, z_0 + 2 \in Z_y$, at any B vertex with $z' = z_0 + 1$ every term of the table vanishes, so $b^B_x = 0$: contradiction.

*Conclusion.* Take $z_0 \in Z_y$; by (★), $z_0 \pm 2 \in Z_x$. These two planes have the same residue mod 4; let $\{c, \tilde c\}$ be the two A classes using that residue for $E_z$ ($\{c_0, c_3\}$ or $\{c_1, c_2\}$). Fix $y' \equiv 1 \pmod 4$. The B planes $z_0 - 1$ and $z_0 + 1$ have opposite $\zeta'$, so one carries vertices of class $c'_0$ and the other of class $c'_2$, both with this $y'$. At each, only the terms of $c$, $\tilde c$ survive (their $z$-plane is $z_0 \mp 2 \in Z_x$, the other two classes sit on $z_0 \in Z_y$), and by the fact above these terms are the same numbers $t = b^{c}_x(y_c, \cdot)$, $\tilde t = b^{\tilde c}_x(y_{\tilde c}, \cdot)$ at both vertices, each $\pm\tfrac12$. The two rows give $|t - \tilde t| = 1$ and $|t + \tilde t| = 1$ (up to overall signs), which no $t, \tilde t \in \{\pm\tfrac12\}$ satisfy. $\square$

**Solver test (not a step).** 'every A $z$-line alternates, every B $x$-line alternates, A has type $y$' is UNSAT on (2,2,2), (2,2,6), (2,4,6), (4,2,6), (6,4,2); the same without 'A has type $y$', and with 'A has type $x$' instead, are SAT on all five (`h483`).

### 2.10 Theorem H on the family (proved, given the record)

*On every member, every odd frozen state has an axis that is empty or one-way. More precisely Statement S of §1 holds.*

*Proof.* By §2.1 assume both sublattices carry three types and every hole is oriented. By L0 each sublattice has a label.
If A is in case (i)_k, then B is in case (i)_k (L5b), axis $k$ is one-way on A and on B (L5a), and by L4 it is one-way. If B is in case (i)_k, the inversion reduces to the previous sentence.
Otherwise both are in case (ii); by L7 with the same $k$; by L6 axis $k$ is one-way on A and on B, and by L4 it is one-way. $\square$

**Which members.** Every member, thin or not: the argument uses only that all three extents are even with pairwise gcd 2 (two chains of each family per pair of planes, for L1 and for Theorem P), plus the record's results on the family. No extent bound enters: the circles of planes in L5 and L6 have length $2b$ or $2a \ge 2$, and in L7 the planes $z_0 \pm 2$ may coincide (extent 2 along $z$, 8 planes) without harm.

**Dependencies, named.** Theorem U on the family (twochain Theorem V, with (C), (S1), Lemma 2, the cage enumeration of Lemma 3, Theorem M′; confirmed by check8); Theorem M′ (check6's proof; tested at extent 2 in §3); Theorem P and Corollaries P1 to P3 of twochain, with the coupling (confirmed by check8); Theorems 17 and 19 of the note (scomp; the note records that this section **has not been read by an independent checker**, and this proof depends on it through L1, L2, L3, L4); Lemma 4 of the note. Not used: $K_u$, Theorem 1′, Lemma 1, Theorems 3 to 9, Lemma 5, Lemma 6, the walls, any certificate beyond those inside Theorem U and M′.

### 2.11 F4: periodicity on the family (proved, given the record)

*Every frozen zero-flux state of a member is invariant under a nonzero translation.* If it has even curl, Theorem P of the curl-reduction note (recorded as proved for every cell) gives a one-cube period. If it is odd, Theorem H above gives an empty or one-way axis. A one-way axis $k$ with a vertex has, by the flux identity (report of 22 September, Theorem (v)), $\Phi_k = M_k(t) \neq 0$ on a plane $t$ containing type $k$, which is excluded in zero flux. So an axis is empty, and Lemma A gives invariance under $\Lambda_x$ (or $\Lambda_y$, $\Lambda_z$), which contains the nonzero translation $(0, 2c, 2c)$ (take $t = c$: $c(0,2,2) - c(0,2,-2) = (0,0,4c) \equiv 0$, so $c(0,2,2) \in \Lambda_x$, and $2c \not\equiv 0 \bmod 4c$). Dependencies: this Theorem H, the flux identity, Lemma A, Theorem P (curl note); none re-derived here.

## 3. F3: the thin members

**Theorem M′ at extent 2 (solver, type model, `h483`).** For each of (2,2,2), (2,2,6), (2,4,6), each axis $k$ and each sublattice $S$: '(T2), $S$ has no vertex of type $k$, $S'$ has one, some hexagon odd' is **UNSAT** (18 of 18, at most 1.8 s each). Controls, both **SAT** in all 18 cases: the same without 'odd', and '(T2), odd, $S$ and $S'$ both have type $k$'. So M′ holds on these cells in the type model (which has no signs and is weaker than the ice rule, so this is stronger than M′ needs).

**Reading of the note's results used on a thin member.** The proof above uses from the note Lemma 3 (through Theorem U and Theorem 17), Lemma 4, Theorem M′, Theorems 17 and 19. Lemma 1, Theorems 3 to 8 are not used, so I did not read them for extent 2.

- Lemma 3 (and Lemma 2): statements about one cage (one hexagon). At extent 2 along $k$ the methylenes $O \pm 2e_k$ are distinct (they differ by 4 modulo 8), so the cage embeds; in any case the identity holds on the lattice and a torus state lifts to a periodic lattice state, so it holds at every extent.
- Lemma 4: no geometry.
- Theorem 17: its proof is character by character and uses no size condition; scomp checked the dimension formula exactly on (2,2,2), (2,2,4), (2,4,6), and every sampled odd state of the thin members here satisfies the consequences L1, L2 exactly.
- Theorem 19: averaging along a line of length 2 visits each of the two chains of a family in the pair of planes once (the step $4$ in $y$ changes $y - z$ by 4, exchanging the classes mod 8), so the argument holds.
- L1 at extent 2 along $k$: the period 8 is then trivial, and the argument given in §2.3 for lines of two vertices applies.
- Theorem P of twochain on thin members: check8's item (b) confirms it (planes $\equiv 2 \bmod 4$ exist along every axis, A-planes 0, 4 and 2, 6 are distinct).

Nothing found fails at extent 2.

## 4. Computations

From `scratch_h`, `.venv/bin/python`, `PYTHONPATH=<repo>:<repo>/experiments/08_frozen_structure`, `TMPDIR=<repo>/.tmp`. Every SAT query through `h32_cap.run_batch`, cap ≤ 280 s per batch. Scripts: `h480_lib.py` (profiles, slack, signs, patterns), `h481_census.py` (first census), `h482_sample.py` (odd sampling; optional type constraint 'every k-line of S alternates'), `h483_query.py` (tests of candidate lemmas), `h484_classes.py` (symbolic table of L7), `h485_verify.py` (exact checks of U, L1, L2, L3, L4, M′, S2, S3 and the census).

| command | what it tested | verdict | wall |
|---|---|---|---|
| `h481_census.py C` for (2,2,2), (2,2,4), (2,4,6), (4,6,10) | first census on saved states | twochain's D4 pattern; A and B same slack in all three-type states | ≤ 1.3 s each |
| `h482_sample.py 2,2,2 halfAz 5 60 1`, `2,4,6 …` | pre-flight, constrained sampling | 4 and 4 states | 0.2 s solver each |
| `h482_sample.py C halfAz 80 120 2`, C = (2,2,2), (2,4,6), (2,2,6) | case-(ii)_z states (a condition on types only) | 50, 64, 54 distinct | 0.9, 1.1, 0.6 s |
| `h483_query.py 2,2,2 60 …` (5 specs) | first test of the mixed case | halfAz+halfBz+three SAT; halfAz+halfBx+three UNSAT (with and without sign field and odd); halfAz+halfBx SAT | 0.1–0.3 s each |
| `h483_query.py C 120 …` (8 specs), C = (2,2,2), (2,2,4), (2,4,6) | all mixed pairs, equal pairs as controls | 4 mixed UNSAT, 2 equal SAT, one-sided 'three' UNSAT, on each cell | ≤ 0.4 s each |
| `h483_query.py C 120 T+halfAz+halfBx+hasAy / +hasAx / (none)`, five cells incl. (4,2,6), (6,4,2) | L7 as stated, with controls | UNSAT / SAT / SAT on all five | ≤ 0.3 s each |
| `h484_classes.py` | the class table of L7, all 4 B classes × 3 pairs | every group $\pm(e_i - e_j)$: True | < 1 s |
| `h482_sample.py 2,6,10 odd 3 120 1`, `2,2,6 odd 3 60 1` | pre-flight | 4, 3 states | 1.6, 0.2 s |
| `h482_sample.py 2,2,6 odd 150 200 2` | unconstrained odd states | 143 distinct | 2.2 s |
| `h482_sample.py 2,6,10 odd 120 280 2` | unconstrained odd states | 115 distinct (118 SAT, 3 UNSAT under random assumptions) | 176.8 s |
| `h485_verify.py C` for six cells; `--neg` on (2,4,6) | exact checks and census (§1) | 0 failures on 526 states; negative control fails 62/88 | ≤ 2 s each |
| `h485_verify.py C --cons=halfAz`, three cells | the same on 171 constrained states | 0 failures; 109 three-type states, all (ii)z/(ii)z, all OOO | ≤ 1 s each |
| `h483_query.py C 120 T+halfBz+threeA+threeB(+sign+odd)+nothalfAz` and controls, C = (2,2,2), (2,2,6), (2,4,6) | case equality at type level (item 11) | UNSAT with and without signs and odd; controls 'without nothalfAz' and 'nothalfAz+three' SAT | ≤ 0.7 s each |
| `h483_query.py C 120 …` M′ block, C = (2,2,2), (2,2,6), (2,4,6) | F3: M′, 3 axes × 2 sublattices, two controls each | 18 UNSAT, 36 SAT | ≤ 1.8 s each |
| `h482_sample.py 4,6,10 odd 3 120 1` | pre-flight | 4 states | 4.1 s |
| `h482_sample.py 4,6,10 odd 100 280 2` | unconstrained odd states | 25 SAT, **76 no verdict** (batch cap hit at 280 s) | 280 s |

## 5. What failed, and why

1. **Line fractions alone do not exclude the mixed case (ii).** My first attempt at A (ii)_z with B (ii)_x used only the signed fractions (B). It forces $U_-$ constant and $D \equiv 0$ and the sign of $x$ on A to be constant along runs, but it leaves a consistent-looking configuration in which $Z_x$, $Z_y$ alternate and all three axes are two-way at the level of line averages. The contradiction comes from the types (L7), found after the solver showed that the mixed case is UNSAT already in the type model. In that first attempt I also wrote that the runs of $Z_y$ must have even length; the correct consequence of the sign relations is only that $|Z_y|$ is even. Neither statement is used.
2. **A type-only proof of case equality is not in hand.** The solver says that the case of B forces the case of A already in the type model (item 11); my proof of the part involving a case (i) uses the signs (L5b). A type-only proof would remove Theorems 17 and 19 from that step, but not from L1, L3, L4.
3. **D4 in its literal form is not proved in case (ii).** There twochain's statement names the axes of the two constant profiles; S names the alternating axis. All three are one-way in every sampled case-(ii) state, but I have no argument for the other two.
4. **Sampling on (4,6,10) is slow**: after a pre-flight of 4 queries in 4 s, the batch of 101 queries hit its 280 s cap with 76 unanswered (no verdict), leaving 41 states with a sign field on that cell, 11 with three types. The (2,6,10) batch took 177 s against about 60 s projected from its pre-flight. Neither was near ten minutes.

## 6. Rules

- **Broken once: `python -` with empty stdin.** One Bash call ran `.venv/bin/python -` with nothing on stdin (a slip while editing); it did nothing and read no input.
- One solver process at a time: the two background sampling batches ran alone; only the non-solver analysis `h485_verify.py` on (2,2,2) ran while the (2,2,6)/(2,6,10) batch was in the background.
- Pre-flight: done for every sampling batch (see §5.4 for two underestimates); no command exceeded ten minutes.
- No heredocs; nothing written to /tmp (states, logs in `<repo>/.tmp`; the harness's own background-task logs went to its directory). No existing file was modified; I edited only my own new scripts. Git not touched. Scripts and report of agent cubethree (h500–h529) not read or run.
- Theorem H, 'odd and all six directions', or anything equivalent was **not** run. The sampling selectors are 'some hexagon odd', plus, for the constrained samples, a condition on types only ('every z-line of A alternates'). The lemma tests (L7, case equality, M′) contain no condition on signs or directions.
