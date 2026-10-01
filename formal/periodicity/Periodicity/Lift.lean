import Periodicity.Basic

/-!
# Lemma 21: a state repeated periodically

`docs/notes/theorem-h-orientation.md`, section "A state repeated periodically,
and the cubic cells of side one to three", Lemma 21: a frozen state of the cell
`(a, b, c)`, repeated periodically, is a frozen state of the cell
`(k₁a, k₂b, k₃c)`; it has an odd hexagon exactly when the original has; and it
has the same set of moments.

The proof here is the note's: the projection of the larger cell onto the
smaller commutes with translation, so it carries bonds to bonds of the same
direction, the hexagon `(O, j)` to the hexagon `(π O, j)` bond by bond, and the
four bits at a vertex to the four bits at its image.  It is done for any pair of
cells whose extents divide (`a ∣ a'` and so on) and then specialised.
-/

namespace Periodicity

section
variable {a b c a' b' c' : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
  (da : a ∣ a') (db : b ∣ b') (dc : c ∣ c')

/-- The state of the larger cell `(a', b', c')` obtained by repeating `s`. -/
def repeatState (s : State a b c) : State a' b' c' := fun p k => s (Pt.proj ha hb hc p) k

include da db dc

theorem proj_add' (p : Pt a' b' c') (v : V3) :
    Pt.proj ha hb hc (p + v) = Pt.proj ha hb hc p + v :=
  Pt.proj_add ha hb hc da db dc p v

omit da db dc in
theorem isA_proj (p : Pt a' b' c') : isA (Pt.proj ha hb hc p) = isA p := by
  simp only [isA, res_proj]

theorem isB_proj (p : Pt a' b' c') : isB (Pt.proj ha hb hc p) = isB p := by
  simp only [isB]
  rw [← proj_add' ha hb hc da db dc, isA_proj]

theorem isVertex_proj (p : Pt a' b' c') : isVertex (Pt.proj ha hb hc p) = isVertex p := by
  simp only [isVertex, isA_proj, isB_proj ha hb hc da db dc]

theorem isAHole_proj (p : Pt a' b' c') : isAHole (Pt.proj ha hb hc p) = isAHole p := by
  simp only [isAHole]
  rw [← proj_add' ha hb hc da db dc, isA_proj]

theorem loc_repeat (s : State a b c) (v : Pt a' b' c') :
    loc (repeatState ha hb hc s : State a' b' c') v = loc s (Pt.proj ha hb hc v) := by
  funext k
  simp only [loc, repeatState, isA_proj]
  split
  · rfl
  · rw [proj_add' ha hb hc da db dc]

theorem moment_repeat (s : State a b c) (v : Pt a' b' c') :
    moment (repeatState ha hb hc s : State a' b' c') v = moment s (Pt.proj ha hb hc v) := by
  simp only [moment, vtype, vsign, loc_repeat ha hb hc da db dc]

theorem hbit_repeat (s : State a b c) (O : Pt a' b' c') (j : Fin 4) (t : Fin 6) :
    hbit (repeatState ha hb hc s : State a' b' c') (O, j) t = hbit s (Pt.proj ha hb hc O, j) t := by
  simp only [hbit, hexBond, repeatState]
  rw [proj_add' ha hb hc da db dc]

theorem nrev_repeat (s : State a b c) (O : Pt a' b' c') (j : Fin 4) :
    nrev (repeatState ha hb hc s : State a' b' c') (O, j) = nrev s (Pt.proj ha hb hc O, j) := by
  simp only [nrev, reversal, hbit_repeat ha hb hc da db dc]

theorem curl_repeat (s : State a b c) (O : Pt a' b' c') (j : Fin 4) :
    curl (repeatState ha hb hc s : State a' b' c') (O, j) = curl s (Pt.proj ha hb hc O, j) := by
  simp only [curl, hbit_repeat ha hb hc da db dc]

end

/-! ## The embedding of the smaller cell, a section of the projection -/

section
variable {a b c a' b' c' : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
  (ha' : 0 < a') (hb' : 0 < b') (hc' : 0 < c')
  (da : a ∣ a') (db : b ∣ b') (dc : c ∣ c')

omit ha hb hc ha' hb' hc' da db dc in
theorem le_of_dvd' {m n : Nat} (hn : 0 < n) (d : m ∣ n) : 4 * m ≤ 4 * n :=
  Nat.mul_le_mul_left 4 (Nat.le_of_dvd hn d)

include da db dc ha' hb' hc'

/-- Every point of the smaller cell is the projection of a point of the larger. -/
theorem proj_surj (p : Pt a b c) : ∃ q : Pt a' b' c', Pt.proj ha hb hc q = p := by
  refine ⟨(⟨p.1.val, Nat.lt_of_lt_of_le p.1.isLt (le_of_dvd' ha' da)⟩,
           ⟨p.2.1.val, Nat.lt_of_lt_of_le p.2.1.isLt (le_of_dvd' hb' db)⟩,
           ⟨p.2.2.val, Nat.lt_of_lt_of_le p.2.2.isLt (le_of_dvd' hc' dc)⟩), ?_⟩
  simp only [Pt.proj, projF]
  rcases p with ⟨x, y, z⟩
  simp only [Nat.mod_eq_of_lt x.isLt, Nat.mod_eq_of_lt y.isLt, Nat.mod_eq_of_lt z.isLt]

theorem ice_repeat_iff (s : State a b c) : Ice (repeatState ha hb hc s : State a' b' c') ↔ Ice s := by
  constructor
  · intro h v hv
    obtain ⟨q, rfl⟩ := proj_surj ha hb hc ha' hb' hc' da db dc v
    rw [← loc_repeat ha hb hc da db dc]
    exact h q (by rw [← isVertex_proj ha hb hc da db dc]; exact hv)
  · intro h v hv
    rw [loc_repeat ha hb hc da db dc]
    exact h _ (by rw [isVertex_proj ha hb hc da db dc]; exact hv)

theorem frozen_repeat_iff (s : State a b c) : Frozen (repeatState ha hb hc s : State a' b' c') ↔ Frozen s := by
  unfold Frozen Circulates Hex.valid
  rw [ice_repeat_iff ha hb hc ha' hb' hc' da db dc]
  constructor
  · rintro ⟨hi, h⟩
    refine ⟨hi, ?_⟩
    rintro ⟨O, j⟩ hO
    obtain ⟨q, rfl⟩ := proj_surj ha hb hc ha' hb' hc' da db dc O
    rw [← nrev_repeat ha hb hc da db dc]
    exact h (q, j) (by rw [← isAHole_proj ha hb hc da db dc]; exact hO)
  · rintro ⟨hi, h⟩
    refine ⟨hi, ?_⟩
    rintro ⟨O, j⟩ hO
    rw [nrev_repeat ha hb hc da db dc]
    exact h _ (by rw [isAHole_proj ha hb hc da db dc]; exact hO)

theorem odd_repeat_iff (s : State a b c) : OddState (repeatState ha hb hc s : State a' b' c') ↔ OddState s := by
  unfold OddState Hex.valid
  constructor
  · rintro ⟨⟨O, j⟩, hO, hc1⟩
    refine ⟨(Pt.proj ha hb hc O, j), ?_, ?_⟩
    · rw [isAHole_proj ha hb hc da db dc]; exact hO
    · rw [← curl_repeat ha hb hc da db dc]; exact hc1
  · rintro ⟨⟨O, j⟩, hO, hc1⟩
    obtain ⟨q, rfl⟩ := proj_surj ha hb hc ha' hb' hc' da db dc O
    refine ⟨(q, j), ?_, ?_⟩
    · rw [← isAHole_proj ha hb hc da db dc]; exact hO
    · rw [curl_repeat ha hb hc da db dc]; exact hc1

theorem moments_repeat_iff (s : State a b c) (m : Fin 3 × Bool) :
    (∃ v : Pt a' b' c', isVertex v = true ∧ moment (repeatState ha hb hc s : State a' b' c') v = m) ↔
      (∃ v : Pt a b c, isVertex v = true ∧ moment s v = m) := by
  constructor
  · rintro ⟨v, hv, hm⟩
    refine ⟨Pt.proj ha hb hc v, ?_, ?_⟩
    · rw [isVertex_proj ha hb hc da db dc]; exact hv
    · rw [← moment_repeat ha hb hc da db dc]; exact hm
  · rintro ⟨v, hv, hm⟩
    obtain ⟨q, rfl⟩ := proj_surj ha hb hc ha' hb' hc' da db dc v
    refine ⟨q, ?_, ?_⟩
    · rw [← isVertex_proj ha hb hc da db dc]; exact hv
    · rw [moment_repeat ha hb hc da db dc]; exact hm

end

/-! ## Lemma 21 as the note states it -/

/-- **Lemma 21** (theorem-h-orientation).  The state `s` of the cell `(a, b, c)`
repeated to the cell `(k₁a, k₂b, k₃c)` is frozen iff `s` is, has an odd hexagon
iff `s` has, and has the same set of moments. -/
theorem lemma21 {a b c : Nat} (k₁ k₂ k₃ : Nat) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hk₁ : 0 < k₁) (hk₂ : 0 < k₂) (hk₃ : 0 < k₃) (s : State a b c) :
    let s' : State (k₁ * a) (k₂ * b) (k₃ * c) := repeatState ha hb hc s
    (Frozen s' ↔ Frozen s) ∧ (OddState s' ↔ OddState s) ∧
      ∀ m : Fin 3 × Bool, (∃ v, isVertex v = true ∧ moment s' v = m) ↔
        (∃ v, isVertex v = true ∧ moment s v = m) := by
  intro s'
  have ha' : 0 < k₁ * a := Nat.mul_pos hk₁ ha
  have hb' : 0 < k₂ * b := Nat.mul_pos hk₂ hb
  have hc' : 0 < k₃ * c := Nat.mul_pos hk₃ hc
  have da : a ∣ k₁ * a := Nat.dvd_mul_left a k₁
  have db : b ∣ k₂ * b := Nat.dvd_mul_left b k₂
  have dc : c ∣ k₃ * c := Nat.dvd_mul_left c k₃
  exact ⟨frozen_repeat_iff ha hb hc ha' hb' hc' da db dc s,
    odd_repeat_iff ha hb hc ha' hb' hc' da db dc s,
    moments_repeat_iff ha hb hc ha' hb' hc' da db dc s⟩

end Periodicity
