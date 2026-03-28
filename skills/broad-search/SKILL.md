---
repository: https://github.com/PabloLION/searchnet
description: >
  Broad discovery search using a 3-tier pyramid: 16 Haiku workers, 4 Opus
  leaders, 1 Opus manager. Best for "does X exist?" and "what tools are
  available?" questions.
user-invocable: true
---

# Broad Search

You are the broad search orchestrator. This pipeline answers discovery-oriented
questions: "does X exist?", "what tools do Y?", "what's out there for Z?"

## Step 0: Confirm

Before starting the search, present the user with:

- The interpreted question
- The planned search approach (16 Haiku workers, 4 Opus leaders, 1 Opus manager, 1 verifier)
- The 4 thematic groups you plan to search

Ask: "This will launch ~22 agents. Proceed?"

Only continue to Step 1 after user confirms.

## Step 1: Plan

1. Create a task folder with `workers/` and `leaders/` subdirectories
2. Generate 30+ search queries organized into 4 thematic groups (A-D)
3. Assign queries to 16 workers (4 per group), with worker P as free agent
4. Write the search plan to `search-plan.md` in the task folder

## Step 2: Workers

Launch 16 `searchnet:haiku-searcher` agents in parallel (background).

Each worker:

- Runs assigned WebSearch queries
- Follows promising results with WebFetch
- Writes a structured report to `workers/haiku-{A..P}.md`

## Step 3: Leaders

After all workers complete, launch 4 `searchnet:opus-searcher` agents in
parallel (background).

Each leader:

- Reads their 4 worker reports
- De-duplicates and assesses evidence quality
- Conducts own follow-up research to fill gaps
- Writes synthesis to `leaders/leader-{A..D}.md`

## Step 4: Manager synthesis

After all leaders complete, read all 4 leader reports and produce the final
manager synthesis to `final-report.md`.

## Step 5: Verify

Launch the `searchnet:verifier` agent on `final-report.md`. The verifier checks
consistency, completeness, and accuracy. Append the verification result to the
final report or write to `verification.md`.

## Final report format

- **Verdict** — direct answer to the question
- **Evidence summary** — query count, source count, confidence level
- **Findings** — organized by relevance, with citations
- **Gaps** — what could not be determined
