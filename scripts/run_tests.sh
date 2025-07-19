#!/usr/bin/env bash
# Run Flutter tests with coverage and ensure minimum threshold.
set -euo pipefail

THRESHOLD=0.9
CMD="flutter"
if command -v fvm >/dev/null 2>&1; then
  CMD="fvm flutter"
fi

$CMD test --coverage

if command -v lcov >/dev/null 2>&1; then
  COVERAGE=$(lcov --summary coverage/lcov.info | awk '/lines/ {print $2}' | sed 's/%//')
  if (( $(echo "$COVERAGE < 90" | bc -l) )); then
    echo "Coverage ${COVERAGE}% is below threshold" >&2
    exit 1
  fi
else
  echo "lcov not installed; skipping threshold check" >&2
fi
