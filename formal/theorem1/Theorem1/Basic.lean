/-!
# Theorem 1 of the ice-mixing project: the smallest cell is frozen

The `(1,1,1)` pyrochlore cell, written algebraically.  A state is a `4 x 4`
zero-one matrix `M : Fin 4 → Fin 4 → Bool`; rows are the four A-site cosets
`g`, columns the four bond directions `k`, and the B-site of the bond `(g,k)`
carries the label `g XOR k` (the direction differences realise the Klein group
`Z2 x Z2`, and `xor` on `Fin 4` realises that group).

* `IceA M` — every row has exactly two `true` entries (ice rule at A-sites);
* `IceB M` — every B-label has exactly two `true` entries (ice rule at B-sites);
* `ZeroFlux M` — every column has exactly two `true` entries (`W = 0`).

The claim proved in `Theorem1/Structured.lean` is that no hexagon of such an
`M` is flippable.

That this matrix model *is* the `(1,1,1)` cell's ice states and hexagons is not
part of the Lean development: it is established in Python, by
`tests/test_frozen.py::test_klein_states_are_exactly_the_w0_states_of_111`
and `::test_model_hexagons_match_the_lattice_hexagons`.  Everything below is a
theorem about the matrix model only.

No Mathlib: core Lean 4 plus `decide` and `omega` suffice throughout.
-/

namespace Theorem1

/-! ## `Fin 4`: case analysis and the Klein group -/

/-- Case analysis on `Fin 4`, used as `cases a using Fin4.rec4`. -/
def Fin4.rec4 {motive : Fin 4 → Sort u}
    (h0 : motive 0) (h1 : motive 1) (h2 : motive 2) (h3 : motive 3) : ∀ a, motive a
  | ⟨0, _⟩ => h0
  | ⟨1, _⟩ => h1
  | ⟨2, _⟩ => h2
  | ⟨3, _⟩ => h3

/-- The Klein four-group on `Fin 4`, as bitwise xor. -/
def xor4 (a b : Fin 4) : Fin 4 := ⟨(a.val ^^^ b.val) % 4, Nat.mod_lt _ (by decide)⟩

@[inherit_doc] infixl:65 " ⊻ " => xor4

theorem xor4_self : ∀ a : Fin 4, a ⊻ a = 0 := by decide
theorem xor4_comm : ∀ a b : Fin 4, a ⊻ b = b ⊻ a := by decide
theorem xor4_assoc : ∀ a b c : Fin 4, (a ⊻ b) ⊻ c = a ⊻ (b ⊻ c) := by decide
theorem xor4_zero : ∀ a : Fin 4, a ⊻ 0 = a := by decide
theorem xor4_cancel : ∀ a b : Fin 4, (a ⊻ b) ⊻ b = a := by decide

/-! ## The model -/

/-- A state of the `(1,1,1)` cell: `M g k = true` iff the bond of direction `k`
at the A-site of coset `g` carries an arrow out of that A-site. -/
abbrev Mat := Fin 4 → Fin 4 → Bool

/-- `Bool` as `0`/`1`. -/
def b2n (b : Bool) : Nat := if b then 1 else 0

theorem b2n_add_not : ∀ b : Bool, b2n b + b2n (!b) = 1 := by decide
theorem b2n_le_one : ∀ b : Bool, b2n b ≤ 1 := by decide

/-- Number of arrows out of the A-site `g`. -/
def rowSum (M : Mat) (g : Fin 4) : Nat :=
  b2n (M g 0) + b2n (M g 1) + b2n (M g 2) + b2n (M g 3)

/-- Number of arrows on the bonds of direction `k` (one per A-coset). -/
def colSum (M : Mat) (k : Fin 4) : Nat :=
  b2n (M 0 k) + b2n (M 1 k) + b2n (M 2 k) + b2n (M 3 k)

/-- Number of arrows into the B-site labelled `h`: its four bonds are
`(h ⊻ d, d)` for the four directions `d`. -/
def labSum (M : Mat) (h : Fin 4) : Nat :=
  b2n (M (h ⊻ 0) 0) + b2n (M (h ⊻ 1) 1) + b2n (M (h ⊻ 2) 2) + b2n (M (h ⊻ 3) 3)

/-- (R) The ice rule at the A-sites: two in, two out. -/
def IceA (M : Mat) : Prop := ∀ g, rowSum M g = 2

/-- (B) The ice rule at the B-sites: two in, two out. -/
def IceB (M : Mat) : Prop := ∀ h, labSum M h = 2

/-- (C) Zero flux, `W = 0`: each direction carries two arrows. -/
def ZeroFlux (M : Mat) : Prop := ∀ k, colSum M k = 2

