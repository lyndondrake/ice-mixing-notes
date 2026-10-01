import Periodicity.LemmaA
import Periodicity.Lift
import Periodicity.Flux
import Periodicity.LemmaL

/-!
# The chain from Theorem U to periodicity: statements and their wiring

The statements of the chain, in the model of `Periodicity/Basic.lean`.  Each
statement whose proof is not formalised is a `theorem` whose proof is `sorry`,
marked `-- BLUEPRINT: proof open`.  Proof open here means *not yet formalised
in Lean*; the standing in the notes differs from statement to statement and is
recorded in `README.md`.  The derivation of periodicity from H, P, A and the
flux balance, `periodic_of_chain`, and its form with the flux balance discharged,
`periodic_of_H_P`, are proved theorems with those statements as
hypotheses, so its axioms are clean; `periodicity_of_U` composes it with the
sorried statements and so depends on `sorryAx`, which `#print axioms` shows.

Sources: `docs/notes/theorem-h-orientation.md` (Theorems U, H, 1; the
periodicity paragraph after the table of "What is proved"; Certification) and
`docs/notes/curl-reduction.md` (Lemma L, Lemma C, Theorem P, the zero-flux remark
after Lemma A); the corrections of `docs/reports/2026-10-01-opus-pacheck.md`
(Theorem P needs every extent at least two; Lemma A's nonzero element).
-/

namespace Periodicity

variable {a b c : Nat}

/-! ## Lemma C (proved) -/

theorem circ_curl : ∀ b0 b1 b2 b3 b4 b5 : Bool,
    (b5 == b0).toNat + (b0 == b1).toNat + (b1 == b2).toNat + (b2 == b3).toNat +
      (b3 == b4).toNat + (b4 == b5).toNat = 0 →
    (b0 ^^ b1 ^^ b2 ^^ b3 ^^ b4 ^^ b5) = true := by decide

/-- A circulating hexagon has odd curl: its bits alternate, so three are set. -/
theorem curl_of_circulates (s : State a b c) (h : Hex a b c) (hc : Circulates s h) :
    curl s h = true :=
  circ_curl (hbit s h 0) (hbit s h 1) (hbit s h 2) (hbit s h 3) (hbit s h 4) (hbit s h 5) hc

/-- **Lemma C** (curl-reduction).  An ice state with even curl on every hexagon
is frozen. -/
theorem lemmaC (s : State a b c) (hi : Ice s) (he : EvenCurl s) : Frozen s :=
  ⟨hi, fun h hv hc => by have := he h hv; rw [curl_of_circulates s h hc] at this; cases this⟩

/-! ## Lemma L (proved) -/

/-- **Lemma L** (curl-reduction): in a frozen state every hexagon has exactly two
reversals. -/
def LemmaL (a b c : Nat) : Prop :=
  ∀ s : State a b c, Frozen s → ∀ h : Hex a b c, h.valid = true → nrev s h = 2

/-- Lemma L, proved in `Periodicity/LemmaL.lean`. -/
theorem lemmaL (a b c : Nat) : LemmaL a b c :=
  fun s hf h hv => lemmaL_proved s hf h hv

/-! ## Theorems U, H and 1 -/

/-- **Theorem U** (theorem-h-orientation): in an odd frozen state every hole has
one rod pointing towards it and one pointing away, that is, charge zero. -/
def TheoremU (a b c : Nat) : Prop :=
  ∀ s : State a b c, Frozen s → OddState s → ∀ O : Pt a b c, isHole O = true → Oriented s O

/-- **Theorem H** (theorem-h-orientation): an odd frozen state has an axis that
is empty or one-way. -/
def TheoremH (a b c : Nat) : Prop :=
  ∀ s : State a b c, Frozen s → OddState s → ∃ k : Fin 3, AxisEmpty s k ∨ OneWay s k

-- BLUEPRINT: proof open
/-- **Theorem U** on a cell.  Open in the notes on every cell outside those
named in `README.md`. -/
theorem theoremU (a b c : Nat) : TheoremU a b c := by
  sorry

-- BLUEPRINT: proof open
/-- **Theorem 1** (theorem-h-orientation, form of 30 September 2026): on every
cell, Theorem U implies Theorem H.  Proved in the note; not yet in Lean. -/
theorem theorem1 (a b c : Nat) (hU : TheoremU a b c) : TheoremH a b c := by
  sorry

/-! ## Theorem P -/

/-- **Theorem P** (curl-reduction): an ice state with even curl on every
hexagon is invariant under a one-cube shift `(4,0,0)`, `(0,4,0)` or `(0,0,4)`. -/
def TheoremP (a b c : Nat) : Prop :=
  ∀ s : State a b c, Ice s → EvenCurl s →
    Invariant s ⟨4, 0, 0⟩ ∨ Invariant s ⟨0, 4, 0⟩ ∨ Invariant s ⟨0, 0, 4⟩

-- BLUEPRINT: proof open
/-- **Theorem P** on a cell whose extents are all at least two (the hypothesis
is what makes the shift nonzero; pacheck, 1 October 2026). -/
theorem theoremP (a b c : Nat) (ha : 2 ≤ a) (hb : 2 ≤ b) (hc : 2 ≤ c) : TheoremP a b c := by
  sorry

/-! ## Zero flux balances the axes -/

/-- **The flux balance** (curl-reduction, the remark after Lemma A; pacheck V2):
in an ice state of zero flux each axis carries as many `+` as `-` moments on each
sublattice, so an axis that is one-way is empty. -/
def FluxBalance (a b c : Nat) : Prop :=
  ∀ s : State a b c, Ice s → ZeroFlux s → ∀ k : Fin 3, OneWay s k → AxisEmpty s k

/-- The flux balance, proved in `Periodicity/Flux.lean`. -/
theorem fluxBalance (a b c : Nat) : FluxBalance a b c :=
  fun s hi hz k hw => oneWay_empty_of_zeroFlux s hi hz k hw

/-! ## Periodicity -/

/-- **The periodicity statement**: every frozen zero-flux state is invariant
under a translation of the A lattice that is not zero modulo the box. -/
def Periodic (a b c : Nat) : Prop :=
  ∀ s : State a b c, Frozen s → ZeroFlux s →
    ∃ t : V3, InALattice t ∧ ¬ ZeroMod a b c t ∧ Invariant s t

theorem shift_nonzero (n : Nat) (hn : 2 ≤ n) : ¬ ((4 * n : Nat) : Int) ∣ 4 := by
  intro h
  have := Int.le_of_dvd (by decide) h
  omega

/-- **The derivation of periodicity from H, P, A and the flux balance** (the
paragraph after the table of theorem-h-orientation, in the form pacheck's V5
gives it).  Proved: an odd state has an empty or one-way axis by H, a one-way
axis is empty by the flux balance, and an empty axis gives a nonzero
translation by Lemma A (proved, `lemmaA_nonzero`); a state that is not odd has
even curl, and P gives a one-cube shift, nonzero because every extent is at
least two. -/
theorem periodic_of_chain (ha : 2 ≤ a) (hb : 2 ≤ b) (hc : 2 ≤ c)
    (hH : TheoremH a b c) (hP : TheoremP a b c) (hF : FluxBalance a b c) : Periodic a b c := by
  intro s hf hz
  by_cases ho : OddState s
  · obtain ⟨k, hk⟩ := hH s hf ho
    have he : AxisEmpty s k := hk.elim id (hF s hf.1 hz k)
    exact lemmaA_nonzero (by omega) (by omega) (by omega) s hf.1 k he
  · rcases hP s hf.1 (evenCurl_of_not_odd s ho) with h | h | h
    · refine ⟨_, ?_, ?_, h⟩
      · refine ⟨?_, ?_, ?_, ?_⟩ <;> decide
      · intro hm; exact shift_nonzero a ha (by simpa using hm.1)
    · refine ⟨_, ?_, ?_, h⟩
      · refine ⟨?_, ?_, ?_, ?_⟩ <;> decide
      · intro hm; exact shift_nonzero b hb (by simpa using hm.2.1)
    · refine ⟨_, ?_, ?_, h⟩
      · refine ⟨?_, ?_, ?_, ?_⟩ <;> decide
      · intro hm; exact shift_nonzero c hc (by simpa using hm.2.2)

/-- **Periodicity from Theorem H and Theorem P** on a cell whose extents are
all at least two, with the flux balance and Lemma A proved.  The hypotheses are
exactly the two open statements of the chain below Theorem H. -/
theorem periodic_of_H_P (ha : 2 ≤ a) (hb : 2 ≤ b) (hc : 2 ≤ c)
    (hH : TheoremH a b c) (hP : TheoremP a b c) : Periodic a b c :=
  periodic_of_chain ha hb hc hH hP (fluxBalance a b c)

/-- **Periodicity from Theorem U** on a cell whose extents are all at least two:
Theorem U gives Theorem H by Theorem 1, and the derivation above does the rest.
Depends on the sorried `theorem1` and `theoremP`. -/
theorem periodicity_of_U (ha : 2 ≤ a) (hb : 2 ≤ b) (hc : 2 ≤ c) (hU : TheoremU a b c) :
    Periodic a b c :=
  periodic_of_H_P ha hb hc (theorem1 a b c hU) (theoremP a b c ha hb hc)

/-- **The periodicity conjecture** on a cell whose extents are all at least two,
as the chain gives it.  Depends on every sorried statement of the chain. -/
theorem periodicity (ha : 2 ≤ a) (hb : 2 ≤ b) (hc : 2 ≤ c) : Periodic a b c :=
  periodicity_of_U ha hb hc (theoremU a b c)

/-- Theorem H on a cell `(a, b, c)` follows from Theorem H on any cell
`(k₁a, k₂b, k₃c)` (the use of Lemma 21 in Theorem 24 and in the proof of Theorem
1 on cells with an extent of one).  Proved from Lemma 21. -/
theorem theoremH_of_repeat (k₁ k₂ k₃ : Nat) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hk₁ : 0 < k₁) (hk₂ : 0 < k₂) (hk₃ : 0 < k₃)
    (hH : TheoremH (k₁ * a) (k₂ * b) (k₃ * c)) : TheoremH a b c := by
  intro s hf ho
  obtain ⟨hF, hO, hM⟩ := lemma21 k₁ k₂ k₃ ha hb hc hk₁ hk₂ hk₃ s
  obtain ⟨k, hk⟩ := hH _ (hF.2 hf) (hO.2 ho)
  refine ⟨k, ?_⟩
  rcases hk with he | ⟨e, hw⟩
  · left
    intro v hv hvk
    obtain ⟨w, hw, hwm⟩ := (hM (k, vsign s v)).2 ⟨v, hv, by simp [moment, hvk]⟩
    exact he w hw (congrArg Prod.fst hwm)
  · right
    refine ⟨e, fun v hv hvk => ?_⟩
    obtain ⟨w, hw', hwm⟩ := (hM (k, vsign s v)).2 ⟨v, hv, by simp [moment, hvk]⟩
    have h1 : vtype _ w = k := congrArg Prod.fst hwm
    have h2 : vsign _ w = vsign s v := congrArg Prod.snd hwm
    rw [← h2]; exact hw w hw' h1

end Periodicity
