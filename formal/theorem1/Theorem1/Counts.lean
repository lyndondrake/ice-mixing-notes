import Theorem1.Decide

/-!
# How many states there are

The counts quoted in `icemix.frozen.model_states`: the matrix model has exactly
90 states obeying the two ice rules (R) and (B), and exactly 12 obeying (R),
(B) and zero flux (C) as well — the Klein patterns.

"Exactly" is made precise without any cardinality machinery, and without
Mathlib, by exhibiting the states as explicit lists and proving four theorems
about each list:

* `_length` — how many entries it has;
* `_sound` — every entry obeys the conditions;
* `_nodup` — the entries are pairwise distinct;
* `_complete` — every matrix obeying the conditions is in the list.

Those four together are a cardinality.  The lists themselves were generated
from `icemix.frozen.model_states`; they are data, and the four theorems are
what makes them trustworthy.

## Cutting the search down to 1296 candidates

Completeness is the only theorem here that has to look at more than the lists,
and the obvious way to state it — `∀ M : Mat, IceA M → IceB M → M ∈ iceStates`
decided over all `2^16` matrices — cannot be built: it reached 55 GB before
being killed.  The reason is the shape of the decidability instances that
enumerate a function type (`Theorem1/Decide.lean`): they nest
`decidable_of_iff (p true ∧ p false)` sixteen deep, which substitutes the
predicate's body twice at every level, so the kernel sees `2^16` copies of it.
That is affordable when the body is small — `Theorem1/Brute.lean` does exactly
this and costs about two minutes — and unaffordable when the body mentions a
list of matrices.

The fix is to shrink the search rather than to enumerate more cleverly.  The
ice rule at the A-sites (R) already says each row has exactly two `true`
entries, so each row is one of the six vectors in `twoHot`, and only
`6^4 = 1296` matrices are candidates.  `mem_iceRowMats` turns (R) into
membership of that 1296-element list, and every exhaustive check below runs
over it, as a `Bool` computation, in about a second.
-/

namespace Theorem1

set_option maxRecDepth 100000
set_option maxHeartbeats 400000

/-! ## The 1296 candidates -/

/-- The six rows allowed by the ice rule at an A-site. -/
def twoHot : List (Fin 4 → Bool) :=
  [mk4 true true false false, mk4 true false true false, mk4 true false false true,
   mk4 false true true false, mk4 false true false true, mk4 false false true true]

/-- A row with exactly two arrows out is one of the six. -/
theorem row_mem_twoHot : ∀ v : Fin 4 → Bool,
    b2n (v 0) + b2n (v 1) + b2n (v 2) + b2n (v 3) = 2 → v ∈ twoHot := by decide

/-- The `6^4 = 1296` matrices all of whose rows obey the ice rule at the
A-site. -/
def iceRowMats : List Mat :=
  twoHot.flatMap fun r0 => twoHot.flatMap fun r1 => twoHot.flatMap fun r2 =>
    twoHot.map fun r3 => mkM r0 r1 r2 r3

theorem iceRowMats_length : iceRowMats.length = 1296 := rfl

/-- Condition (R) alone confines a matrix to the 1296 candidates. -/
theorem mem_iceRowMats (M : Mat) (h : IceA M) : M ∈ iceRowMats := by
  have h0 : M 0 ∈ twoHot := row_mem_twoHot _ (h 0)
  have h1 : M 1 ∈ twoHot := row_mem_twoHot _ (h 1)
  have h2 : M 2 ∈ twoHot := row_mem_twoHot _ (h 2)
  have h3 : M 3 ∈ twoHot := row_mem_twoHot _ (h 3)
  have hm : mkM (M 0) (M 1) (M 2) (M 3) ∈ iceRowMats := by
    simp only [iceRowMats, List.mem_flatMap, List.mem_map]
    exact ⟨_, h0, _, h1, _, h2, _, h3, rfl⟩
  exact mat_eta M ▸ hm

/-! ## `Bool`-valued equality, membership and bounded quantification

Used in place of the `DecidableEq Mat` instance: a `Decidable` instance carries
a proof term per comparison, and `∀ M ∈ iceStates, …` is literally
`∀ M : Mat, M ∈ iceStates → …`, which sends instance resolution back to the
`2^16` enumeration.  `Bool` computation plus the bridging lemmas below keeps
everything cheap. -/

