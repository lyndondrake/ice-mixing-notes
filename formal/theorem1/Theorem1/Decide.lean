import Theorem1.Basic

/-!
# Decision procedures for the model

Core Lean has no `Fintype`, so quantification over the function types
`Fin 4 → Bool` and `Mat = Fin 4 → Fin 4 → Bool` is not decidable out of the
box.  This file supplies the missing instances by hand (via the eta lemmas
`vec_eta` and `mat_eta`), so that `decide` can range over all `2^16 = 65536`
matrices.  Nothing here is Mathlib and nothing here is an axiom: the instances
are ordinary definitions checked by the kernel.
-/

namespace Theorem1

/-- The vector `Fin 4 → Bool` with the given four entries. -/
def mk4 (b0 b1 b2 b3 : Bool) : Fin 4 → Bool := Fin4.rec4 b0 b1 b2 b3

/-- The matrix with the given four rows. -/
def mkM (r0 r1 r2 r3 : Fin 4 → Bool) : Mat := Fin4.rec4 r0 r1 r2 r3

theorem vec_eta (v : Fin 4 → Bool) : mk4 (v 0) (v 1) (v 2) (v 3) = v := by
  funext a; cases a using Fin4.rec4 <;> rfl

theorem mat_eta (M : Mat) : mkM (M 0) (M 1) (M 2) (M 3) = M := by
  funext a; cases a using Fin4.rec4 <;> rfl

instance decBoolAll (p : Bool → Prop) [DecidablePred p] : Decidable (∀ b : Bool, p b) :=
  decidable_of_iff (p true ∧ p false)
    ⟨fun ⟨ht, hf⟩ b => by cases b <;> assumption, fun h => ⟨h true, h false⟩⟩

instance decBoolEx (p : Bool → Prop) [DecidablePred p] : Decidable (∃ b : Bool, p b) :=
  decidable_of_iff (p true ∨ p false)
    ⟨fun h => h.elim (fun ht => ⟨true, ht⟩) (fun hf => ⟨false, hf⟩),
     fun ⟨b, hb⟩ => by cases b with | false => exact Or.inr hb | true => exact Or.inl hb⟩

instance decVecAll (p : (Fin 4 → Bool) → Prop) [DecidablePred p] :
    Decidable (∀ v : Fin 4 → Bool, p v) :=
  decidable_of_iff (∀ b0 b1 b2 b3, p (mk4 b0 b1 b2 b3))
    ⟨fun h v => vec_eta v ▸ h (v 0) (v 1) (v 2) (v 3), fun h _ _ _ _ => h _⟩

instance decMatAll (p : Mat → Prop) [DecidablePred p] : Decidable (∀ M : Mat, p M) :=
  decidable_of_iff (∀ r0 r1 r2 r3, p (mkM r0 r1 r2 r3))
    ⟨fun h M => mat_eta M ▸ h (M 0) (M 1) (M 2) (M 3), fun h _ _ _ _ => h _⟩

instance decEqVec : DecidableEq (Fin 4 → Bool) := fun v w =>
  decidable_of_iff (v 0 = w 0 ∧ v 1 = w 1 ∧ v 2 = w 2 ∧ v 3 = w 3)
    ⟨fun ⟨h0, h1, h2, h3⟩ => by
        funext a; cases a using Fin4.rec4 <;> assumption,
     fun h => ⟨h ▸ rfl, h ▸ rfl, h ▸ rfl, h ▸ rfl⟩⟩

instance decEqMat : DecidableEq Mat := fun M N =>
  decidable_of_iff (M 0 = N 0 ∧ M 1 = N 1 ∧ M 2 = N 2 ∧ M 3 = N 3)
    ⟨fun ⟨h0, h1, h2, h3⟩ => by
        funext a; cases a using Fin4.rec4 <;> assumption,
     fun h => ⟨h ▸ rfl, h ▸ rfl, h ▸ rfl, h ▸ rfl⟩⟩

instance decIceA (M : Mat) : Decidable (IceA M) :=
  inferInstanceAs (Decidable (∀ g, rowSum M g = 2))

instance decIceB (M : Mat) : Decidable (IceB M) :=
  inferInstanceAs (Decidable (∀ h, labSum M h = 2))

instance decZeroFlux (M : Mat) : Decidable (ZeroFlux M) :=
  inferInstanceAs (Decidable (∀ k, colSum M k = 2))

instance decFlippable (M : Mat) (g i j k : Fin 4) : Decidable (Flippable M g i j k) := by
  unfold Flippable; infer_instance

end Theorem1
