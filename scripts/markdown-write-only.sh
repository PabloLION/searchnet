#!/bin/bash
# Restrict Write tool to .md files only.
# Denies any Write call where the file_path does not end in .md.
# Used by hooks-researcher agent for safe file output.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ "$FILE_PATH" == *.md ]]; then
  # Allow markdown writes
  exit 0
fi

# Deny non-markdown writes
jq -n '{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": "Write restricted to .md files only"
  }
}'