/-- Bool-valued equality of matrices. -/
def matBEq (M N : Mat) : Bool :=
  (M 0 0 == N 0 0) && (M 0 1 == N 0 1) && (M 0 2 == N 0 2) && (M 0 3 == N 0 3) &&
  (M 1 0 == N 1 0) && (M 1 1 == N 1 1) && (M 1 2 == N 1 2) && (M 1 3 == N 1 3) &&
  (M 2 0 == N 2 0) && (M 2 1 == N 2 1) && (M 2 2 == N 2 2) && (M 2 3 == N 2 3) &&
  (M 3 0 == N 3 0) && (M 3 1 == N 3 1) && (M 3 2 == N 3 2) && (M 3 3 == N 3 3)

theorem matBEq_refl (M : Mat) : matBEq M M = true := by simp [matBEq]

theorem matBEq_eq {M N : Mat} (h : matBEq M N = true) : M = N := by
  simp only [matBEq, Bool.and_eq_true, beq_iff_eq] at h
  funext g k
  cases g using Fin4.rec4 <;> cases k using Fin4.rec4 <;> simp_all

/-- Bool-valued list membership. -/
def memB (M : Mat) : List Mat → Bool
  | [] => false
  | N :: l => matBEq M N || memB M l

theorem memB_mem {M : Mat} : ∀ {l : List Mat}, memB M l = true → M ∈ l
  | [], h => by simp [memB] at h
  | N :: l, h => by
      simp only [memB, Bool.or_eq_true] at h
      cases h with
      | inl h => exact matBEq_eq h ▸ List.mem_cons_self ..
      | inr h => exact List.mem_cons_of_mem _ (memB_mem h)

theorem mem_memB {M : Mat} : ∀ {l : List Mat}, M ∈ l → memB M l = true
  | [], h => by cases h
  | N :: l, h => by
      cases List.mem_cons.mp h with
      | inl he => simp [memB, he, matBEq_refl]
      | inr hm => simp [memB, mem_memB hm]

/-- Bool-valued bounded universal quantification. -/
def allB (p : Mat → Bool) : List Mat → Bool
  | [] => true
  | N :: l => p N && allB p l

theorem allB_forall {p : Mat → Bool} :
    ∀ {l : List Mat}, allB p l = true → ∀ M ∈ l, p M = true
  | [], _, _, hM => by cases hM
  | N :: l, hall, M, hM => by
      simp only [allB, Bool.and_eq_true] at hall
      cases List.mem_cons.mp hM with
      | inl he => exact he ▸ hall.1
      | inr hm => exact allB_forall hall.2 M hm

/-- Bool-valued pairwise distinctness. -/
def nodupB : List Mat → Bool
  | [] => true
  | N :: l => if memB N l then false else nodupB l

theorem nodupB_nodup : ∀ {l : List Mat}, nodupB l = true → l.Nodup
  | [], _ => List.Pairwise.nil
  | N :: l, h => by
      unfold nodupB at h
      split at h
      · exact Bool.noConfusion h
      · rename_i hne
        refine List.Pairwise.cons (fun a ha heq => ?_) (nodupB_nodup h)
        subst heq
        exact hne (mem_memB ha)

/-! ## The states -/

