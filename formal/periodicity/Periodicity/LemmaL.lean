import Periodicity.Flux

/-!
# Lemma L: in a frozen state every hexagon has exactly two reversals

`docs/notes/curl-reduction.md`, Lemma L, with the proof of the note (read again
by pacheck, V1): twelve hexagon slots pass through a vertex, two for each of the
six pairs of its bonds, and the vertex is a reversal for exactly the four slots
whose pair is one of its two kinked pairs (two bits set, or two clear).  Summing
over vertices, the reversals number `4|V| = 8|A|`, which is twice the number of
hexagons `4|A|`.  A frozen state has no circulating hexagon, and the number of
reversals of a hexagon is even, so every hexagon has at least two, hence exactly
two.

The count is by slots, as pacheck notes, so it holds on small cells where
vertices of a hexagon coincide.  The double count is a reindexing of a sum over
the torus by the translation from a hole to the vertex at a given slot of its
hexagon (`sumPtI_translate`).
-/

namespace Periodicity

/-! ## Integer sums -/

theorem sumI_congr (n : Nat) {f g : Fin n → Int} (h : ∀ i, f i = g i) : sumI n f = sumI n g := by
  rw [funext h]

theorem sumI_zero : ∀ n : Nat, sumI n (fun _ => 0) = 0
  | 0 => rfl
  | n + 1 => by simp only [sumI]; rw [sumI_zero n]; rfl

theorem sumI_add : ∀ (n : Nat) (f g : Fin n → Int),
    sumI n (fun i => f i + g i) = sumI n f + sumI n g
  | 0, _, _ => rfl
  | n + 1, f, g => by simp only [sumI]; rw [sumI_add n]; omega

theorem sumI_ite (n : Nat) (c : Bool) (f : Fin n → Int) :
    sumI n (fun i => if c then f i else 0) = if c then sumI n f else 0 := by
  cases c
  · simp only [Bool.false_eq_true, if_false]; exact sumI_zero n
  · simp only [if_true]

theorem sumI_comm : ∀ (n m : Nat) (f : Fin n → Fin m → Int),
    sumI n (fun i => sumI m (f i)) = sumI m (fun k => sumI n (fun i => f i k))
  | 0, m, _ => by simp only [sumI]; rw [sumI_zero m]
  | n + 1, m, f => by
    simp only [sumI]
    rw [sumI_comm n m, sumI_add]

theorem sumPtI_congr {a b c : Nat} {f g : Pt a b c → Int} (h : ∀ p, f p = g p) :
    sumPtI f = sumPtI g := by rw [funext h]

theorem sumPtI_add {a b c : Nat} (f g : Pt a b c → Int) :
    sumPtI (fun p => f p + g p) = sumPtI f + sumPtI g := by
  simp only [sumPtI, sumI_add]

theorem sumPtI_zero {a b c : Nat} : sumPtI (fun _ : Pt a b c => (0 : Int)) = 0 := by
  simp only [sumPtI, sumI_zero]

theorem sumPtI_sumI {a b c : Nat} : ∀ (n : Nat) (H : Pt a b c → Fin n → Int),
    sumPtI (fun p => sumI n (H p)) = sumI n (fun i => sumPtI (fun p => H p i))
  | 0, _ => by simp only [sumI]; exact sumPtI_zero
  | n + 1, H => by
    simp only [sumI]
    rw [sumPtI_add, sumPtI_sumI n]

theorem sumPtI_eq_compk {a b c : Nat} (f : Pt a b c → Int) :
    sumPtI f = compk 0 (sumPt fun p => (⟨f p, 0, 0⟩ : V3)) := by
  rw [compk_sumPt]; rfl

/-- Integer sums over the torus are invariant under translation. -/
theorem sumPtI_translate {a b c : Nat} (f : Pt a b c → Int) (v : V3) :
    sumPtI (fun p => f (p + v)) = sumPtI f := by
  rw [sumPtI_eq_compk, sumPtI_eq_compk f]
  rw [sumPt_translate (fun q => (⟨f q, 0, 0⟩ : V3)) v]

theorem sumPtI_nonneg_eq_zero {a b c : Nat} (f : Pt a b c → Int) (h : ∀ p, 0 ≤ f p)
    (hz : sumPtI f = 0) (p0 : Pt a b c) : f p0 = 0 := by
  have := h p0
  by_cases hp : 0 < f p0
  · have := sumPtI_pos f h p0 hp; omega
  · omega

