---
title: "Machine-checkable certificates for the finite results, and the frozen census at the first cubic cell"
date: 2026-09-04
---

# Subagent report: certificates, SAT and certified counting (2026-09-04)

**Provenance.** Written by an implementation/numerics subagent (Claude Fable
5.1, high effort), dispatched by the Fable main loop on 2026-09-04. All
compute was local, on `spark-709c` (GB10, aarch64, 20 cores); no ARC or
Isambard time was used, so no HPC acknowledgement is owed. Every number in
this report is read from
`experiments/07_certificates/results/results.json` (rendered as
`results/summary.md` by `make_summary.py`); nothing is quoted from memory
and no number is recomputed in prose.

**Files added.** `icemix/cnf.py` (the encoding and the certificate helpers),
`experiments/07_certificates/run_certificates.py` and `make_summary.py`,
`tests/test_cnf.py`, and this report. Nothing existing was edited.

---

## 0. Bottom line

| # | claim | status | what establishes it |
|---|---|---|---|
| 1 | The CNF encoding reproduces the project's counts exactly | **PASS** | SAT enumeration vs `icemix.enumerate` (DFS) vs the frontier DP: 90 / 3,618 / 181,122 ice, 12 / 388 / 15,024 `W = 0`, 12 / 68 / 528 frozen, plus 221,628 and 204 at (1,2,2) — and the *state sets*, not merely the counts, are identical |
| 2 | **Theorem 1** — every `W = 0` state of (1,1,1) is frozen | **CERTIFIED** | CaDiCaL says UNSAT; the DRAT proof (996 bytes) is accepted by `drat-trim`, and an LRAT proof by `lrat-check` |
| 3 | **Theorem 2** — translation-invariance forces frozen | **CERTIFIED at 5 cells × 3 axes** | 15 UNSAT DRAT proofs, all `s VERIFIED` by `drat-trim`, at (1,1,2), (1,2,2), (2,2,2), (3,3,3) and (4,4,4); no `W = 0` constraint is used, so this certifies the "in every flux sector" form |
| 4 | The certificates are falsifiable | **PASS** | 4 negative controls, each dropping one constraint, all SAT with a model that icemix and the C flip kernel both certify as a *flippable* ice state |
| 5 | Certified model counts | **19 of 20 formulas CERTIFIED** | CPOG builds on aarch64 (recipe in §5.2, one real patch needed); `cpog-check` certifies 90 / 12 / 12, 3,618 / 388 / 68, 181,122 / 15,024 / 528, 204, and — new — **612** at (2,2,2) and **968** at (1,2,3). The one failure is a `d4` timeout at (3,3,3), not a disagreement |
| 5b | The stage-4b three-bond obstruction rests on certified counts | **NEW** | `N = 90`, `n_i = 45`, `n_{15,0} = 15`, `n_{0,1} = 15`, `n_{1,15} = 25`, each a certified model count, reproducing stage 4b §3.3 exactly |
| 6 | Frozen `W = 0` census at the first cubic cell (2,2,2), 128 bonds | **NEW: 612 states** | frozen-constrained SAT enumeration, every state re-verified by icemix and the C kernel, and the count independently **certified** by CPOG |
| 7 | (2,2,2) has **no aperiodic** frozen `W = 0` state | **NEW** | minimum stabiliser order 2 under the 32 FCC translations — in contrast with (1,1,2) (16 of 68 aperiodic) and (1,2,3) (336 of 968) |
| 8 | Neither theorem, nor tiling, exhausts the frozen set at (2,2,2) | **NEW** | 108 in the Theorem 2 family, 420 are tilings of smaller frozen states, and **192 are neither** |
| 9 | Frozen `W = 0` census at (1,2,3), 96 bonds | **NEW: 968 states** | same route; 440 in the family, 584 tilings, 384 neither, 336 aperiodic |

Nothing here changes the measurement or any headline of the note. Items 2
and 3 upgrade the two frozen-state theorems from "hand proof, checked
numerically" to "hand proof, plus a proof object a third party can check
without running any of this code". Items 6–9 are new facts about the
frozen set at the smallest cubic cell, previously out of reach because
`icemix.enumerate` is capped at 64 spins and (2,2,2) has 128.

---

## 1. Pre-flight (measured, then multiplied out)

Every launch was timed on one unit first, as the operating rules require.

| work | unit timing | projection | actual |
|---|---|---|---|
| SAT enumeration, (1,1,2) ice | 3,618 models in 0.07 s | ≈ 50 k models/s | (1,1,3) ice 181,122 in 21.5 s |
| SAT enumeration, (1,2,2) `W = 0` | scaled from the above | ≈ 30 s | 54.3 s |
| (2,2,2) frozen census | 612 models in 2.1 s (probe, exhausted the search) | seconds | 4.2 s |
| (1,2,3) frozen census | 968 models in 0.2 s (probe) | seconds | 0.3 s |
| Theorem 2 certificate, (3,3,3) | probe: solve 0.012 s, check 0.13 s | seconds | 0.05 s / 0.29 s |
| Theorem 2 certificate, (4,4,4) | probe: 1,024 bonds, 25,601 clauses | seconds | solve 0.10 s, check 0.32 s |

