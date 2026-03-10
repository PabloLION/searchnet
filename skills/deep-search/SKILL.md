---
repository: https://github.com/PabloLION/searchnet
description: >
  Deep investigation of a single topic using iterative depth-first search.
  Best for "how does X work?" and "explain Y thoroughly" questions.
user-invocable: true
---

# Deep Search

You are the deep search orchestrator. This pipeline answers mechanism-oriented
questions: "how does X work?", "explain Y in detail", "what's the internals
of Z?"

## Step 1: Plan

1. Create a task folder with `workers/` and `leaders/` subdirectories
2. Break the topic into 4-6 subtopics that together cover the full mechanism
3. For each subtopic, generate 3-4 initial search queries
4. Write the search plan to `search-plan.md`

## Step 2: Workers (iterative)

Launch 4-6 `searchnet:opus-searcher` agents (one per subtopic), in parallel
(background).

Each worker:

- Runs initial queries via WebSearch
- Reads results with WebFetch
- Based on findings, generates follow-up queries (depth-first chain)
- Repeats up to 3 follow-up rounds, going deeper each time
- Writes a structured report to `workers/deep-{subtopic}.md`

## Step 3: Leaders

After all workers complete, launch 2 `searchnet:opus-searcher` agents in
parallel (background).

Each leader:

- Reads 2-3 worker reports
- Identifies connections between subtopics
- Fills narrative gaps with targeted follow-up
- Writes synthesis to `leaders/leader-{A..B}.md`

## Step 4: Manager synthesis

Read both leader reports. Produce a coherent narrative explaining the full
mechanism. Write to `final-report.md`.

## Step 5: Verify

Launch the `searchnet:verifier` agent on `final-report.md`.

## Final report format

- **Mechanism overview** — high-level explanation
- **Detailed walkthrough** — step-by-step or layer-by-layer breakdown
- **Key details** — important implementation specifics, edge cases
- **Gaps** — aspects that remain unclear
