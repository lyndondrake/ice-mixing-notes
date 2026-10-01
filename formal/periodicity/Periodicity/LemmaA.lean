import Periodicity.Basic

/-!
# Lemma A: a missing axis forces a translation symmetry

`docs/notes/curl-reduction.md`, Lemma A: let `S` be an ice state on the cell
`(a, b, c)` with box `B = (4a, 4b, 4c)` in which no vertex has type `x`; then
`S` is invariant under every translation in
`Λₓ = (ℤ(0,2,2) + Bℤ³) ∩ (ℤ(0,2,-2) + Bℤ³)`; the same for `y` and `z`.

With the line the independent checker of 1 October 2026 (pacheck) added:
`Λₓ` contains `(0, 2g, 2g)` with `g = gcd(b, c)`, which is not zero modulo the
box, so on every cell the state has a nonzero translation symmetry.

The proof is the note's.  A vertex is a kink of a `{0,1}` chain iff its type is
`x`, and in bits it is a kink iff the bits of the chain's two bonds there are
equal (`chain_step`).  With no kink the bits of the `d₀` and `d₁` bonds are
invariant under the chain step `d₀ - d₁ = (0,2,2)`, and with the ice rule the
`{2,3}` chains are kink-free too, giving `d₂ - d₃ = (0,2,-2)` for the other two
directions.  The ice rule is used only there.
-/

namespace Periodicity

variable {a b c : Nat}

/-- The bits of direction `k` are invariant under the translation `t`. -/
def InvDir (s : State a b c) (k : Fin 4) (t : V3) : Prop :=
  ∀ p : Pt a b c, isA p = true → s (p + t) k = s p k

theorem isA_add (p : Pt a b c) (v : V3) : isA (p + v) = isA4 (res p + v) := by
  simp only [isA, res_add]

/-- Membership of A is preserved by a vector `v` whenever it is on residues. -/
theorem isA_add_of (v : V3) (hv : ∀ r : Res, isA4 r = true → isA4 (r + v) = true)
    (p : Pt a b c) (hp : isA p = true) : isA (p + v) = true := by
  rw [isA_add]; exact hv _ hp

theorem dvec_add_neg : ∀ i : Fin 4, dvec i + -dvec i = 0 := by decide

theorem dvec_sub : ∀ i j : Fin 4, dvec i + -dvec j = dvec i - dvec j := by decide

theorem res_step_B : ∀ i : Fin 4, ∀ r : Res, isA4 r = true →
    isA4 (r + dvec i) = false ∧ isA4 (r + dvec i + -one3) = true := by decide

theorem res_step_A : ∀ i j : Fin 4, ∀ r : Res, isA4 r = true →
    isA4 (r + (dvec i - dvec j)) = true ∧ isA4 (r + -(dvec i - dvec j)) = true := by decide

