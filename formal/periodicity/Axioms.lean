import Periodicity

/-!
Run with `lake env lean Axioms.lean` (after `lake build`) to print the axiom
dependencies of every theorem in the development.  A proved theorem shows at
most `propext`, `Quot.sound` and `Classical.choice`; a theorem that rests on a
blueprint statement shows `sorryAx`.
-/

-- Lemma 21 (theorem-h-orientation)
#print axioms Periodicity.lemma21
#print axioms Periodicity.frozen_repeat_iff
#print axioms Periodicity.odd_repeat_iff
#print axioms Periodicity.moments_repeat_iff
#print axioms Periodicity.ice_repeat_iff
#print axioms Periodicity.theoremH_of_repeat

-- Lemma A (curl-reduction), with the nonzero element
#print axioms Periodicity.lemmaA_x
#print axioms Periodicity.lemmaA_y
#print axioms Periodicity.lemmaA_z
#print axioms Periodicity.lemmaA_gen
#print axioms Periodicity.gcd_mem_lamX
#print axioms Periodicity.gcd_mem_lamY
#print axioms Periodicity.gcd_mem_lamZ
#print axioms Periodicity.lemmaA_nonzero
#print axioms Periodicity.bezout

-- Lemma C (curl-reduction)
#print axioms Periodicity.lemmaC

-- the derivation of periodicity, with H, P and the flux balance as hypotheses
#print axioms Periodicity.periodic_of_chain
#print axioms Periodicity.periodic_of_H_P

-- the flux balance (curl-reduction, remark after Lemma A)
#print axioms Periodicity.fluxBalance
#print axioms Periodicity.oneWay_empty_of_zeroFlux
#print axioms Periodicity.flux_A
#print axioms Periodicity.flux_B
#print axioms Periodicity.sumPt_translate

-- the thin cell (1,2,2): pacheck's witness
#print axioms Periodicity.w122_frozen
#print axioms Periodicity.w122_zeroFlux
#print axioms Periodicity.w122_evenCurl
#print axioms Periodicity.w122_six
#print axioms Periodicity.w122_aperiodic
#print axioms Periodicity.not_periodic_122

-- the bridge: hexagons as lattice walks, counts
#print axioms Periodicity.hex_closed
#print axioms Periodicity.hex_ends
#print axioms Periodicity.walk_matches
#print axioms Periodicity.walk_is_hexagon
#print axioms Periodicity.hexagon_is_walk
#print axioms Periodicity.validWalks_count
#print axioms Periodicity.counts_111
#print axioms Periodicity.counts_122
#print axioms Periodicity.counts_222
#print axioms Periodicity.counts_223

-- the bridge to formal/theorem1
#print axioms Periodicity.ice_iff_theorem1
#print axioms Periodicity.hex_to_theorem1
#print axioms Periodicity.hex_of_theorem1
#print axioms Periodicity.frozen_iff_theorem1
#print axioms Periodicity.zeroFlux_iff_theorem1
#print axioms Periodicity.ice_count_111
#print axioms Periodicity.w0_count_111
#print axioms Periodicity.frozen_111
#print axioms Periodicity.ofMat_injective
#print axioms Periodicity.ofMat_surjective

-- Lemma L (curl-reduction) and the agreement of the two forms of oddness
#print axioms Periodicity.lemmaL
#print axioms Periodicity.lemmaL_proved
#print axioms Periodicity.curl_iff_same_sublattice
#print axioms Periodicity.sumPtI_translate

-- blueprint statements (proof open: sorryAx expected)
#print axioms Periodicity.theoremU
#print axioms Periodicity.theorem1
#print axioms Periodicity.theoremP

#print axioms Periodicity.periodicity_of_U
#print axioms Periodicity.periodicity
