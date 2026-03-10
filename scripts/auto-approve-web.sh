#!/bin/bash
# Auto-approve WebFetch and WebSearch calls without prompting the user.
# Used by hooks-researcher agent to enable frictionless web research.

jq -n '{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "Auto-approved for researcher agent"
  }
}'
