---
title: "Package D (agent twochain): on every cell (2a', 2b', 2c') with a', b', c' pairwise coprime, (V) is proved by hand — in a type-model solution containing the unoriented cage, sublattice B has no vertex of type x and the two planes of bridgeheads are entirely of types y and z. The proof is the profile description (nine functions of one coordinate on each sublattice, the B data a shift of the A data), one linear identity from the four bridgeheads, and a finite parity case analysis. With Theorem M′ this is Theorem U on the whole family, and with Theorem 1′ and K_u it gives Theorem H on the members with every extent at least 4; the thin members are not covered by the recorded scope of K_u"
author: "Claude (Opus), agent twochain, for Lyndon Drake"
date: 2026-09-28
---

Status tags: **proved** (argument written out here in full), **computed** (exact, reproducible, no solver), **solver** (SAT verdict through `h32_cap`), **conjecture**. New scripts `experiments/08_frozen_structure/scratch_h/h450_lib.py` to `h460_weak.py`. No existing file was modified; nothing was committed. All computation ran on this Mac.

## Status table

| # | statement | tag |
|---|---|---|
| 1 | **Theorem P (profile description, D1).** On every member of the family each type indicator on each sublattice has the form $a(\text{transverse}) + \pi(v)\,b(\text{transverse})$; on each $k$-line $K_k$ is constant 0, constant 1, or alternates ($a = \tfrac12$, $b = \pm\tfrac12$); the line fractions are $a_y = (p(x)-r(z))/2$, $a_z = (q(y)-p(x))/2$, $a_x = (2+r(z)-q(y))/2$ with integer profiles; the $b$ parts are differences of six functions $E_k(\cdot,\pm)$ of one coordinate, and the E-data of B are a shift of those of A: $E^B_k(n',\sigma) = \tfrac12(\sigma D^A_k(n'-1) - S^A_k(n'+1))$ | **proved** (§1); formulas **computed** exactly on 7 pattern states of (2,2,2), (2,4,6) and on 169+ odd states of (2,2,2), (2,2,4), (2,4,6) and the (4,6,10) samples |
| 2 | Chain inequality: $\max r \le \min p$, $\max p \le \min q$, $\max q \le \min r + 2$ on each sublattice; the six slacks sum to 2 | **proved** (§1) |
| 3 | Parity rule: at every vertex $|E_x - E_z| = \tfrac12[p(x)-r(z)\text{ odd}]$ and cyclically; with the chain inequality this is exactly one-hot + (T2) + $t \in \{0,1\}$ | **proved** (§1) |
| 4 | The a-profiles of A and of B are independent; the E-data are fixed by the state up to one additive constant per vertex class of A (four) | **proved** (§1) |
| 5 | **Identity (★)**: $p_B(1) - p_B(3) = 2 + b(0,z_0) - b(4,z_0) - b(0,0) - b(4,0)$ ($z_0 \equiv 2$), a linear identity on {one-hot, (T2), pattern} | **proved** (§2); **computed** exactly (row-space test, (C) by modular rank) on (2,2,2), (2,2,4), (2,2,6), (2,4,6), (2,6,10), (4,6,10), 8–12 choices of $(z', z_0)$ each, with controls |
| 6 | **Theorem V (D2).** On every member, a type-model solution containing the unoriented cage in standard position has: $p_A$ constant; B no vertex of type $x$; the B-plane $x=1$ all of type $y$; the B-plane $x=3$ all of type $z$. Only the literals $X(v)=X(v')=1$, $Y(\beta)=Y(\beta')=1$, $Y(\gamma)=Y(\gamma')=0$ are used | **proved** (§2) |
| 7 | The special case of step 5 of the proof is realisable (so the case analysis is not vacuous), and its lemma holds, on (2,2,2), (2,2,6), (2,4,6), (4,6,10); facts A1–A6 hold exactly on 31 sampled special-case states | **solver** + **computed** (h455) |
| 8 | Algebra of steps 3 and 5 re-done symbolically | **computed** (sympy, h456) |
| 9 | Solver consistency of Theorem V: pattern + B has $x$ UNSAT on (2,2,2), (2,4,6); also 'A fractional line', 'B fractional line', 'odd', 'G1 not all $y$', 'G3 not all $z$' UNSAT; bridgeheads alone + B has $x$ SAT (the rods are needed); with $\gamma,\gamma'$ only 'not $y$' (what the proof uses), B has $x$ and $\gamma$ of type $x$ are UNSAT on (2,4,6), (4,6,10) | **solver** (tests only) |
| 10 | **Theorem U on the family**: in a frozen state of a member every hole of an odd state is oriented | **proved**, given Theorem V, (C), (S1), the cage enumeration of Lemma 3, Lemma 2 and Theorem $M'$ (record) |
| 11 | **Theorem H on the members with $a', b', c' \ge 2$** (every extent $\ge 4$), e.g. (4,6,10), (4,6,14), (4,10,14), (6,8,10), (6,10,14) | **proved given the record**: Theorem U here + Theorem 1′ (noncubic audit, check6) + $K_u$ for chains of all three axes (certificates; P1 covers the slab since every gcd is 2) |
| 12 | Thin members (some extent 2: (2,2,2), (2,2,4), (2,2,6), (2,4,6), (2,6,10), …): Theorem U proved; Theorem H **not covered** by the recorded scope of $K_u$ (extents 3, 4, 4 in the chain's frame); check6's remark C2 would cover them if accepted, but it has not been checked on a thin cell | open for H |
| 13 | D4: in 127 sampled odd states with three types on both sublattices (three cells), A and B have the same slack vector; in 125 of them exactly one of $p,q,r$ is constant, the same on A and B; the axis of the constant profile is one-way in all of them; its E-functions are 4-periodic on both sublattices. No sampled state has all three axes two-way | **computed** on solver samples (description, not proof) |
| 14 | **Conjecture D4.** In an odd state of a member with three types, the axis whose profile is constant on both sublattices is one-way. This would give H on the family without $K_u$ | **conjecture** |
| 15 | D5: the proof does not extend to (4,4,6) or (8,4,6): it uses the two-chain form for all three axes; on (4,4,6) $y$-lines of A are not 8-periodic (SAT). (V′) itself is UNSAT on both cells | **proved** (reading) + **solver** |

## 0. Setting

Family: $(a,b,c) = (2a',2b',2c')$, $a',b',c'$ pairwise coprime; members (2,2,2), (2,2,4), (2,2,6), (2,4,6), (2,6,10), (4,6,10), (6,10,14), … (all permutations). Every pair of extents has gcd 2, so by (S1) every pair of neighbouring planes holds exactly two chains of each family (check4; oddtwo Lemma A).

Signs at a vertex $v = (x,y,z)$. On A: $\xi = (-1)^{x/2}$, $\eta = (-1)^{y/2}$, $\zeta = (-1)^{z/2}$, $\pi = (-1)^{(x+y+z)/4}$. On B: $\xi = (-1)^{(x-1)/2}$, $\eta = (-1)^{(y-1)/2}$, $\zeta = (-1)^{(z-1)/2}$, $\pi = (-1)^{(x+y+z-3)/4}$. The periods are $8a', 8b', 8c'$, so all are well defined on the cell, and $\xi\eta\zeta = 1$ at every vertex (from $x+y+z \equiv 0$, resp. $3 \pmod 4$). The four **vertex classes** of a sublattice are the four sign triples. A vertex and its translate by $4e_k$ have the same $\xi,\eta,\zeta$ and opposite $\pi$.

Chain signs. The two chains of a family in a pair of planes are the two classes of a residue mod 8 (oddtwo Lemma A), told apart by a sign constant along the chain, evaluated at any A vertex of it: $\{0,1\}$: $(-1)^{(x+y-z)/4}$; $\{0,2\}$: $(-1)^{(y+z-x)/4}$; $\{0,3\}$: $(-1)^{(z+x-y)/4}$; $\{2,3\}$, $\{1,3\}$, $\{1,2\}$: $\pi$. (Each exponent is unchanged by the step of its chain and changes by 1 under $y - z \mapsto y - z + 4$ etc.) Write the weight of the chain of family $f$ with A-plane $n$ and sign $s$ as $m_f(n) + s\,e_f(n)$.

Standard cage: $O=(2,0,0)$, rods $v=(0,0,0)$, $v'=(4,0,0)$ of type $x$; $\beta=(1,1,1)$, $\beta'=(1,-1,-1)$ of type $y$; $\gamma=(3,1,-1)$, $\gamma'=(3,-1,1)$ of type $z$.

## 1. D1: the profile description

**Theorem P.** Put, for A-planes $n$ and $\sigma = \pm 1$,
$$E^A_x(n,\sigma) = \sigma e_{01}(n) + e_{23}(n),\quad E^A_y(n,\sigma) = \sigma e_{02}(n) + e_{13}(n),\quad E^A_z(n,\sigma) = \sigma e_{03}(n) + e_{12}(n),$$
and for B-planes $n'$
$$E^B_x(n',\sigma) = \sigma e_{01}(n'-1) - e_{23}(n'+1),$$ and cyclically ($e_{02}, e_{13}$ with $y$; $e_{03}, e_{12}$ with $z$). Put $\Phi^A_x(n) = m_{01}(n) + m_{23}(n)$, $\Phi^B_x(n') = m_{01}(n'-1) + m_{23}(n'+1)$, and cyclically. Then on sublattice $S$, with $\sigma_S = \pm1$,
$$F_x = \Phi^S_x(x) + \pi E^S_x(x,\zeta),\qquad F_y = \Phi^S_y(y) + \pi E^S_y(y,\xi),\qquad F_z = \Phi^S_z(z) + \pi E^S_z(z,\eta),$$
and every real solution of one-hot and (T2) is
$$Y = a_y + \pi(E_x - E_z),\quad Z = a_z + \pi(E_y - E_x),\quad X = a_x + \pi(E_z - E_y),$$
$a_y = \Phi_x(x) - \Phi_z(z) + \sigma_S\alpha$, $a_z = \Phi_y(y) - \Phi_x(x) + \sigma_S\beta$, $a_x = 1 - a_y - a_z$, where at the vertex $E_x = E^S_x(x,\zeta)$, $E_y = E^S_y(y,\xi)$, $E_z = E^S_z(z,\eta)$.

*Proof.* By (C), $Y = F_x - F_z + \sigma\alpha$, $Z = F_y - F_x + \sigma\beta$. At an A vertex the chain of $\{0,1\}$ through $v$ has A-plane $x$ and sign $(-1)^{(x+y-z)/4} = \pi\cdot(-1)^{-z/2} = \pi\zeta$, and the chain of $\{2,3\}$ has A-plane $x$ and sign $\pi$; so $F_x = m_{01}(x) + m_{23}(x) + \pi(\zeta e_{01}(x) + e_{23}(x))$. In the same way the signs of $\{0,2\}$ and $\{0,3\}$ are $\pi\xi$ and $\pi\eta$ (the exponents differ from that of $\pi$ by $x/2$ and $y/2$). At a B vertex $w$ the chain of $\{0,1\}$ contains $w - d_0 = (x-1,y-1,z-1)$, A-plane $x-1$, sign $(-1)^{(x+y-z-1)/4} = \pi\zeta$ (exponents differ by $(z-1)/2$); the chain of $\{2,3\}$ contains $w - d_2 = (x+1,y-1,z+1)$, A-plane $x+1$, sign $(-1)^{(x+y+z+1)/4} = -\pi$. Likewise $\{0,2\}$ through $w-d_0$ (A-plane $y-1$, sign $\pi\xi$), $\{1,3\}$ through $w-d_1 = (x-1,y+1,z+1)$ (A-plane $y+1$, sign $-\pi$), $\{0,3\}$ through $w-d_0$ (plane $z-1$, sign $\pi\eta$), $\{1,2\}$ through $w-d_1$ (plane $z+1$, sign $-\pi$). Substituting gives the formulas. $\square$

Since $\eta = \xi\zeta$, the $b$ part of $Y$, $E_x(x,\zeta) - E_z(z,\xi\zeta)$, is a function of $(x,z)$ alone; likewise for $Z$ of $(x,y)$ and for $X$ of $(y,z)$.

**Corollary P1 (lines; proved).** On a $k$-line $\{v + 4ne_k\}$ the transverse coordinates, hence $a_k$ and $b_k$, are fixed and $\pi$ alternates. So $K_k(v) + K_k(v+4e_k) = 2a_k$ and $K_k(v) - K_k(v+4e_k) = 2\pi b_k$. With $K_k \in \{0,1\}$: $(a_k,b_k) \in \{(0,0),(1,0),(\tfrac12,\pm\tfrac12)\}$. The line has $a$, $b$ or $c$ vertices, an even number, so the alternation closes. $a_k$ is the line fraction of the law of line fractions; $K_k$ has period 8 along $k$.

**Corollary P2 (profiles; proved).** Put $p = 2\Phi_x + c_p$, $q = 2\Phi_y + c_q$, $r = 2\Phi_z + c_r$ with $c_p - c_r = 2\sigma_S\alpha$, $c_q - c_p = 2\sigma_S\beta$. Then $2a_y = p(x) - r(z)$, $2a_z = q(y) - p(x)$, $2a_x = 2 + r(z) - q(y)$. Every pair of values of two coordinates occurs at a vertex of $S$, so the differences are integers (P1), and after a common shift $p,q,r$ are integer valued. From $a \ge 0$ on all pairs: $\max r \le \min p$, $\max p \le \min q$, $\max q \le \min r + 2$ (the **chain inequality**). The six slacks $s = (\text{spread } r,\ \min p - \max r,\ \text{spread } p,\ \min q - \max p,\ \text{spread } q,\ \min r + 2 - \max q)$ are non-negative integers with sum 2. In particular **the three spreads add to at most 2**, and a profile taking both parities has spread $\ge 1$.

**Corollary P3 (parity rule; proved).** $|b_y| = \tfrac12$ iff $a_y = \tfrac12$ iff $p(x) - r(z)$ is odd. So at every vertex $|E_x - E_z| = \tfrac12[p - r \text{ odd}]$, $|E_y - E_x| = \tfrac12[q - p\text{ odd}]$, $|E_z - E_y| = \tfrac12[r - q\text{ odd}]$. Conversely, integer profiles with the chain inequality and E-data obeying the parity rule give $X,Y,Z \in \{0,1\}$ with sum 1 at every vertex. One-hot is automatic ($a$'s sum to 1, $b$'s to 0 identically). So the type model is exactly: {profiles with the chain inequality on A, on B; E-data of A} subject to the parity rule on both sublattices, B's E-data given by the coupling below. Non-negativity alone (the LP) only gives $|b| \le \min(a, 1-a)$ on each line.

**Coupling (proved, by the definitions).** With $D^S_k(n) = E^S_k(n,+) - E^S_k(n,-)$ and $S^S_k(n) = E^S_k(n,+) + E^S_k(n,-)$: $D^B_k(n') = D^A_k(n'-1)$ and $S^B_k(n') = -S^A_k(n'+1)$, i.e. $E^B_k(n',\sigma) = \tfrac12(\sigma D^A_k(n'-1) - S^A_k(n'+1))$.

**Freedom (proved).** (i) The a-profiles of A and of B are independent: given integer triples on both with the chain inequality, choose $\Phi^A$, $\Phi^B$; $m_{01}, m_{23}$ with $m_{01}(n)+m_{23}(n) = \Phi^A_x(n)$ and $m_{01}(n)+m_{23}(n+2) = \Phi^B_x(n+1)$ exist iff $\sum\Phi^A_x = \sum\Phi^B_x$ over the circle of $2a$ A-planes, which the free additive constants arrange; $\alpha$, $\beta$ are then fixed by the constants of A and B (two linear equations with a solution). (ii) Within one vertex class the E-values are linked by the given differences on a complete tripartite graph, so the state fixes the E-data of A up to one constant per class. Shifting class $(+++)$ of A by $c$ shifts every E-value of every B class by $\pm c/2$ uniformly within the class (checked for all four B classes), so no type changes. Hence exactly four constants of gauge on the E-data, and a common shift of $(p,q,r)$ on each sublattice.

This agrees with the main loop's form (see the last section): nine functions of one coordinate per sublattice ($p,q,r$ and $E_k(\cdot,\pm)$).

**Checks (computed).** `h452_check.py` (pattern states) and `h457_odd.py` (odd states) fit (C) exactly (Fraction elimination), rebuild $Y, Z$ at every vertex from the formulas of Theorem P, check alternation and $(a,b)$ values on every line, separability with common $p,q,r$, and the chain inequality: 7/7 pattern states on (2,2,2), (2,4,6), 54/54, 56/56, 59/59 odd states on (2,2,2), (2,2,4), (2,4,6), and the (4,6,10) samples of §4: all pass.

## 2. D2: Theorem V by hand

**Theorem V.** Let $(a,b,c)$ be a member, and take a solution of the type model with $X(v) = X(v') = 1$, $Y(\beta) = Y(\beta') = 1$, $Y(\gamma) = Y(\gamma') = 0$. Then $p_A$ is constant, $p_B(1) - p_B(3) = 2$, and consequently B has no vertex of type $x$, the B-plane $x=1$ is entirely of type $y$ and the B-plane $x = 3$ entirely of type $z$. In particular (V′) holds.

*Step 1 (the rod line).* $v$ and $v'$ lie on one A $x$-line with opposite $\pi$, and both have $X = 1$, so $a^A_x(0,0) = 1$ (P1), i.e. $q_A(0) = r_A(0)$. The chain inequality gives $r_A(0) \le \min p_A \le \max p_A \le q_A(0) = r_A(0)$: **$p_A \equiv c$ is constant**, and $a^A_y$ depends on $z$ only, $a^A_z$ on $y$ only, with $a^A_y(0) = a^A_z(0) = 0$.

*Step 2 (integral lines through the origin).* Since $a^A_y(x,0) = 0$ for all $x$, $b^A_y(x,0) = 0$: at the A vertices $(x,y,0)$, $E^A_x(x,+) = E^A_z(0,\xi(x))$. So **$E^A_x(n,+) = E^A_z(0,+) =: \kappa$ for $n \equiv 0$** and $E^A_x(n,+) = E^A_z(0,-) =: \lambda$ for $n \equiv 2 \pmod 4$. From $a^A_z(x,0) = 0$ at the vertices $(x,0,z)$: $E^A_y(0,\xi(x)) = E^A_x(x,\xi(x))$, so **$E^A_x(n,-) = E^A_y(0,-) =: \mu$ for $n \equiv 2$**.

*Step 3 (identity ★).* With the classes of the four bridgeheads — $\beta$: $(+,+,+)$, $\pi=+$; $\beta'$: $\xi=+,\eta=\zeta=-$, $\pi=-$; $\gamma$: $\xi=-,\eta=+,\zeta=-$, $\pi=+$; $\gamma'$: $\xi=\eta=-,\zeta=+$, $\pi=+$ —
$$Y(\beta)+Y(\beta')-Y(\gamma)-Y(\gamma') = [p_B(1)-p_B(3)] + [D^B_x(1) - S^B_x(3)] + [S^B_z(-1) - D^B_z(1)],$$
the $a$ terms giving $\tfrac12(p(1)-r(1)) + \tfrac12(p(1)-r(-1)) - \tfrac12(p(3)-r(-1)) - \tfrac12(p(3)-r(1))$. By the coupling the brackets are $D^A_x(0) + S^A_x(4)$ and $-S^A_z(0) - D^A_z(0) = -2E^A_z(0,+)$. The left side is 2, so
$$p_B(1) - p_B(3) = 2 - E^A_x(0,+) + E^A_x(0,-) - E^A_x(4,+) - E^A_x(4,-) + 2E^A_z(0,+) = 2 + E^A_x(0,-) - E^A_x(4,-)\qquad(\star)$$
by Step 2. (In type form, with $b(x,z) = \tfrac12\pi(v)(Y(v) - Y(v+4e_y))$: $2a^B_y(1,z') - 2a^B_y(3,z') = 2 + b(0,z_0) - b(4,z_0) - b(0,0) - b(4,0)$ for any odd $z'$ and $z_0 \equiv 2$; this is linear and was verified as an identity on the solution space, §6.)

Since $p_B$ has spread at most 2, (★) gives $E^A_x(4,-) \ge E^A_x(0,-)$, and **(V) follows as soon as $E^A_x(0,-) = E^A_x(4,-)$**: then $p_B(1) = p_B(3) + 2$, the chain inequality on B forces $r_B \equiv p_B(3)$ and $q_B \equiv p_B(1) = r_B + 2$, so $a^B_x = (2 + r - q)/2 \equiv 0$, $a^B_y(1,\cdot) = 1$ and $a^B_z(3,\cdot) = (q - p(3))/2 = 1$.

*Step 4 (the generic case).* If some $z_0 \equiv 2 \pmod 4$ has $a^A_y(z_0) \in \{0,1\}$, then at the vertices $(n,y,z_0)$, $n \equiv 0$ (class $(+,-,-)$), $b_y = E^A_x(n,-) - E^A_z(z_0,-) = 0$, so $E^A_x(\cdot,-)$ is constant on $n \equiv 0$ and we are done. The same if some $y_0 \equiv 2$ has $a^A_z(y_0) \in \{0,1\}$ (vertices $(n,y_0,z)$: $b_z = E^A_y(y_0,+) - E^A_x(n,-) = 0$).

*Step 5 (the special case).* Otherwise $a^A_y(z) = \tfrac12$ for every $z \equiv 2$ and $a^A_z(y) = \tfrac12$ for every $y \equiv 2 \pmod 4$. On A this gives (each from the parity rule in one class):

- (A3) class $(+,-,-)$: $a_x = 0$, so $E^A_z(z,-) = E^A_y(y,+) =: \tau$ for all $y, z \equiv 2$;
- (A4) class $(+,-,-)$: $E^A_x(n,-) = \tau \pm \tfrac12$ for $n \equiv 0$;
- (A5) class $(-,+,-)$ ($x\equiv 2$, $y \equiv 0$, $z \equiv 2$): $E^A_z(z,+) = \mu + \tfrac12\psi(z)$, $\psi = \pm1$, for $z \equiv 2$;
- (A6) class $(-,-,+)$: $E^A_y(y,-) = \lambda + \tfrac12\varphi(y)$, $\varphi = \pm1$, for $y \equiv 2$;
- (A7) for $n \equiv 0$: $E^A_z(n,+) - \kappa$ and $E^A_z(n,-) - \lambda$ (classes $(+++)$ and $(-,-,+)$) are both 0 or both $\pm\tfrac12$ (their size is $\tfrac12[a^A_y(n) = \tfrac12]$); likewise $E^A_y(n,+) - \kappa$ and $E^A_y(n,-) - \mu$.

By (A4), $E^A_x(0,-) - E^A_x(4,-) \in \{-1,0,1\}$. The value 1 would give $p_B(1) - p_B(3) = 3$ in (★), impossible; the value 0 finishes by Step 3. Suppose it is $-1$: $E^A_x(0,-) = \tau - \tfrac12$, $E^A_x(4,-) = \tau + \tfrac12$, and $p_B(1) - p_B(3) = 1$. We show that each of $p_B$, $q_B$, $r_B$ takes both parities; their spreads then add to at least 3, against P2.

(F1) From the coupling and Step 2: $E^B_x(1,\sigma) - E^B_x(5,\sigma) = \tfrac\sigma2(D^A_x(0) - D^A_x(4)) - \tfrac12(S^A_x(2) - S^A_x(6)) = \tfrac\sigma2$ and $E^B_x(3,\sigma) - E^B_x(-1,\sigma) = \tfrac\sigma2(D^A_x(2) - D^A_x(-2)) - \tfrac12(S^A_x(4) - S^A_x(0)) = -\tfrac12$, for both $\sigma$.

(Pinning.) Take a B-plane $z'$ and a class of B containing it with $\xi = +$. The B vertices $(1,y,z')$ and $(5,y',z')$ are in that class and have $b_y$ values $E^B_x(1,\zeta) - h$ and $E^B_x(5,\zeta) - h$, $h = E^B_z(z',\xi\zeta)$, which differ by $\pm\tfrac12$ by (F1) and both lie in $\{0,\pm\tfrac12\}$; so $h \in \{E^B_x(1,\zeta), E^B_x(5,\zeta)\}$. The same with the planes $3, -1$ for classes with $\xi = -$, and with $E^B_y$ in place of $E^B_z$ (via $b_z$). For $z' \equiv 1$ (classes $(+++)$ and $(-,-,+)$) this gives $E^B_z(z',+) \in E^B_x(1,+) + \{0,-\tfrac12\}$ and $E^B_z(z',-) \in E^B_x(-1,+) + \{0,-\tfrac12\}$; since $E^B_x(1,+) - E^B_x(-1,+) = \kappa - \lambda$ (coupling),
$$D^A_z(z'-1) = D^B_z(z') \in \kappa - \lambda + \{-\tfrac12, 0, \tfrac12\}.$$
By (A7), $D^A_z(n) - (\kappa - \lambda) \in \{0,\pm1\}$ for $n \equiv 0$, so it is 0. For $z'' \equiv 3$ (classes $(+,-,-)$, $(-,+,-)$), $E^B_z(z'',-) \in E^B_x(1,-) + \{0,\tfrac12\}$, $E^B_z(z'',+) \in E^B_x(-1,-) + \{0,-\tfrac12\}$, $E^B_x(1,-) + E^B_x(-1,-) = -\kappa - \lambda$, so $-S^A_z(z''+1) = S^B_z(z'') \in -\kappa - \lambda + \{-\tfrac12,0,\tfrac12\}$, and by (A7) $S^A_z(n) = \kappa + \lambda$. Together: **$E^A_z(n,+) = \kappa$, $E^A_z(n,-) = \lambda$ for every $n \equiv 0$**. The same argument with $E^B_y$ (classes $(+++)$, $(-,+,-)$ for $y' \equiv 1$; $(+,-,-)$, $(-,-,+)$ for $y'' \equiv 3$; $E^B_x(1,+) - E^B_x(-1,-) = \kappa - \mu$, $E^B_x(1,-) + E^B_x(-1,+) = -\kappa - \mu$) gives $E^A_y(n,+) = \kappa$, $E^A_y(n,-) = \mu$ for every $n \equiv 0$.

(Parities.) Let $z' \equiv 1$ and $n = z'+1 \equiv 2$. At $x' = 1$ the vertex $(1,\cdot,z')$ is in class $(+++)$ and $(1,\cdot,z'+2)$ in class $(+,-,-)$. By the coupling, (A3), (A5) and the previous paragraph,
$$E^B_x(1,+) - E^B_z(z',+) = \tfrac14(1+\psi(n)),\qquad E^B_x(1,-) - E^B_z(z'+2,-) = \tfrac14(\psi(n) - 1).$$
Exactly one of them is $\pm\tfrac12$, so by the parity rule exactly one of $r_B(z')$, $r_B(z'+2)$ has the parity of $p_B(1)$: **$r_B$ takes both parities.** Likewise, with $y' \equiv 1$, $n = y'+1$: $E^B_y(y',+) - E^B_x(1,+) = -\tfrac14(1 + \varphi(n))$ and $E^B_y(y'+2,+) - E^B_x(1,-) = \tfrac14(1 - \varphi(n))$, so **$q_B$ takes both parities**. And $p_B(1) - p_B(3) = 1$: **$p_B$ takes both parities**. The spreads add to at least 3. Contradiction. $\square$

**What the proof uses.** (C) and (S1) (two chains per pair of planes for all three axes); integrality once, through P1 (values $\{0,\tfrac12,1\}$ and the parity rule); non-negativity through the chain inequality; the torus only through the existence of the vertex classes on planes $1, 5, 3, -1$ (so $4a \ge 8$) and through the profiles being defined on whole circles. It does not use Lemma 6, Theorem $M'$, any certificate or any solver verdict. Of the pattern it uses $X(v) = X(v') = 1$, $Y(\beta) = Y(\beta') = 1$, $Y(\gamma) = Y(\gamma') = 0$ only (the types $z$ of $\gamma,\gamma'$ are a conclusion). The case analysis is on the values of profiles: generic (a $z\equiv2$ plane with integral $y$-fraction, or a $y \equiv 2$ plane with integral $z$-fraction) against special, and in the special case on the sign of $E^A_x(0,-)-E^A_x(4,-)$.

**Other positions and axes.** Theorem V is for the A-hole with $y$-bridgeheads below. The inversion $w \mapsto (1,1,1) - w$ (B-holes), the reflection $x \mapsto 4 - x$ (sides exchanged) and the exchange $y \leftrightarrow z$ (cell $(a,c,b)$, a member) map every other position to this one on a member, and a permutation of the coordinates maps rods along $y$ or $z$ to rods along $x$ on a member. So (V′) holds for every unoriented cage of every member.

## 3. D3: Theorems U and H on the family

**Theorem U on the family (proved, given the record).** Let a frozen state of a member have an unoriented hole. Its type field is a solution of the type model containing an unoriented cage, which after a symmetry is the standard one on a member. By Theorem V the other sublattice has no vertex of the rod type, and the rods' sublattice has one, so Theorem $M'$ gives even curl. Hence in an odd state every straight hole is oriented, and corners are oriented by Lemma 2: every hole is oriented, which is Theorem U (unoriented = charged by the cage enumeration of Lemma 3).
Dependencies: (C) (record; re-checked by modular rank on six members, §6); (S1) (check4, oddtwo Lemma A); Lemma 3's enumeration and Lemma 2 (note); Theorem $M'$ (record; confirmed on every cell by check6; its proof has DRAT-certified window lemmas, check7's correction 1).

**Theorem H (proved given the record, for $a', b', c' \ge 2$).** Theorem 1′ (noncubic audit; confirmed as a conditional by check6 §2): on a cell where $K_u$ holds for uniform chains of all three axes, Theorem U implies H. $K_u$'s first step (P1) covers the slab for chains of an axis when the gcd of the two transverse extents is at most 2 (check6 §3.2), which is every axis of every member. The recorded scope of the window lemmas is extents 3, 4, 4 in the chain's frame (note, 'The statement'; check6 §3.1 table), with 3 the extent along the chain; on a member all extents are even, so this is: every extent at least 4, i.e. $a',b',c' \ge 2$. So H holds on (4,6,10), (4,6,14), (4,10,14), (6,8,10), (6,10,14), (4,10,18), … and all permutations. Dependencies: Theorem U above; Theorem 1′; $K_u$'s certificates, automata and hand steps (not re-run by me).

**Thin members.** (2,2,2), (2,2,4), (2,2,6), (2,4,6), (2,6,10), (2,10,14), … have an extent 2. Theorem U holds on them (the proof above has no size condition beyond $4a \ge 8$, and (C) was re-checked by rank on five of them). Theorem H is **not covered**: the record states $K_u$ for extents at least 3, 4, 4, and nothing in the record checks it on a cell with an extent 2. check6's remark C2 (a window CNF of the infinite lattice pulls back to every torus, so the extent bounds are conservative) would cover them, together with a reading of Theorem 1′'s steps on a cell with 8 planes along one axis; I did not do that reading, and the attack proposal's caveat 4 flags the definitions on cells of extent 2.

## 4. D4: odd states of the family

Samples: `h451_sample.py CELL odd` (type model + sign field + 'some hexagon odd', random assumptions, no condition on types or directions). Analysis `h457_odd.py`, `h459_d4stats.py` (exact).

(4,6,10): sampling is slow there (random assumption literals; one batch of 30 queries hit its 290 s cap with 27 queries unanswered, which are no verdict), so only 8 distinct odd states: 4 with three types (all with exactly one constant profile, the same on A and B, that axis one-way and its E 4-periodic; slack 100010 twice, 001010 twice), 4 with an empty axis. D1 checks pass on all 8. The three cells with at least 20 states each are (2,2,2), (2,2,4), (2,4,6).

| cell | states | three types on A and on B | an axis empty | A and B same slack (3 types) | exactly one constant profile, same on A and B | that axis one-way | its E 4-periodic on A and B | all three axes two-way |
|---|---|---|---|---|---|---|---|---|
| (2,2,2) | 54 | 40 | 14 | 40/40 | 39/40 (one with two constant, 'pr') | 39/39 | 39/39 | 0 |
| (2,2,4) | 56 | 42 | 14 | 42/42 | 41/42 (one 'pq') | 41/41 | 41/41 | 0 |
| (2,4,6) | 59 | 45 | 14 | 45/45 | 45/45 | 45/45 | 45/45 | 0 |

What distinguishes the odd states with three types, in profile terms (**computed** on these samples; the classification of slack vectors is **proved** in §1, the frequencies are data):

- **Slack.** Always two units: the three-type slack vectors are $(1,0,1,0,0,0)$ ($r$ and $p$ spread 1, $q$ constant), $(1,0,0,0,1,0)$ ($p$ constant), $(0,0,1,0,1,0)$ ($r$ constant), and twice a gap version ($(0,1,0,0,1,0)$, $(1,0,0,1,0,0)$, two constant profiles). A and B have the same slack vector in every three-type sample. So in a three-type odd state exactly one coordinate (typically) has a constant profile on both sublattices, and the other two have spread 1: their line fractions are $\tfrac12$ on the planes where the profile takes its odd value.
- **Axes.** The axis $k$ whose coordinate profile is constant is one-way (never two-way, never empty) in every such sample; the other two axes are each one-way or two-way in all combinations (OOO, OOT, OTO, TOO, TOT, TTO, OTT occur). Its E-functions $E_k(\cdot,\pm)$ are 4-periodic on both sublattices (gauge invariant: constant on each residue class of planes mod 4).
- **States with an empty axis** have two types on each sublattice, a single slack of 2 or two units with a gap, and sometimes different slack vectors on A and B (e.g. $(0,0,0,0,2,0)$ against $(0,0,0,0,1,1)$).
- No sampled state has all three axes two-way (a sample, not a test of H).

**What Theorem V used, for package E.** A constant profile along the rod axis ($p_A$, from the complete rod line); the integrality of the lines $z=0$ and $y=0$ through the rods; the four bridgeheads through one linear identity; and a parity count on B that needs each of $p_B,q_B,r_B$ to take both parities, which is impossible because the spreads add to at most 2. At $L$ chains per slab the analogue of P1 is an $L$-periodic pattern along lines with fractions in $\tfrac1L\mathbb Z$ (for prime $L$), and the 'spreads add to at most 2' becomes a budget in units of $\tfrac1L$; the parity argument would have to become an argument on residues mod $L$.

**Conjecture D4.** On a member, in an odd frozen state with three types, one coordinate profile is constant on both sublattices and the corresponding axis is one-way. If proved, H follows on the whole family, thin members included, without $K_u$.

## 5. D5: cells with gcd(b,c) = 2 and other gcds larger

Every step used the two-chain form for all three axes: Step 1 needs $X$-lines to alternate, and $X = a_x + \pi(E_z - E_y)$ involves the chains of axes $y$ and $z$; (★) uses $E^B_z$, i.e. two chains of axis $z$ per slab ($\gcd(a,b) = 2$); Step 4 compares $E_x$ with $E_z$ and $E_y$; Step 5 uses $E_y$, $E_z$ on planes $\equiv 0, 2 \pmod 4$. On (4,4,6) and (8,4,6), with rods along $x$, $\gcd(b,c) = 2$ but $\gcd(a,b) = 4$: four chains of axis $z$ per pair of planes, so $F_z$ has components in the characters of $\mathbb Z_4$, $Y$ and $X$ are not of the form $a + \pi b$, and fractions $\tfrac14$ are possible. Solver (h458): on (4,4,6) some A $y$-line is not 8-periodic (SAT, 0.2 s), so Corollary P1 fails there; (V′) is nevertheless UNSAT on (4,4,6) (1.8 s) and (8,4,6) (6.4 s). So the proof does not extend as it stands; it would need the four-character version of Theorem P for axis $z$ (this is package E's situation, at $L = 4$ for one axis).

## 6. Computations

From `scratch_h`, `.venv/bin/python`, `PYTHONPATH=<repo>:<repo>/experiments/08_frozen_structure`, `TMPDIR=<repo>/.tmp`. SAT through `h32_cap` (`one`, `run_batch`), cap ≤ 300 s; no query hit its cap.

| command | what it tested | verdict | wall |
|---|---|---|---|
| `h451_sample.py 2,2,2 pat 10 60`, `2,4,6 pat 10 60` | pattern states (type model) | 3 and 4 distinct states | 1.7 s each |
| `h452_check.py h451_pat_222.json h451_pat_246.json --show` | D1 formulas, lines, separability, chain inequality | 7/7 pass; all fractions integral | 1.1 s |
| `h453_query.py 2,2,2 60`, `2,4,6 60` | ctrl, Vp, V4, A3, AF, BF, odd, G1, G3 | ctrl SAT; V4 SAT; all others UNSAT (both cells) | 3.5 s, 4.6 s |
| `h454_star.py 2,2,2 2,4,6`; `2,2,4 2,2,6 4,6,10 2,6,10` | (★) as exact linear identity, (C) by modular rank; controls | 48/48 + 20/20 HOLDS 0; controls CONSTANT 2 and NOT CONSTANT on every cell | 0.5 s; 13 s (log `.tmp/h454.log`) |
| `h455_special.py 2,2,2 60 10`, `2,4,6 60 10`, `4,6,10 120 8`, `2,2,6 60 8` | special case: control S, lemma S+L, S+bridgeheads; facts A1–A6 and θ constant on models of S | S SAT (5, 11, 8, 7 states), S+L UNSAT, S+br UNSAT; all facts hold | 1.9, 1.8, 16, 1.7 s |
| `h456_algebra.py` | sympy re-derivation of (F1), pinning sums, parity differences | ALL OK | 0.6 s |
| `h451_sample.py CELL odd 60 120` on (2,2,2), (2,2,4), (2,4,6) | odd frozen states | 54, 56, 59 distinct | 0.3, 0.5, 3.2 s solver |
| `h451_sample.py 4,6,10 odd 4 120`; `4,6,10 odd 29 290 1` | odd frozen states | 5; 3 (27 of 30 queries unanswered at the 290 s batch cap) | 37 s; 290 s |
| `h457_odd.py …`, `h459_d4stats.py …` | D4 description; D1 checks on odd states | tables of §4 | < 5 s per cell |
| `h458_d5.py 120` | D5: (V′) on (4,4,6), (8,4,6); period 8 on (4,4,6) | UNSAT, UNSAT; SAT | 9.9 s |
| `h460_weak.py 2,4,6 60`, `4,6,10 120` | a test of the proof: pattern with $\gamma,\gamma'$ only 'not of type $y$'; W1 + B has $x$; W2 + $\gamma$ of type $x$ | W0 SAT; W1, W2 UNSAT on both | 1.5 s, 6.5 s |
| `h451_sample.py 4,6,10 pat 10 200`; `h452_check.py h451_pat_4610.json` | pattern states on (4,6,10), D1 checks | 2 states, 2/2 pass | 2.1 s, 0.5 s |

## 7. What failed, and why

1. **A wrong step in my first version of step 5.** I first derived that the deviations $u_z \pm u'_z$ on planes $z\equiv 0$ vanish from 'every $\delta_z = \pm1$' in one class; that does not follow, because a deviation of $\pm2$ can be compensated by $\psi$. The correct argument uses both classes of B containing a plane (the pinning paragraph), which is what the proof above does, and the conclusion was then re-checked symbolically (h456).
2. **Theorem 11's route at even length.** In profile terms its first step is (★), and its missing piece (the vertex $P$) is the equality $E^A_x(0,-) = E^A_x(4,-)$. No linear argument gives it (the LP is positive, gtwo); it is exactly where integrality enters, through the quadrant argument of Step 4 and the parity count of Step 5.
3. **Special case not observable.** The special case never occurs in pattern states (AF UNSAT), so Step 5 could not be checked on solutions; it was checked by realising the special case without the bridgeheads (h455: non-vacuous control, the lemma UNSAT, facts A1–A6 exact on 31 states) and by symbolic algebra.

## 8. Rules

- **Broken: one solver process at a time.** `h458_d5.py` (three queries, 9.9 s in all) ran while the background sampler `h451_sample.py 4,6,10 odd 29 290 1` was still solving. I noticed afterwards; no other overlap. No verdict depends on timing.
- One Bash call ran `python -` with stdin empty (a slip; it did nothing). No heredoc was used.
- I edited my own new script `h457_odd.py` once with `sed -i` (output format). No existing file was touched.
- No heredocs; nothing written to /tmp (scratch outputs in `<repo>/.tmp`). H, 'odd and all six directions', or anything equivalent to H was not run. The D4 samples ask for 'some hexagon odd' only.

## 9. The main loop's starting point

- The form $F_x = \Phi(x) + \pi[\delta_x(-1)^{z/2} + \delta'_x]$ on A is **right**, with $\delta_x = e_{01}$ (pair of planes above), $\delta'_x = e_{23}$ (below). 'The same form for $F_y$, $F_z$ with the coordinates permuted cyclically' is right with the chain signs of §0; with the other natural sign for $\{0,2\}$ (constant $x - z$ read as $(x+y-z)/4$) the factor is $(-1)^{z/2}$, not $(-1)^{x/2}$, which is the same up to relabelling $e_{02}(y) \to (-1)^{y/2}e_{02}(y)$.
- 'A takes the values 0, 1/2, 1', 'a line with fraction 1/2 alternates', 'period 8', 'the rod line is all of type $x$ at once': all **right**.
- 'Nine functions of one coordinate on each sublattice': right as a count, but they are **not independent between sublattices**: the six E-functions of B are those of A shifted by one plane, $E^B_k(n',\sigma) = \tfrac12(\sigma D^A_k(n'-1) - S^A_k(n'+1))$ (the $e_{k-}$ part with a sign change), while the three a-profiles of B are independent of those of A. The B form is $F_x = \Phi^B_x(x) + \pi_B[(-1)^{(z-1)/2}e_{01}(x-1) - e_{23}(x+1)]$ with $\pi_B = (-1)^{(x+y+z-3)/4}$.
- Nothing else was wrong.
