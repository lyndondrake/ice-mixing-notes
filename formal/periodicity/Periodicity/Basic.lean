/-!
# The diamond-lattice ice model on a general cell

The setting of `docs/notes/curl-reduction.md` ("The model and the language of
dipoles") and of the first section of `docs/notes/theorem-h-orientation.md`.

* Coordinates are in quarter-cube units.  The cell `(a, b, c)` is the torus of
  `a`, `b` and `c` cubes, so a point is a triple in
  `Fin (4a) × Fin (4b) × Fin (4c)` (`Pt a b c`) and translations act modulo the
  box `(4a, 4b, 4c)`.
* Sublattice A is the points with even coordinates whose sum is a multiple of
  four; `B = A + (1,1,1)`.  Both are read off the residues of the coordinates
  modulo four (`res`), which is well defined because every box side is a
  multiple of four.
* The four bond directions are `d₀ = (1,1,1)`, `d₁ = (1,-1,-1)`,
  `d₂ = (-1,1,-1)`, `d₃ = (-1,-1,1)`, from each A vertex.  The bond `(p, k)`
  joins the A vertex `p` to the B vertex `p + d_k`.
* A state is a bit on every bond: `s p k = true` iff the arrow on the bond
  `(p, k)` points from A to B.  A state is a function on all points, and only
  its values at A points are read (`Invariant`, `loc`, the hexagons); the
  values at other points are never used.

The hexagons are the pairs of holes `(O, O + σ)` of the note on Theorem H,
section "Holes, cages and rods": `O` an A-hole and `σ ∈ {±1}³` with
`σₓσ_yσ_z = 1`.  The four admissible `σ` are exactly the four bond vectors, so a
hexagon is a pair `(O, j)` with `σ = d_j`.  The bridge to the definition of
the independent Python model `h730_lib.py` (closed non-backtracking six-walks
of zero displacement) is in `Periodicity/Bridge.lean`.

Core Lean 4 only.
-/

namespace Periodicity

/-! ## Integer vectors -/

/-- A vector of `ℤ³`, in quarter-cube units. -/
structure V3 where
  x : Int
  y : Int
  z : Int
deriving DecidableEq, Repr

namespace V3

instance : Add V3 := ⟨fun u v => ⟨u.x + v.x, u.y + v.y, u.z + v.z⟩⟩
instance : Neg V3 := ⟨fun u => ⟨-u.x, -u.y, -u.z⟩⟩
instance : Sub V3 := ⟨fun u v => ⟨u.x - v.x, u.y - v.y, u.z - v.z⟩⟩
instance : OfNat V3 0 := ⟨⟨0, 0, 0⟩⟩

/-- Integer multiple. -/
def smul (m : Int) (u : V3) : V3 := ⟨m * u.x, m * u.y, m * u.z⟩

@[simp] theorem add_x (u v : V3) : (u + v).x = u.x + v.x := rfl
@[simp] theorem add_y (u v : V3) : (u + v).y = u.y + v.y := rfl
@[simp] theorem add_z (u v : V3) : (u + v).z = u.z + v.z := rfl
@[simp] theorem neg_x (u : V3) : (-u).x = -u.x := rfl
@[simp] theorem neg_y (u : V3) : (-u).y = -u.y := rfl
@[simp] theorem neg_z (u : V3) : (-u).z = -u.z := rfl
@[simp] theorem sub_x (u v : V3) : (u - v).x = u.x - v.x := rfl
@[simp] theorem sub_y (u v : V3) : (u - v).y = u.y - v.y := rfl
@[simp] theorem sub_z (u v : V3) : (u - v).z = u.z - v.z := rfl
@[simp] theorem zero_x : (0 : V3).x = 0 := rfl
@[simp] theorem zero_y : (0 : V3).y = 0 := rfl
@[simp] theorem zero_z : (0 : V3).z = 0 := rfl
@[simp] theorem smul_x (m : Int) (u : V3) : (smul m u).x = m * u.x := rfl
@[simp] theorem smul_y (m : Int) (u : V3) : (smul m u).y = m * u.y := rfl
@[simp] theorem smul_z (m : Int) (u : V3) : (smul m u).z = m * u.z := rfl

theorem ext {u v : V3} (hx : u.x = v.x) (hy : u.y = v.y) (hz : u.z = v.z) : u = v := by
  cases u; cases v; simp_all

end V3

/-! ## Coordinates modulo a box side -/

theorem pos_of_fin {n : Nat} (x : Fin n) : (0 : Int) < n := by
  have := x.isLt; omega

/-- `x + d` modulo `n`. -/
def wrap {n : Nat} (x : Fin n) (d : Int) : Fin n :=
  ⟨(((x.val : Int) + d) % (n : Int)).toNat, by
    have hn := pos_of_fin x
    have h0 := Int.emod_nonneg ((x.val : Int) + d) (Int.ne_of_gt hn)
    have h1 := Int.emod_lt_of_pos ((x.val : Int) + d) hn
    have h2 := Int.toNat_of_nonneg h0
    omega⟩

theorem wrap_val {n : Nat} (x : Fin n) (d : Int) :
    ((wrap x d).val : Int) = ((x.val : Int) + d) % n := by
  have hn := pos_of_fin x
  exact Int.toNat_of_nonneg (Int.emod_nonneg _ (Int.ne_of_gt hn))

theorem fin_ext_int {n : Nat} {x y : Fin n} (h : (x.val : Int) = y.val) : x = y :=
  Fin.ext (by omega)

theorem wrap_wrap {n : Nat} (x : Fin n) (d e : Int) : wrap (wrap x d) e = wrap x (d + e) := by
  apply fin_ext_int
  rw [wrap_val, wrap_val, wrap_val, Int.emod_add_emod, Int.add_assoc]

theorem wrap_zero {n : Nat} (x : Fin n) : wrap x 0 = x := by
  apply fin_ext_int
  rw [wrap_val, Int.add_zero]
  exact Int.emod_eq_of_lt (by omega) (by have := x.isLt; omega)

/-- `wrap` depends on the offset only modulo `n`. -/
theorem wrap_congr {n : Nat} (x : Fin n) {d e : Int} (h : (n : Int) ∣ d - e) :
    wrap x d = wrap x e := by
  apply fin_ext_int
  rw [wrap_val, wrap_val]
  obtain ⟨k, hk⟩ := h
  have : (x.val : Int) + d = ((x.val : Int) + e) + n * k := by omega
  rw [this, Int.add_mul_emod_self_left]

/-- Reduction from `Fin n` to `Fin m`. -/
def projF {n : Nat} (m : Nat) (hm : 0 < m) (x : Fin n) : Fin m := ⟨x.val % m, Nat.mod_lt _ hm⟩

theorem projF_wrap {n m : Nat} (hm : 0 < m) (hd : m ∣ n) (x : Fin n) (d : Int) :
    projF m hm (wrap x d) = wrap (projF m hm x) d := by
  apply fin_ext_int
  have hdI : (m : Int) ∣ (n : Int) := Int.ofNat_dvd.mpr hd
  simp only [projF, Int.natCast_emod]
  rw [wrap_val, wrap_val]
  simp only [Int.natCast_emod]
  rw [Int.emod_emod_of_dvd _ hdI, Int.emod_add_emod]

theorem projF_projF {n m l : Nat} (hm : 0 < m) (hl : 0 < l) (hd : l ∣ m) (x : Fin n) :
    projF l hl (projF m hm x) = projF l hl x := by
  apply Fin.ext
  simp only [projF]
  exact Nat.mod_mod_of_dvd _ hd

/-! ## Points of a cell -/

/-- A point of the cell `(a, b, c)`: coordinates modulo `(4a, 4b, 4c)`. -/
abbrev Pt (a b c : Nat) := Fin (4 * a) × Fin (4 * b) × Fin (4 * c)

/-- Translation of a point by a vector, modulo the box. -/
def Pt.add {a b c : Nat} (p : Pt a b c) (v : V3) : Pt a b c :=
  (wrap p.1 v.x, wrap p.2.1 v.y, wrap p.2.2 v.z)

instance {a b c : Nat} : HAdd (Pt a b c) V3 (Pt a b c) := ⟨Pt.add⟩

theorem Pt.add_def {a b c : Nat} (p : Pt a b c) (v : V3) :
    p + v = (wrap p.1 v.x, wrap p.2.1 v.y, wrap p.2.2 v.z) := rfl

theorem Pt.add_add {a b c : Nat} (p : Pt a b c) (u v : V3) : p + u + v = p + (u + v) := by
  simp only [Pt.add_def, wrap_wrap, V3.add_x, V3.add_y, V3.add_z]

theorem Pt.add_zero {a b c : Nat} (p : Pt a b c) : p + (0 : V3) = p := by
  simp only [Pt.add_def, V3.zero_x, V3.zero_y, V3.zero_z, wrap_zero]

/-- Congruence of two vectors modulo the box of the cell. -/
def ModBox (a b c : Nat) (u v : V3) : Prop :=
  ((4 * a : Nat) : Int) ∣ u.x - v.x ∧ ((4 * b : Nat) : Int) ∣ u.y - v.y ∧
    ((4 * c : Nat) : Int) ∣ u.z - v.z

theorem Pt.add_congr {a b c : Nat} (p : Pt a b c) {u v : V3} (h : ModBox a b c u v) :
    p + u = p + v := by
  simp only [Pt.add_def, wrap_congr _ h.1, wrap_congr _ h.2.1, wrap_congr _ h.2.2]

/-- The cube `(1,1,1)` is the residue cell: coordinates modulo four. -/
abbrev Res := Pt 1 1 1

/-- Projection of a cell onto a cell whose extents divide its own. -/
def Pt.proj {a b c a' b' c' : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (p : Pt a' b' c') :
    Pt a b c :=
  (projF (4 * a) (by omega) p.1, projF (4 * b) (by omega) p.2.1, projF (4 * c) (by omega) p.2.2)

theorem Pt.proj_add {a b c a' b' c' : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (da : a ∣ a') (db : b ∣ b') (dc : c ∣ c') (p : Pt a' b' c') (v : V3) :
    Pt.proj ha hb hc (p + v) = Pt.proj ha hb hc p + v := by
  simp only [Pt.proj, Pt.add_def]
  rw [projF_wrap _ (Nat.mul_dvd_mul_left 4 da), projF_wrap _ (Nat.mul_dvd_mul_left 4 db),
    projF_wrap _ (Nat.mul_dvd_mul_left 4 dc)]

theorem Pt.proj_proj {a b c a' b' c' a'' b'' c'' : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (ha' : 0 < a') (hb' : 0 < b') (hc' : 0 < c')
    (da : a ∣ a') (db : b ∣ b') (dc : c ∣ c') (p : Pt a'' b'' c'') :
    Pt.proj ha hb hc (Pt.proj ha' hb' hc' p) = Pt.proj ha hb hc p := by
  simp only [Pt.proj]
  rw [projF_projF _ _ (Nat.mul_dvd_mul_left 4 da), projF_projF _ _ (Nat.mul_dvd_mul_left 4 db),
    projF_projF _ _ (Nat.mul_dvd_mul_left 4 dc)]

/-- The residues modulo four of a point. -/
def res {a b c : Nat} (p : Pt a b c) : Res := Pt.proj (by decide) (by decide) (by decide) p

theorem res_add {a b c : Nat} (p : Pt a b c) (v : V3) : res (p + v) = res p + v :=
  Pt.proj_add _ _ _ (Nat.one_dvd a) (Nat.one_dvd b) (Nat.one_dvd c) p v

theorem res_proj {a b c a' b' c' : Nat} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) (p : Pt a' b' c') :
    res (Pt.proj ha hb hc p) = res p :=
  Pt.proj_proj _ _ _ ha hb hc (Nat.one_dvd a) (Nat.one_dvd b) (Nat.one_dvd c) p

/-! ## Decidable quantification over points -/

instance decForallPt {a b c : Nat} (P : Pt a b c → Prop) [DecidablePred P] :
    Decidable (∀ p, P p) :=
  decidable_of_iff (∀ x y z, P (x, y, z))
    ⟨fun h p => h p.1 p.2.1 p.2.2, fun h _ _ _ => h _⟩

instance decExistsPt {a b c : Nat} (P : Pt a b c → Prop) [DecidablePred P] :
    Decidable (∃ p, P p) :=
  decidable_of_iff (∃ x y z, P (x, y, z))
    ⟨fun ⟨x, y, z, h⟩ => ⟨(x, y, z), h⟩, fun ⟨p, h⟩ => ⟨p.1, p.2.1, p.2.2, h⟩⟩

/-! ## Sublattices, directions, holes -/

/-- Sublattice A on residues: `(0,0,0)`, `(0,2,2)`, `(2,0,2)`, `(2,2,0)` mod 4. -/
def isA4 (r : Res) : Bool :=
  match r.1.val, r.2.1.val, r.2.2.val with
  | 0, 0, 0 => true
  | 0, 2, 2 => true
  | 2, 0, 2 => true
  | 2, 2, 0 => true
  | _, _, _ => false

/-- The point is a vertex of sublattice A. -/
def isA {a b c : Nat} (p : Pt a b c) : Bool := isA4 (res p)

/-- The bond vectors `d₀ … d₃`. -/
def dvec : Fin 4 → V3
  | ⟨0, _⟩ => ⟨1, 1, 1⟩
  | ⟨1, _⟩ => ⟨1, -1, -1⟩
  | ⟨2, _⟩ => ⟨-1, 1, -1⟩
  | ⟨3, _⟩ => ⟨-1, -1, 1⟩

/-- `(1,1,1)`, the offset from A to B. -/
def one3 : V3 := ⟨1, 1, 1⟩

/-- The point is a vertex of sublattice B, `B = A + (1,1,1)`. -/
def isB {a b c : Nat} (p : Pt a b c) : Bool := isA (p + -one3)

/-- The point is a vertex (of either sublattice). -/
def isVertex {a b c : Nat} (p : Pt a b c) : Bool := isA p || isB p

/-- `(2,0,0)`: holes are `A + (2,0,0)` and `B + (2,0,0)`. -/
def two0 : V3 := ⟨2, 0, 0⟩

/-- An A-hole: a point of `A + (2,0,0)`. -/
def isAHole {a b c : Nat} (O : Pt a b c) : Bool := isA (O + -two0)

/-- A B-hole: a point of `B + (2,0,0)`. -/
def isBHole {a b c : Nat} (O : Pt a b c) : Bool := isB (O + -two0)

/-- A hole of either sublattice (an octahedral interstice). -/
def isHole {a b c : Nat} (O : Pt a b c) : Bool := isAHole O || isBHole O

/-- The Klein group on the direction labels: `d_j ⊙ d_k = d_(j ⊻ k)`. -/
def kx (j k : Fin 4) : Fin 4 := ⟨(j.val ^^^ k.val) % 4, Nat.mod_lt _ (by decide)⟩

/-- Coordinatewise product of two sign vectors. -/
def V3.hmul (u v : V3) : V3 := ⟨u.x * v.x, u.y * v.y, u.z * v.z⟩

theorem dvec_kx : ∀ j k : Fin 4, dvec (kx j k) = V3.hmul (dvec j) (dvec k) := by decide

/-! ## States, local bits, moments -/

/-- A state: `s p k = true` iff the arrow on the bond `(p, k)` (from the A
vertex `p` to `p + d_k`) points from A to B.  Only values at A points are read. -/
abbrev State (a b c : Nat) := Pt a b c → Fin 4 → Bool

/-- The four bits at a vertex, indexed by bond direction: at an A vertex `p`
the bits of the bonds `(p, k)`; at a B vertex `q` the bits of the bonds
`(q - d_k, k)`.  At an A vertex `true` is an arrow out, at a B vertex an arrow
in. -/
def loc {a b c : Nat} (s : State a b c) (v : Pt a b c) (k : Fin 4) : Bool :=
  if isA v then s v k else s (v + -dvec k) k

/-- Number of `true` among four bits. -/
def cnt (l : Fin 4 → Bool) : Nat := (l 0).toNat + (l 1).toNat + (l 2).toNat + (l 3).toNat

/-- The ice rule at every vertex: two in, two out. -/
def Ice {a b c : Nat} (s : State a b c) : Prop := ∀ v : Pt a b c, isVertex v = true → cnt (loc s v) = 2

instance {a b c : Nat} (s : State a b c) : Decidable (Ice s) := by unfold Ice; infer_instance

/-- The axis of the moment, the **type** of the vertex (`0, 1, 2` for
`x, y, z`): with the set `{i, j}` of `true` bits the moment is proportional to
`d_i + d_j`, so `{0,1}`, `{2,3}` give `x`, `{0,2}`, `{1,3}` give `y`, and
`{0,3}`, `{1,2}` give `z`.  Under the ice rule `l 0 = l 1` holds exactly for the
two `x` pairs, and so on. -/
def typ (l : Fin 4 → Bool) : Fin 3 :=
  if l 0 == l 1 then 0 else if l 0 == l 2 then 1 else 2

/-- The sign of the moment: `+` (`true`) exactly when bond `0` is in the pair. -/
def sgn (l : Fin 4 → Bool) : Bool := l 0

/-- The type of a vertex in a state. -/
def vtype {a b c : Nat} (s : State a b c) (v : Pt a b c) : Fin 3 := typ (loc s v)

/-- The sign of the moment of a vertex in a state. -/
def vsign {a b c : Nat} (s : State a b c) (v : Pt a b c) : Bool := sgn (loc s v)

/-- The moment of a vertex: its axis and its sign. -/
def moment {a b c : Nat} (s : State a b c) (v : Pt a b c) : Fin 3 × Bool := (vtype s v, vsign s v)

/-- The unit vector `e_k` scaled by `m`. -/
def axv (k : Fin 3) (m : Int) : V3 :=
  match k with
  | ⟨0, _⟩ => ⟨m, 0, 0⟩
  | ⟨1, _⟩ => ⟨0, m, 0⟩
  | ⟨2, _⟩ => ⟨0, 0, m⟩

/-- The moment as a vector (`± e_k`). -/
def momentVec {a b c : Nat} (s : State a b c) (v : Pt a b c) : V3 :=
  axv (vtype s v) (if vsign s v then 1 else -1)

/-- Axis `k` is **empty**: no vertex has type `k`. -/
def AxisEmpty {a b c : Nat} (s : State a b c) (k : Fin 3) : Prop :=
  ∀ v : Pt a b c, isVertex v = true → vtype s v ≠ k

/-- Axis `k` is **one-way**: the vertices of type `k` all have one sign. -/
def OneWay {a b c : Nat} (s : State a b c) (k : Fin 3) : Prop :=
  ∃ e : Bool, ∀ v : Pt a b c, isVertex v = true → vtype s v = k → vsign s v = e

instance {a b c : Nat} (s : State a b c) (k : Fin 3) : Decidable (AxisEmpty s k) := by
  unfold AxisEmpty; infer_instance

instance {a b c : Nat} (s : State a b c) (k : Fin 3) : Decidable (OneWay s k) := by
  unfold OneWay; exact decidable_of_iff _ (⟨fun h => match h with
    | Or.inl h => ⟨true, h⟩ | Or.inr h => ⟨false, h⟩,
    fun ⟨e, h⟩ => by cases e with | true => exact Or.inl h | false => exact Or.inr h⟩ :
      ((∀ v : Pt a b c, isVertex v = true → vtype s v = k → vsign s v = true) ∨
       (∀ v : Pt a b c, isVertex v = true → vtype s v = k → vsign s v = false)) ↔ _)

/-! ## Hexagons -/

/-- A hexagon slot: an A-hole `O` (when `isAHole O`) and `j`, with `σ = d_j`. -/
abbrev Hex (a b c : Nat) := Pt a b c × Fin 4

/-- The slot is a hexagon: its first entry is an A-hole. -/
def Hex.valid {a b c : Nat} (h : Hex a b c) : Bool := isAHole h.1

/-- The offset from the hole `O` of the A end of bond `t` of the hexagon
`(O, d_j)`: `2σₓeₓ` for bonds 0 and 5, `2σ_z e_z` for 1 and 2, `2σ_y e_y` for
3 and 4. -/
def hexOff (j : Fin 4) (t : Fin 6) : V3 :=
  let σ := dvec j
  match t with
  | ⟨0, _⟩ => ⟨2 * σ.x, 0, 0⟩
  | ⟨1, _⟩ => ⟨0, 0, 2 * σ.z⟩
  | ⟨2, _⟩ => ⟨0, 0, 2 * σ.z⟩
  | ⟨3, _⟩ => ⟨0, 2 * σ.y, 0⟩
  | ⟨4, _⟩ => ⟨0, 2 * σ.y, 0⟩
  | ⟨5, _⟩ => ⟨2 * σ.x, 0, 0⟩

/-- The direction of bond `t` of the hexagon `(O, d_j)`. -/
def hexDir (j : Fin 4) (t : Fin 6) : Fin 4 :=
  match t with
  | ⟨0, _⟩ => kx j 3
  | ⟨1, _⟩ => kx j 1
  | ⟨2, _⟩ => kx j 2
  | ⟨3, _⟩ => kx j 3
  | ⟨4, _⟩ => kx j 1
  | ⟨5, _⟩ => kx j 2

/-- The six bonds of the hexagon `(O, σ = d_j)` in cycle order, as
`(A end, direction)`.  The vertices in cycle order are
`a_x = O + 2σₓeₓ`, `b_y = O + (σₓ, -σ_y, σ_z)`, `a_z = O + 2σ_z e_z`,
`b_x = O + (-σₓ, σ_y, σ_z)`, `a_y = O + 2σ_y e_y`, `b_z = O + (σₓ, σ_y, -σ_z)`;
bond `t` joins vertex `t` to vertex `t + 1`.  The hexagon omits direction `j`
and uses `j ⊻ 3`, `j ⊻ 1`, `j ⊻ 2` twice each. -/
def hexBond {a b c : Nat} (h : Hex a b c) (t : Fin 6) : Pt a b c × Fin 4 :=
  (h.1 + hexOff h.2 t, hexDir h.2 t)

/-- The bit of the `t`-th bond of a hexagon. -/
def hbit {a b c : Nat} (s : State a b c) (h : Hex a b c) (t : Fin 6) : Bool :=
  s (hexBond h t).1 (hexBond h t).2

/-- Vertex `t` of the hexagon (between bonds `t - 1` and `t`) is a **reversal**:
the two hexagon bonds there point both in or both out.  Since consecutive
vertices lie on opposite sublattices, this is equality of the two bits. -/
def reversal {a b c : Nat} (s : State a b c) (h : Hex a b c) (t : Fin 6) : Bool :=
  hbit s h (⟨(t.val + 5) % 6, Nat.mod_lt _ (by decide)⟩) == hbit s h t

/-- The number of reversals of a hexagon. -/
def nrev {a b c : Nat} (s : State a b c) (h : Hex a b c) : Nat :=
  (reversal s h 0).toNat + (reversal s h 1).toNat + (reversal s h 2).toNat +
    (reversal s h 3).toNat + (reversal s h 4).toNat + (reversal s h 5).toNat

/-- The hexagon **circulates** (is flippable): no reversal. -/
def Circulates {a b c : Nat} (s : State a b c) (h : Hex a b c) : Prop := nrev s h = 0

instance {a b c : Nat} (s : State a b c) (h : Hex a b c) : Decidable (Circulates s h) := by
  unfold Circulates; infer_instance

/-- The **curl** of a hexagon: the sum of its six bits modulo two (`true` is odd). -/
def curl {a b c : Nat} (s : State a b c) (h : Hex a b c) : Bool :=
  hbit s h 0 ^^ hbit s h 1 ^^ hbit s h 2 ^^ hbit s h 3 ^^ hbit s h 4 ^^ hbit s h 5

/-- Quantification over hexagons is decidable. -/
instance decForallHex {a b c : Nat} (P : Hex a b c → Prop) [DecidablePred P] :
    Decidable (∀ h, P h) :=
  decidable_of_iff (∀ O j, P (O, j)) ⟨fun h x => h x.1 x.2, fun h _ _ => h _⟩

instance decExistsHex {a b c : Nat} (P : Hex a b c → Prop) [DecidablePred P] :
    Decidable (∃ h, P h) :=
  decidable_of_iff (∃ O j, P (O, j))
    ⟨fun ⟨O, j, h⟩ => ⟨(O, j), h⟩, fun ⟨x, h⟩ => ⟨x.1, x.2, h⟩⟩

/-- **(T2)/frozen**: an ice state with no circulating hexagon. -/
def Frozen {a b c : Nat} (s : State a b c) : Prop :=
  Ice s ∧ ∀ h : Hex a b c, h.valid = true → ¬ Circulates s h

instance {a b c : Nat} (s : State a b c) : Decidable (Frozen s) := by unfold Frozen; infer_instance

/-- Some hexagon has odd curl. -/
def OddState {a b c : Nat} (s : State a b c) : Prop :=
  ∃ h : Hex a b c, h.valid = true ∧ curl s h = true

/-- Every hexagon has even curl. -/
def EvenCurl {a b c : Nat} (s : State a b c) : Prop :=
  ∀ h : Hex a b c, h.valid = true → curl s h = false

instance {a b c : Nat} (s : State a b c) : Decidable (OddState s) := by
  unfold OddState; infer_instance

instance {a b c : Nat} (s : State a b c) : Decidable (EvenCurl s) := by
  unfold EvenCurl; infer_instance

theorem evenCurl_of_not_odd {a b c : Nat} (s : State a b c) (h : ¬ OddState s) : EvenCurl s := by
  intro x hx
  cases hc : curl s x with
  | false => rfl
  | true => exact absurd ⟨x, hx, hc⟩ h

/-! ## Holes, rods, charge -/

/-- The methylene `O + 2 s e_k` of a hole, `s = +` for `true`. -/
def methylene {a b c : Nat} (O : Pt a b c) (k : Fin 3) (sg : Bool) : Pt a b c :=
  O + axv k (if sg then 2 else -2)

/-- Contribution of the methylene position `O + 2 s e_k` to the charge of the
hole `O`: `0` if it is not a rod (its type is not `k`), `+1` if the rod points
away from `O` (its sign is `s`), `-1` if it points towards `O`. -/
def rodCharge {a b c : Nat} (st : State a b c) (O : Pt a b c) (k : Fin 3) (sg : Bool) : Int :=
  let v := methylene O k sg
  if vtype st v = k then (if vsign st v = sg then 1 else -1) else 0

/-- The **charge** of a hole: rods pointing away minus rods pointing towards,
counted over the six methylene positions. -/
def charge {a b c : Nat} (st : State a b c) (O : Pt a b c) : Int :=
  rodCharge st O 0 true + rodCharge st O 0 false + rodCharge st O 1 true +
    rodCharge st O 1 false + rodCharge st O 2 true + rodCharge st O 2 false

/-- The hole is **oriented**: charge zero. -/
def Oriented {a b c : Nat} (st : State a b c) (O : Pt a b c) : Prop := charge st O = 0

/-! ## Translations -/

/-- The action of a translation on states. -/
def State.shift {a b c : Nat} (s : State a b c) (t : V3) : State a b c := fun p k => s (p + t) k

/-- The state is invariant under the translation `t` (on every bond). -/
def Invariant {a b c : Nat} (s : State a b c) (t : V3) : Prop :=
  ∀ p : Pt a b c, isA p = true → ∀ k, s (p + t) k = s p k

instance {a b c : Nat} (s : State a b c) (t : V3) : Decidable (Invariant s t) := by
  unfold Invariant; infer_instance

/-- `t` lies in the translation lattice of A: even coordinates, sum ≡ 0 mod 4. -/
def InALattice (t : V3) : Prop := t.x % 2 = 0 ∧ t.y % 2 = 0 ∧ t.z % 2 = 0 ∧ (t.x + t.y + t.z) % 4 = 0

/-- `t` is zero modulo the box. -/
def ZeroMod (a b c : Nat) (t : V3) : Prop := ModBox a b c t 0

/-! ## Flux -/

/-- Sum over `Fin n`. -/
def sumFin : (n : Nat) → (Fin n → V3) → V3
  | 0, _ => 0
  | n + 1, f => sumFin n (fun i => f ⟨i.val, by omega⟩) + f ⟨n, by omega⟩

/-- Sum over the points of a cell. -/
def sumPt {a b c : Nat} (f : Pt a b c → V3) : V3 :=
  sumFin (4 * a) fun x => sumFin (4 * b) fun y => sumFin (4 * c) fun z => f (x, y, z)

/-- The flux: the sum over bonds of `± d_k`, `+` when the arrow points from A to B. -/
def flux {a b c : Nat} (s : State a b c) : V3 :=
  sumPt fun p => if isA p then
      sumFin 4 fun k => if s p k then dvec k else -dvec k
    else 0

/-- Zero flux. -/
def ZeroFlux {a b c : Nat} (s : State a b c) : Prop := flux s = 0

instance {a b c : Nat} (s : State a b c) : Decidable (ZeroFlux s) := by
  unfold ZeroFlux; infer_instance

/-! ## Counting (for the bridge) -/

/-- Sum of natural numbers over `Fin n`. -/
def sumNat : (n : Nat) → (Fin n → Nat) → Nat
  | 0, _ => 0
  | n + 1, f => sumNat n (fun i => f ⟨i.val, by omega⟩) + f ⟨n, by omega⟩

/-- Number of points of the cell with a property. -/
def countPt {a b c : Nat} (f : Pt a b c → Bool) : Nat :=
  sumNat (4 * a) fun x => sumNat (4 * b) fun y => sumNat (4 * c) fun z => (f (x, y, z)).toNat

end Periodicity