/-- The 90 ice states of the `(1,1,1)` cell: row sums 2 and B-label sums 2. -/
def iceStates : List Mat :=
  [ mkM (mk4 true true false false) (mk4 true true false false) (mk4 true true false false) (mk4 true true false false)
  , mkM (mk4 false true false true) (mk4 true true false false) (mk4 true false true false) (mk4 true true false false)
  , mkM (mk4 true true false false) (mk4 true false true false) (mk4 true false true false) (mk4 true true false false)
  , mkM (mk4 false true true false) (mk4 true true false false) (mk4 false true true false) (mk4 true true false false)
  , mkM (mk4 true true false false) (mk4 true false false true) (mk4 false true true false) (mk4 true true false false)
  , mkM (mk4 true false false true) (mk4 true true false false) (mk4 true false false true) (mk4 true true false false)
  , mkM (mk4 true true false false) (mk4 false true true false) (mk4 true false false true) (mk4 true true false false)
  , mkM (mk4 true false true false) (mk4 true true false false) (mk4 false true false true) (mk4 true true false false)
  , mkM (mk4 true true false false) (mk4 false true false true) (mk4 false true false true) (mk4 true true false false)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 true false true false) (mk4 true true false false) (mk4 true true false false) (mk4 true false true false)
  , mkM (mk4 true true false false) (mk4 false true false true) (mk4 true true false false) (mk4 true false true false)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 true false true false) (mk4 true false false true) (mk4 false true true false) (mk4 true false true false)
  , mkM (mk4 false true true false) (mk4 false true false true) (mk4 false true true false) (mk4 true false true false)
  , mkM (mk4 true false true false) (mk4 false true true false) (mk4 true false false true) (mk4 true false true false)
  , mkM (mk4 true false false true) (mk4 false true false true) (mk4 true false false true) (mk4 true false true false)
  , mkM (mk4 true false true false) (mk4 false true false true) (mk4 false true false true) (mk4 true false true false)
  , mkM (mk4 false false true true) (mk4 false true false true) (mk4 false false true true) (mk4 true false true false)
  , mkM (mk4 true false true false) (mk4 false false true true) (mk4 false false true true) (mk4 true false true false)
  , mkM (mk4 true false false true) (mk4 true true false false) (mk4 true true false false) (mk4 false true true false)
  , mkM (mk4 true true false false) (mk4 false true true false) (mk4 true true false false) (mk4 false true true false)
  , mkM (mk4 true false false true) (mk4 true false true false) (mk4 true false true false) (mk4 false true true false)
  , mkM (mk4 false true false true) (mk4 false true true false) (mk4 true false true false) (mk4 false true true false)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 true false false true) (mk4 false true true false) (mk4 true false false true) (mk4 false true true false)
  , mkM (mk4 true false true false) (mk4 false true true false) (mk4 false true false true) (mk4 false true true false)
  , mkM (mk4 true false false true) (mk4 false true false true) (mk4 false true false true) (mk4 false true true false)
  , mkM (mk4 false false true true) (mk4 false true true false) (mk4 false false true true) (mk4 false true true false)
  , mkM (mk4 true false false true) (mk4 false false true true) (mk4 false false true true) (mk4 false true true false)
  , mkM (mk4 false true true false) (mk4 true true false false) (mk4 true true false false) (mk4 true false false true)
  , mkM (mk4 true true false false) (mk4 true false false true) (mk4 true true false false) (mk4 true false false true)
  , mkM (mk4 false true true false) (mk4 true false true false) (mk4 true false true false) (mk4 true false false true)
  , mkM (mk4 false true false true) (mk4 true false false true) (mk4 true false true false) (mk4 true false false true)
  , mkM (mk4 false true true false) (mk4 true false false true) (mk4 false true true false) (mk4 true false false true)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 true false true false) (mk4 true false false true) (mk4 false true false true) (mk4 true false false true)
  , mkM (mk4 false true true false) (mk4 false true false true) (mk4 false true false true) (mk4 true false false true)
  , mkM (mk4 false false true true) (mk4 true false false true) (mk4 false false true true) (mk4 true false false true)
  , mkM (mk4 false true true false) (mk4 false false true true) (mk4 false false true true) (mk4 true false false true)
  , mkM (mk4 false true false true) (mk4 true true false false) (mk4 true true false false) (mk4 false true false true)
  , mkM (mk4 true true false false) (mk4 true false true false) (mk4 true true false false) (mk4 false true false true)
  , mkM (mk4 false true false true) (mk4 true false true false) (mk4 true false true false) (mk4 false true false true)
  , mkM (mk4 false true true false) (mk4 true false true false) (mk4 false true true false) (mk4 false true false true)
  , mkM (mk4 false true false true) (mk4 true false false true) (mk4 false true true false) (mk4 false true false true)
  , mkM (mk4 true false false true) (mk4 true false true false) (mk4 true false false true) (mk4 false true false true)
  , mkM (mk4 false true false true) (mk4 false true true false) (mk4 true false false true) (mk4 false true false true)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 false false true true) (mk4 true false true false) (mk4 false false true true) (mk4 false true false true)
  , mkM (mk4 false true false true) (mk4 false false true true) (mk4 false false true true) (mk4 false true false true)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 false false true true) (mk4 true false true false) (mk4 true false true false) (mk4 false false true true)
  , mkM (mk4 false true false true) (mk4 false false true true) (mk4 true false true false) (mk4 false false true true)
  , mkM (mk4 false false true true) (mk4 true false false true) (mk4 false true true false) (mk4 false false true true)
  , mkM (mk4 false true true false) (mk4 false false true true) (mk4 false true true false) (mk4 false false true true)
  , mkM (mk4 false false true true) (mk4 false true true false) (mk4 true false false true) (mk4 false false true true)
  , mkM (mk4 true false false true) (mk4 false false true true) (mk4 true false false true) (mk4 false false true true)
  , mkM (mk4 false false true true) (mk4 false true false true) (mk4 false true false true) (mk4 false false true true)
  , mkM (mk4 true false true false) (mk4 false false true true) (mk4 false true false true) (mk4 false false true true)
  , mkM (mk4 false false true true) (mk4 false false true true) (mk4 false false true true) (mk4 false false true true)
  ]

