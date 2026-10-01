import Theorem1.Basic

/-!
# Theorem 1, structured proof

The hand argument, formalised step for step.

Let the hexagon be given by the coset `g` and the distinct directions `i, j, k`,
let `l = d4 i j k` be the fourth direction and `a4 = g ⊻ i ⊻ k` the fourth
A-site.  The three cells

* `z = (a3, k)`,
* `r = (a3, l)`,
* `u = (a4, k)`

lie off the hexagon; `z` and `r` share the row `a3`, `z` and `u` share the
column `k`, and `r` and `u` share the B-label `g ⊻ i`.  Each of those three
lines carries exactly two of the hexagon's six cells, one traversed A→B and one
traversed B→A, so on a flippable hexagon those two carry opposite bits and
contribute `1` to the line's sum of `2`.  Hence

    z + r = 1,   z + u = 1,   r + u = 1,

which no three natural numbers satisfy.
-/

namespace Theorem1

/-! ## The finite facts about `Fin 4`

All proved by exhausting `Fin 4` — this is the honest content of "the cosets
form the Klein group and the four directions are its four elements". -/

theorem i_ne_d4 : ∀ i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → i ≠ d4 i j k := by decide
theorem j_ne_d4 : ∀ i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → j ≠ d4 i j k := by decide
theorem k_ne_d4 : ∀ i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → k ≠ d4 i j k := by decide

theorem a2_ne_a1 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → a2 g i j ≠ g := by decide
theorem a2_ne_a3 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → a2 g i j ≠ a3 g j k := by decide
theorem a2_ne_a4 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → a2 g i j ≠ a4 g i k := by decide
theorem a1_ne_a3 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → g ≠ a3 g j k := by decide
theorem a1_ne_a4 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → g ≠ a4 g i k := by decide
theorem a3_ne_a4 : ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → a3 g j k ≠ a4 g i k := by decide

/-! The four cells of the B-label `h = g ⊻ i`: one per direction, at the coset
`h ⊻ d`.  Two of them are hexagon cells (`(g,i)` traversed A→B and `(a2,j)`
traversed B→A) and the other two are the obstruction cells `u` and `r`. -/

theorem lab_i : ∀ g i : Fin 4, (g ⊻ i) ⊻ i = g := by decide
theorem lab_j : ∀ g i j : Fin 4, (g ⊻ i) ⊻ j = a2 g i j := by decide
theorem lab_k : ∀ g i k : Fin 4, (g ⊻ i) ⊻ k = a4 g i k := by decide
theorem lab_l : ∀ g i j k : Fin 4, (g ⊻ i) ⊻ d4 i j k = a3 g j k := by decide

/-! ## The three lines -/

/-- **Row `a3`.**  Its four cells are `(a3,j)` and `(a3,i)` — on the hexagon,
one of each traversal class — together with `z = (a3,k)` and `r = (a3,l)`.  On
a flippable hexagon the first two are opposite, so `z + r = 1`. -/
theorem row_line (M : Mat) (hA : IceA M) {g i j k : Fin 4}
    (hij : i ≠ j) (hjk : j ≠ k) (hik : i ≠ k) {b : Bool}
    (e3 : M (a3 g j k) j = b) (e5 : M (a3 g j k) i = !b) :
    b2n (M (a3 g j k) k) + b2n (M (a3 g j k) (d4 i j k)) = 1 := by
  have h := hA (a3 g j k)
  rw [rowSum_perm M (a3 g j k) (a := j) (b := i) (c := k) (d := d4 i j k)
      (Ne.symm hij) hjk (j_ne_d4 i j k hij hjk hik) hik
      (i_ne_d4 i j k hij hjk hik) (k_ne_d4 i j k hij hjk hik), e3, e5] at h
  have := b2n_add_not b
  omega

