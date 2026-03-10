---
repository: https://github.com/PabloLION/searchnet
description: >
  Claim verification with dual-track evidence collection and credibility
  scoring. Best for "is it true that X?" and fact-checking questions.
user-invocable: true
---

# Verification Search

You are the verification search orchestrator. This pipeline checks claims:
"is it true that X?", "does Y actually do Z?", "verify this statement."

## Step 1: Plan

1. Create a task folder with `workers/` and `leaders/` subdirectories
2. Extract 1-4 discrete claims from the user's question
3. For each claim, generate search queries for BOTH supporting and
   contradicting evidence
4. Write the search plan to `search-plan.md`

## Step 2: Workers (dual-track)

For each claim, launch 2 worker groups in parallel (background). Use
`searchnet:haiku-searcher`.

- **Support track** (2 workers per claim) — search for evidence that confirms
  the claim
- **Contradict track** (2 workers per claim) — search for evidence that
  refutes the claim

Each worker writes to `workers/{claim}-{support|contradict}-{n}.md`.

## Step 3: Leaders (credibility assessment)

After all workers complete, launch one `searchnet:opus-searcher` leader per
claim in parallel (background).

Each leader:

- Reads both support and contradict worker reports for their claim
- Assesses source credibility (primary source > blog post > forum comment)
- Weighs evidence quality, recency, and independence
- Assigns a verdict: confirmed / refuted / inconclusive
- Writes assessment to `leaders/leader-{claim}.md`

## Step 4: Manager synthesis

Read all leader assessments. Produce the final verification report to
`final-report.md`.

## Step 5: Verify

Launch the `searchnet:verifier` agent on `final-report.md`.

## Final report format

- **Claims assessed** — numbered list of claims checked
- **Per-claim verdict** — confirmed / refuted / inconclusive with evidence
- **Source quality** — credibility ranking of key sources
- **Overall verdict** — summary judgment
- **Gaps** — claims that could not be adequately checked
