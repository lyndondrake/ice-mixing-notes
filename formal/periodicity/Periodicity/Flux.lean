import Periodicity.LemmaA

/-!
# Zero flux balances every axis on each sublattice

`docs/notes/curl-reduction.md`, the remark after Lemma A, with the one-line
proof of pacheck (V2): at a vertex obeying the ice rule the sum over its four
bonds of `±d_k` (`+` for a set bit) is `4 n(v)`, four times its moment, so the
flux is four times the sum of the moments of A, and, counting each bond from its
B end instead, four times the sum of the moments of B.  At zero flux both sums
vanish, so on each sublattice every axis carries as many `+` as `-` moments, and
an axis that is one-way is empty.

The counting from the B end is a reindexing of a sum over the torus by the
translation `q = p + d_k`, which needs the invariance of sums under translation
(`sumPt_translate`), proved here from scratch since core Lean has no finite-sum
library.
-/

namespace Periodicity

namespace V3
theorem add_comm' (u v : V3) : u + v = v + u := ext (Int.add_comm _ _) (Int.add_comm _ _) (Int.add_comm _ _)
theorem add_assoc' (u v w : V3) : u + v + w = u + (v + w) :=
  ext (Int.add_assoc _ _ _) (Int.add_assoc _ _ _) (Int.add_assoc _ _ _)
theorem zero_add' (u : V3) : 0 + u = u := ext (by simp) (by simp) (by simp)
theorem add_zero' (u : V3) : u + 0 = u := ext (by simp) (by simp) (by simp)
end V3

/-! ## Finite sums of vectors -/

theorem sumFin_congr (n : Nat) {f g : Fin n → V3} (h : ∀ i, f i = g i) : sumFin n f = sumFin n g := by
  rw [funext h]