/-! ## The vertex at each slot of a hexagon -/

/-- The slot before `t` round the hexagon. -/
def prev6 (t : Fin 6) : Fin 6 := ⟨(t.val + 5) % 6, Nat.mod_lt _ (by decide)⟩

/-- The offset from the hole of vertex `t` of the hexagon `(O, d_j)` (between
bonds `t - 1` and `t`): A vertices at even `t`, B vertices at odd `t`. -/
def vOff (j : Fin 4) (t : Fin 6) : V3 :=
  match t with
  | ⟨0, _⟩ => hexOff j 0
  | ⟨1, _⟩ => hexOff j 0 + dvec (hexDir j 0)
  | ⟨2, _⟩ => hexOff j 1
  | ⟨3, _⟩ => hexOff j 2 + dvec (hexDir j 2)
  | ⟨4, _⟩ => hexOff j 3
  | ⟨5, _⟩ => hexOff j 4 + dvec (hexDir j 4)

/-- From the vertex to the A end of a bond at it: `0` at an A vertex, `-d` at a
B vertex. -/
def corr (j : Fin 4) (t i : Fin 6) : V3 := if t.val % 2 = 0 then 0 else -dvec (hexDir j i)

theorem ends_at_vertex : ∀ j : Fin 4, ∀ t : Fin 6,
    hexOff j (prev6 t) = vOff j t + corr j t (prev6 t) ∧ hexOff j t = vOff j t + corr j t t := by
  decide

theorem vertex_class : ∀ r : Res, isA4 (r + -two0) = true → ∀ j : Fin 4, ∀ t : Fin 6,
    isA4 (r + vOff j t) = (t.val % 2 == 0) := by
  decide

theorem hole_of_vertex : ∀ r : Res, ∀ j : Fin 4, ∀ t : Fin 6,
    isA4 (r + -vOff j t + -two0) = (if t.val % 2 = 0 then isA4 r else isA4 (r + -one3)) := by
  decide

theorem add_neg_V3 (u : V3) : -u + u = 0 := V3.ext (by simp; omega) (by simp; omega) (by simp; omega)

theorem add_zero_V3 (u : V3) : u + 0 = u := V3.add_zero' u

