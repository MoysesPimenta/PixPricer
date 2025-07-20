#!/usr/bin/env bash
# Lint and format documentation Python sources
set -euo pipefail

# Run docformatter in check mode
if ! docformatter --check docs/conf.py; then
  echo "Run docformatter to format docstrings" >&2
  exit 1
fi

# Run pydocstyle on documentation sources
pydocstyle docs/conf.py