/-! ## Hexagons

A hexagon is given by a coset `g` and an ordered triple `(i,j,k)` of distinct
directions.  Its A-sites are `g`, `a2 = g ⊻ i ⊻ j` and `a3 = g ⊻ j ⊻ k`;
this is `icemix.frozen.hexagon_cells`.  Distinct orderings give the same 16
hexagons up to traversal direction. -/

/-- The second A-site of the hexagon. -/
def a2 (g i j : Fin 4) : Fin 4 := g ⊻ i ⊻ j

/-- The third A-site of the hexagon. -/
def a3 (g j k : Fin 4) : Fin 4 := g ⊻ j ⊻ k

/-- The fourth A-site of the cell, which is *not* on the hexagon. -/
def a4 (g i k : Fin 4) : Fin 4 := g ⊻ i ⊻ k

/-- The fourth direction, which is *not* one of the hexagon's three. -/
def d4 (i j k : Fin 4) : Fin 4 := i ⊻ j ⊻ k

/-- The fourth direction agrees with `icemix.frozen.obstruction_cells`, which
computes it as `6 - i - j - k`. -/
theorem d4_eq_complement : ∀ i j k : Fin 4, i ≠ j → j ≠ k → i ≠ k →
    (d4 i j k).val = 6 - i.val - j.val - k.val := by decide

/-- The hexagon is flippable when its three A→B-traversed cells `(g,i)`,
`(a2,k)`, `(a3,j)` all carry one value and its three B→A-traversed cells
`(a2,j)`, `(a3,i)`, `(g,k)` all carry the other.  This is
`icemix.frozen.model_flippable`. -/
def Flippable (M : Mat) (g i j k : Fin 4) : Prop :=
  ∃ b : Bool,
    M g i = b ∧ M (a2 g i j) k = b ∧ M (a3 g j k) j = b ∧
    M (a2 g i j) j = !b ∧ M (a3 g j k) i = !b ∧ M g k = !b

/-! ## Reindexing a line sum

Each of the three "lines" (a row, a column, a B-label) has four cells, indexed
in the definitions above by `0,1,2,3`.  The proof needs them listed in an order
adapted to the hexagon, so we need to know that a sum of four terms does not
depend on the order.  Proved by exhausting the `4^4` index assignments. -/

theorem sum4_perm (f : Fin 4 → Nat) : ∀ a b c d : Fin 4,
    a ≠ b → a ≠ c → a ≠ d → b ≠ c → b ≠ d → c ≠ d →
    f 0 + f 1 + f 2 + f 3 = f a + f b + f c + f d := by
  intro a b c d
  cases a using Fin4.rec4 <;> cases b using Fin4.rec4 <;> cases c using Fin4.rec4 <;>
    cases d using Fin4.rec4 <;> intro h1 h2 h3 h4 h5 h6 <;>
    first
      | exact absurd rfl h1
      | exact absurd rfl h2
      | exact absurd rfl h3
      | exact absurd rfl h4
      | exact absurd rfl h5
      | exact absurd rfl h6
      | omega

theorem rowSum_perm (M : Mat) (g : Fin 4) {a b c d : Fin 4}
    (h1 : a ≠ b) (h2 : a ≠ c) (h3 : a ≠ d) (h4 : b ≠ c) (h5 : b ≠ d) (h6 : c ≠ d) :
    rowSum M g = b2n (M g a) + b2n (M g b) + b2n (M g c) + b2n (M g d) :=
  sum4_perm (fun x => b2n (M g x)) a b c d h1 h2 h3 h4 h5 h6

theorem colSum_perm (M : Mat) (k : Fin 4) {a b c d : Fin 4}
    (h1 : a ≠ b) (h2 : a ≠ c) (h3 : a ≠ d) (h4 : b ≠ c) (h5 : b ≠ d) (h6 : c ≠ d) :
    colSum M k = b2n (M a k) + b2n (M b k) + b2n (M c k) + b2n (M d k) :=
  sum4_perm (fun x => b2n (M x k)) a b c d h1 h2 h3 h4 h5 h6

theorem labSum_perm (M : Mat) (h : Fin 4) {a b c d : Fin 4}
    (h1 : a ≠ b) (h2 : a ≠ c) (h3 : a ≠ d) (h4 : b ≠ c) (h5 : b ≠ d) (h6 : c ≠ d) :
    labSum M h = b2n (M (h ⊻ a) a) + b2n (M (h ⊻ b) b)
               + b2n (M (h ⊻ c) c) + b2n (M (h ⊻ d) d) :=
  sum4_perm (fun x => b2n (M (h ⊻ x) x)) a b c d h1 h2 h3 h4 h5 h6

end Theorem1
