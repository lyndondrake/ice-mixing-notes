import Periodicity.Basic

/-!
# The bridge to the Python models

Three kinds of check tie the model of `Periodicity/Basic.lean` to the objects
of the notes and of the independent Python model
`experiments/08_frozen_structure/scratch_h/h730_lib.py` (agent pacheck,
1 October 2026).

1. **The hexagon definition, on every cell.**  `h730_lib` defines a hexagon as
   a closed six-step walk on the infinite lattice from an A vertex, steps
   alternating `+d` (A to B) and `-d` (B to A), no direction used twice in a row
   (cyclically), total displacement zero and six distinct unwrapped vertices,
   reduced modulo the box and de-duplicated.  `walk_is_hexagon` shows that
   every such walk from every A point of every cell traverses one of the hexagon
   slots `(O, j)` of the model (with `O` an A-hole), in one of its twelve
   rotations or reflections, and `hexagon_is_walk` that every slot is traversed
   by such a walk.  `validWalks_count` shows there are exactly 24 such walks
   from a vertex: twelve hexagons through it, in two senses.  These facts are
   position-free and hold on every cell.
2. **Counts on four cells.**  On `(1,1,1)`, `(1,2,2)`, `(2,2,2)`, `(2,2,3)`: the
   numbers of A sites and B sites (`4abc` each, disjoint, so `8abc` vertices),
   bonds (`16abc`) and hexagons (`16abc`, the count `h730_lib` asserts), and
   that distinct hexagon slots have distinct sets of six bonds modulo the box
   (pacheck: "no two small hexagons share a bond cycle, even on (1,1,1)").
3. **The `(1,1,1)` matrix model of `formal/theorem1`**: `Periodicity/BridgeT1.lean`.
-/

namespace Periodicity

/-! ## Each hexagon is a closed cycle of six bonds -/

/-- Consecutive bonds of a hexagon share a vertex: the B ends of bonds `0, 1`,
`2, 3` and `4, 5` agree, and the A ends of bonds `1, 2`, `3, 4` and `5, 0`. -/
theorem hex_closed : ∀ j : Fin 4,
    hexOff j 0 + dvec (hexDir j 0) = hexOff j 1 + dvec (hexDir j 1) ∧
    hexOff j 1 = hexOff j 2 ∧
    hexOff j 2 + dvec (hexDir j 2) = hexOff j 3 + dvec (hexDir j 3) ∧
    hexOff j 3 = hexOff j 4 ∧
    hexOff j 4 + dvec (hexDir j 4) = hexOff j 5 + dvec (hexDir j 5) ∧
    hexOff j 5 = hexOff j 0 := by decide

/-- The hexagon `(O, d_j)` omits direction `j`, and uses each of the other
three twice. -/
theorem hex_dirs : ∀ j : Fin 4, ∀ t : Fin 6, hexDir j t ≠ j := by decide

/-- The A ends of a hexagon's bonds are the methylenes `O + 2σ_k e_k`, which are
A vertices when `O` is an A-hole; the B ends are B vertices. -/
theorem hex_ends : ∀ r : Res, isA4 (r + -two0) = true → ∀ j : Fin 4, ∀ t : Fin 6,
    isA4 (r + hexOff j t) = true ∧ isA4 (r + hexOff j t + dvec (hexDir j t) + -one3) = true := by
  decide

/-! ## Walks on the infinite lattice -/

/-- A sequence of six directions. -/
def mk6 (k0 k1 k2 k3 k4 k5 : Fin 4) : Fin 6 → Fin 4
  | ⟨0, _⟩ => k0
  | ⟨1, _⟩ => k1
  | ⟨2, _⟩ => k2
  | ⟨3, _⟩ => k3
  | ⟨4, _⟩ => k4
  | ⟨5, _⟩ => k5

/-- Step `t` of the walk: `+d` from A to B when `t` is even, `-d` back when odd. -/
def walkStep (ks : Fin 6 → Fin 4) (t : Fin 6) : V3 :=
  if t.val % 2 = 0 then dvec (ks t) else -dvec (ks t)

/-- The unwrapped vertices of the walk relative to its start, `0 … 6`. -/
def walkVert (ks : Fin 6 → Fin 4) : Nat → V3
  | 0 => 0
  | n + 1 => walkVert ks n + (if h : n < 6 then walkStep ks ⟨n, h⟩ else 0)

