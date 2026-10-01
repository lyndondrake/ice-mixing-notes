# Theorem 1 in Lean 4

A standalone Lean 4 formalisation of Theorem 1 of the ice-mixing project: in
the `4 x 4` matrix model of the `(1,1,1)` pyrochlore cell, every state obeying
the ice rule at the A-sites, the ice rule at the B-sites and zero flux is
**frozen** — no hexagon is flippable.

The Python statement and its lattice cross-checks are in `icemix/frozen.py`
and `tests/test_frozen.py`.

## What is here

| file | contents |
|---|---|
| `Theorem1/Basic.lean` | the model: the Klein group on `Fin 4`, `Mat`, the three conditions `IceA`/`IceB`/`ZeroFlux`, hexagons, `Flippable`, and the line-reindexing lemmas |
| `Theorem1/Structured.lean` | the hand proof: the three off-hexagon cells `z`, `r`, `u`, the three line lemmas, and `no_flippable_hexagon` |
| `Theorem1/Decide.lean` | decidability instances for quantification over `Fin 4 → Bool` and `Mat` (core Lean has no `Fintype`) |
| `Theorem1/Brute.lean` | the same theorem again by exhausting all 65536 matrices, `decide +kernel` |
| `Theorem1/Counts.lean` | exactly 90 ice states and exactly 12 with `W = 0`: length, soundness, distinctness and completeness for explicit lists |
| `Axioms.lean` | `#print axioms` for every theorem (not part of the library) |

No dependencies: core Lean 4 only, no Mathlib, no Batteries, no `lake update`,
no network. The toolchain is pinned in `lean-toolchain` to
`leanprover/lean4:v4.33.1`.

## How to check it

```sh
export PATH="$HOME/.elan/bin:$PATH"
cd formal/theorem1
lake build                  # under 2 min from scratch
lake env lean Axioms.lean   # ~1 s; prints the axiom dependencies
```

Measured on a GB10 (aarch64), Lean 4.33.1, one module at a time:

| module | wall | peak RSS |
|---|---|---|
| `Theorem1.Basic` | 3.7 s | small |
| `Theorem1.Decide` | 1.1 s | small |
| `Theorem1.Structured` | 2.0 s | small |
| `Theorem1.Counts` | 13–22 s | 1.4 GB |
| `Theorem1.Brute` | 90–110 s | 9.6 GB |
| **whole project, clean** | **1 min 44 s - 1 min 57 s** (two runs) | 9.6 GB |

Every theorem depends only on `propext` and `Quot.sound` (several on `propext`
alone). No `Classical.choice`, no `sorryAx`, and no `Lean.ofReduceBool` —
`native_decide` is not used anywhere.

## Notes for anyone extending this

`decide +kernel` is used where plain `decide` exhausts the elaborator's
heartbeat budget. It hands the evaluation to the **kernel**, so the proof stays
inside the trusted core; `native_decide` would trust the compiler and add the
`Lean.ofReduceBool` axiom, so it is deliberately avoided.

The one real hazard here is memory. Core Lean has no `Fintype`, so
`Theorem1/Decide.lean` builds the instances for `∀ v : Fin 4 → Bool, …` and
`∀ M : Mat, …` by nesting `decidable_of_iff (p true ∧ p false)`. Each level
substitutes the predicate's body twice, so a full `Mat` enumeration puts `2^16`
copies of that body in front of the kernel. With a small body (as in
`Brute.lean`) that costs 9.6 GB and 90 s. With a body that mentions a list of
matrices it does not finish at all: the first version of `Counts.lean` reached
**55 GB** before being killed.

Two habits avoid it, both used in `Counts.lean`:

1. **Shrink the search before enumerating.** Condition (R) already forces every
   row to be one of six two-hot vectors, so only `6^4 = 1296` matrices are
   candidates; `mem_iceRowMats` turns (R) into membership of that list and every
   exhaustive check runs over 1296 rather than 65536.
2. **Keep the body a `Bool` computation.** `matBEq` / `memB` / `allB` /
   `nodupB` replace the proof-carrying `DecidableEq Mat` instance. Note that
   `∀ M ∈ iceStates, …` is literally `∀ M : Mat, M ∈ iceStates → …`, so writing
   it that way silently sends instance resolution back to the `2^16`
   enumeration.

## What is and is not formalised

Formalised: everything about the matrix model — the theorem, the counts, and
the finite `Fin 4` facts the hand proof leans on.

Not formalised: that the matrix model *is* the `(1,1,1)` cell. That the 12
`W = 0` matrices are exactly the `W = 0` ice states of the built lattice, and
that the 16 model hexagons are exactly the lattice's hexagons, are checked in
Python by
`tests/test_frozen.py::test_klein_states_are_exactly_the_w0_states_of_111`
and `::test_model_hexagons_match_the_lattice_hexagons`. That is the trust
boundary of this development.