Two probes were *stopped* on the pre-flight rule rather than run to
completion; both are recorded in §7 as things not done. Nothing was
launched without a timing first, and the two runs that exceeded a minute
(`certABD`, `certCD`) went into named `tmux` sessions with canonical
exptop feeds (§8).

---

## 2. The encoding (`icemix/cnf.py`)

One CNF encoding serves all four items. The Boolean variables **are** the
arrow bits: bond `e` is DIMACS variable `e + 1`, true iff the arrow points
from the A-end to the B-end (`icemix.lattice`'s convention). Auxiliary
variables live above `n_bonds` and are never projected on.

**(1) Ice rule.** `icemix.enumerate`'s docstring proves that "exactly 2 of
the 4 incident arrows point in" reduces at *both* sublattices to "exactly 2
of the 4 incident bits are set". Exactly-2-of-4 is 8 clauses with no
auxiliaries: forbid any three true, forbid any three false.
`test_exactly_two_of_four_is_eight_clauses_and_correct` checks all 16
assignments.

**(2) `W = 0`.** Flux is conserved, so one cut plane per axis suffices. The
plane `x_j = 1/2` (in `a/4` units) is a good choice because A-sites have
even coordinates: the only bond segments covering `1/2` leave an A-site at
`x_j = 0` with `sgn(d_j) = +1`. There are exactly `4·abc/cells_j` of them
and **every one carries `+1`**, so the signed flux is `2·popcount −
n_cross` and `W_j = 0` is the single cardinality constraint "exactly half
of them set" (pysat `CardEnc.equals`, sequential-counter encoding). That
this cut-plane flux equals `icemix.enumerate.winding` bit for bit is
*checked, not assumed*, over every ice state at (1,1,1), (1,1,2) and
(1,1,3) — `cut_plane_equals_winding: true` in `part_A.json`, and again in
`tests/test_cnf.py::test_cut_plane_flux_equals_the_winding_formula`.

**(3) Hexagon flippability.** Walking a hexagon in cycle order the
traversal alternates with respect to the bond's own A→B orientation, so
flippability is "the six bits in cycle order alternate": positions 0, 2, 4
all `b` and 1, 3, 5 all `1 − b` (`icemix.chain`). "Frozen" is then two
6-clauses per hexagon (block each pattern), with no auxiliaries at all;
"hexagon `h` is flippable" is a selector `s_h ↔ (P_A ∨ P_B)` via two
definitional auxiliaries, and "some hexagon flippable" is one clause over
the selectors. The encoding was cross-checked against
`icemix.chain.flippable_ref` — the reference implementation written
directly from the definition, no bit tricks — over every hexagon and a
sample of ice states: **0 mismatches** at (1,1,1) (90 states × 16
hexagons), (1,1,2) (200 × 32) and (1,1,3) (200 × 48).

**(4) Translation invariance.** `x_e ↔ x_{perm(e)}` from
`icemix.frozen.translation_perm`, two clauses per bond.

Formula sizes (from `part_A.json` / `part_B.json`):

| formula | cell | vars | clauses |
|---|---|---|---|
| ice | (1,1,1) | 16 | 64 |
| ice ∧ `W = 0` | (1,1,1) | 40 | 112 |
| ice ∧ `W = 0` ∧ frozen | (1,1,1) | 40 | 144 |
| ice ∧ `W = 0` ∧ some flippable (Theorem 1) | (1,1,1) | 88 | 385 |
| ice ∧ `W = 0` ∧ frozen | (2,2,2) | 512 | 1,536 |
| ice ∧ 2 translations ∧ some flippable | (4,4,4) | 4,096 | 25,601 |

---

## 3. Item A — the two-method count gate

Mandatory gate: SAT enumeration (blocking clauses **on the bond variables
only**, so no auxiliary can split one state into several models) against
`icemix.enumerate`. Where both materialise states, the *sets* are compared,
not just the counts.

| cell | quantity | SAT enumeration | `icemix` DFS | known | state sets identical | SAT s |
|---|---|---|---|---|---|---|
| (1,1,1) | ice | 90 | 90 | 90 | yes | 0.02 |
| (1,1,1) | `W = 0` | 12 | 12 | 12 | yes | 0.00 |
| (1,1,1) | frozen `W = 0` | 12 | 12 | 12 | yes | 0.00 |
| (1,1,2) | ice | 3,618 | 3,618 | 3,618 | yes | 0.11 |
| (1,1,2) | `W = 0` | 388 | 388 | 388 | yes | 0.02 |
| (1,1,2) | frozen `W = 0` | 68 | 68 | 68 | yes | 0.00 |
| (1,1,3) | ice | 181,122 | 181,122 | 181,122 | yes | 21.53 |
| (1,1,3) | `W = 0` | 15,024 | 15,024 | 15,024 | yes | 1.22 |
| (1,1,3) | frozen `W = 0` | 528 | 528 | 528 | yes | 0.04 |
| (1,2,2) | `W = 0` | 221,628 | 221,628 | 221,628 | yes | 54.32 |
| (1,2,2) | frozen `W = 0` | 204 | 204 | 204 | yes | 0.04 |

A **third** method is run at every cell: the frontier DP
(`enumerate.frontier_count`), which counts without materialising a single
state. It returns 90 / 3,618 / 181,122 / **2,891,562**, matching the known
ice counts including (1,2,2)'s, whose 2.89 M states were deliberately not
SAT-enumerated (≈ 5 min for no extra information; the registered gate asks
only for (1,2,2)'s `W = 0` and frozen counts).

A sample of up to 50 models of every formula was re-verified with
`enumerate.ice_rule_ok_int`, `enumerate.winding_int` and the C kernel
`msc_scalar_nflip`: the kernel reports 0 flippable hexagons on every model
of a frozen formula and a positive count on the others. (In item D, by
contrast, *every* state of every census is re-verified, not a sample.)

**Gate: PASS, all eleven rows, exactly.**

---

## 4. Item B — UNSAT certificates

CaDiCaL rel-3.0.1 (`--binary=false`, exit 20 = UNSAT) writes a DRAT proof;
`drat-trim` checks it and must print `s VERIFIED`. All artefacts —
`.cnf`, `.drat`, and the checker's own stdout — are kept under
`experiments/07_certificates/results/certificates/`, so the claims can be
rechecked without running any project code.

### 4.1 Theorem 1

`(1,1,1)`: ice ∧ `W = 0` ∧ (some hexagon flippable).

| | |
|---|---|
| formula | 88 vars, 385 clauses, 4,121-byte CNF |
| solver | CaDiCaL rel-3.0.1, **UNSAT** in 0.017 s |
| DRAT proof | 996 bytes |
| checker | `drat-trim`, **`s VERIFIED`**, 0.274 s |
| LRAT proof | 6,293 bytes, `lrat-check` **VERIFIED**, 0.030 s |

Both proof formats were produced and both checkers accepted, so the claim
does not rest on one checker.

### 4.2 Theorem 2

Per cell and per axis: ice ∧ (invariant under both half-diagonals
perpendicular to that axis) ∧ (some hexagon flippable). **No `W = 0`
constraint is imposed** — which is the point: the certificate establishes
the theorem in the form "frozen in *every* flux sector", not merely in the
zero sector.

| cell | axis | clauses | solver | DRAT bytes | solve s | check s | `drat-trim` |
|---|---|---|---|---|---|---|---|
| (1,1,2) | x | 801 | UNSAT | 651 | 0.006 | 0.278 | VERIFIED |
| (1,1,2) | y | 801 | UNSAT | 667 | 0.015 | 0.171 | VERIFIED |
| (1,1,2) | z | 737 | UNSAT | 636 | 0.014 | 0.278 | VERIFIED |
| (1,2,2) | x | 1,601 | UNSAT | 1,377 | 0.018 | 0.273 | VERIFIED |
| (1,2,2) | y | 1,601 | UNSAT | 1,371 | 0.017 | 0.271 | VERIFIED |
| (1,2,2) | z | 1,601 | UNSAT | 1,345 | 0.005 | 0.275 | VERIFIED |
| (2,2,2) | x | 3,201 | UNSAT | 2,758 | 0.006 | 0.272 | VERIFIED |
| (2,2,2) | y | 3,201 | UNSAT | 2,776 | 0.006 | 0.274 | VERIFIED |
| (2,2,2) | z | 3,201 | UNSAT | 2,734 | 0.023 | 0.108 | VERIFIED |
| (3,3,3) | x | 10,801 | UNSAT | 9,876 | 0.051 | 0.290 | VERIFIED |
| (3,3,3) | y | 10,801 | UNSAT | 9,897 | 0.049 | 0.288 | VERIFIED |
| (3,3,3) | z | 10,801 | UNSAT | 9,850 | 0.048 | 0.291 | VERIFIED |
| (4,4,4) | x | 25,601 | UNSAT | 24,651 | 0.103 | 0.319 | VERIFIED |
| (4,4,4) | y | 25,601 | UNSAT | 24,672 | 0.017 | 0.137 | VERIFIED |
| (4,4,4) | z | 25,601 | UNSAT | 24,625 | 0.017 | 0.141 | VERIFIED |

The three (2,2,2) rows also carry LRAT proofs accepted by `lrat-check`.
(4,4,4) — 1,024 bonds, 1,024 hexagons — cost 0.10 s to refute and 0.32 s
to check, so the size ceiling here is nowhere near.

**One subtlety, recorded because it would otherwise make a control
vacuous.** The two half-diagonals perpendicular to `z` are `(2,2,0)` and
`(2,−2,0)`; modulo the box they *coincide* whenever the cell has extent 1
along `y` (`−2 ≡ 2 mod 4b` iff `b = 1`). That is why the (1,1,2) `z` row
has 737 clauses rather than 801: it imposes one translation, not two, and
is still UNSAT — correctly, since at `b = 1` the second translation is the
same permutation. `part_B.json` records
`translations_distinct_mod_box` for every row, and the negative control
for Theorem 2 was therefore placed at (2,2,2) and (3,3,3), where the two
are genuinely distinct.

### 4.3 Negative controls — the certificates can fail

Each drops exactly one constraint and must come back SAT with a model that
`icemix` *and* the C kernel independently certify as a flippable ice
state.

| control | cell | SAT | flippable hexagons (icemix / C kernel) | winding of the witness |
|---|---|---|---|---|
| drop `W = 0` | (1,1,1) | yes | 4 / 4 | (0, 0, −2) |
| drop the frozen clauses, keep `W = 0` | (1,1,2) | yes | 8 / 8 | (0, 0, 0) |
| drop one of the two half-diagonals (z) | (2,2,2) | yes | 32 / 32 | (0, 0, 0) |
| drop one of the two half-diagonals (z) | (3,3,3) | yes | 60 / 60 | (−6, −6, 12) |

The (1,1,1) control is the sharpest: with `W = 0` removed the same
formula is satisfiable, and its witness has winding `(0,0,−2)` — so the
UNSAT verdict for Theorem 1 really is *about* the flux constraint and not
an artefact of the encoding. The (2,2,2) and (3,3,3) controls show the
same for the *second* translation of Theorem 2; the test suite additionally
checks that the (2,2,2) witness really is invariant under the translation
that was kept.

---

## 5. Item C — certified model counting (CPOG on aarch64)

### 5.1 Outcome

**CPOG builds and works end to end on this machine.** The pipeline is

```
d4 FILE.cnf -dDNNF -out=FILE.nnf      # decision-DNNF compilation
cpog-gen -v 1 FILE.cnf FILE.nnf FILE.cpog
cpog-check -v 2 FILE.cnf FILE.cpog    # prints FULL-PROOF SUCCESS + the count
```

and `cpog-check`'s own line `CHECK: Regular model count = N` is the count
this report treats as certified. The run **never** labels a count
"certified" from `d4`'s raw output; `d4`'s number is recorded separately and
required to agree with the checked one, which is a second method on the
count itself.

Smoke tests before any use: `p cnf 3 1 / 1 2 3 0` → certified 7;
`p cnf 4 2 / 1 2 0 / -1 -2 0` → certified 8; a random 20-variable /
60-clause 3-CNF → certified 722, cross-checked against a plain
`itertools.product` brute force over all 2²⁰ assignments → 722.

### 5.2 The build recipe that worked (no sudo, aarch64)

Recorded verbatim so the main loop can turn it into a chezmoi
`run_onchange_` script. Everything lives under `~/.local/opt/<tool>/` with
symlinks in `~/.local/bin/`; `/usr` is untouched.

**Dependencies without root.** `apt-get download` is an HTTP fetch, not an
install, so headers can be unpacked into a private sysroot:

```bash
mkdir -p ~/.local/opt/sysdeps /tmp/cpogwork/debs && cd /tmp/cpogwork/debs
apt-get download libgmp-dev libmpfr6 libmpfr-dev zlib1g-dev \
  libboost1.83-dev libboost-iostreams1.83-dev libboost-program-options1.83-dev \
  libboost-filesystem1.83-dev libboost-serialization1.83-dev libboost-system1.83-dev
for f in *.deb; do dpkg-deb -x "$f" ~/.local/opt/sysdeps; done
```

**cpog** (commit `a97ed8543d8368a234f715cf8b1a7aa38bc96c3d`) — no patches
needed, pure C/C++11:

```bash
git clone --depth 1 https://github.com/rebryant/cpog ~/.local/opt/cpog
cd ~/.local/opt/cpog/src && make install     # -> cpog-gen, cpog-check
```

**d4** (crillab, commit `333370cc1e843dd0749c1efe88516e72b5239174`) — **one
real aarch64 blocker and its patch.** `d4/patoh/libpatoh.a` is a
*precompiled x86-64* static archive (confirmed with `file` on its extracted
objects), used only by the optional `CB`/`VB` bipartite-graph partitioning
heuristics. It cannot link on aarch64. Three edits remove it:

1. `Makefile`: `CSRCS = $(filter-out heuristics/ClauseBipartiteGraphPartitioner.cc heuristics/VarBipartiteGraphPartitioner.cc, $(wildcard *.cc */*.cc))`, and drop `patoh/libpatoh.a` from the Linux `LFLAGS`.
2. `interfaces/PartitionerInterface.cc`: drop the two `#include`s and make the `CB`/`VB` branches print a message and `exit(12)` instead of referencing the missing symbols.
3. `core/Main.cc`: change the default of the `pv` option from `"CB"` to `"NO"`, so cpog's documented invocation works unmodified.

```bash
git clone --depth 1 https://github.com/crillab/d4 /tmp/cpogwork/d4
# apply the three patches above
export CPATH="$HOME/.local/opt/sysdeps/usr/include:$HOME/.local/opt/sysdeps/usr/include/aarch64-linux-gnu"
export LIBRARY_PATH="$HOME/.local/opt/sysdeps/usr/lib/aarch64-linux-gnu"
cd /tmp/cpogwork/d4 && make -j4
mkdir -p ~/.local/opt/d4 && cp -a /tmp/cpogwork/d4/* ~/.local/opt/d4/
```

The linker picks the static `libgmp.a`/`libgmpxx.a` out of the extra
`LIBRARY_PATH`, so the resulting `d4` needs nothing from the sysroot at
run time (`ldd` shows only `libz`, `libstdc++`, `libm`, `libgcc_s`,
`libc`).

**cadical** (`c60730422e758ef1cebe7aeddf2dda31c996bf04`, i.e. rel-3.0.1) and
**drat-trim** (`2e3b2dc0ecf938addbd779d42877b6ed69d9a985`, which also
builds `lrat-check`) — no patches:

```bash
git clone --depth 1 https://github.com/arminbiere/cadical /tmp/cpogwork/cadical
cd /tmp/cpogwork/cadical && ./configure && make -j4
mkdir -p ~/.local/opt/cadical && cp -a build/cadical build/libcadical.a ~/.local/opt/cadical/

git clone --depth 1 https://github.com/marijnheule/drat-trim /tmp/cpogwork/drat-trim
cd /tmp/cpogwork/drat-trim && make
mkdir -p ~/.local/opt/drat-trim && cp -a drat-trim lrat-check ~/.local/opt/drat-trim/

ln -sf ~/.local/opt/d4/d4               ~/.local/bin/d4
ln -sf ~/.local/opt/cpog/src/cpog-gen    ~/.local/bin/cpog-gen
ln -sf ~/.local/opt/cpog/src/cpog-check  ~/.local/bin/cpog-check
ln -sf ~/.local/opt/cadical/cadical      ~/.local/bin/cadical
ln -sf ~/.local/opt/drat-trim/drat-trim  ~/.local/bin/drat-trim
ln -sf ~/.local/opt/drat-trim/lrat-check ~/.local/bin/lrat-check
```

Total build time ≈ 8 minutes, inside the 45-minute box that was set.

**Caveat worth carrying forward.** Because `patoh` is gone, this `d4`
compiles with **no** clause/variable partitioning heuristic (`-pv=NO`).
That is correctness-neutral — the certified counts are checked
independently by `cpog-check` — but it is a real performance loss on hard
instances, and it is the most likely reason the largest compilations here
are slow (§5.4). A future aarch64 build of `patoh`, or a partitioner
substitute, would lift that.

### 5.3 The certified counts

`cpog-check`'s verdict, its own model count, and the agreement with `d4`'s
raw count. **19 of 20 formulas certified**; the one failure is a timeout,
not a disagreement.

| formula | vars | clauses | certified count | expected | `d4` agrees | `d4` s | `cpog-gen` s | `cpog-check` s | CPOG bytes |
|---|---|---|---|---|---|---|---|---|---|
| (1,1,1) ice | 16 | 64 | **90** | 90 | yes | 0.13 | 0.07 | 0.12 | 97,680 |
| (1,1,1) `W = 0` | 40 | 112 | **12** | 12 | yes | 0.12 | 0.03 | 0.07 | 41,470 |
| (1,1,1) frozen `W = 0` | 40 | 144 | **12** | 12 | yes | 0.12 | 0.03 | 0.01 | 45,646 |
| (1,1,2) ice | 32 | 128 | **3,618** | 3,618 | yes | 0.20 | 0.42 | 0.42 | 2,618,713 |
| (1,1,2) `W = 0` | 104 | 272 | **388** | 388 | yes | 0.07 | 0.82 | 0.42 | 2,321,354 |
| (1,1,2) frozen `W = 0` | 104 | 336 | **68** | 68 | yes | 0.07 | 0.27 | 0.17 | 1,508,099 |
| (1,1,3) ice | 48 | 192 | **181,122** | 181,122 | yes | 0.08 | 0.57 | 0.82 | 8,344,569 |
| (1,1,3) `W = 0` | 200 | 496 | **15,024** | 15,024 | yes | 0.89 | 36.34 | 12.22 | 171,418,734 |
| (1,1,3) frozen `W = 0` | 200 | 592 | **528** | 528 | yes | 0.29 | 6.57 | 1.22 | 15,174,239 |
| (1,2,2) frozen `W = 0` | 256 | 768 | **204** | 204 | yes | 0.31 | 10.29 | 3.19 | 43,892,501 |
| (2,2,2) frozen `W = 0` | 512 | 1,536 | **612** | — | yes | 1.78 | 299.57 | 24.88 | 411,041,494 |
| (1,2,3) frozen `W = 0` | 488 | 1,360 | **968** | — | yes | 0.97 | 149.14 | 37.35 | 651,666,323 |
| (3,3,3) frozen `W = 0` | — | — | *not obtained* | — | — | **timeout at 900 s in `d4`** | — | — | — |

And the stage-4b three-bond certificate at (1,1,1), re-derived as seven
certified counting problems (the bond ids are re-asserted against the
current lattice build inside the run, so a change in build order breaks
the job rather than silently changing its meaning: bond 15 and bond 0
share the B-site at (1,1,1); bonds 0 and 1 share the A-site at the origin;
bonds 1 and 15 share no site):

| quantity | certified count | stage 4b §3.3 |
|---|---|---|
| `N` (ice states) | **90** | 90 |
| `n_0` | **45** | 45 |
| `n_1` | **45** | 45 |
| `n_15` | **45** | 45 |
| `n_{15,0}` | **15** | 15 |
| `n_{0,1}` | **15** | 15 |
| `n_{1,15}` | **25** | 25 |

So the covariances behind the "no sign gauge exists" FAIL —
`C = 90·15 − 45² = −675`, `−675`, and `90·25 − 45² = +225` — now rest on
certified counts, and the three-bond obstruction at the 16-spin cell is a
machine-checked fact rather than one implementation's arithmetic.

**The (2,2,2) frozen count is the substantive new one:** 612 by SAT
enumeration and 612 by a certified d-DNNF proof, at a cell where the
project's own enumerator cannot run at all.

### 5.4 What was left uncertified, and why

Four counts were **deliberately not attempted**, with the measurement that
decided it: the certified proof for (1,1,3) `W = 0` (15,024 models) is a
171 MB CPOG object costing 36 s to generate, and a probe on (1,2,2) ice
passed 1.7 GB of CPOG in three minutes without finishing. Extrapolating,
(1,2,2) ice (2,891,562 models), (1,2,2) `W = 0` (221,628), and the (1,2,3)
counts (3,076,306,362 and 196,465,480) are all far beyond what is worth
spending here — the last two by many orders of magnitude. `d4` alone did
not finish compiling (1,2,3) ice in **18.5 minutes** (3.5 GB resident)
before it was stopped. Those four counts therefore remain **agreed by two
independent methods** (the frontier DP and, where it runs, the DFS
enumeration) and are **not** described as certified anywhere in this
report.

(3,3,3) frozen `W = 0` is the one attempted-and-failed job: `d4` hit the
900 s wall. Its blocking-clause enumeration was also tried and abandoned
(§9). The (3,3,3) frozen count is **not known**.

**A caveat on what "certified" covers here.** A model count is over *all*
variables of the CNF, auxiliaries included, so a certified count is the
count of the *encoding*, not automatically of the ice states. It coincides
with the state count only if every auxiliary is functionally determined by
the bond variables. That it is, for the sequential-counter flux encoding
used here, is not assumed: it is *checked*, by the ten rows above whose
certified count equals a count known by two other methods, across three
different constraint sets and four cells. The 612 and 968 rows inherit
that check because they use the same encoding shape, and each is
independently equal to the projected SAT enumeration.

---

## 6. Item D — the frozen `W = 0` census, including the first cubic cell

The (2,2,2) cell has **128 bonds**. `icemix.enumerate` raises above 64
spins and `chain.build_flip_graph` assumes a `uint64` state word, so the
frozen set there had never been enumerated. The frozen-constrained CNF
does it directly, because "frozen" is only two 6-clauses per hexagon and
prunes the search enormously: **612 states in 4.2 s**. Every state was then
re-verified independently — `enumerate.ice_rule_ok_int`,
`enumerate.winding_int`, `chain.n_flippable_int` **and** the C kernel
`msc_scalar_nflip` — with 0 failures at every cell.

The stabiliser census needed a new implementation:
`frozen.stabiliser_census` packs states into `uint64`. `cnf.stabiliser_census_int`
is the same census on a packed `uint8` bit array, valid at any size, and
`tests/test_cnf.py::test_stabiliser_census_int_agrees_with_the_uint64_version`
requires the two to agree exactly (per-state stabiliser orders included)
where both can run.

| cell | bonds | frozen `W = 0` | Theorem 2 family | tilings of smaller frozen | in **neither** | aperiodic | min. stabiliser order | FCC translations | seconds |
|---|---|---|---|---|---|---|---|---|---|
| (1,1,2) | 32 | 68 | 44 | 12 | 24 | 16 | 1 | 8 | 0.0 |
| (1,2,2) | 64 | 204 | 76 | 124 | 80 | 64 | 1 | 16 | 0.0 |
| (1,2,3) | 96 | 968 | 440 | 584 | 384 | 336 | 1 | 24 | 0.3 |
| **(2,2,2)** | **128** | **612** | **108** | **420** | **192** | **0** | **2** | **32** | **4.2** |

The (1,1,2) row (68 frozen, 16 aperiodic) and the (1,2,2) row (204 frozen,
64 aperiodic) reproduce exactly the numbers already in
`icemix/frozen.py`'s docstring and `tests/test_frozen.py` — an unplanned
but welcome cross-check of the whole pipeline against work done by a
different route on a different day.

The Theorem 2 family is complete at every cell:
`C(2a,a)² + C(2b,b)² + C(2c,c)²` gives 44, 76, 440 and 108 respectively,
and every predicted member is present in the enumerated set
(`theorem2_family_all_present: true`).

### 6.1 (2,2,2) — the readings

- **612 frozen `W = 0` states**, from a formula with 512 variables and
  1,536 clauses. All 612 verified by icemix and by the C kernel.
- **Every one of them is periodic.** The stabiliser-order histogram under
  the 32 FCC translations is `{2: 192, 4: 288, 8: 120, 16: 12}`: the
  minimum is 2, so **no frozen `W = 0` state of (2,2,2) has trivial
  translation stabiliser**. This is a genuine qualitative difference from
  the thin cells, where aperiodic frozen states are common (16 of 68 at
  (1,1,2), 64 of 204 at (1,2,2), 336 of 968 at (1,2,3)). It is not a
  general fact about cubic cells — it is a fact about `L = 2`, and the
  obvious next question is whether (3,3,3) has aperiodic frozen states
  (not answered here, see §9).
- **108 are the Theorem 2 family** (3 × C(4,2)² = 3 × 36), and they are the
  most symmetric states in the set: the 12 of stabiliser order 16 and 96 of
  the 120 of order 8.
- **420 are tilings** of frozen `W = 0` states of a proper sub-cell —
  12 from (1,1,1), 68 each from (1,1,2)/(1,2,1)/(2,1,1), 204 each from
  (1,2,2)/(2,1,2)/(2,2,1), giving 420 distinct states. The whole Theorem 2
  family is inside this set, so tiling subsumes the theorem here.
- **192 are neither** — not in the Theorem 2 family, and not the tiling of
  any smaller frozen state. They are new at (2,2,2), and every one of them
  has stabiliser order exactly 4. This is the sharpest statement available
  about the gap between the two theorems and the truth: at the first cubic
  cell, 31 % of the frozen `W = 0` states are outside both.
- All 612 are in the `W = 0` sector by construction, so the flux-sector
  question does not arise here.

### 6.2 (1,2,3) — the readings

- **968 frozen `W = 0` states** (96 bonds; the `W = 0` sector itself has
  196,465,480 states, so this subset could only ever come from the
  frozen-constrained search, never from enumeration).
- 440 in the Theorem 2 family (4 + 36 + 400), 584 tilings (528 from
  (1,1,3), 68 from (1,2,1), 12 from (1,1,1)), and the family sits inside
  the tilings.
- **384 are in neither**, and **336 of those are aperiodic** — the
  largest set of frozen states beyond both theorems and beyond tiling that
  this project has exhibited.

---
## 7. Defects and traps found

**D1 — `frozen.stabiliser_census` cannot reach a cubic cell.** It packs
states into `uint64`, so it is silently limited to ≤ 64 bonds; (2,2,2) has
128. Fixed additively by `cnf.stabiliser_census_int` (packed `uint8` bit
array, any size), with a test requiring the two to agree exactly where both
run. The old function is untouched.

**D2 — the two half-diagonals coincide mod the box when a transverse cell
extent is 1.** `(2,−2,0) ≡ (2,2,0) mod 4b` exactly when `b = 1`, so at
(1,1,2) the `z`-axis form of Theorem 2 imposes *one* translation, not two.
That is mathematically fine (the second is the same permutation), but a
"drop one translation" control at such a cell would have been vacuous —
it would have come back UNSAT and looked like a failed control. Recorded
per row as `translations_distinct_mod_box`, and the Theorem 2 controls were
placed at (2,2,2) and (3,3,3) instead.

**D3 — `cpog-check` writes multi-gigabyte stdout, and the first version of
this run captured it in memory.** With `-v 2` the checker emitted **1.98
GB** on the (1,1,3) `W = 0` proof and the run was on its way to filling the
repository with 4 GB of proof objects inside three minutes;
`subprocess.run(capture_output=True)` was holding all of it in RAM. The run
was stopped with `kill -TERM` at 15:07, the artefacts deleted, and the code
changed to: `-v 1`; all `.nnf`/`.cpog`/log files written to a scratch
directory **outside** the repository (`ICEMIX_CPOG_WORK`, default
`/tmp/claude-1000/icemix-cpog`); the checker log *streamed* line by line
and only the matching lines kept; and anything over 50 MB deleted after the
verdict is read. Even at `-v 1` the (1,2,3) frozen check log was 6.5 GB, so
the streaming fix is not cosmetic. What the repository keeps is the CNF,
the DRAT/LRAT proofs (all ≤ 25 KB) and a ten-line checker verdict —
2.7 MB in total.

**D4 — blocking-clause enumeration does not scale to (3,3,3).** At (2,2,2)
the frozen search returns 612 models in 4.2 s; at (3,3,3) the same code was
still running after ~20 minutes without reaching a 3,000-model cap, so it
was stopped with `kill -TERM`. The cost is not the search, it is the
accumulating blocking clauses. A projected-model counter is the right tool
there, and `d4` did not manage that either (§5.4).

**D5 — the aarch64 `d4` has no partitioning heuristic.** The `patoh`
library shipped with `d4` is x86-64-only, so this build runs `-pv=NO`.
Correctness is unaffected (the count is independently checked by
`cpog-check`), but the compiler is weaker than upstream's, and that is the
most likely reason (1,2,3) ice would not compile.

**D6 — `exptop` is still not installed into the project's interpreter.**
As in stage 4, `run_certificates.py` has to put
`~/repo/project/exptop/src` on `sys.path` by hand. Not a fork — the
canonical `ProgressReporter` is imported — but an environment defect that
keeps being worked around rather than fixed. Checked, as the conventions
require: `grep -rl "class ProgressReporter" --include="*.py" .` finds no
copy in this repository.

---

## 8. Tests added

`tests/test_cnf.py`, 17 tests, **32 s** on its own — every one a gate, not
a smoke test:

| test | what it can catch |
|---|---|
| `test_exactly_two_of_four_is_eight_clauses_and_correct` | all 16 assignments against the intended predicate |
| `test_flippability_encoding_matches_flippable_ref` (2 cells) | the alternating-pattern encoding drifting from `chain.flippable_ref` |
| `test_cut_plane_flux_equals_the_winding_formula` (3 cells) | the single cut plane no longer computing the winding |
| `test_half_diagonals_are_the_theorem2_vectors` | the `b = 1` coincidence (D2) changing silently |
| `test_sat_enumeration_reproduces_the_known_counts_and_the_state_sets` (2 cells) | any drift between SAT, the DFS enumerator, the frontier DP and the known counts — **state sets**, not just counts |
| `test_theorem1_is_unsat_and_the_control_is_sat` | Theorem 1 in process, with its negative control |
| `test_theorem2_is_unsat_on_every_axis` (2 cells × 3 axes) | Theorem 2 in process |
| `test_theorem2_control_one_translation_is_sat` | the second translation mattering; also that the witness really is invariant under the one kept |
| `test_theorem1_drat_certificate_end_to_end` | cadical + drat-trim end to end, and that the *control* comes back SAT and unverified; skips cleanly if the binaries are absent |
| `test_222_frozen_set_contains_the_108_member_translation_family` | the (2,2,2) frozen set losing the 108 predicted members, or the family exhausting it |
| `test_stabiliser_census_int_agrees_with_the_uint64_version` | the new big-int census disagreeing with `frozen.stabiliser_census` |
| `test_recorded_results_are_internally_consistent` | the recorded run drifting from its own claims; skips if `results.json` is absent |

**Whole suite, run once at the end on the final tree:**

```
OMP_NUM_THREADS=4 ~/.pyenv/versions/3.12.13/bin/python3 -m pytest
288 passed in 805.81s (0:13:25)      # exit 0
```

288 = the 271 of the 2026-09-04 afternoon run plus these 17. No skips, no
failures.

---

## 9. Run ledger — every launch and its feed card

| session | items | feed card | final status | wall | outcome |
|---|---|---|---|---|---|
| `tmux certABD` | A, B, D | `ice-mixing-certificates-sat-2305929` | **completed** | 157 s | `part_A/B/D.json` |
| `tmux certCD` | D, C | `ice-mixing-certificates-sat-2315631` | **KILLED** (`kill -TERM`, stamped) | 323 s | superseded; artefacts deleted (defect D3) |
| `tmux certC` | C | `ice-mixing-certificates-sat-2339911` | **completed** | 1,642 s | `part_C.json` |
| `tmux icesuite` | full pytest | — (not an instrumented run) | exit 0 | 806 s | 288 passed |

Sub-minute probes were run with `--no-feed`, per the convention, and left
no cards: the encoding gates at (1,1,1)/(1,1,2), the certificate
pre-flight, and the four-cell census re-run (10 s). Two bare probes were
stopped with `kill -TERM` and left no card because they were not
instrumented runs: the (3,3,3) blocking-clause enumeration (~20 min, D4)
and the `d4` (1,2,3) ice compilation (18.5 min, §5.4).

Machine discipline: `uptime` was checked before every launch (other agents
were building Lean on the same box); nothing ran with more than
`OMP_NUM_THREADS=4`, and no two heavy jobs of mine were ever started
side by side.

---

## 10. What was NOT done, and why

1. **A certified count at (3,3,3).** `d4` hit the 900 s wall compiling the
   frozen formula, and blocking-clause enumeration had already been
   abandoned there (D4). The (3,3,3) frozen `W = 0` count remains unknown.
   This is the one item of the brief that was attempted and failed.
2. **Certified counts for the four large formulas** ((1,2,2) ice and
   `W = 0`; (1,2,3) ice and `W = 0`). Skipped on a measured projection, not
   a guess — see §5.4. They stay two-method-agreed, not certified.
3. **SAT enumeration of (1,2,2)'s full ice manifold** (2,891,562 states):
   ≈ 5 min for no information the frontier DP does not already give, and
   the registered gate did not ask for it. The DP's 2,891,562 is in the
   results.
4. **Aperiodicity at (3,3,3).** The most interesting question raised by
   §6.1 — is "no aperiodic frozen state" special to `L = 2`? — needs the
   (3,3,3) frozen set, which item 1 above did not deliver.
5. **A `patoh` replacement for `d4` on aarch64.** Recorded as D5; fixing it
   is the obvious lever if certified counting is wanted at larger cells.
6. **Nothing was committed**, and `LOG.md`, `HANDOVER.md`, `README.md`,
   `paper/` and `docs/project-briefing*` were not touched, as instructed.
   `icemix/frozen.py` was *not* edited either — the big-int stabiliser
   census went into `icemix/cnf.py` instead.

---

## 11. What a reader should take from this

The two frozen-state theorems now come with proof objects. Anyone with
`drat-trim` can take `experiments/07_certificates/results/certificates/`
and confirm, without running a line of this project's code, that at
(1,1,1) no zero-flux ice state has a flippable hexagon, and that at
(1,1,2), (1,2,2), (2,2,2), (3,3,3) and (4,4,4) no state invariant under
both half-diagonals perpendicular to an axis has one either — in any flux
sector. The counts the note quotes at the small cells are now certified
model counts as well, and so are the three covariance counts behind the
stage-4b three-bond obstruction.

The new mathematics is in §6. At the first cubic cell there are 612 frozen
`W = 0` states; 108 are Theorem 2's, 420 are tilings of smaller frozen
states, and 192 are neither — so the census section of the note can say,
with a certified count behind it, that the two theorems and periodic
tiling together still miss about a third of the frozen states at `L = 2`.
And every frozen `W = 0` state at (2,2,2) is periodic, which is *not* true
at (1,1,2), (1,2,2) or (1,2,3). Whether that survives to `L = 3` is open.
