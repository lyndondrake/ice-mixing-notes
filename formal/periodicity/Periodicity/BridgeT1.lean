import Periodicity.Bridge
import Theorem1.Basic
import Theorem1.Decide
import Theorem1.Counts
import Theorem1.Structured

/-!
# The bridge to `formal/theorem1`: the `(1,1,1)` cell

`formal/theorem1` models the `(1,1,1)` cell as a `4 × 4` Boolean matrix
`M g k` (A coset `g`, direction `k`; the B end of the bond `(g, k)` has label
`g ⊻ k`), and its README names the trust boundary of that development: that the
matrix model *is* the `(1,1,1)` cell was checked only in Python.  This file
closes that boundary from the side of the general model, against theorem1's own
definitions (imported, not copied).

* `ice_iff_theorem1`: for every matrix `M`, the state `ofMat M` of the general
  model on `(1,1,1)` obeys the ice rule iff `M` obeys theorem1's (R) and (B).
  Proved by hand for all `2¹⁶` matrices.
* `hex_to_theorem1`, `hex_of_theorem1`: the hexagons of the two models are the
  same bond cycles (as `(coset, direction)` pairs), up to rotation and
  reflection, in both directions.
* `frozen_iff_theorem1`, `zeroFlux_iff_theorem1`: on every ice state, freezing
  and zero flux agree with theorem1's `Flippable` and `ZeroFlux`; checked over
  theorem1's list of the 90 ice states, which theorem1 proves complete.
* `ice_count_111`, `w0_count_111`: hence the general model has, on `(1,1,1)`,
  exactly theorem1's 90 ice states and 12 zero-flux ones (in the sense that
  `ofMat` is a bijection from the matrices onto the A-bit assignments, and the
  conditions correspond), and `frozen_111` transfers theorem1's Theorem 1.
-/

namespace Periodicity

open Theorem1 (Mat IceA IceB Flippable b2n rowSum labSum xor4)

/-- The coset label of an A residue: `(0,0,0) ↦ 0`, `(0,2,2) ↦ 1`,
`(2,0,2) ↦ 2`, `(2,2,0) ↦ 3` (so that `d_k - (1,1,1)` has label `k`). -/
def coset (r : Res) : Fin 4 :=
  match r.1.val, r.2.1.val, r.2.2.val with
  | 0, 2, 2 => 1
  | 2, 0, 2 => 2
  | 2, 2, 0 => 3
  | _, _, _ => 0

/-- The state of the general model on `(1,1,1)` given by a matrix. -/
def ofMat (M : Mat) : State 1 1 1 := fun p k => M (coset (res p)) k

/-- The A point of coset `g`. -/
def aPt (g : Fin 4) : Res :=
  match g with
  | ⟨0, _⟩ => (⟨0, by decide⟩, ⟨0, by decide⟩, ⟨0, by decide⟩)
  | ⟨1, _⟩ => (⟨0, by decide⟩, ⟨2, by decide⟩, ⟨2, by decide⟩)
  | ⟨2, _⟩ => (⟨2, by decide⟩, ⟨0, by decide⟩, ⟨2, by decide⟩)
  | ⟨3, _⟩ => (⟨2, by decide⟩, ⟨2, by decide⟩, ⟨0, by decide⟩)

/-- The label of a B point: the coset of `q - (1,1,1)`. -/
def bco (q : Res) : Fin 4 := coset (res (q + -one3))

theorem aPt_spec : ∀ g : Fin 4, isA (aPt g) = true ∧ coset (res (aPt g)) = g := by decide

theorem bPt_spec : ∀ h : Fin 4,
    isA (aPt h + one3) = false ∧ isVertex (aPt h + one3) = true ∧ bco (aPt h + one3) = h := by
  decide

/-- The B end of the bond of direction `k` into the B point `q` lies in coset
`bco q ⊻ k`: the Klein-group labelling of theorem1. -/
theorem coset_B : ∀ q : Res, isA q = false → isB q = true →
    ∀ k : Fin 4, coset (res (q + -dvec k)) = xor4 (bco q) k := by decide

theorem toNat_b2n : ∀ x : Bool, x.toNat = b2n x := by decide

theorem loc_A {a b c : Nat} (s : State a b c) (v : Pt a b c) (h : isA v = true) :
    loc s v = fun k => s v k := by
  funext k; simp [loc, h]

theorem loc_B {a b c : Nat} (s : State a b c) (v : Pt a b c) (h : isA v = false) :
    loc s v = fun k => s (v + -dvec k) k := by
  funext k; simp [loc, h]