/-- **Column `k`.**  Its four cells are `(a2,k)` and `(g,k)` — on the hexagon,
one of each traversal class — together with `z = (a3,k)` and `u = (a4,k)`.  So
`z + u = 1`. -/
theorem col_line (M : Mat) (hC : ZeroFlux M) {g i j k : Fin 4}
    (hij : i ≠ j) (hjk : j ≠ k) (hik : i ≠ k) {b : Bool}
    (e2 : M (a2 g i j) k = b) (e6 : M g k = !b) :
    b2n (M (a3 g j k) k) + b2n (M (a4 g i k) k) = 1 := by
  have h := hC k
  rw [colSum_perm M k (a := a2 g i j) (b := g) (c := a3 g j k) (d := a4 g i k)
      (a2_ne_a1 g i j k hij hjk hik) (a2_ne_a3 g i j k hij hjk hik)
      (a2_ne_a4 g i j k hij hjk hik) (a1_ne_a3 g i j k hij hjk hik)
      (a1_ne_a4 g i j k hij hjk hik) (a3_ne_a4 g i j k hij hjk hik), e2, e6] at h
  have := b2n_add_not b
  omega

/-- **B-label `g ⊻ i`.**  Its four cells are `(g,i)` and `(a2,j)` — on the
hexagon, one of each traversal class — together with `u = (a4,k)` and
`r = (a3,l)`.  So `u + r = 1`. -/
theorem lab_line (M : Mat) (hB : IceB M) {g i j k : Fin 4}
    (hij : i ≠ j) (hjk : j ≠ k) (hik : i ≠ k) {b : Bool}
    (e1 : M g i = b) (e4 : M (a2 g i j) j = !b) :
    b2n (M (a4 g i k) k) + b2n (M (a3 g j k) (d4 i j k)) = 1 := by
  have h := hB (g ⊻ i)
  rw [labSum_perm M (g ⊻ i) (a := i) (b := j) (c := k) (d := d4 i j k)
      hij hik (i_ne_d4 i j k hij hjk hik) hjk
      (j_ne_d4 i j k hij hjk hik) (k_ne_d4 i j k hij hjk hik),
      lab_i g i, lab_j g i j, lab_k g i k, lab_l g i j k, e1, e4] at h
  have := b2n_add_not b
  omega

/-! ## The theorem -/

/-- **Theorem 1.**  In the `4 x 4` matrix model of the `(1,1,1)` pyrochlore
cell, a state obeying the ice rule at the A-sites (R), the ice rule at the
B-sites (B) and zero flux (C) has no flippable hexagon: it is frozen. -/
theorem no_flippable_hexagon (M : Mat) (hA : IceA M) (hB : IceB M) (hC : ZeroFlux M)
    (g i j k : Fin 4) (hij : i ≠ j) (hjk : j ≠ k) (hik : i ≠ k) :
    ¬ Flippable M g i j k := by
  intro hflip
  have ⟨b, e1, e2, e3, e4, e5, e6⟩ := hflip
  -- the three off-hexagon cells, as 0/1 numbers
  have hzr : b2n (M (a3 g j k) k) + b2n (M (a3 g j k) (d4 i j k)) = 1 :=
    row_line M hA hij hjk hik e3 e5
  have hzu : b2n (M (a3 g j k) k) + b2n (M (a4 g i k) k) = 1 :=
    col_line M hC hij hjk hik e2 e6
  have hru : b2n (M (a4 g i k) k) + b2n (M (a3 g j k) (d4 i j k)) = 1 :=
    lab_line M hB hij hjk hik e1 e4
  -- z + r = z + u = r + u = 1 is impossible: it would make 2(z+r+u) = 3
  omega

/-- The same statement with the hexagon quantified as in
`icemix.frozen.model_hexagons`: over every coset and every ordered triple of
distinct directions. -/
theorem frozen (M : Mat) (hA : IceA M) (hB : IceB M) (hC : ZeroFlux M) :
    ∀ g i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k → ¬ Flippable M g i j k :=
  fun g i j k hij hjk hik => no_flippable_hexagon M hA hB hC g i j k hij hjk hik

end Theorem1
