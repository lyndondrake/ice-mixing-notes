---
title: "Attack proposal of 28 September: Theorem H is proved by hand on every cell in which two of the three extents are coprime, by a lemma on the types of one sublattice; what is left is the cells in which every two extents share a factor, where odd states with all three types exist and the signs are needed; a proposal for that case"
author: "Claude (Fable 5.1), main loop, for Lyndon Drake"
date: 2026-09-28
---

Status tags as in the note: **proved** (argument written out here), **computed** (exact, no solver), **solver** (SAT verdict through `h32_cap`), **conjecture**. New scripts `scratch_h/h420_family.py` to `h423_signed_modes.py`. All compute on the primary Mac, one process at a time. The longest solve was 40 s, and three queries stopped at their cap of 100 or 120 s without a verdict. Lyndon asked for the best way to attack the overall problem analytically, from the docs. While reading for that I found a proof, which changes what the proposal has to cover. It has had no independent check yet. An Opus checker is to be dispatched on it before anything else is built on it.

## Corrections after the independent check (added the same day)

Agent check7 (Opus; `2026-09-28-opus-check7.md`, scripts `h430`–`h432`, its own implementation and none of the scripts below) read the proofs for a gap and found none. It confirmed the sheet lemma, Lemma T′, the failure of Lemma T, Lemma J, Theorem S, Theorem S2, the repair of Theorem R1 and the law of line fractions as written, and Corollary H with one correction. The main loop read its scripts, checked that its symmetry reduction is sound, and re-ran `h430_geom.py`, `h431_sl.py 4,3,3 pair` and one sampling run of `h432_sample.py`, with the same verdicts. The text below is left as written. Read it with these.

1. **'No certificate' is wrong (Summary, item 2).** Corollary H uses Theorem $M'$, and the proof of Theorem $M'$ rests on finite lemmas on four hexagons that carry DRAT certificates. They are window lemmas and hold on every torus, so they do not limit the scope, but the corollary is not free of certificates. The second proof, through Theorem S2, is free of Theorem $M'$ and of certificates, and it needs $\gcd(a, b) = \gcd(a, c) = 1$.
2. **Where the hypothesis enters.** The two lines of Case 2 meet whenever $\gcd(a, b, c) = 1$ (enumerated on twelve cells: no pair fails to meet on (4,3,3), (5,3,3), (3,4,4), and pairs fail on every cell with $\gcd(a, b, c) > 1$ tried). The last step of Lemma J needs the same and no more. So $\gcd(b, c) = 1$ is used only through (S1), and on the cells that are left it is (S1) that fails.
3. **Smaller counterexamples to Lemma T.** On $\mathbb{Z}_2 \times \mathbb{Z}_2$ every function with values 0 and 1 has the form of the lemma. The patterns that are not functions of one of $i$, $j$, $i + j$ number 8, 36 and 96 on the square tori of side 2, 3 and 4.
4. **More cells decided.** With a reduction by the translations and the half-turns to nine cases, 'A has all three types' is UNSAT on (5,4,4) (in the plain form, 198 s), (6,2,9) and (7,3,6), which the table below has as no verdict or does not have. (10,4,5) gave no verdict. On 258 sampled solutions of seven cells with a coprime pair the case of Theorem S, the planes of case (i), the lines of Case 2 and the forms of Theorem S2 had no exception, and the jumps of $\Phi_S$ were integers in 920 of 920 cases.
5. **Thin cells** (caveat 4 below) cause no trouble in any step the checker read, and the law of line fractions holds exactly on 495 sampled solutions of ten cells that are not cubic, three of them with no coprime pair.

Not checked by check7: completeness, Theorem $M'$, Lemma A and Theorem P, which are from the record; the corpus statistics; package B.

## Summary