theorem cnt_row (M : Mat) (g : Fin 4) : cnt (fun k => M g k) = rowSum M g := by
  simp only [cnt, rowSum, toNat_b2n]

theorem cnt_lab (M : Mat) (h : Fin 4) : cnt (fun k => M (xor4 h k) k) = labSum M h := by
  simp only [cnt, labSum, toNat_b2n]

theorem loc_ofMat_B (M : Mat) (q : Res) (hA : isA q = false) (hB : isB q = true) :
    loc (ofMat M) q = fun k => M (xor4 (bco q) k) k := by
  rw [loc_B _ _ hA]; funext k; simp only [ofMat]; rw [coset_B q hA hB k]

/-- **The ice rule agrees with theorem1's (R) and (B), for every matrix.** -/
theorem ice_iff_theorem1 (M : Mat) : Ice (ofMat M) ↔ IceA M ∧ IceB M := by
  constructor
  · intro h
    refine ⟨fun g => ?_, fun g => ?_⟩
    · have hv := h (aPt g) (by simp [isVertex, (aPt_spec g).1])
      rw [loc_A _ _ (aPt_spec g).1] at hv
      simp only [ofMat, (aPt_spec g).2] at hv
      rw [cnt_row] at hv; exact hv
    · obtain ⟨hA, hV, hb⟩ := bPt_spec g
      have hB : isB (aPt g + one3) = true := by simpa [isVertex, hA] using hV
      have hv := h _ hV
      rw [loc_ofMat_B M _ hA hB, hb, cnt_lab] at hv
      exact hv
  · rintro ⟨hA, hB⟩ v hv
    cases hvA : isA v with
    | true =>
      rw [loc_A _ _ hvA]; simp only [ofMat]; rw [cnt_row]; exact hA _
    | false =>
      have hvB : isB v = true := by simpa [isVertex, hvA] using hv
      rw [loc_ofMat_B M v hvA hvB, cnt_lab]; exact hB _

/-! ## Hexagons -/

/-- Bond `t` of theorem1's hexagon `(g, i, j, k)` in cycle order, as
`(coset, direction)`: `(g,i), (a2,j), (a2,k), (a3,i), (a3,j), (g,k)`. -/
def t1Bond (g i j k : Fin 4) (t : Fin 6) : Fin 4 × Fin 4 :=
  match t with
  | ⟨0, _⟩ => (g, i)
  | ⟨1, _⟩ => (Theorem1.a2 g i j, j)
  | ⟨2, _⟩ => (Theorem1.a2 g i j, k)
  | ⟨3, _⟩ => (Theorem1.a3 g j k, i)
  | ⟨4, _⟩ => (Theorem1.a3 g j k, j)
  | ⟨5, _⟩ => (g, k)

/-- Bond `t` of the general model's hexagon `(O, j)` on `(1,1,1)`, as
`(coset, direction)`. -/
def myBond (h : Hex 1 1 1) (t : Fin 6) : Fin 4 × Fin 4 :=
  (coset (res (hexBond h t).1), (hexBond h t).2)

/-- Every hexagon of the general model on `(1,1,1)` is a hexagon of theorem1. -/
theorem hex_to_theorem1 : ∀ O : Res, ∀ j : Fin 4, isAHole O = true →
    ∃ g i j' k : Fin 4, i ≠ j' ∧ j' ≠ k ∧ i ≠ k ∧ ∃ r : Fin 6, ∃ rev : Bool,
      ∀ t : Fin 6, myBond (O, j) t = t1Bond g i j' k (matchIdx r rev t) := by
  decide +kernel

