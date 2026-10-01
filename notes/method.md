---
title: "How the work was done: the method of a language-model research programme on pyrochlore ice, and what it produced beyond its results"
author: "Lyndon Drake, with Claude Code (Anthropic Claude 5 models)"
date: 2026-09-06
lang: en-GB
abstract: |
  The results of this project, a measured dynamical exponent, two
  frozen-state theorems, a certified periodicity result at two cell
  sizes, a reduction of the periodicity conjecture to a parity
  statement, and four falsifier results, were produced by language
  models working under human direction over about four weeks of
  sessions. This note describes the method rather than the results:
  the pre-registration of every measurement stage with its falsifiers
  and its readings, the gate between stages at which a human reads a
  report against the registration, the status vocabulary in which every
  claim carries the word proved, certified, enumerated, solver or
  conjecture, the two-method gate for every count, the certification
  ladder from a solver verdict to a checked DRAT or LRAT proof to a
  formalisation in Lean 4 or Isabelle/HOL, the division of labour
  between a main loop that reasons, reviews and logs and subagents that
  compute and report in archived documents, and the record itself, a
  log in which every claim has an actor and a status and every
  withdrawal is kept. It then lists what the method caught and what it
  missed, each with the incident that is its evidence, and the
  generalisable findings: that structure seen only on degenerate cells
  is suspect and the two kinds of degeneracy that arose here, that a
  statement true by an averaging argument over the whole torus cannot
  be found by any finite window, that a solver's silence within a time
  cap is an outcome to be recorded and not a claim, and that the rules
  which held were the ones enforced by code or by a gate rather than by
  a sentence in a brief. Nothing in this note is certified; its
  evidence is the repository's log, its handover file and its archived
  subagent reports, and the sibling notes carry the results.
---

# What the method had to do

The problem set was a mixture of a numerical measurement at scale, a
set of exact computations on small cells, machine-checked proofs, and
analytic work whose aim was to find and prove structure. The failure
modes of language models differ across those kinds of work. A model
that runs a Monte Carlo campaign can fit noise and report a clean
exponent; a model that enumerates can miscount and never know; a model
that proves can re-derive a refuted statement at the same cost as
recalling that it was refuted, and cannot feel the difference; and a
model that searches for structure on small examples will find
structure that is an artefact of the example. The method described
here is the set of rules that were adopted against those failure
modes, with the evidence for each rule's value.

# Pre-registration and stage gates

Every measurement stage was registered before it ran. The registration
named the quantity, the cells, the estimator, the falsifiers (what
would count as a failure), and the reading rule, that is, how the
numbers would be read as PASS or FAIL. After the stage the subagent
that ran it wrote a report; the main loop read the report against the
registration and recorded PASS or FAIL as registered, and the human
read both at the gate before the next stage was briefed. The rule was
that a reading is never reinterpreted after the fact: if a falsifier
fires, the stage fails and the failure is recorded, whatever the
number looks like.

Two defects of substance were caught this way during the campaign,
both in flight: a phase quantisation of hexagon centres that corrupted
a structure factor, and a family of fast observables that had been
fitted to noise. Both are in the log with their dates, and both would
have survived a method that let the reading follow the number. The
plan of record (`docs/next-stage-plan-2026-09-04.md`) carries the
registration of the falsifier stage in the form used: each item with
its statement, its falsifier, its cost and its reading, and a later
section with the outcomes against it.

# The status vocabulary

Every claim in the working notes and the log carries one of five words.
**Proved** means a proof is written and can be read. **Certified**
means a machine-checked artefact exists in the repository: a DRAT or
LRAT proof accepted by an independent checker, a CPOG count, a Lean 4
or Isabelle/HOL theory that builds. **Enumerated** means the statement
was checked on every state of a cell by exhaustive enumeration.
**Solver** means a SAT verdict without a checked proof. **Conjecture**
means evidence only. The vocabulary was adopted on the first day of
the analytic work and applied backwards to everything already
recorded; its value is that a reader of any sentence knows what stands
behind it without opening a file, and that the writer cannot promote a
solver verdict to a theorem by a turn of phrase. The note on the
periodicity conjecture, `docs/frozen-structure-2026-09-05.md`, is
written entirely in it.

# The two-method gate

No count was trusted on its own. Every enumeration of ice states was
matched against an independent enumerator on every cell where both
could run (a frontier dynamic programme against a bit-parallel depth
first search; later, SAT enumeration with blocking clauses against
both), as sets rather than as totals, and the tests in the repository
assert the match. Certified counts by knowledge compilation were
matched against the enumerators before they were quoted. The frozen
state census at $(2,2,2)$ was produced by SAT enumeration and
certified by CPOG; the count of 612 is quoted because both agree. The
crystallographic anchors, the cell's point group and its 192 general
positions, were computed and asserted as tests, so that a symmetry
argument rests on a checked group rather than a recalled one.

The value of the gate showed in the one place it was skipped: the
first form of the chain-current identity in the note on dipole types
was written with a sign convention that ignored the projection of the
dipole on the chain, and failed on the enumerated states; the correct
law was found by fixing the failure. Without the enumeration the wrong
identity would have been recorded as proved.

# The certification ladder

A statement about a finite cell moves up a ladder as it is trusted
more. A solver verdict is recorded as such. A DRAT proof from the solver
is checked by drat-trim and the verdict file kept; the proof itself is
not committed but its hash is. Where a formula defeats a direct solve,
cube-and-conquer produces one LRAT proof per leaf cube, each checked by
lrat-check, and a DRAT proof that the leaves are exhaustive, with a
manifest of hashes and a checker written from scratch in the standard
library so that a third party need run none of the project's code.
Counts are certified by CPOG. Theorems with hand proofs were
formalised in Lean 4, with a bridge from the formal hexagons to the
ones the simulation derives, so that the object proved about is the
object simulated; and the real-root verdicts of the sector marginals
were certified in Isabelle/HOL by Sturm's theorem. The rule was that a
statement is described by the highest rung it has reached and no
higher, and that a rung is climbed only when the cost is small against
the value: the $L = 3$ periodicity result cost a night of certification
and was worth it; the $L = 4$ result stopped at 22,746 of 23,153 leaves
and is described as indicated, not proved.

