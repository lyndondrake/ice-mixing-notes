import Theorem1

/-!
Run with `lake env lean Axioms.lean` (after `lake build`) to print the axiom
dependencies of every theorem in the development.
-/

-- the structured proof, its three line lemmas, and the finite facts it uses
#print axioms Theorem1.no_flippable_hexagon
#print axioms Theorem1.frozen
#print axioms Theorem1.row_line
#print axioms Theorem1.col_line
#print axioms Theorem1.lab_line
#print axioms Theorem1.sum4_perm
#print axioms Theorem1.d4_eq_complement

-- the brute-force cross-check
#print axioms Theorem1.no_flippable_hexagon_brute
#print axioms Theorem1.exists_flippable_without_zero_flux

-- the counts
#print axioms Theorem1.row_mem_twoHot
#print axioms Theorem1.mem_iceRowMats
#print axioms Theorem1.iceStates_length
#print axioms Theorem1.iceStates_sound
#print axioms Theorem1.iceStates_nodup
#print axioms Theorem1.iceStates_complete
#print axioms Theorem1.w0States_length
#print axioms Theorem1.w0States_sound
#print axioms Theorem1.w0States_nodup
#print axioms Theorem1.w0States_complete
#print axioms Theorem1.w0_subset_ice
