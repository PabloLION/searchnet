# searchnet

Multi-pipeline search plugin for [Claude Code](https://claude.ai/claude-code) using tiered agent architectures.

## Pipelines

| Pipeline | Skill | Architecture |
|----------|-------|-------------|
| Broad | `/searchnet:broad-search` | 16 Haiku workers → 4 Opus leaders → 1 Opus manager |
| Deep | `/searchnet:deep-search` | 4-6 Opus workers (iterative depth-first) → 2 leaders → manager |
| Comparison | `/searchnet:comparison` | Advocacy groups per option → adversarial leader synthesis → manager |
| Verification | `/searchnet:verification` | Dual-track (support + contradict) → credibility assessment → manager |

All pipelines include a final verification step using the `verifier` agent.

## Agents

| Agent | Model | Permission strategy |
|-------|-------|-------------------|
| haiku-researcher | Haiku | Hooks (external scripts) |
| sonnet-researcher | Sonnet | Hooks (external scripts) |
| opus-researcher | Opus | Hooks (external scripts) |
| hook-researcher | Sonnet | Hooks (inline jq) |
| bypass-researcher | Sonnet | bypassPermissions |
| bypass-opus-researcher | Opus | bypassPermissions |
| verifier | Opus | Read-only (no write tools) |

## Installation

```sh
claude plugin marketplace add ~/base/repo/PabloLION/searchnet
claude plugin install searchnet@searchnet --scope user
```

## Development

Test the plugin without installing:

```sh
claude --plugin-dir ~/base/repo/PabloLION/searchnet
```

## License

MIT
