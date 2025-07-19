#!/usr/bin/env bash
# Run Flutter benchmarks and fail on regressions
set -euo pipefail

if [ ! -d benchmark ]; then
  echo "No benchmark directory found. Skipping benchmarks." >&2
  exit 0
fi

# Run benchmark tests
flutter test benchmark > benchmark/current.txt

# Compare with baseline if available
if [ -f benchmark/baseline.txt ]; then
  if ! diff -u benchmark/baseline.txt benchmark/current.txt >/dev/null; then
    echo "Benchmark regression detected" >&2
    exit 1
  fi
fi