1. **Theorem S (proved here).** On a cell in which two of the three extents are coprime, no sublattice of a frozen state carries all three types. The statement is about the type model alone, with no signs and no oddness.
2. **Theorem H follows on every such cell (proved here, given Theorem $M'$).** An odd state has a corner, the sublattice of the corner has the two types of its rods and so lacks the third, and Theorem $M'$ makes the other sublattice lack it too. So every odd state of such a cell has an empty axis. This needs no $K_u$, no Theorem U, no Theorem R1 and no certificate. On the cells $(L, L, L+1)$ it holds for every $L$.
3. **One lemma of the record is false as stated.** Lemma T of 18 September (a function $\alpha(i) + \beta(j) + \gamma(i+j)$ with values 0 and 1 on a torus depends on one of $i$, $j$, $i+j$) fails on the torus $\mathbb{Z}_3 \times \mathbb{Z}_3$. It holds when the jumps of $\gamma$ are integers, and in the two places where the project uses it they are, by an argument given below. Theorem R1 stands, with that repair to its proof.
4. **What is left** is the cells in which every two extents have a common factor. The cubic cells are among them. There Theorem S is false, and odd states with all three types exist on every such cell tried, down to $(2,2,2)$. In the corpus of 1,357 odd states of the cubic cells of side three and four, 1,001 have all three types on both sublattices, and every one of these has a one-way axis that is not empty. So on these cells no statement about types alone proves H, and the proof has to reach the signs.
5. **The proposal** for that case is in the last section but one. Its first step is a fact computed here on the cubic cells of side three and four: the solutions of one cage law $P^k$ are exactly the sums over chains of the two other axes, so in a state with every hole oriented the six direction indicators have the same linear form as the three type indicators. The method that proved Theorem S can then be applied to directions.

## Where the problem stood

From the handover of 27 September. The periodicity conjecture follows from Theorem H, Theorem P and Lemma A, and the last two are proved. Theorem H followed from $K_u$ and Theorem U (Theorem 1 of the note, valid on every cell). On a cubic cell both had an open statement: (V) for Theorem U, and the first step of $K_u$ on the whole slab. Each was certified on small cubic cells and each has a reach that grows with the greatest common divisor of the two extents transverse to an axis. H was proved with no open statement on cells whose extents are pairwise coprime (no odd state, Theorem R1), and, given the certificates of $K_u$, on cells with one pair of extents of greatest common divisor two and the other pairs coprime.

## Theorem S and Theorem H on cells with a coprime pair

### Statements

Cell $(a, b, c)$, coordinates modulo $(4a, 4b, 4c)$. $X$, $Y$, $Z$ are the indicators of the types $x$, $y$, $z$. A solution of the type model is an assignment of types satisfying (T2) on every hexagon. A frozen state gives one.

**Theorem S.** Let $\gcd(b, c) = 1$. In every solution of the type model, each sublattice $S$ satisfies one of the following.

(i) $S$ has no vertex of type $x$, and every plane $x = $ const of $S$ is entirely of type $y$ or entirely of type $z$.

(ii) $S$ has no vertex of type $y$.

(iii) $S$ has no vertex of type $z$.

By the permutations of the axes the same holds, with the axes renamed, whenever some pair of extents is coprime.

**Theorem S2.** Let $\gcd(a, b) = \gcd(a, c) = 1$. Then each sublattice $S$ has one of three forms.

($P_z$) $S$ has types $x$ and $y$ only, and the vertices of type $x$ are the vertices of $S$ on a set of planes $z = $ const.

($P_y$) $S$ has types $x$ and $z$ only, and the vertices of type $x$ are those on a set of planes $y = $ const.

($Q$) $S$ has no vertex of type $x$, and on each plane $x = $ const of $S$ the type is constant along the chains of axis $x$ of one of the two families.

**Corollary H.** On a cell with a coprime pair of extents every odd frozen state lacks one of the three types. So Theorem H holds on the cell, and with Lemma A and Theorem P every frozen zero-flux state of the cell is invariant under a nonzero translation. When $\gcd(a, b) = \gcd(a, c) = 1$ the type that is absent is $x$.

The last sentence is statement (F) of the handover, which had no proof, for every value of $\gcd(b, c)$.

### Ingredients

(C) Completeness (report of 17 September, confirmed for every cell by check4). Every real solution of one-hot and (T2) has
$$Y(v) = F_x(v) - F_z(v) + \sigma_v \alpha, \qquad Z(v) = F_y(v) - F_x(v) + \sigma_v \beta,$$
where $F_E(v)$ is the sum of the real weights of the two chains of axis $E$ through $v$ and $\sigma_v = \pm 1$ on A and B. Hence $X = 1 - Y - Z = 1 + F_z - F_y - \sigma_v(\alpha + \beta)$.

(S1) A pair of neighbouring planes $x = $ const holds $\gcd(b, c)$ chains of axis $x$ of its family (check4). When $\gcd(b, c) = 1$ it holds one, and $F_x(v) = \Phi(x_v)$.

**Sheet lemma.** Let $\varepsilon(i, j) = \alpha(i) + \beta(j)$ take the values 0 and 1 on a product $I \times J$. Then $\alpha$ or $\beta$ is constant. *Proof.* If $\alpha(i_1) \neq \alpha(i_2)$ their difference is $\pm 1$, so for every $j$ the two values $\varepsilon(i_1, j)$, $\varepsilon(i_2, j)$ are 0 and 1 in an order that does not depend on $j$, and $\beta(j)$ is determined. $\square$

**Grids as products.** Let $G$ be a plane $z = z_0$ of $S$. Its vertices are $v_0 + m(2,2,0) + n(2,-2,0)$. The chains of axis $z$ through such a vertex are the one of the family $\{0,3\}$, whose vertices of $S$ are $v + t(2,2,0)$, and the one of the family $\{1,2\}$, with vertices $v + t(2,-2,0)$. So on $G$
$$F_z = P(n) + Q(m), \qquad x = x_0 + 2(m + n),$$
with $P$ and $Q$ periodic of period $g_z = \gcd(a, b)$, the number of chains of each family in a pair of planes. The translations of $G$ act transitively on its vertices, the step $(2,2,0)$ fixes the class of $n$ and moves the class of $m$ by one, and the step $(2,-2,0)$ does the reverse. So every pair of classes occurs at some vertex of $G$. The same holds on a plane $y = y_0$ with the steps $(2,0,2)$ and $(2,0,-2)$ and period $g_y = \gcd(a, c)$, and on a plane $x = x_0$ with $(0,2,2)$ and $(0,2,-2)$.

### The corrected lemma on three families

**Lemma T′.** Let $\varepsilon(m, n) = \gamma(m + n) + \alpha(n) + \beta(m)$ take the values 0 and 1 on $\mathbb{Z}^2$, with $\alpha$, $\beta$, $\gamma$ real and periodic, and suppose the jumps $\gamma(k+1) - \gamma(k)$ are integers. Then either $\gamma$ is constant and $\varepsilon$ is a function of $m$ alone or of $n$ alone, or $\alpha$ and $\beta$ are constant and $\varepsilon$ is a function of $m + n$.

*Proof.* Put $p(n) = \alpha(n+1) - \alpha(n)$, $q(m) = \beta(m+1) - \beta(m)$, $c(k) = \gamma(k+1) - \gamma(k)$. Then $\varepsilon(m+1, n) - \varepsilon(m, n) = q(m) + c(m+n)$, so $q$ is integer valued, and in the same way $p$ is. Also $\varepsilon(m, n+1) - \varepsilon(m+1, n) = p(n) - q(m) \in \{-1, 0, 1\}$. A periodic function has jumps of sum zero over a period, so if $p \neq 0$ it has a value $\geq 1$ and a value $\leq -1$, and then $0 \leq q(m) \leq 0$ for every $m$. So $\alpha$ or $\beta$ is constant. If $\beta$ is, $\varepsilon = \gamma(k) + \alpha(n) + $ const as a function of $(k, n) = (m + n, n)$, which runs over $\mathbb{Z}^2$, and the sheet lemma makes $\gamma$ or $\alpha$ constant. $\square$

**The lemma fails without the hypothesis on the jumps.** On $\mathbb{Z}_3 \times \mathbb{Z}_3$ take $\alpha = \beta = (\tfrac23, \tfrac13, 0)$ and $\gamma = (-\tfrac13, 0, -\tfrac23)$. Then $\alpha(i) + \beta(j) + \gamma(i + j)$ is 1 at $(0,0)$, $(0,1)$, $(1,0)$ and 0 at the six other points. The proof of Lemma T in the report of 18 September says that a function $a$ with sum zero and $a(i) - b(j) \in \{-1, 0, 1\}$ is zero or takes a value $\geq 1$ and a value $\leq -1$. That is true of integer-valued $a$ only. In the general case the jumps take two values $\theta - 1$ and $\theta$ with $0 < \theta < 1$.

**Lemma J (the jumps are integers).** Let $\gcd(b, c) = 1$ and let $\Phi_S$ be the restriction of $\Phi$ to the planes $x = $ const of $S$. In a solution of the type model the jumps $\Phi_S(x + 2) - \Phi_S(x)$ are integers.

*Proof.* On a plane $z = z_0$ of $S$, $Y = \gamma(m + n) - P(n) - Q(m) + $ const with $\gamma(k) = \Phi_S(x_0 + 2k)$. Let $c$ and $q$ be the jumps of $\gamma$ and of $Q$. Then $Y(m+1, n) - Y(m, n) = c(m + n) - q(m) \in \{-1, 0, 1\}$ for all $m$ and $n$. Suppose some $c(k_0)$ is not an integer and let $\theta \in (0, 1)$ be its fractional part. Every $q(m)$ is congruent to $\theta$ modulo 1, and then so is every $c(k)$. Both have sum zero over a period and no value zero, so each has a value $\geq \theta$ and a value $\leq \theta - 1$. Since $\max c - \min q \leq 1$ and $\min c - \max q \geq -1$, both take the two values $\theta - 1$ and $\theta$ only. If $j$ of the $g_z$ values of $q$ in a period equal $\theta$, then $j\theta + (g_z - j)(\theta - 1) = 0$, so $g_z \theta$ is an integer. On a plane $y = y_0$ of $S$, $Z = P'(n') + Q'(m') - \gamma(m' + n') + $ const, and the same argument gives that $g_y \theta$ is an integer. But $g_z$ divides $b$ and $g_y$ divides $c$, so they are coprime, and $\theta$ is an integer. $\square$