/-- Every hexagon of theorem1 is a hexagon of the general model on `(1,1,1)`. -/
theorem hex_of_theorem1 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k →
    ∃ O : Res, ∃ j' : Fin 4, isAHole O = true ∧ ∃ r : Fin 6, ∃ rev : Bool,
      ∀ t : Fin 6, t1Bond g i j k t = myBond (O, j') (matchIdx r rev t) := by
  decide +kernel

/-! ## Freezing and flux, over the 90 ice states -/

/-- theorem1's notion of frozen: no flippable hexagon. -/
def T1Frozen (M : Mat) : Prop := ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → ¬ Flippable M g i j k

instance (M : Mat) : Decidable (T1Frozen M) := by unfold T1Frozen; infer_instance

theorem frozen_flux_check :
    Theorem1.allB (fun M => (decide (Frozen (ofMat M)) == decide (Ice (ofMat M) ∧ T1Frozen M)) &&
      (decide (ZeroFlux (ofMat M)) == decide (Theorem1.ZeroFlux M))) Theorem1.iceStates = true := by
  decide +kernel

/-- On every ice state, freezing in the general model is theorem1's "no
flippable hexagon". -/
theorem frozen_iff_theorem1 (M : Mat) (hA : IceA M) (hB : IceB M) :
    Frozen (ofMat M) ↔ T1Frozen M := by
  have h := Theorem1.allB_forall frozen_flux_check M (Theorem1.iceStates_complete M hA hB)
  simp only [Bool.and_eq_true, beq_iff_eq] at h
  have h1 := h.1
  have hi : Ice (ofMat M) := (ice_iff_theorem1 M).2 ⟨hA, hB⟩
  constructor
  · intro hf; have := (decide_eq_true_iff.mp (h1 ▸ decide_eq_true hf)); exact this.2
  · intro ht; exact decide_eq_true_iff.mp (h1.symm ▸ decide_eq_true ⟨hi, ht⟩)

/-- On every ice state, zero flux in the general model is theorem1's (C). -/
theorem zeroFlux_iff_theorem1 (M : Mat) (hA : IceA M) (hB : IceB M) :
    ZeroFlux (ofMat M) ↔ Theorem1.ZeroFlux M := by
  have h := Theorem1.allB_forall frozen_flux_check M (Theorem1.iceStates_complete M hA hB)
  simp only [Bool.and_eq_true, beq_iff_eq] at h
  have h2 := h.2
  constructor
  · intro hf; exact decide_eq_true_iff.mp (h2 ▸ decide_eq_true hf)
  · intro ht; exact decide_eq_true_iff.mp (h2.symm ▸ decide_eq_true ht)

/-- The ice states of the general model on `(1,1,1)` are exactly `ofMat` of
theorem1's 90 ice states. -/
theorem ice_count_111 (M : Mat) : Ice (ofMat M) ↔ M ∈ Theorem1.iceStates :=
  ⟨fun h => Theorem1.iceStates_complete M ((ice_iff_theorem1 M).1 h).1 ((ice_iff_theorem1 M).1 h).2,
   fun h => (ice_iff_theorem1 M).2 (Theorem1.iceStates_sound M h)⟩

/-- The zero-flux ice states of the general model on `(1,1,1)` are exactly
`ofMat` of theorem1's 12. -/
theorem w0_count_111 (M : Mat) : Ice (ofMat M) ∧ ZeroFlux (ofMat M) ↔ M ∈ Theorem1.w0States := by
  constructor
  · rintro ⟨hi, hz⟩
    obtain ⟨hA, hB⟩ := (ice_iff_theorem1 M).1 hi
    exact Theorem1.w0States_complete M hA hB ((zeroFlux_iff_theorem1 M hA hB).1 hz)
  · intro h
    obtain ⟨hA, hB, hC⟩ := Theorem1.w0States_sound M h
    exact ⟨(ice_iff_theorem1 M).2 ⟨hA, hB⟩, (zeroFlux_iff_theorem1 M hA hB).2 hC⟩

/-- theorem1's Theorem 1, transferred: on `(1,1,1)` every zero-flux ice state of
the general model is frozen. -/
theorem frozen_111 (M : Mat) (hi : Ice (ofMat M)) (hz : ZeroFlux (ofMat M)) : Frozen (ofMat M) := by
  obtain ⟨hA, hB⟩ := (ice_iff_theorem1 M).1 hi
  exact (frozen_iff_theorem1 M hA hB).2
    (Theorem1.frozen M hA hB ((zeroFlux_iff_theorem1 M hA hB).1 hz))

/-- `ofMat` is injective on the A bits: two matrices with the same state agree. -/
theorem ofMat_injective (M N : Mat) (h : ∀ p : Res, isA p = true → ∀ k, ofMat M p k = ofMat N p k) :
    M = N := by
  funext g k
  have := h (aPt g) (aPt_spec g).1 k
  simp only [ofMat, (aPt_spec g).2] at this
  exact this

theorem aPt_coset : ∀ p : Res, isA p = true → aPt (coset (res p)) = p := by decide

/-- Every state of the general model on `(1,1,1)` agrees on its A bits with
`ofMat` of a matrix: with `ofMat_injective`, `ofMat` is a bijection from
matrices onto the A-bit assignments. -/
theorem ofMat_surjective (s : State 1 1 1) :
    ∃ M : Mat, ∀ p : Res, isA p = true → ∀ k, ofMat M p k = s p k :=
  ⟨fun g k => s (aPt g) k, fun p hp k => by simp only [ofMat]; rw [aPt_coset p hp]⟩

end Periodicity
