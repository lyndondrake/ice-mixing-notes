import Periodicity.Blueprint
import Periodicity.Bridge

/-!
# The thin cell `(1,2,2)`: periodicity fails without the extents hypothesis

pacheck (1 October 2026, `docs/reports/2026-10-01-opus-pacheck.md`, V5) found
by solver, and re-checked with its own model `h730_lib`, frozen zero-flux states
of even curl with all six directions and no nonzero translation symmetry on the
thin cells `(1,1,2)`, `(1,2,2)`, `(1,2,3)`, `(1,3,3)`, `(1,3,4)` and `(1,4,5)`.
This file takes its `(1,2,2)` witness (`.tmp/h737_witness_122.json`, bits indexed
`4·(A index) + k` in the order of `h730_lib`) and checks it in the Lean model,
by `decide`.  This is an independent re-check of the witness and a second
bridge to `h730_lib`: the bit order, the ice rule, the hexagons, freezing, the
curl, the flux, the moments and the translations of the two models agree on it.

`not_periodic_122` is the formal form of the correction: the hypothesis that
every extent is at least two cannot be dropped from `periodicity`.
-/

namespace Periodicity

/-- The A points of a cell in the order of `h730_lib`: `x`, then `y`, then `z`
over the even coordinates, keeping those whose sum is a multiple of four. -/
def aList (a b c : Nat) : List (Pt a b c) := (allPts a b c).filter isA

/-- A state from a list of bits indexed `4·(A index) + k`, as in `h730_lib`. -/
def ofBits {a b c : Nat} (L : List Bool) : State a b c :=
  fun p k => L.getD (4 * (aList a b c).idxOf p + k.val) false

/-- pacheck's witness on `(1,2,2)`. -/
def w122 : State 1 2 2 := ofBits
  [true, true, false, false, false, true, false, true, true, true, false, false, true, false,
   true, false, false, false, true, true, true, false, true, false, false, false, true, true,
   false, true, false, true, true, true, false, false, true, false, true, false, true, true,
   false, false, false, true, false, true, false, false, true, true, false, true, false, true,
   false, false, true, true, true, false, true, false]

theorem w122_frozen : Frozen w122 := by decide +kernel

theorem w122_zeroFlux : ZeroFlux w122 := by decide +kernel

theorem w122_evenCurl : EvenCurl w122 := by decide +kernel

/-- All six directions occur. -/
theorem w122_six : ∀ k : Fin 3, ∀ e : Bool, ∃ v : Pt 1 2 2, isVertex v = true ∧ moment w122 v = (k, e) := by
  decide +kernel

/-- The vector of a point. -/
def vecOf {a b c : Nat} (r : Pt a b c) : V3 := ⟨r.1.val, r.2.1.val, r.2.2.val⟩

/-- No translation that is nonzero modulo the box fixes the witness. -/
theorem w122_aperiodic : ∀ r : Pt 1 2 2, r ≠ (⟨0, by decide⟩, ⟨0, by decide⟩, ⟨0, by decide⟩) →
    ¬ Invariant w122 (vecOf r) := by
  decide +kernel

/-- Reduction of a translation to its representative in the box. -/
theorem reduce_mod {a b c : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (t : V3) :
    let z : Pt a b c := (⟨0, by omega⟩, ⟨0, by omega⟩, ⟨0, by omega⟩)
    ModBox a b c t (vecOf (z + t)) ∧ (vecOf (z + t) = vecOf z → ZeroMod a b c t) := by
  intro z
  have key : ∀ (n : Nat) (hn : 0 < n) (d : Int),
      (n : Int) ∣ d - ((wrap (⟨0, hn⟩ : Fin n) d).val : Int) ∧
      (((wrap (⟨0, hn⟩ : Fin n) d).val : Int) = 0 → (n : Int) ∣ d - 0) := by
    intro n hn d
    rw [wrap_val]
    simp only [Int.natCast_zero, Int.zero_add, Int.sub_zero]
    refine ⟨⟨d / n, ?_⟩, fun h => Int.dvd_of_emod_eq_zero h⟩
    rw [Int.emod_def]; omega
  have kx := key (4 * a) (by omega) t.x
  have ky := key (4 * b) (by omega) t.y
  have kz := key (4 * c) (by omega) t.z
  refine ⟨⟨kx.1, ky.1, kz.1⟩, fun h => ?_⟩
  simp only [vecOf, z, Pt.add_def, V3.mk.injEq] at h
  exact ⟨kx.2 (by exact_mod_cast h.1), ky.2 (by exact_mod_cast h.2.1), kz.2 (by exact_mod_cast h.2.2)⟩

/-- **Periodicity fails on the thin cell `(1,2,2)`** (pacheck's witness, checked
here): the hypothesis that every extent is at least two is needed. -/
theorem not_periodic_122 : ¬ Periodic 1 2 2 := by
  intro hP
  obtain ⟨t, _, hnz, hinv⟩ := hP w122 w122_frozen w122_zeroFlux
  obtain ⟨hm, hz⟩ := reduce_mod (a := 1) (b := 2) (c := 2) (by decide) (by decide) (by decide) t
  apply w122_aperiodic _ (fun h => hnz (hz (congrArg vecOf h)))
  intro p hp k
  rw [← Pt.add_congr p hm]
  exact hinv p hp k

end Periodicity