This is the repair that the proof of Theorem R1 needs, since it applies Lemma T in the same two places.

### Proof of Theorem S

Absorb the constants of (C) on $S$ into the heights, so that on $S$
$$Y = \Phi_S(x) - F_z, \qquad Z = F_y - \Phi_S(x), \qquad X = 1 - Y - Z.$$

*Case 1: $\Phi_S$ is not constant.* On a plane $z = z_0$ of $S$ Lemma T′ applies, by Lemma J, and $\gamma$ is not constant. So $P$ and $Q$ are constant on that plane and $Y = \Phi_S(x) - \kappa(z_0)$. Hence $Y(v) = \Phi_S(x_v) - \kappa(z_v)$ on $S$. Every pair $(x, z)$ of the parity of $S$ belongs to a vertex of $S$, so the sheet lemma applies, and $\kappa$ is constant. In the same way $Z(v) = \kappa' - \Phi_S(x_v)$ with $\kappa'$ constant. $\Phi_S$ takes two values, $\kappa$ and $\kappa + 1$ from $Y$ and $\kappa' - 1$ and $\kappa'$ from $Z$, so $\kappa' = \kappa + 1$ and $Y + Z = 1$. This is (i).

*Case 2: $\Phi_S$ is constant.* On a plane $z = z_0$ of $S$, $Y = $ const $ - P(n) - Q(m)$, and by the sheet lemma it is a function of $n$ alone or of $m$ alone. So every vertex of type $y$ of $S$ lies on a line $\{q + t u\}$, $u = (2, 2\epsilon, 0)$, $\epsilon = \pm 1$, all of whose vertices are of type $y$. In the same way every vertex of type $z$ of $S$ lies on a line $\{r + s w\}$, $w = (2, 0, 2\epsilon')$, all of type $z$. Two such lines meet. Write $q - r = (d_x, d_y, d_z)$, with all entries even and sum divisible by 4. A common point needs $t \equiv -\epsilon d_y / 2 \pmod{2b}$, $s \equiv \epsilon' d_z / 2 \pmod{2c}$ and $t - s \equiv -d_x / 2 \pmod{2a}$. The first two fix $t$ and $s$ up to multiples of $2b$ and $2c$, so $t - s$ up to multiples of $2\gcd(b, c) = 2$, and its parity is that of $(d_x + d_y + d_z)/2$, which is even. So $t - s$ can be given any value of the right parity. A common point would have two types, so $S$ lacks type $y$ or type $z$. $\square$

### Proof of Corollary H

Let the state be odd. By Lemma 1 of the note some hole $O$ is a corner. Its two rods are vertices of the sublattice $S$ of $O$, of two different types $j$ and $k$. By Theorem S, $S$ has no vertex of the third type $i$. If the other sublattice had one, Theorem $M'$ (proved for every cell, and confirmed by check6) would give even curl. So no vertex has type $i$ and the axis $i$ is empty. $\square$

### Proof of Theorem S2, and of its corollary without Theorem $M'$

Now $F_y = \Upsilon(y)$ and $F_z = \mathrm{Z}(z)$ by (S1). On $S$, $X(v) = \zeta(z_v) - \upsilon(y_v)$ with the constants absorbed. Every pair $(y, z)$ of the parity of $S$ belongs to a vertex of $S$, so by the sheet lemma $X$ is a function of $z$ alone or of $y$ alone on $S$.

Suppose $X$ is a function of $z$ alone and is not zero, so that $\upsilon$ is constant and some plane $z = z_1$ of $S$ is all of type $x$. Then $Z = \upsilon - F_x + $ const takes the values 0 and 1, and on each plane $x = x_0$ of $S$ it is a sum of a function of the chain of one family and a function of the chain of the other. By the sheet lemma it is constant along the chains of one family. The line $z = z_1$ of that plane meets every chain of each family, because its points are $4$ apart in $y$ and the classes of the chains are those of $y \mp z$ modulo $4\gcd(b, c)$, which divides $4b$. On that line $Z = 0$. So $Z = 0$ on the plane, and on $S$. This is ($P_z$). The other case gives ($P_y$), and $X = 0$ on $S$ gives ($Q$) by the same use of the sheet lemma.

*The corollary.* A corner of $S$ cannot have a rod of type $x$. If $S$ is of the form ($P_z$) the rod of type $x$ and the other rod, which is of type $y$ and lies on the axis $y$ through the hole, have the same coordinate $z$, and the whole plane is of type $x$. The form ($P_y$) is the same with $y$ and $z$ exchanged. So a corner has rods of types $y$ and $z$ and its sublattice has the form ($Q$). Let $(O, \sigma)$ be the odd hexagon at the corner $O$, with $O' = O + \sigma$ in the other sublattice $S'$. By (T2) none of the three vertices $b_k = O' - 2\sigma_k e_k$ has type $k$. If $S'$ had the form ($P_z$), $b_y$ would be of type $x$, the plane $z = z_{O'}$ of $S'$ would be all of type $x$, and $b_x$, which lies in it, would have type $x$. The form ($P_y$) is excluded by $b_z$ and $b_x$ in the same way. So $S'$ has the form ($Q$) and no vertex has type $x$. $\square$

### Solver support

Type model, no signs. SL: 'A has a vertex of each type' (one of them fixed at the origin). PL: 'the origin is of type $x$ and neither plane of A through it, $z = 0$ or $y = 0$, is all of type $x$'. V4: 'the four bridgeheads of an A-hole are of types $y$, $y$ below and $z$, $z$ above, and B has a vertex of type $x$'. Every query has controls, which are satisfiable. Script `h420_family.py`.

| cell | coprime pairs | $\gcd(b,c)$ | SL | PL | V4 |
|---|---|---|---|---|---|
| (2,3,3) | two | 3 | UNSAT 0.6 s | UNSAT 0.3 s | UNSAT 0.2 s |
| (4,3,3) | two | 3 | UNSAT 4.7 s | UNSAT 6.2 s | UNSAT 1.6 s |
| (5,3,3) | two | 3 | UNSAT 10.8 s | UNSAT 9.8 s | UNSAT 5.6 s |
| (3,4,4) | two | 4 | UNSAT 8.3 s | UNSAT 6.2 s | UNSAT 3.0 s |
| (5,2,4) | two | 2 | UNSAT 6.3 s | UNSAT 6.1 s | UNSAT 1.6 s |
| (5,4,4) | two | 4 | no verdict, 120 s | no verdict, 120 s | UNSAT 36 s |
| (6,2,3) | one | 1 | UNSAT 2.0 s | SAT | UNSAT 0.7 s |
| (6,3,4) | one | 1 | UNSAT 40 s | SAT | UNSAT 2.6 s |
| (6,2,9) | one | 1 | no verdict, 100 s | SAT | UNSAT 6.6 s |
| (3,3,3) | none | 3 | SAT | SAT | SAT |
| (4,4,6) | none | 2 | SAT | SAT | SAT |

PL is the plane statement of Theorem S2 and is claimed only with two coprime pairs. 'Some hexagon odd and all three types present' (`h333_oddtypes.py`) is UNSAT on (6,2,3) in 13.5 s and on (4,3,3) in 31 s, and SAT on (3,3,3), (2,2,2), (2,2,4), (2,4,6) and (4,4,6). These are tests of the proof and not part of it.

### What this does to the record

1. Theorem U holds on every cell with a coprime pair, in one line: the unoriented cage has bridgeheads of types $y$ and $z$ on one sublattice, which therefore has no vertex of type $x$, and Theorem $M'$ gives even curl. Theorem 10 is the case in which the coprime pair is transverse to the rods. Theorem 11 is not covered: it holds on cells such as (15,6,10), which have no coprime pair.
2. V4 shows that on these cells the rods are not needed in the hypothesis of (V). On a cubic cell they are (V4 is SAT on (3,3,3)).
3. H no longer depends on the certificates of $K_u$ on any cell with a coprime pair.
4. The linear programme of (V) is positive on cells such as (5,3,3) and (5,4,4), so no weighted sum of laws proves it there. The proof above uses that the types are integers twice, each time through the sheet lemma, applied to a function on a product of two sets of chains or of two sets of planes. It uses the torus through (S1) and through the meeting of two lines. It is not a window statement and has no case split on vertices.

## What is left

**The cells with no coprime pair.** Every two extents share a factor. The cubic cell of side $L \geq 2$ is one, and so are (2,2,4), (4,4,6), (6,10,15). On such a cell every pair of planes holds at least two chains of each family, and no height is a function of one coordinate.

**Odd states with three types exist there (solver).** On (2,2,2), (2,2,4), (2,4,6), (3,3,3) and (4,4,6), with the sign field. So the line between the cells that Theorem S settles and the rest is sharp on every cell tried.

**The corpus (computed, `h421_corpus_sl.py`).** 637 odd states at side three and 720 at side four.

| types on A, on B | axis pattern | side 3 | side 4 |
|---|---|---|---|
| 2, 2 | one axis empty | 173 | 183 |
| 3, 3 | no axis empty, at least one one-way | 464 | 537 |

Every state has corners on both sublattices. No state has two types on one sublattice and three on the other. In the states with three types each axis has the same pattern of signs on A and on B. For the 356 states of the first row H follows from Theorem $M'$ by the argument of Corollary H. For the 1,001 of the second row H holds through an axis that is one-way and not empty, which is a statement about signs. In the zero-flux sector a one-way axis is empty, so for the periodicity conjecture the statement needed on these cells is that a frozen zero-flux state with all three types has even curl (Corollary Z of 22 September).

**A law for all cells (proved; computed with no exception on the corpus, `h422_shadow.py`).** Average (C) along the line $\{v + 4n e_k\}$. The labels of the chains of the two other axes run over all their values and leave the averages over pairs of planes. So with $h_k(v)$ the number of vertices of type $k$ on the $k$-line through $v$, and $\ell_k$ the number of vertices of that line,
$$\frac{h_y}{\ell_y} = P(x) - R(z), \qquad \frac{h_z}{\ell_z} = Q(y) - P(x), \qquad \frac{h_x}{\ell_x} = 1 + R(z) - Q(y),$$
on each sublattice, for three functions of one coordinate, and the three fractions at any vertex add to one. The separability is Theorem 5 of the note. The common profiles and the sum are not in the record that I have read. A state has even curl exactly when every fraction is 0 or 1. This is the part of a state that a slab sum would have, and an odd state is one in which it is fractional.

## Why this was not found before

Four tools have produced every hand proof of a statement of this class in the project (Theorem R1, Theorem $M'$, Theorems 10 and 11, Theorem S): completeness; a sum or a restriction that leaves a function of two sets of labels; the fact that such a function with values in a small set is rigid; and the meeting of two complete lines on the torus. The attempts on (V) from 22 to 27 September looked for something else: a window, a weighted sum of laws, a thin family of integral indicators, a case split on vertices, a lift of degree two. The integrality that the proofs use is always the sheet lemma, and it is applied to a quantity on the whole torus that the geometry makes separable. The proposal below is to look for those quantities on the cells that are left, and not for certificates.

## Proposal

Five packages. A and B are first and do not depend on each other. Agents are Opus, compute is on the Mac, and each agent has its own range of script numbers, as on 27 September.

**A. Check and record Theorem S.** An independent checker with its own implementation: read the proofs above for a gap; test SL with a symmetry-broken encoding on (5,4,4), (6,2,9), (7,3,6) and (10,4,5); confirm the counterexample to Lemma T and the repair; read the proof of Theorem R1 with Lemma T′ in place of Lemma T. Then the note gets Theorem S and Corollary H as theorems, and its statement of what is open changes.

**B. Signed completeness.** Computed here (`h423_signed_modes.py`) on the cubic cells of side three and four: the solutions of the law $P^k$ alone form a space of dimension 62 and 114, and it is the span of the indicators of the chains of the two other axes and the two sublattice constants. By Lemma 3 of the note the signed component $n_k$ obeys $P^k$ at every oriented hole, and in all 34 corpus states sampled $n_k$ lies in that span for each $k$. So in a state with every hole oriented, each of the six indicators of a direction is a difference of chain sums, as each type indicator is. The package: prove the statement about the kernel for every cell by the stratified Fourier method of 17 September, which applies to any system of laws invariant under the translations; find which weights the six fields share; and state the result as a theorem about odd states given Theorem U. This is the step that lets the method reach the signs.

**C. The sublattice theorem for directions, on cells with a coprime pair.** On those cells H is proved, so this is a test of the method and not a new case. The target is $K_u$ by hand there, for every greatest common divisor: a chain of one moment forces a direction to be absent. The first step of $K_u$ on the whole slab is the second open statement on cubic cells, and it has no proof on any cell with greatest common divisor three or more. A proof on the cells $(a, L, L)$ with $a$ coprime to $L$ would show what carries it across the $L$ chains of a slab.

**D. The first cells with no coprime pair: two chains in every pair of planes.** The cells $(2a', 2b', 2c')$ with $a'$, $b'$, $c'$ pairwise coprime, among them (2,2,2), (2,2,6), (2,6,10) and (6,10,14). All three greatest common divisors are 2. On these cells $K_u$ is certified (its first step covers the slab when the greatest common divisor is at most 2) and Theorem 1′ reduces H to (V) with two chains per slab and even length, which is the case that gtwo and oddtwo left open. With two chains the weight of a chain is the mean of its pair of planes plus or minus one number, and on A
$$F_x = \tilde\Phi(x) + \pi(v)\bigl[\delta_x (-1)^{z/2} + \delta'_x\bigr], \qquad \pi(v) = (-1)^{(x+y+z)/4},$$
with the same form for $F_y$ and $F_z$. The state is then given by nine functions of one coordinate on each sublattice. The fractions of the law above are $0$, $\tfrac12$ or $1$, and a line with fraction $\tfrac12$ alternates. (V) becomes a statement about profiles, of the kind the profile lemma of the curl-reduction note settled by a finite case analysis. The alternating mode that made the linear programme positive is one of the nine profiles. The deliverable is H, by hand apart from the certificates of $K_u$, on an infinite family of cells with no coprime pair, which includes the cubic cell of side two.

**E. The cubic cell of side $L$ as the first member of its family.** The cells $(La', Lb', Lc')$ with $a'$, $b'$, $c'$ pairwise coprime have $L$ chains in every pair of planes, and the cubic cell is the smallest. Package D is $L = 2$. For general $L$ the weights of the chains of a pair of planes are a function on $\mathbb{Z}_L$, and its components in the characters of $\mathbb{Z}_L$ are profiles of one coordinate: the trivial character gives the fractions of the law above, and package D is the sign character. For prime $L$ the types are integers, so the components in the $L - 1$ other characters are conjugate under the Galois group and carry one profile between them. The package is to write (V) and the first step of $K_u$ in these profiles at $L = 3$, where the solver decides every finite question in seconds, and to see whether the argument of package D goes over. This is the step at which the proposal could fail. If the case analysis at $L = 3$ does not resemble the one at $L = 2$, the project has H on every cell with a coprime pair and on the family of package D, and the cubic cells of side three and more stay with their certificates.

Order: A and B at once. C and D when B has landed, since both use it (D needs it only if it goes for H without $K_u$). E last.

**Not proposed.** Further windows, slabs, linear programmes or case splits for (V); certificates at side seven to ten; Theorem U by itself on cells with a coprime pair, which is now a corollary; any solver run of 'odd and three types' beyond those above, which are tests of Theorem S.

## Caveats

1. Theorem S and its corollary were found and proved in one session by the main loop and have had no second reader. The record's one experience of a statement left without one is the gap in $K_u$.
2. Corollary H rests on Theorem $M'$, which is from the record, with two proofs and one second reader. Theorem S2 gives the corollary without it, for cells with two coprime pairs that share an extent.
3. Completeness (C) is taken from the record. It was proved by a symbolic computation over strata and confirmed by check4 by rank computations on cells.
4. The cells of extent one and two are covered by the proofs as written, but (T2) on them is Lemma L of the curl-reduction note applied to hexagons that may wind, and I have not checked the definitions on those cells. The solver runs include (2,3,3), (5,2,4), (6,2,3).
5. Package B's statement about the kernel is computed on two cells. The sample of corpus states for the membership of $n_k$ is every fortieth state.

## Computations run

From `scratch_h`, project `.venv`, `PYTHONPATH=<repo>:<repo>/experiments/08_frozen_structure`, `TMPDIR=<repo>/.tmp`.

| command | what | verdict | wall |
|---|---|---|---|
| `h420_family.py 4,3,3` | pre-flight | as in the table | 13 s |
| `h420_family.py 5,3,3 3,3,3 2,3,3` | SL, PL, V4 with controls | as in the table | 30 s |
| `h420_family.py 3,4,4 5,2,4` | the same | as in the table | 35 s |
| `h420_family.py 6,3,4 4,4,6 5,4,4` | the same | as in the table; two queries capped at 120 s | 5 min |
| `h420_family.py 6,2,3 6,2,9` | the same | as in the table; one query capped at 100 s | 2 min |
| `h333_oddtypes.py CELL`, (6,2,3), (4,3,3), (3,3,3) | odd and three types | UNSAT, UNSAT, SAT | 14 s, 32 s, 0 s |
| `h333_oddtypes.py CELL --sign`, (2,2,2), (2,2,4), (2,4,6), (4,4,6) | the same with the sign field | SAT on all four | under 5 s each |
| `h421_corpus_sl.py` | types by sublattice and axis patterns on the corpus | the table of 'What is left' | 10 s |
| `h422_shadow.py` | the law of line fractions on the corpus | 0 violations in 1,357 states | 15 s |
| `h423_signed_modes.py 3`, `4` | kernel of $P^k$ and the signed fields | ranks 62 and 114, equal to the span; 16 of 16 and 18 of 18 in the span | 1.5 s, 4 s |