/-- The walk is a lattice hexagon in the sense of `h730_lib`: no direction twice
in a row (cyclically), zero displacement, six distinct unwrapped vertices. -/
def walkValid (ks : Fin 6 → Fin 4) : Prop :=
  (∀ t : Fin 6, ks t ≠ ks ⟨(t.val + 1) % 6, Nat.mod_lt _ (by decide)⟩) ∧
  walkVert ks 6 = 0 ∧
  (∀ t u : Fin 6, t ≠ u → walkVert ks t.val ≠ walkVert ks u.val)

instance (ks : Fin 6 → Fin 4) : Decidable (walkValid ks) := by unfold walkValid; infer_instance

/-- Bond `t` of the walk, relative to its start, as `(A end, direction)`. -/
def walkBond (ks : Fin 6 → Fin 4) (t : Fin 6) : V3 × Fin 4 :=
  if t.val % 2 = 0 then (walkVert ks t.val, ks t) else (walkVert ks (t.val + 1), ks t)

/-- The index of the hexagon bond matched to walk bond `t`, for a rotation `r`
and a sense `rev`. -/
def matchIdx (r : Fin 6) (rev : Bool) (t : Fin 6) : Fin 6 :=
  if rev then ⟨(r.val + 6 - t.val) % 6, Nat.mod_lt _ (by decide)⟩
  else ⟨(r.val + t.val) % 6, Nat.mod_lt _ (by decide)⟩

/-- The hole of the hexagon matched to a walk, relative to the walk's start. -/
def walkHole (ks : Fin 6 → Fin 4) (j : Fin 4) (r : Fin 6) (rev : Bool) : V3 :=
  (walkBond ks 0).1 - hexOff j (matchIdx r rev 0)

/-- The position-free core of `walk_is_hexagon`. -/
theorem walk_matches : ∀ k0 k1 k2 k3 k4 k5 : Fin 4,
    walkValid (mk6 k0 k1 k2 k3 k4 k5) →
    ∃ j : Fin 4, ∃ r : Fin 6, ∃ rev : Bool,
      (∀ t : Fin 6, walkBond (mk6 k0 k1 k2 k3 k4 k5) t =
        (walkHole (mk6 k0 k1 k2 k3 k4 k5) j r rev + hexOff j (matchIdx r rev t),
          hexDir j (matchIdx r rev t))) ∧
      (∀ x : Res, isA4 x = true →
        isA4 (x + walkHole (mk6 k0 k1 k2 k3 k4 k5) j r rev + -two0) = true) := by
  decide +kernel

theorem mk6_eta (ks : Fin 6 → Fin 4) : mk6 (ks 0) (ks 1) (ks 2) (ks 3) (ks 4) (ks 5) = ks := by
  funext t
  match t with
  | ⟨0, _⟩ => rfl
  | ⟨1, _⟩ => rfl
  | ⟨2, _⟩ => rfl
  | ⟨3, _⟩ => rfl
  | ⟨4, _⟩ => rfl
  | ⟨5, _⟩ => rfl

/-- **Every lattice hexagon of `h730_lib` is a hexagon of the model.**  On any
cell, a valid walk started at an A point `p` traverses, bond for bond, the
hexagon `(O, j)` for an A-hole `O`, up to rotation and reflection. -/
theorem walk_is_hexagon {a b c : Nat} (p : Pt a b c) (hp : isA p = true)
    (ks : Fin 6 → Fin 4) (hv : walkValid ks) :
    ∃ O : Pt a b c, ∃ j : Fin 4, ∃ r : Fin 6, ∃ rev : Bool, isAHole O = true ∧
      ∀ t : Fin 6, (p + (walkBond ks t).1, (walkBond ks t).2) = hexBond (O, j) (matchIdx r rev t) := by
  rw [← mk6_eta ks] at hv ⊢
  obtain ⟨j, r, rev, h1, h2⟩ := walk_matches _ _ _ _ _ _ hv
  refine ⟨p + walkHole (mk6 (ks 0) (ks 1) (ks 2) (ks 3) (ks 4) (ks 5)) j r rev, j, r, rev, ?_, ?_⟩
  · simp only [isAHole, isA, res_add]; exact h2 _ hp
  · intro t; rw [h1 t]; simp only [hexBond, Pt.add_add]

/-- The position-free core of `hexagon_is_walk`. -/
theorem hexagon_walk_core : ∀ j : Fin 4,
    walkValid (fun t => hexDir j t) ∧
    ∀ t : Fin 6, walkBond (fun t => hexDir j t) t = (hexOff j t - hexOff j 0, hexDir j t) := by
  decide +kernel

theorem sub_add_V3 (u v : V3) : v + (u - v) = u :=
  V3.ext (by simp; omega) (by simp; omega) (by simp; omega)