/-- One step along a chain of the family `{i, j}`.  If no vertex is a kink of
these chains (the bits of the bonds `i` and `j` differ at every vertex), the
bits of both directions are invariant under the chain step `d_i - d_j`. -/
theorem chain_step (s : State a b c) (i j : Fin 4)
    (h : ∀ v : Pt a b c, isVertex v = true → loc s v i ≠ loc s v j)
    (p : Pt a b c) (hp : isA p = true) :
    s (p + (dvec i - dvec j)) i = s p i ∧ s (p + (dvec i - dvec j)) j = s p j := by
  have hqA : isA (p + dvec i) = false := by rw [isA_add]; exact (res_step_B i _ hp).1
  have hqB : isB (p + dvec i) = true := by
    simp only [isB, isA_add, res_add]; exact (res_step_B i _ hp).2
  have hp'A : isA (p + (dvec i - dvec j)) = true := by
    rw [isA_add]; exact (res_step_A i j _ hp).1
  have hq := h (p + dvec i) (by simp [isVertex, hqB])
  have hpp := h p (by simp [isVertex, hp])
  have hp' := h (p + (dvec i - dvec j)) (by simp [isVertex, hp'A])
  simp only [loc, hqA, hp, hp'A, if_true, Bool.false_eq_true, if_false] at hq hpp hp'
  rw [Pt.add_add, Pt.add_add, dvec_add_neg, Pt.add_zero, dvec_sub] at hq
  revert hq hpp hp'
  cases s p i <;> cases s p j <;> cases s (p + (dvec i - dvec j)) i <;>
    cases s (p + (dvec i - dvec j)) j <;> decide

/-- Invariance under a vector gives invariance under its natural multiples. -/
theorem invDir_nat (s : State a b c) (k : Fin 4) (u : V3)
    (hu : ∀ r : Res, isA4 r = true → isA4 (r + u) = true) (h : InvDir s k u) :
    ∀ n : Nat, ∀ p : Pt a b c, isA p = true →
      isA (p + V3.smul n u) = true ∧ s (p + V3.smul n u) k = s p k := by
  intro n
  induction n with
  | zero =>
    intro p hp
    have : V3.smul ((0 : Nat) : Int) u = 0 := V3.ext (by simp) (by simp) (by simp)
    rw [this, Pt.add_zero]; exact ⟨hp, rfl⟩
  | succ n ih =>
    intro p hp
    have e : V3.smul ((n + 1 : Nat) : Int) u = V3.smul (n : Int) u + u :=
      V3.ext (by simp [Int.add_mul]) (by simp [Int.add_mul]) (by simp [Int.add_mul])
    obtain ⟨h1, h2⟩ := ih p hp
    rw [e, ← Pt.add_add]
    exact ⟨isA_add_of u hu _ h1, (h _ h1).trans h2⟩

/-- Invariance under a vector gives invariance under its negative. -/
theorem invDir_neg (s : State a b c) (k : Fin 4) (u : V3)
    (hu' : ∀ r : Res, isA4 r = true → isA4 (r + -u) = true) (h : InvDir s k u) :
    InvDir s k (-u) := by
  intro p hp
  have hA := isA_add_of (-u) hu' p hp
  have := h (p + -u) hA
  rw [Pt.add_add] at this
  have e : -u + u = 0 := V3.ext (by simp [Int.add_left_neg]) (by simp [Int.add_left_neg])
    (by simp [Int.add_left_neg])
  rw [e, Pt.add_zero] at this
  exact this.symm

theorem neg_neg_V3 (u : V3) : -(-u) = u := V3.ext (by simp) (by simp) (by simp)

/-- Invariance under a vector gives invariance under every integer multiple. -/
theorem invDir_int (s : State a b c) (k : Fin 4) (u : V3)
    (hu : ∀ r : Res, isA4 r = true → isA4 (r + u) = true)
    (hu' : ∀ r : Res, isA4 r = true → isA4 (r + -u) = true) (h : InvDir s k u) (m : Int) :
    InvDir s k (V3.smul m u) := by
  cases m with
  | ofNat n => exact fun p hp => (invDir_nat s k u hu h n p hp).2
  | negSucc n =>
    have e : V3.smul (Int.negSucc n) u = V3.smul ((n + 1 : Nat) : Int) (-u) :=
      V3.ext (by simp [Int.negSucc_eq, Int.neg_mul, Int.mul_neg])
        (by simp [Int.negSucc_eq, Int.neg_mul, Int.mul_neg])
        (by simp [Int.negSucc_eq, Int.neg_mul, Int.mul_neg])
    rw [e]
    have hu'' : ∀ r : Res, isA4 r = true → isA4 (r + -(-u)) = true := by
      rw [neg_neg_V3]; exact hu
    exact fun p hp => (invDir_nat s k (-u) hu' (invDir_neg s k u hu' h) (n + 1) p hp).2

/-- Invariance depends on the translation only modulo the box. -/
theorem invDir_congr (s : State a b c) (k : Fin 4) {t t' : V3} (ht : ModBox a b c t t')
    (h : InvDir s k t') : InvDir s k t := by
  intro p hp; rw [Pt.add_congr p ht]; exact h p hp

/-- The general form of Lemma A: if the chains of the two families `{i, j}`
and `{k, l}` have no kinks, and `{i, j, k, l}` are the four directions, the
state is invariant under every translation that is congruent modulo the box to
a multiple of `d_i - d_j` and to a multiple of `d_k - d_l`. -/
theorem lemmaA_gen (s : State a b c) (i j k l : Fin 4)
    (hall : ∀ e : Fin 4, e = i ∨ e = j ∨ e = k ∨ e = l)
    (h1 : ∀ v : Pt a b c, isVertex v = true → loc s v i ≠ loc s v j)
    (h2 : ∀ v : Pt a b c, isVertex v = true → loc s v k ≠ loc s v l)
    (t : V3) (m n : Int)
    (hm : ModBox a b c t (V3.smul m (dvec i - dvec j)))
    (hn : ModBox a b c t (V3.smul n (dvec k - dvec l))) :
    Invariant s t := by
  have A1 := fun r => (res_step_A i j r)
  have A2 := fun r => (res_step_A k l r)
  have di : InvDir s i (dvec i - dvec j) := fun p hp => (chain_step s i j h1 p hp).1
  have dj : InvDir s j (dvec i - dvec j) := fun p hp => (chain_step s i j h1 p hp).2
  have dk : InvDir s k (dvec k - dvec l) := fun p hp => (chain_step s k l h2 p hp).1
  have dl : InvDir s l (dvec k - dvec l) := fun p hp => (chain_step s k l h2 p hp).2
  intro p hp e
  rcases hall e with rfl | rfl | rfl | rfl
  · exact invDir_congr s _ hm (invDir_int s _ _ (fun r h => (A1 r h).1) (fun r h => (A1 r h).2)
      di m) p hp
  · exact invDir_congr s _ hm (invDir_int s _ _ (fun r h => (A1 r h).1) (fun r h => (A1 r h).2)
      dj m) p hp
  · exact invDir_congr s _ hn (invDir_int s _ _ (fun r h => (A2 r h).1) (fun r h => (A2 r h).2)
      dk n) p hp
  · exact invDir_congr s _ hn (invDir_int s _ _ (fun r h => (A2 r h).1) (fun r h => (A2 r h).2)
      dl n) p hp

/-! ## Types and kinks -/

theorem typ_ne_x (l : Fin 4 → Bool) (hc : cnt l = 2) (ht : typ l ≠ 0) :
    l 0 ≠ l 1 ∧ l 2 ≠ l 3 := by
  revert hc ht; unfold cnt typ
  cases l 0 <;> cases l 1 <;> cases l 2 <;> cases l 3 <;> decide

theorem typ_ne_y (l : Fin 4 → Bool) (hc : cnt l = 2) (ht : typ l ≠ 1) :
    l 0 ≠ l 2 ∧ l 1 ≠ l 3 := by
  revert hc ht; unfold cnt typ
  cases l 0 <;> cases l 1 <;> cases l 2 <;> cases l 3 <;> decide

theorem typ_ne_z (l : Fin 4 → Bool) (hc : cnt l = 2) (ht : typ l ≠ 2) :
    l 0 ≠ l 3 ∧ l 1 ≠ l 2 := by
  revert hc ht; unfold cnt typ
  cases l 0 <;> cases l 1 <;> cases l 2 <;> cases l 3 <;> decide

/-! ## The lattices Λₓ, Λ_y, Λ_z -/

/-- `Λₓ` modulo the box: congruent to a multiple of `(0,2,2)` and to a multiple of
`(0,2,-2)`. -/
def InLamX (a b c : Nat) (t : V3) : Prop :=
  (∃ m : Int, ModBox a b c t (V3.smul m ⟨0, 2, 2⟩)) ∧ (∃ n : Int, ModBox a b c t (V3.smul n ⟨0, 2, -2⟩))

/-- `Λ_y`: multiples of `(2,0,2)` and of `(2,0,-2)`. -/
def InLamY (a b c : Nat) (t : V3) : Prop :=
  (∃ m : Int, ModBox a b c t (V3.smul m ⟨2, 0, 2⟩)) ∧ (∃ n : Int, ModBox a b c t (V3.smul n ⟨2, 0, -2⟩))

/-- `Λ_z`: multiples of `(2,2,0)` and of `(2,-2,0)`. -/
def InLamZ (a b c : Nat) (t : V3) : Prop :=
  (∃ m : Int, ModBox a b c t (V3.smul m ⟨2, 2, 0⟩)) ∧ (∃ n : Int, ModBox a b c t (V3.smul n ⟨2, -2, 0⟩))

theorem all4 : ∀ e : Fin 4, e = 0 ∨ e = 1 ∨ e = 2 ∨ e = 3 := by decide
theorem all4' : ∀ e : Fin 4, e = 0 ∨ e = 2 ∨ e = 1 ∨ e = 3 := by decide
theorem all4'' : ∀ e : Fin 4, e = 0 ∨ e = 3 ∨ e = 1 ∨ e = 2 := by decide

/-- **Lemma A** (curl-reduction), axis `x`. -/
theorem lemmaA_x (s : State a b c) (hice : Ice s) (hx : AxisEmpty s 0) (t : V3)
    (ht : InLamX a b c t) : Invariant s t := by
  obtain ⟨⟨m, hm⟩, ⟨n, hn⟩⟩ := ht
  exact lemmaA_gen s 0 1 2 3 all4
    (fun v hv => (typ_ne_x _ (hice v hv) (hx v hv)).1)
    (fun v hv => (typ_ne_x _ (hice v hv) (hx v hv)).2) t m n hm hn

/-- **Lemma A** (curl-reduction), axis `y`. -/
theorem lemmaA_y (s : State a b c) (hice : Ice s) (hy : AxisEmpty s 1) (t : V3)
    (ht : InLamY a b c t) : Invariant s t := by
  obtain ⟨⟨m, hm⟩, ⟨n, hn⟩⟩ := ht
  exact lemmaA_gen s 0 2 1 3 all4'
    (fun v hv => (typ_ne_y _ (hice v hv) (hy v hv)).1)
    (fun v hv => (typ_ne_y _ (hice v hv) (hy v hv)).2) t m n hm hn

/-- **Lemma A** (curl-reduction), axis `z`. -/
theorem lemmaA_z (s : State a b c) (hice : Ice s) (hz : AxisEmpty s 2) (t : V3)
    (ht : InLamZ a b c t) : Invariant s t := by
  obtain ⟨⟨m, hm⟩, ⟨n, hn⟩⟩ := ht
  exact lemmaA_gen s 0 3 1 2 all4''
    (fun v hv => (typ_ne_z _ (hice v hv) (hz v hv)).1)
    (fun v hv => (typ_ne_z _ (hice v hv) (hz v hv)).2) t m n hm hn

/-! ## The nonzero element `(0, 2g, 2g)` -/

/-- Bézout for natural numbers, proved here since core Lean does not carry it. -/
theorem bezout (m n : Nat) : ∃ u v : Int, u * m + v * n = (Nat.gcd m n : Int) := by
  induction m, n using Nat.gcd.induction with
  | H0 n => exact ⟨0, 1, by simp⟩
  | H1 m n hm ih =>
    obtain ⟨u, v, h⟩ := ih
    rw [Nat.gcd_rec m n]
    have hd := Nat.mod_add_div n m
    have hdI : ((n % m : Nat) : Int) = (n : Int) - (m : Int) * ((n / m : Nat) : Int) := by
      have : ((n % m : Nat) : Int) + ((m * (n / m) : Nat) : Int) = (n : Int) := by
        rw [← Int.natCast_add, hd]
      rw [Int.natCast_mul] at this
      omega
    refine ⟨v - u * ((n / m : Nat) : Int), u, ?_⟩
    rw [← h, hdI]
    simp only [Int.sub_mul, Int.mul_sub]
    rw [Int.mul_assoc u, Int.mul_comm ((n / m : Nat) : Int) (m : Int)]
    omega

/-- The general nonzero element: for extents `p, q` (the two extents across
the axis) the vector with `2g` in both transverse slots, `g = gcd(p, q)`, is
congruent modulo `(4p, 4q)` to `n·(2, -2)` for an integer `n`. -/
theorem gcd_congr (p q : Nat) :
    ∃ n : Int, ((4 * p : Nat) : Int) ∣ 2 * (Nat.gcd p q : Int) - n * 2 ∧
      ((4 * q : Nat) : Int) ∣ 2 * (Nat.gcd p q : Int) - n * (-2) := by
  obtain ⟨u, v, h⟩ := bezout p q
  rw [Int.mul_comm u, Int.mul_comm v] at h
  refine ⟨(Nat.gcd p q : Int) - 2 * p * u, ⟨u, ?_⟩, ⟨v, ?_⟩⟩
  · rw [Int.natCast_mul]; simp only [Int.mul_assoc]; omega
  · rw [Int.natCast_mul]; simp only [Int.mul_assoc]; omega

theorem not_dvd_two_gcd (p q : Nat) (hp : 0 < p) (_hq : 0 < q) :
    ¬ ((4 * p : Nat) : Int) ∣ 2 * (Nat.gcd p q : Int) := by
  intro h
  have hg : 0 < Nat.gcd p q := Nat.gcd_pos_of_pos_left q hp
  have hgp : Nat.gcd p q ≤ p := Nat.gcd_le_left q hp
  have := Int.le_of_dvd (by omega) h
  push_cast at this; omega

theorem zero_dvd_sub (n : Nat) : ((n : Nat) : Int) ∣ (0 : Int) - (0 : Int) := ⟨0, by simp⟩

/-- The element `(0, 2g, 2g)`, `g = gcd(b, c)`, lies in `Λₓ` on every cell. -/
theorem gcd_mem_lamX (a b c : Nat) :
    InLamX a b c ⟨0, 2 * (Nat.gcd b c : Int), 2 * (Nat.gcd b c : Int)⟩ := by
  obtain ⟨n, h1, h2⟩ := gcd_congr b c
  refine ⟨⟨(Nat.gcd b c : Int), ⟨0, by simp⟩, ⟨0, by simp [Int.mul_comm]⟩,
    ⟨0, by simp [Int.mul_comm]⟩⟩, ⟨n, ⟨0, by simp⟩, ?_, ?_⟩⟩
  · simpa using h1
  · simpa using h2

/-- The element `(2g, 0, 2g)`, `g = gcd(a, c)`, lies in `Λ_y` on every cell. -/
theorem gcd_mem_lamY (a b c : Nat) :
    InLamY a b c ⟨2 * (Nat.gcd a c : Int), 0, 2 * (Nat.gcd a c : Int)⟩ := by
  obtain ⟨n, h1, h2⟩ := gcd_congr a c
  refine ⟨⟨(Nat.gcd a c : Int), ⟨0, by simp [Int.mul_comm]⟩, ⟨0, by simp⟩,
    ⟨0, by simp [Int.mul_comm]⟩⟩, ⟨n, ?_, ⟨0, by simp⟩, ?_⟩⟩
  · simpa using h1
  · simpa using h2

/-- The element `(2g, 2g, 0)`, `g = gcd(a, b)`, lies in `Λ_z` on every cell. -/
theorem gcd_mem_lamZ (a b c : Nat) :
    InLamZ a b c ⟨2 * (Nat.gcd a b : Int), 2 * (Nat.gcd a b : Int), 0⟩ := by
  obtain ⟨n, h1, h2⟩ := gcd_congr a b
  refine ⟨⟨(Nat.gcd a b : Int), ⟨0, by simp [Int.mul_comm]⟩, ⟨0, by simp [Int.mul_comm]⟩,
    ⟨0, by simp⟩⟩, ⟨n, ?_, ?_, ⟨0, by simp⟩⟩⟩
  · simpa using h1
  · simpa using h2

/-- **Lemma A with the nonzero element** (pacheck's added line).  On every cell
with positive extents, an ice state with an empty axis is invariant under a
translation of the A lattice that is not zero modulo the box: `(0, 2g, 2g)` with
`g = gcd(b, c)` for an empty `x` axis, and likewise for `y` and `z`. -/
theorem lemmaA_nonzero (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (s : State a b c) (hice : Ice s)
    (k : Fin 3) (hk : AxisEmpty s k) :
    ∃ t : V3, InALattice t ∧ ¬ ZeroMod a b c t ∧ Invariant s t := by
  match k, hk with
  | ⟨0, _⟩, hk =>
    refine ⟨_, ?_, ?_, lemmaA_x s hice hk _ (gcd_mem_lamX a b c)⟩
    · refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> omega
    · intro h; exact not_dvd_two_gcd b c hb hc (by simpa using h.2.1)
  | ⟨1, _⟩, hk =>
    refine ⟨_, ?_, ?_, lemmaA_y s hice hk _ (gcd_mem_lamY a b c)⟩
    · refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> omega
    · intro h; exact not_dvd_two_gcd a c ha hc (by simpa using h.1)
  | ⟨2, _⟩, hk =>
    refine ⟨_, ?_, ?_, lemmaA_z s hice hk _ (gcd_mem_lamZ a b c)⟩
    · refine ⟨?_, ?_, ?_, ?_⟩ <;> simp <;> omega
    · intro h; exact not_dvd_two_gcd a b ha hb (by simpa using h.1)

end Periodicity