/-- The bit of a hexagon bond at slot `t` is a bit of the vertex there. -/
theorem hbit_loc {a b c : Nat} (s : State a b c) (O : Pt a b c) (hO : isAHole O = true)
    (j : Fin 4) (t i : Fin 6) (hi : hexOff j i = vOff j t + corr j t i) :
    hbit s (O, j) i = loc s (O + vOff j t) (hexDir j i) := by
  have hcls : isA (O + vOff j t) = (t.val % 2 == 0) := by
    simp only [isAHole, isA, res_add] at hO ⊢; exact vertex_class _ hO j t
  simp only [hbit, hexBond, hi, ← Pt.add_add, loc, hcls, corr]
  by_cases ht : t.val % 2 = 0
  · have h' : (t.val % 2 == 0) = true := beq_iff_eq.mpr ht
    rw [if_pos ht, if_pos h', Pt.add_zero]
  · have h' : (t.val % 2 == 0) = false := by
      cases h : (t.val % 2 == 0) with
      | false => rfl
      | true => exact absurd (beq_iff_eq.mp h) ht
    rw [if_neg ht, h']
    rfl

/-- A reversal at slot `t` is an equality of two bits of the vertex there. -/
theorem reversal_loc {a b c : Nat} (s : State a b c) (O : Pt a b c) (hO : isAHole O = true)
    (j : Fin 4) (t : Fin 6) :
    reversal s (O, j) t =
      (loc s (O + vOff j t) (hexDir j (prev6 t)) == loc s (O + vOff j t) (hexDir j t)) := by
  show (hbit s (O, j) (prev6 t) == hbit s (O, j) t) = _
  rw [hbit_loc s O hO j t (prev6 t) (ends_at_vertex j t).1,
    hbit_loc s O hO j t t (ends_at_vertex j t).2]

/-! ## The local count at a vertex -/

/-- The reversal indicator of slot `(j, t)` at a vertex with bits `l`. -/
def revAt (l : Fin 4 → Bool) (j : Fin 4) (t : Fin 6) : Int :=
  ((l (hexDir j (prev6 t)) == l (hexDir j t)).toNat : Int)

theorem local_rev_core : ∀ b0 b1 b2 b3 : Bool, cnt (mk4b b0 b1 b2 b3) = 2 →
    sumI 4 (fun j => sumI 6 (fun t => if t.val % 2 = 0 then revAt (mk4b b0 b1 b2 b3) j t else 0)) = 4 ∧
    sumI 4 (fun j => sumI 6 (fun t => if t.val % 2 = 0 then 0 else revAt (mk4b b0 b1 b2 b3) j t)) = 4 := by
  decide

/-- A vertex obeying the ice rule is a reversal for exactly four of the twelve
slots through it, at an A vertex (even slots) and at a B vertex (odd slots). -/
theorem local_rev (l : Fin 4 → Bool) (h : cnt l = 2) :
    sumI 4 (fun j => sumI 6 (fun t => if t.val % 2 = 0 then revAt l j t else 0)) = 4 ∧
    sumI 4 (fun j => sumI 6 (fun t => if t.val % 2 = 0 then 0 else revAt l j t)) = 4 := by
  rw [eta4 l] at h ⊢; exact local_rev_core _ _ _ _ h

/-- The number of reversals of a non-circulating hexagon is even and at least two. -/
theorem nrev_core : ∀ b0 b1 b2 b3 b4 b5 : Bool,
    (b5 == b0).toNat + (b0 == b1).toNat + (b1 == b2).toNat + (b2 == b3).toNat +
      (b3 == b4).toNat + (b4 == b5).toNat ≠ 0 →
    2 ≤ (b5 == b0).toNat + (b0 == b1).toNat + (b1 == b2).toNat + (b2 == b3).toNat +
      (b3 == b4).toNat + (b4 == b5).toNat ∧
    ((b5 == b0).toNat + (b0 == b1).toNat + (b1 == b2).toNat + (b2 == b3).toNat +
      (b3 == b4).toNat + (b4 == b5).toNat) % 2 = 0 := by decide

theorem nrev_even_ge {a b c : Nat} (s : State a b c) (h : Hex a b c) (hc : ¬ Circulates s h) :
    2 ≤ nrev s h ∧ nrev s h % 2 = 0 :=
  nrev_core (hbit s h 0) (hbit s h 1) (hbit s h 2) (hbit s h 3) (hbit s h 4) (hbit s h 5) hc

theorem nrev_sumI {a b c : Nat} (s : State a b c) (h : Hex a b c) :
    (nrev s h : Int) = sumI 6 (fun t => ((reversal s h t).toNat : Int)) := by
  simp only [nrev, sumI]; push_cast; (try omega)

/-! ## The double count -/

section
variable {a b c : Nat} (s : State a b c)

/-- The reversals of all hexagons, summed over holes. -/
def totalRev : Int :=
  sumPtI fun O : Pt a b c => if isAHole O then sumI 4 (fun j => (nrev s (O, j) : Int)) else 0

/-- The class of a point at slot `t`: A for even slots, B for odd. -/
def slotClass (t : Fin 6) (v : Pt a b c) : Bool := if t.val % 2 = 0 then isA v else isB v

theorem slot_sum (j : Fin 4) (t : Fin 6) :
    sumPtI (fun O : Pt a b c => if isAHole O then ((reversal s (O, j) t).toNat : Int) else 0) =
    sumPtI (fun v : Pt a b c => if slotClass t v then revAt (loc s v) j t else 0) := by
  rw [← sumPtI_translate (fun O : Pt a b c =>
    if isAHole O then ((reversal s (O, j) t).toNat : Int) else 0) (-vOff j t)]
  apply sumPtI_congr; intro v
  have hcls : isAHole (v + -vOff j t) = slotClass t v := by
    simp only [isAHole, slotClass, isB, isA, res_add]
    rw [hole_of_vertex]
  rw [hcls]
  cases hv : slotClass t v
  · rfl
  · simp only [if_true]
    rw [reversal_loc s _ (hcls.trans hv) j t, Pt.add_add, add_neg_V3, Pt.add_zero]
    rfl

theorem isA_isB_excl (v : Pt a b c) (hB : isB v = true) : isA v = false := isA_of_isB v hB

include s in
theorem totalRev_eq (hi : Ice s) :
    totalRev s = sumPtI (fun v : Pt a b c => if isVertex v then 4 else 0) := by
  unfold totalRev
  have e1 : ∀ O : Pt a b c, (if isAHole O then sumI 4 (fun j => (nrev s (O, j) : Int)) else 0) =
      sumI 4 (fun j => sumI 6 (fun t =>
        if isAHole O then ((reversal s (O, j) t).toNat : Int) else 0)) := by
    intro O
    simp only [sumI_ite, nrev_sumI]
  rw [sumPtI_congr e1, sumPtI_sumI]
  simp only [sumPtI_sumI, slot_sum s]
  simp only [← sumPtI_sumI]
  apply sumPtI_congr; intro v
  cases hA : isA v
  · cases hB : isB v
    · simp only [isVertex, hA, hB, Bool.or_false, Bool.false_eq_true, if_false, slotClass,
        ite_self, sumI_zero]
    · have hl := (local_rev (loc s v) (hi v (by simp [isVertex, hB]))).2
      simp only [isVertex, hA, hB, Bool.or_true, if_true]
      rw [← hl]
      apply sumI_congr; intro j; apply sumI_congr; intro t
      simp only [slotClass, hA, hB]
      by_cases ht : t.val % 2 = 0 <;> simp [ht]
  · have hl := (local_rev (loc s v) (hi v (by simp [isVertex, hA]))).1
    have hB : isB v = false := by
      cases h : isB v
      · rfl
      · rw [isA_isB_excl v h] at hA; cases hA
    simp only [isVertex, hA, Bool.true_or, if_true]
    rw [← hl]
    apply sumI_congr; intro j; apply sumI_congr; intro t
    simp only [slotClass, hA, hB]
    by_cases ht : t.val % 2 = 0 <;> simp [ht]

end

/-- The number of A sites. -/
def numA (a b c : Nat) : Int := sumPtI fun p : Pt a b c => if isA p then 1 else 0

theorem vertex_count (a b c : Nat) :
    sumPtI (fun v : Pt a b c => if isVertex v then 4 else 0) = 8 * numA a b c := by
  have hB : sumPtI (fun v : Pt a b c => if isB v then 1 else 0) = numA a b c := by
    unfold numA isB
    exact sumPtI_translate (fun p : Pt a b c => if isA p then (1 : Int) else 0) (-one3)
  have e : ∀ v : Pt a b c, (if isVertex v then (4 : Int) else 0) =
      4 * (if isA v then 1 else 0) + 4 * (if isB v then 1 else 0) := by
    intro v
    cases hA : isA v
    · cases hB' : isB v <;> simp [isVertex, hA, hB']
    · have hB' : isB v = false := by
        cases h : isB v
        · rfl
        · rw [isA_of_isB v h] at hA; cases hA
      simp [isVertex, hA, hB']
  rw [sumPtI_congr e, sumPtI_add]
  have m1 : sumPtI (fun v : Pt a b c => 4 * (if isA v then (1 : Int) else 0)) = 4 * numA a b c :=
    sumPtI_mul 4 _
  have m2 : sumPtI (fun v : Pt a b c => 4 * (if isB v then (1 : Int) else 0)) = 4 * numA a b c := by
    rw [sumPtI_mul 4 _, hB]
  rw [m1, m2]; omega

theorem hole_count (a b c : Nat) :
    sumPtI (fun O : Pt a b c => if isAHole O then (8 : Int) else 0) = 8 * numA a b c := by
  have : sumPtI (fun O : Pt a b c => if isAHole O then (1 : Int) else 0) = numA a b c := by
    unfold numA isAHole
    exact sumPtI_translate (fun p : Pt a b c => if isA p then (1 : Int) else 0) (-two0)
  rw [← this, ← sumPtI_mul]
  apply sumPtI_congr; intro O
  cases isAHole O <;> simp

/-- **Lemma L** (curl-reduction).  In a frozen state every hexagon has exactly
two reversals. -/
theorem lemmaL_proved {a b c : Nat} (s : State a b c) (hf : Frozen s) (h : Hex a b c)
    (hv : h.valid = true) : nrev s h = 2 := by
  obtain ⟨O0, j0⟩ := h
  -- D(O) = Σ_j (nrev - 2) over the hexagons at O: nonnegative, total zero
  let D : Pt a b c → Int := fun O =>
    if isAHole O then sumI 4 (fun j => (nrev s (O, j) : Int) - 2) else 0
  have hD : ∀ O, 0 ≤ D O := by
    intro O
    simp only [D]
    cases hO : isAHole O
    · simp
    · simp only [if_true]
      apply sumI_nonneg; intro j
      have := (nrev_even_ge s (O, j) (hf.2 (O, j) hO)).1
      omega
  have hsum : sumPtI D = 0 := by
    have e : ∀ O : Pt a b c, D O =
        (if isAHole O then sumI 4 (fun j => (nrev s (O, j) : Int)) else 0) +
          -(if isAHole O then (8 : Int) else 0) := by
      intro O
      simp only [D]
      cases isAHole O
      · simp
      · simp only [if_true]
        have : sumI 4 (fun j => (nrev s (O, j) : Int) - 2) =
            sumI 4 (fun j => (nrev s (O, j) : Int)) + sumI 4 (fun _ => (-2 : Int)) := by
          rw [← sumI_add]; apply sumI_congr; intro j; omega
        rw [this]; simp [sumI]; (try omega)
    rw [sumPtI_congr e, sumPtI_add]
    have hneg : sumPtI (fun O : Pt a b c => -(if isAHole O then (8 : Int) else 0)) =
        -(8 * numA a b c) := by
      rw [← hole_count]
      have := sumPtI_mul (-1) (fun O : Pt a b c => if isAHole O then (8 : Int) else 0)
      rw [show (fun O : Pt a b c => -(if isAHole O then (8 : Int) else 0)) =
        (fun O => -1 * (if isAHole O then (8 : Int) else 0)) from funext fun _ => by omega]
      rw [this]; omega
    have ht := totalRev_eq s hf.1
    unfold totalRev at ht
    rw [ht, vertex_count, hneg]; omega
  have hO0 := sumPtI_nonneg_eq_zero D hD hsum O0
  simp only [D, Hex.valid] at hO0 hv
  rw [hv] at hO0
  simp only [if_true] at hO0
  -- every term of the inner sum is nonnegative and the sum is zero
  have hterm : ∀ j, 0 ≤ (nrev s (O0, j) : Int) - 2 := by
    intro j; have := (nrev_even_ge s (O0, j) (hf.2 (O0, j) hv)).1; omega
  by_cases hp : 0 < (nrev s (O0, j0) : Int) - 2
  · have := sumI_pos 4 _ hterm j0 hp; omega
  · have := hterm j0; omega

/-! ## The two forms of oddness agree -/

theorem odd_core : ∀ b0 b1 b2 b3 b4 b5 : Bool,
    (b5 == b0).toNat + (b0 == b1).toNat + (b1 == b2).toNat + (b2 == b3).toNat +
      (b3 == b4).toNat + (b4 == b5).toNat = 2 →
    ((b0 ^^ b1 ^^ b2 ^^ b3 ^^ b4 ^^ b5) = true ↔
      (((b5 == b0) || (b1 == b2) || (b3 == b4)) && ((b0 == b1) || (b2 == b3) || (b4 == b5))) = false) := by
  decide

/-- **The two forms of oddness agree** (curl-reduction, after Lemma L: "an odd
hexagon has its two reversals at distance two"; theorem-h-orientation, "odd
curl when they lie on the same [sublattice]").  In a frozen state a hexagon has
odd curl iff its reversals do not occur on both sublattices (slots `0, 2, 4` are
its A vertices and `1, 3, 5` its B vertices); with Lemma L it has two, so iff
both lie on one sublattice. -/
theorem curl_iff_same_sublattice {a b c : Nat} (s : State a b c) (hf : Frozen s) (h : Hex a b c)
    (hv : h.valid = true) :
    curl s h = true ↔
      ((reversal s h 0 || reversal s h 2 || reversal s h 4) &&
        (reversal s h 1 || reversal s h 3 || reversal s h 5)) = false :=
  odd_core (hbit s h 0) (hbit s h 1) (hbit s h 2) (hbit s h 3) (hbit s h 4) (hbit s h 5)
    (lemmaL_proved s hf h hv)

end Periodicity