/-- The 12 `W = 0` ice states of the `(1,1,1)` cell: also column sums 2. -/
def w0States : List Mat :=
  [ mkM (mk4 false false true true) (mk4 true true false false) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 false false true true) (mk4 true true false false)
  , mkM (mk4 false true false true) (mk4 false true false true) (mk4 true false true false) (mk4 true false true false)
  , mkM (mk4 true false true false) (mk4 false true false true) (mk4 false true false true) (mk4 true false true false)
  , mkM (mk4 true false false true) (mk4 true false false true) (mk4 false true true false) (mk4 false true true false)
  , mkM (mk4 true false false true) (mk4 false true true false) (mk4 true false false true) (mk4 false true true false)
  , mkM (mk4 false true true false) (mk4 true false false true) (mk4 false true true false) (mk4 true false false true)
  , mkM (mk4 false true true false) (mk4 false true true false) (mk4 true false false true) (mk4 true false false true)
  , mkM (mk4 false true false true) (mk4 true false true false) (mk4 true false true false) (mk4 false true false true)
  , mkM (mk4 true false true false) (mk4 true false true false) (mk4 false true false true) (mk4 false true false true)
  , mkM (mk4 false false true true) (mk4 true true false false) (mk4 true true false false) (mk4 false false true true)
  , mkM (mk4 true true false false) (mk4 false false true true) (mk4 true true false false) (mk4 false false true true)
  ]

/-! ## The four theorems, twice -/

theorem iceStates_length : iceStates.length = 90 := rfl

theorem w0States_length : w0States.length = 12 := rfl

theorem iceStates_sound : ∀ M ∈ iceStates, IceA M ∧ IceB M := by
  have h : allB (fun M => decide (IceA M ∧ IceB M)) iceStates = true := by decide
  exact fun M hM => of_decide_eq_true (allB_forall h M hM)

theorem w0States_sound : ∀ M ∈ w0States, IceA M ∧ IceB M ∧ ZeroFlux M := by
  have h : allB (fun M => decide (IceA M ∧ IceB M ∧ ZeroFlux M)) w0States = true := by
    decide
  exact fun M hM => of_decide_eq_true (allB_forall h M hM)

theorem iceStates_nodup : iceStates.Nodup :=
  nodupB_nodup (by decide)

theorem w0States_nodup : w0States.Nodup :=
  nodupB_nodup (by decide)

/-- **Every** state obeying (R) and (B) is one of the 90.  Checked over the
1296 candidates of `iceRowMats`, which (R) alone confines it to. -/
theorem iceStates_complete : ∀ M : Mat, IceA M → IceB M → M ∈ iceStates := by
  have key : allB (fun M => if IceA M ∧ IceB M then memB M iceStates else true)
      iceRowMats = true := by decide +kernel
  intro M h1 h2
  have h := allB_forall key M (mem_iceRowMats M h1)
  rw [if_pos ⟨h1, h2⟩] at h
  exact memB_mem h

/-- **Every** state obeying (R), (B) and (C) is one of the 12. -/
theorem w0States_complete : ∀ M : Mat, IceA M → IceB M → ZeroFlux M → M ∈ w0States := by
  have key : allB (fun M => if IceA M ∧ IceB M ∧ ZeroFlux M then memB M w0States else true)
      iceRowMats = true := by decide +kernel
  intro M h1 h2 h3
  have h := allB_forall key M (mem_iceRowMats M h1)
  rw [if_pos ⟨h1, h2, h3⟩] at h
  exact memB_mem h

/-- The 12 `W = 0` states are among the 90 ice states. -/
theorem w0_subset_ice : ∀ M ∈ w0States, M ∈ iceStates := by
  have h : allB (fun M => memB M iceStates) w0States = true := by decide
  exact fun M hM => memB_mem (allB_forall h M hM)

end Theorem1