# Division of labour

The main loop, the session the human talks to, did the reasoning, the
review and the record. Subagents did the computing and the reading of
long outputs, and wrote reports that were archived verbatim with their
provenance (`docs/reports/`). A subagent's "done" was treated as a
claim: the main loop checked the diff, re-ran a sample, or re-derived
the number before quoting it, and where a subagent's number and a
results file disagreed, the file won and the disagreement was
recorded. The eight contribution notes beside this one were drafted by
subagents from the repository's reports and code, with a literature
search whose every entry was verified against a fetched record, and
each was instructed to flag in its text any number that rests on prose
or on its own arithmetic rather than a results file; the flags are in
the notes. Model choice followed the work: a stronger model for the
analytic day, when the whole argument had to be held at once, and
smaller ones for the mechanical scans and the watch loops.

# The record

The log (`LOG.md`) is chronological and carries every claim with its
actor and its status; corrections are appended, not overwritten, so
that a withdrawn statement can be read beside its withdrawal. The
handover file (`HANDOVER.md`) is rewritten at the close of every
session to let a fresh session continue with nothing to re-derive: what
is in flight with the command to verify it, what to do in order, and
the standing policies the human has set. Memory outside the repository
holds only pointers. The commit history is one commit per milestone
with a message that states the result, and every milestone is pushed.
The value of the record is not sentimental: on the day the periodicity
work was done, the morning's note was read second by the afternoon's
session, and the afternoon's queries were built on its dead ends
without repeating them.

# What the method caught, and what it missed

Caught: the two campaign defects above; a vacuous pass that a
falsifier would have produced, disarmed before the stage ran; a
propagation law found on four cells and refuted on the fifth, recorded
as withdrawn with the reason (see the next section); a sign convention
in an identity, by the enumerated states; a first framing of the
prior-art gap, narrowed after every cited reference was fetched, with
the earlier wording kept.

Missed, and now rules: the main loop's own exploratory solvers were
launched beside a twelve-worker job and pushed the load to 33 on 20
cores, the oversubscription its own log had warned a day earlier
against, and again to 18 on the analytic day; the lesson is that a
warning written as a completed action decays, and the launch check now
lives in the brief as a step. Two subagents parked on their own
background monitors and stopped, twice each, until messaged; the
lesson is that a watch loop belongs inside one tool call or in the
main loop, never in a subagent's background. A solver's silence inside
a cap was at first reported as "running" for too long; the rule now is
that a cap reached is an outcome, recorded with its cap, and the
handover names it as such.

# Generalisable findings

**Structure seen only on degenerate cells is suspect, and there are
two kinds of degeneracy here.** On cells with an extent of two, every
chain parallel to a given chain is its half-box translate, so a
"propagation law" between chains was in fact the half-box symmetry;
it held on four such cells and failed on $(4,4,4)$. On cells with
$\gcd(b,c) = 1$ transverse to an axis there is one chain per slab along
that axis, so a kink-free chain is a whole slab and rigidity appears
that larger cells lack; it held on $(2,2,3)$ and $(2,3,3)$ and failed on
$(2,2,2)$, $(2,2,4)$ and $(3,3,3)$. The rule adopted: no structural
claim is recorded from a cell unless it also holds on a cell without
both degeneracies, and the note names the cells to trust.

**Some true statements have no finite witness.** That every hexagon of
a frozen state has exactly two flow reversals is proved by an average
over the torus, and a hexagon with four reversals is consistent with
freezing on the 610 hexagons within three steps of it. A window test
can therefore refute a local conjecture but cannot confirm a global
lemma, and the distinction was made explicit after the propagation-law
episode: a claim that a window cannot see was thereafter attacked by a
counting or parity argument rather than a larger window.

**Sharpness is worth measuring.** Several statements were tested not
only for truth but for the minimal hypothesis: that five of six
directions do not suffice for Theorem S, that no pair, triple,
quadruple or quintuple of directions is excluded by a single defect,
that per-axis hypotheses fail where the three-axis one holds. Each such
measurement told the analytic work what kind of proof was possible,
and in one case (the quintuple result) that no local proof was.

**The right reformulation was found by asking the solver which
hypothesis it needed, not by asking it for the theorem.** The reduction
of the periodicity conjecture went through five candidate intermediate
statements in a day, each tested as a query in minutes; the one that
survived, the parity on hexagons, was not the first or the most
natural, and the two that preceded it (type periodicity, and its
step to the period) became corollaries. The cost of a wrong candidate
was minutes, and the record keeps all five.

**Mechanised rules held; prose rules decayed.** The gates that were
code, the tests that assert counts, the checkers that accept or reject
proofs, did their work every time. The rules that lived as sentences in
a brief, on machine load, on monitors, on the caps, were the ones that
failed and had to be moved into code or into the checklist of a
launch.

# Artefacts

- `LOG.md`, `HANDOVER.md`, `docs/reports/` (archived subagent reports
  with provenance), `docs/next-stage-plan-2026-09-04.md` (a
  registration and its outcomes), `docs/frozen-structure-2026-09-05.md`
  (the status vocabulary in use), `tests/` (the two-method gates and
  crystallographic anchors), `experiments/07_certificates/verify_cnc_certificate.py`
  (the independent checker), `formal/` (Lean 4 and Isabelle/HOL).
