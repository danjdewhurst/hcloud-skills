#!/bin/bash

# hcloud safety hook - warns Claude about destructive hcloud operations
# This is a PreToolUse hook for Bash commands

# Read the tool input from stdin
INPUT=$(cat)

# Extract the command being run
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# If no command or not an hcloud command, allow silently
if [ -z "$COMMAND" ] || ! echo "$COMMAND" | grep -q "hcloud"; then
  exit 0
fi

# Check for destructive operations
DESTRUCTIVE_PATTERNS=(
  "hcloud.*delete"
  "hcloud.*disable-protection"
  "hcloud.*poweroff"
  "hcloud.*shutdown"
  "hcloud.*reset[^-]"
  "hcloud.*remove-from"
  "hcloud.*remove-subnet"
  "hcloud.*remove-route"
  "hcloud.*remove-target"
  "hcloud.*delete-rule"
  "hcloud.*delete-service"
  "hcloud.*replace-rules"
  "hcloud.*remove-from-resource"
  "hcloud.*disable-backup"
  "hcloud.*disable-public-interface"
  "hcloud.*rollback-snapshot"
)

for PATTERN in "${DESTRUCTIVE_PATTERNS[@]}"; do
  if echo "$COMMAND" | grep -qE "$PATTERN"; then
    # Extract the specific destructive action for the warning
    ACTION=$(echo "$COMMAND" | grep -oE "(delete|disable-protection|poweroff|shutdown|reset|remove-from|remove-subnet|remove-route|remove-target|delete-rule|delete-service|replace-rules|remove-from-resource|disable-backup|disable-public-interface|rollback-snapshot)" | head -1)

    echo "WARN: This hcloud command performs a destructive operation ($ACTION). Ensure the user is aware this will modify or remove cloud resources."
    exit 0
  fi
done

# Non-destructive hcloud command, allow silently
exit 0