/-- **Every hexagon of the model is a lattice hexagon of `h730_lib`**: the slot
`(O, j)` is traversed, bond for bond, by a valid walk started at its A vertex
`O + 2σₓeₓ`. -/
theorem hexagon_is_walk {a b c : Nat} (O : Pt a b c) (j : Fin 4) :
    walkValid (fun t => hexDir j t) ∧
    ∀ t : Fin 6, (O + hexOff j 0 + (walkBond (fun t => hexDir j t) t).1,
      (walkBond (fun t => hexDir j t) t).2) = hexBond (O, j) t := by
  refine ⟨(hexagon_walk_core j).1, fun t => ?_⟩
  rw [(hexagon_walk_core j).2 t]
  simp only [hexBond, Pt.add_add, sub_add_V3]

/-- Number of valid walks from a vertex. -/
def validWalks : Nat :=
  sumNat 4 fun k0 => sumNat 4 fun k1 => sumNat 4 fun k2 => sumNat 4 fun k3 =>
    sumNat 4 fun k4 => sumNat 4 fun k5 => (decide (walkValid (mk6 k0 k1 k2 k3 k4 k5))).toNat

/-- 24 valid walks from a vertex: twelve hexagons through it, two senses each. -/
theorem validWalks_count : validWalks = 24 := by decide +kernel

/-! ## Counts and distinctness on small cells -/

/-- The index of the bond `(p, k)` as a natural number. -/
def bondIdx {a b c : Nat} (e : Pt a b c × Fin 4) : Nat :=
  ((e.1.1.val * (4 * b) + e.1.2.1.val) * (4 * c) + e.1.2.2.val) * 4 + e.2.val

/-- Insertion into a sorted list. -/
def ins (x : Nat) : List Nat → List Nat
  | [] => [x]
  | y :: l => if x ≤ y then x :: y :: l else y :: ins x l

/-- Insertion sort. -/
def isort : List Nat → List Nat
  | [] => []
  | x :: l => ins x (isort l)

/-- The set of six bonds of a hexagon slot, as a sorted list of bond indices. -/
def hexKey {a b c : Nat} (h : Hex a b c) : List Nat :=
  isort ((List.range 6).map fun t => if ht : t < 6 then bondIdx (hexBond h ⟨t, ht⟩) else 0)

/-- All points of a cell. -/
def allPts (a b c : Nat) : List (Pt a b c) :=
  (List.finRange (4 * a)).flatMap fun x => (List.finRange (4 * b)).flatMap fun y =>
    (List.finRange (4 * c)).map fun z => (x, y, z)

/-- The keys of all hexagons of the cell. -/
def hexKeys (a b c : Nat) : List (List Nat) :=
  ((allPts a b c).filter isAHole).flatMap fun O => (List.finRange 4).map fun j => hexKey (O, j)

/-- Pairwise distinctness, as a `Bool`. -/
def nodupL : List (List Nat) → Bool
  | [] => true
  | x :: l => l.all (fun y => y != x) && nodupL l

/-- The counts of one cell: A sites, B sites, A-and-B points, vertices, bonds,
hexagons, and distinctness of the hexagons' bond sets. -/
def cellCounts (a b c : Nat) : Nat × Nat × Nat × Nat × Nat × Nat × Bool :=
  (countPt (a := a) (b := b) (c := c) isA, countPt (a := a) (b := b) (c := c) isB,
   countPt (a := a) (b := b) (c := c) (fun p => isA p && isB p),
   countPt (a := a) (b := b) (c := c) isVertex,
   4 * countPt (a := a) (b := b) (c := c) isA,
   4 * countPt (a := a) (b := b) (c := c) isAHole,
   nodupL (hexKeys a b c))

/-- `(1,1,1)`: 4 + 4 sites, 8 vertices, 16 bonds, 16 hexagons, all distinct. -/
theorem counts_111 : cellCounts 1 1 1 = (4, 4, 0, 8, 16, 16, true) := by decide +kernel

/-- `(1,2,2)`: 16 + 16 sites, 32 vertices, 64 bonds, 64 hexagons, all distinct. -/
theorem counts_122 : cellCounts 1 2 2 = (16, 16, 0, 32, 64, 64, true) := by decide +kernel

/-- `(2,2,2)`: 32 + 32 sites, 64 vertices, 128 bonds, 128 hexagons, all distinct. -/
theorem counts_222 : cellCounts 2 2 2 = (32, 32, 0, 64, 128, 128, true) := by decide +kernel

/-- `(2,2,3)`: 48 + 48 sites, 96 vertices, 192 bonds, 192 hexagons, all distinct. -/
theorem counts_223 : cellCounts 2 2 3 = (48, 48, 0, 96, 192, 192, true) := by decide +kernel

end Periodicity