theorem sumFin_zero : ∀ n : Nat, sumFin n (fun _ => (0 : V3)) = 0
  | 0 => rfl
  | n + 1 => by simp only [sumFin]; rw [sumFin_zero n, V3.add_zero']

theorem sumFin_add : ∀ (n : Nat) (f g : Fin n → V3),
    sumFin n (fun i => f i + g i) = sumFin n f + sumFin n g
  | 0, _, _ => by simp only [sumFin]; rw [V3.add_zero']
  | n + 1, f, g => by
    simp only [sumFin]
    rw [sumFin_add n]
    apply V3.ext <;> simp <;> omega

theorem sumFin_smul : ∀ (n : Nat) (m : Int) (f : Fin n → V3),
    sumFin n (fun i => V3.smul m (f i)) = V3.smul m (sumFin n f)
  | 0, _, _ => by apply V3.ext <;> simp [sumFin]
  | n + 1, m, f => by
    simp only [sumFin]
    rw [sumFin_smul n]
    apply V3.ext <;> simp [Int.mul_add]

theorem sumFin_ite (n : Nat) (c : Bool) (f : Fin n → V3) :
    sumFin n (fun i => if c then f i else 0) = if c then sumFin n f else 0 := by
  cases c
  · simp only [Bool.false_eq_true, if_false]; exact sumFin_zero n
  · simp only [if_true]

/-- Peeling off the first term instead of the last. -/
theorem sumFin_succ' : ∀ (n : Nat) (f : Fin (n + 1) → V3),
    sumFin (n + 1) f = f ⟨0, by omega⟩ + sumFin n (fun i => f ⟨i.val + 1, by omega⟩)
  | 0, f => by simp only [sumFin]; rw [V3.zero_add', V3.add_zero']
  | n + 1, f => by
    rw [sumFin, sumFin_succ' n]
    simp only [sumFin]
    rw [V3.add_assoc']

/-- A sum over `Fin n` is invariant under the rotation `x ↦ x + 1`. -/
theorem sumFin_rot : ∀ (n : Nat) (g : Fin n → V3), sumFin n (fun x => g (wrap x 1)) = sumFin n g
  | 0, _ => rfl
  | k + 1, g => by
    have hlast : wrap (⟨k, by omega⟩ : Fin (k + 1)) 1 = ⟨0, by omega⟩ := by
      apply fin_ext_int; rw [wrap_val]; simp
    have hmid : ∀ i : Fin k, wrap (⟨i.val, by omega⟩ : Fin (k + 1)) 1 = ⟨i.val + 1, by omega⟩ := by
      intro i; apply fin_ext_int; rw [wrap_val]; push_cast
      exact Int.emod_eq_of_lt (by omega) (by have := i.isLt; omega)
    rw [sumFin_succ' k g]
    simp only [sumFin]
    rw [hlast, sumFin_congr k (fun i => congrArg g (hmid i)), V3.add_comm']

theorem sumFin_wrap_nat (n : Nat) : ∀ (m : Nat) (g : Fin n → V3),
    sumFin n (fun x => g (wrap x (m : Int))) = sumFin n g
  | 0, g => by simp only [Int.natCast_zero, wrap_zero]
  | m + 1, g => by
    have e : ∀ x : Fin n, wrap x ((m + 1 : Nat) : Int) = wrap (wrap x (m : Int)) 1 := by
      intro x; rw [wrap_wrap]; simp
    rw [sumFin_congr n (fun x => congrArg g (e x))]
    rw [sumFin_wrap_nat n m (fun y => g (wrap y 1)), sumFin_rot]

/-- A sum over `Fin n` is invariant under every rotation. -/
theorem sumFin_wrap (n : Nat) (g : Fin n → V3) (d : Int) :
    sumFin n (fun x => g (wrap x d)) = sumFin n g := by
  cases n with
  | zero => rfl
  | succ k =>
    have hn : (0 : Int) < ((k + 1 : Nat) : Int) := by omega
    have h0 := Int.emod_nonneg d (Int.ne_of_gt hn)
    have e : ∀ x : Fin (k + 1), wrap x d = wrap x (((d % ((k + 1 : Nat) : Int)).toNat : Nat) : Int) := by
      intro x; apply wrap_congr
      rw [Int.toNat_of_nonneg h0, Int.emod_def]
      exact ⟨d / ((k + 1 : Nat) : Int), by omega⟩
    rw [sumFin_congr _ (fun x => congrArg g (e x)), sumFin_wrap_nat]

/-! ## Sums over the cell -/

theorem sumPt_congr {a b c : Nat} {f g : Pt a b c → V3} (h : ∀ p, f p = g p) :
    sumPt f = sumPt g := by rw [funext h]

theorem sumPt_add {a b c : Nat} (f g : Pt a b c → V3) :
    sumPt (fun p => f p + g p) = sumPt f + sumPt g := by
  simp only [sumPt, sumFin_add]

theorem sumPt_smul {a b c : Nat} (m : Int) (f : Pt a b c → V3) :
    sumPt (fun p => V3.smul m (f p)) = V3.smul m (sumPt f) := by
  simp only [sumPt, sumFin_smul]

/-- **Sums over the torus are invariant under translation.** -/
theorem sumPt_translate {a b c : Nat} (f : Pt a b c → V3) (v : V3) :
    sumPt (fun p => f (p + v)) = sumPt f := by
  simp only [sumPt, Pt.add_def]
  have h1 : ∀ x y, sumFin (4 * c) (fun z => f (wrap x v.x, wrap y v.y, wrap z v.z)) =
      sumFin (4 * c) (fun z => f (wrap x v.x, wrap y v.y, z)) :=
    fun x y => sumFin_wrap _ (fun z => f (wrap x v.x, wrap y v.y, z)) v.z
  simp only [h1]
  have h2 : ∀ x, sumFin (4 * b) (fun y => sumFin (4 * c) (fun z => f (wrap x v.x, wrap y v.y, z))) =
      sumFin (4 * b) (fun y => sumFin (4 * c) (fun z => f (wrap x v.x, y, z))) :=
    fun x => sumFin_wrap _ (fun y => sumFin (4 * c) (fun z => f (wrap x v.x, y, z))) v.y
  simp only [h2]
  exact sumFin_wrap _ (fun x => sumFin (4 * b) (fun y => sumFin (4 * c) (fun z => f (x, y, z)))) v.x

theorem sumPt_zero {a b c : Nat} : sumPt (fun _ : Pt a b c => (0 : V3)) = 0 := by
  simp only [sumPt, sumFin_zero]

/-- Exchange of a sum over the four directions with a sum over the cell. -/
theorem sumPt_sum4 {a b c : Nat} (H : Pt a b c → Fin 4 → V3) :
    sumPt (fun p => sumFin 4 (H p)) = sumFin 4 (fun k => sumPt (fun p => H p k)) := by
  simp only [sumFin, sumPt_add, sumPt_zero]

/-! ## The local identity: four bonds give four times the moment -/

/-- Four bits as a function. -/
def mk4b (b0 b1 b2 b3 : Bool) : Fin 4 → Bool
  | ⟨0, _⟩ => b0
  | ⟨1, _⟩ => b1
  | ⟨2, _⟩ => b2
  | ⟨3, _⟩ => b3

theorem eta4 (l : Fin 4 → Bool) : l = mk4b (l 0) (l 1) (l 2) (l 3) := by
  funext k
  match k with
  | ⟨0, _⟩ => rfl
  | ⟨1, _⟩ => rfl
  | ⟨2, _⟩ => rfl
  | ⟨3, _⟩ => rfl

/-- The signed direction of a bond as read at a vertex. -/
def sdir (l : Fin 4 → Bool) (k : Fin 4) : V3 := if l k then dvec k else -dvec k

theorem local_core : ∀ b0 b1 b2 b3 : Bool, cnt (mk4b b0 b1 b2 b3) = 2 →
    sumFin 4 (sdir (mk4b b0 b1 b2 b3)) =
      V3.smul 4 (axv (typ (mk4b b0 b1 b2 b3)) (if sgn (mk4b b0 b1 b2 b3) then 1 else -1)) := by
  decide

/-- At a vertex obeying the ice rule, the four signed bond directions add up to
four times the moment. -/
theorem local_moment (l : Fin 4 → Bool) (h : cnt l = 2) :
    sumFin 4 (sdir l) = V3.smul 4 (axv (typ l) (if sgn l then 1 else -1)) := by
  rw [eta4 l] at h ⊢; exact local_core _ _ _ _ h

theorem loc_eq_A {a b c : Nat} (s : State a b c) (v : Pt a b c) (h : isA v = true) :
    loc s v = fun k => s v k := by
  funext k; simp [loc, h]

theorem loc_eq_B {a b c : Nat} (s : State a b c) (v : Pt a b c) (h : isA v = false) :
    loc s v = fun k => s (v + -dvec k) k := by
  funext k; simp [loc, h]

theorem res_B_shift : ∀ k : Fin 4, ∀ r : Res, isA4 (r + dvec k + -one3) = isA4 r := by decide

theorem res_B_notA : ∀ r : Res, isA4 (r + -one3) = true → isA4 r = false := by decide

theorem isB_add_dvec {a b c : Nat} (p : Pt a b c) (k : Fin 4) : isB (p + dvec k) = isA p := by
  simp only [isB, isA, res_add]; exact res_B_shift k _

theorem isA_of_isB {a b c : Nat} (q : Pt a b c) (h : isB q = true) : isA q = false := by
  simp only [isB, isA, res_add] at h ⊢; exact res_B_notA _ h

theorem smul_ite (m : Int) (c : Bool) (u : V3) :
    (if c then V3.smul m u else 0) = V3.smul m (if c then u else 0) := by
  cases c
  · apply V3.ext <;> simp
  · rfl

/-- The flux is four times the sum of the moments of A. -/
theorem flux_A {a b c : Nat} (s : State a b c) (hi : Ice s) :
    flux s = V3.smul 4 (sumPt fun p => if isA p then momentVec s p else 0) := by
  unfold flux
  rw [← sumPt_smul]
  apply sumPt_congr; intro p
  rw [← smul_ite]
  cases hA : isA p
  · rfl
  · simp only [if_true]
    have hl := local_moment (loc s p) (hi p (by simp [isVertex, hA]))
    unfold momentVec vtype vsign
    rw [loc_eq_A s p hA] at hl ⊢
    exact hl

/-- The flux is four times the sum of the moments of B: each bond counted from
its B end. -/
theorem flux_B {a b c : Nat} (s : State a b c) (hi : Ice s) :
    flux s = V3.smul 4 (sumPt fun q => if isB q then momentVec s q else 0) := by
  unfold flux
  have step1 : (sumPt fun p : Pt a b c => if isA p then sumFin 4 (fun k => if s p k then dvec k else -dvec k) else 0)
      = sumFin 4 (fun k => sumPt (fun p : Pt a b c => if isA p then (if s p k then dvec k else -dvec k) else 0)) := by
    rw [← sumPt_sum4]; apply sumPt_congr; intro p; rw [sumFin_ite]
  have step2 : ∀ k : Fin 4,
      sumPt (fun p : Pt a b c => if isA p then (if s p k then dvec k else -dvec k) else 0) =
      sumPt (fun q : Pt a b c => if isB q then (if s (q + -dvec k) k then dvec k else -dvec k) else 0) := by
    intro k
    rw [← sumPt_translate (fun q : Pt a b c =>
      if isB q then (if s (q + -dvec k) k then dvec k else -dvec k) else 0) (dvec k)]
    apply sumPt_congr; intro p
    simp only [isB_add_dvec, Pt.add_add, dvec_add_neg, Pt.add_zero]
  rw [step1, sumFin_congr 4 step2, ← sumPt_sum4, ← sumPt_smul]
  apply sumPt_congr; intro q
  rw [sumFin_ite, ← smul_ite]
  cases hB : isB q
  · rfl
  · simp only [if_true]
    have hA := isA_of_isB q hB
    have hl := local_moment (loc s q) (hi q (by simp [isVertex, hB]))
    unfold momentVec vtype vsign
    rw [loc_eq_B s q hA] at hl ⊢
    exact hl

/-! ## Components and signs -/

/-- The `k`-th coordinate of a vector. -/
def compk (k : Fin 3) (u : V3) : Int :=
  match k with
  | ⟨0, _⟩ => u.x
  | ⟨1, _⟩ => u.y
  | ⟨2, _⟩ => u.z

theorem compk_add (k : Fin 3) (u v : V3) : compk k (u + v) = compk k u + compk k v := by
  match k with
  | ⟨0, _⟩ => rfl
  | ⟨1, _⟩ => rfl
  | ⟨2, _⟩ => rfl

theorem compk_zero (k : Fin 3) : compk k 0 = 0 := by
  match k with
  | ⟨0, _⟩ => rfl
  | ⟨1, _⟩ => rfl
  | ⟨2, _⟩ => rfl

theorem compk_smul (k : Fin 3) (m : Int) (u : V3) : compk k (V3.smul m u) = m * compk k u := by
  match k with
  | ⟨0, _⟩ => rfl
  | ⟨1, _⟩ => rfl
  | ⟨2, _⟩ => rfl

theorem compk_axv (k j : Fin 3) (m : Int) : compk k (axv j m) = if j = k then m else 0 := by
  match k, j with
  | ⟨0, _⟩, ⟨0, _⟩ => rfl
  | ⟨0, _⟩, ⟨1, _⟩ => rfl
  | ⟨0, _⟩, ⟨2, _⟩ => rfl
  | ⟨1, _⟩, ⟨0, _⟩ => rfl
  | ⟨1, _⟩, ⟨1, _⟩ => rfl
  | ⟨1, _⟩, ⟨2, _⟩ => rfl
  | ⟨2, _⟩, ⟨0, _⟩ => rfl
  | ⟨2, _⟩, ⟨1, _⟩ => rfl
  | ⟨2, _⟩, ⟨2, _⟩ => rfl

/-- Sum of integers over `Fin n`. -/
def sumI : (n : Nat) → (Fin n → Int) → Int
  | 0, _ => 0
  | n + 1, f => sumI n (fun i => f ⟨i.val, by omega⟩) + f ⟨n, by omega⟩

theorem compk_sumFin (k : Fin 3) : ∀ (n : Nat) (f : Fin n → V3),
    compk k (sumFin n f) = sumI n (fun i => compk k (f i))
  | 0, _ => compk_zero k
  | n + 1, f => by simp only [sumFin, sumI, compk_add, compk_sumFin k n]

theorem sumI_mul (m : Int) : ∀ (n : Nat) (f : Fin n → Int),
    sumI n (fun i => m * f i) = m * sumI n f
  | 0, _ => by simp [sumI]
  | n + 1, f => by simp only [sumI, sumI_mul m n, Int.mul_add]

theorem sumI_nonneg : ∀ (n : Nat) (f : Fin n → Int), (∀ i, 0 ≤ f i) → 0 ≤ sumI n f
  | 0, _, _ => by simp [sumI]
  | n + 1, f, h => by
    simp only [sumI]
    have := sumI_nonneg n (fun i => f ⟨i.val, by omega⟩) (fun i => h _)
    have := h ⟨n, by omega⟩
    omega

theorem sumI_pos : ∀ (n : Nat) (f : Fin n → Int), (∀ i, 0 ≤ f i) → ∀ i0, 0 < f i0 → 0 < sumI n f
  | 0, _, _, i0, _ => absurd i0.isLt (Nat.not_lt_zero _)
  | n + 1, f, h, i0, h0 => by
    simp only [sumI]
    by_cases hi : i0.val = n
    · have e : i0 = ⟨n, by omega⟩ := Fin.ext hi
      have := sumI_nonneg n (fun i => f ⟨i.val, by omega⟩) (fun i => h _)
      rw [e] at h0; omega
    · have := sumI_pos n (fun i => f ⟨i.val, by omega⟩) (fun i => h _) ⟨i0.val, by omega⟩ h0
      have := h ⟨n, by omega⟩
      omega

/-- Integer sum over the cell. -/
def sumPtI {a b c : Nat} (f : Pt a b c → Int) : Int :=
  sumI (4 * a) fun x => sumI (4 * b) fun y => sumI (4 * c) fun z => f (x, y, z)

theorem compk_sumPt {a b c : Nat} (k : Fin 3) (f : Pt a b c → V3) :
    compk k (sumPt f) = sumPtI (fun p => compk k (f p)) := by
  simp only [sumPt, sumPtI, compk_sumFin]

theorem sumPtI_mul {a b c : Nat} (m : Int) (f : Pt a b c → Int) :
    sumPtI (fun p => m * f p) = m * sumPtI f := by
  simp only [sumPtI, sumI_mul]

theorem sumPtI_pos {a b c : Nat} (f : Pt a b c → Int) (h : ∀ p, 0 ≤ f p) (p0 : Pt a b c)
    (h0 : 0 < f p0) : 0 < sumPtI f := by
  unfold sumPtI
  apply sumI_pos _ _ (fun x => sumI_nonneg _ _ (fun y => sumI_nonneg _ _ (fun z => h _))) p0.1
  apply sumI_pos _ _ (fun y => sumI_nonneg _ _ (fun z => h _)) p0.2.1
  exact sumI_pos _ _ (fun z => h _) p0.2.2 h0

/-! ## The flux balance -/

/-- On one sublattice (`sub`), at zero total moment, a one-way axis carries no
vertex. -/
theorem no_type_of_balanced {a b c : Nat} (s : State a b c) (sub : Pt a b c → Bool)
    (hsub : ∀ p, sub p = true → isVertex p = true)
    (hbal : (sumPt fun p => if sub p then momentVec s p else 0) = 0)
    (k : Fin 3) (e : Bool) (hw : ∀ v : Pt a b c, isVertex v = true → vtype s v = k → vsign s v = e)
    (v : Pt a b c) (hv : sub v = true) (hvk : vtype s v = k) : False := by
  let σ : Int := if e then 1 else -1
  let T : Pt a b c → Int := fun p => compk k (if sub p then momentVec s p else 0)
  have hT : ∀ p, 0 ≤ σ * T p ∧ (p = v → 0 < σ * T p) := by
    intro p
    simp only [T, σ]
    cases hp : sub p
    · simp only [Bool.false_eq_true, if_false, compk_zero, Int.mul_zero]
      refine ⟨Int.le_refl 0, fun h => ?_⟩
      rw [h, hv] at hp; cases hp
    · simp only [if_true, momentVec, compk_axv]
      by_cases ht : vtype s p = k
      · rw [if_pos ht, hw p (hsub p hp) ht]
        cases e <;> exact ⟨by decide, fun _ => by decide⟩
      · rw [if_neg ht]
        refine ⟨by simp, fun h => ?_⟩
        rw [h] at ht; exact (ht hvk).elim
  have hpos := sumPtI_pos (fun p => σ * T p) (fun p => (hT p).1) v ((hT v).2 rfl)
  rw [sumPtI_mul] at hpos
  have hz : sumPtI T = 0 := by
    simp only [T]; rw [← compk_sumPt, hbal, compk_zero]
  rw [hz, Int.mul_zero] at hpos
  exact Int.lt_irrefl 0 hpos

theorem smul4_eq_zero (u : V3) (h : V3.smul 4 u = 0) : u = 0 := by
  have hx := congrArg V3.x h; have hy := congrArg V3.y h; have hz := congrArg V3.z h
  simp at hx hy hz
  exact V3.ext (by simp; omega) (by simp; omega) (by simp; omega)

/-- **The flux balance.**  In an ice state of zero flux, an axis that is
one-way is empty. -/
theorem oneWay_empty_of_zeroFlux {a b c : Nat} (s : State a b c) (hi : Ice s) (hz : ZeroFlux s)
    (k : Fin 3) (hw : OneWay s k) : AxisEmpty s k := by
  obtain ⟨e, hw⟩ := hw
  have hA : (sumPt fun p => if isA p then momentVec s p else 0) = 0 :=
    smul4_eq_zero _ ((flux_A s hi).symm.trans hz)
  have hB : (sumPt fun q => if isB q then momentVec s q else 0) = 0 :=
    smul4_eq_zero _ ((flux_B s hi).symm.trans hz)
  intro v hv hvk
  cases hvA : isA v
  · have hvB : isB v = true := by simpa [isVertex, hvA] using hv
    exact no_type_of_balanced s isB (fun p hp => by simp [isVertex, hp]) hB k e hw v hvB hvk
  · exact no_type_of_balanced s isA (fun p hp => by simp [isVertex, hp]) hA k e hw v hvA hvk

end Periodicity
