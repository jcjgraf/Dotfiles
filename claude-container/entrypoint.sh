#!/usr/bin/env bash
set -euo pipefail

exec claude --dangerously-skip-permissions "$@"
