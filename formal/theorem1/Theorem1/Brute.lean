import Theorem1.Decide
import Theorem1.Structured

/-!
# Theorem 1, brute force

An independent cross-check of `Theorem1.no_flippable_hexagon`: the same
statement, decided by exhausting all `2^16 = 65536` matrices and all
`4 * 4 * 4 * 4 = 256` index tuples.  No part of the hand argument is used.

`decide` alone (elaborator evaluation) exceeds the default heartbeat budget, so
we ask for kernel evaluation with `decide +kernel`.  That keeps the proof
inside the kernel's trusted computation — in particular it does **not** use
`native_decide`, which would trust the compiler and add `Lean.ofReduceBool` to
the axiom list.  Cost: about two minutes.
-/

namespace Theorem1

set_option maxRecDepth 100000
set_option maxHeartbeats 0

/-- **Theorem 1, by exhaustion.**  Checked by the kernel over all 65536
matrices; agrees with the structured proof `no_flippable_hexagon`. -/
theorem no_flippable_hexagon_brute : ∀ M : Mat, IceA M → IceB M → ZeroFlux M →
    ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → ¬ Flippable M g i j k := by
  decide +kernel

/-- The brute-force check and the structured proof are the same statement. -/
example : (∀ M : Mat, IceA M → IceB M → ZeroFlux M →
    ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → ¬ Flippable M g i j k) :=
  fun M hA hB hC => frozen M hA hB hC

/-- A sanity check in the other direction: without the zero-flux condition (C)
the conclusion is false — some ice state of `(1,1,1)` does have a flippable
hexagon.  (In Python: 78 of the 90 ice states are not `W = 0`, and some of them
are flippable — `tests/test_frozen.py::test_every_w0_model_state_is_frozen_and_some_others_are_not`.) -/
theorem exists_flippable_without_zero_flux :
    ¬ (∀ M : Mat, IceA M → IceB M →
        ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → ¬ Flippable M g i j k) := by
  decide +kernel

end Theorem1
