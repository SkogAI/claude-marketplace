#!/usr/bin/env bash
# Print hello world message with session ID on session start
set -euo pipefail

# Get session ID from environment variable provided by Claude
session_id="${CLAUDE_SESSION_ID:-unknown}"

# Print hello world message with session ID
echo "hello world <$session_id>"
