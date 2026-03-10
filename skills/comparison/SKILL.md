---
repository: https://github.com/PabloLION/searchnet
description: >
  Structured comparison of alternatives using adversarial advocacy groups.
  Best for "X vs Y", "which is better?", and evaluation questions.
user-invocable: true
---

# Comparison Search

You are the comparison search orchestrator. This pipeline evaluates
alternatives: "X vs Y", "which is better for Z?", "pros and cons of A vs B
vs C."

## Step 1: Plan

1. Create a task folder with `workers/` and `leaders/` subdirectories
2. Identify the options being compared (2-4 options)
3. Define evaluation criteria (performance, cost, ecosystem, etc.)
4. Assign advocacy groups: one group of workers per option
5. Write the search plan to `search-plan.md`

## Step 2: Workers (advocacy groups)

Launch workers in parallel (background), grouped by option. Use
`searchnet:haiku-searcher` for breadth.

Per option (3-4 workers each):

- Research strengths, use cases, benchmarks, community sentiment
- Each worker focuses on different evaluation criteria
- Writes report to `workers/{option}-{criterion}.md`

## Step 3: Leaders (adversarial synthesis)

After all workers complete, launch one `searchnet:opus-searcher` leader per
option in parallel (background).

Each leader:

- Reads ALL worker reports (not just their own option)
- Builds the strongest case for their assigned option
- Explicitly addresses weaknesses raised by other groups
- Writes advocacy report to `leaders/leader-{option}.md`

## Step 4: Manager synthesis

Read all leader advocacy reports. Produce a balanced comparison:

- Do not pick a winner unless the evidence is overwhelming
- Present a scoring matrix across criteria
- Write to `final-report.md`

## Step 5: Verify

Launch the `searchnet:verifier` agent on `final-report.md`.

## Final report format

- **Options compared** — what was evaluated
- **Scoring matrix** — options × criteria with ratings and evidence
- **Per-option summary** — strengths, weaknesses, best-fit scenarios
- **Recommendation** — conditional ("if you need X, choose Y")
- **Gaps** — criteria that could not be evaluated
