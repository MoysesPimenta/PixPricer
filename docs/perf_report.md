<!-- Copyright (c) 2025 Shopping Bill App Project -->
<!-- SPDX-License-Identifier: MIT -->
# Performance Benchmark Report

The nightly benchmark workflow executes micro benchmarks located in the
`benchmark/` directory. Results are uploaded as workflow artifacts.

| Metric | Latest Result |
| ------ | ------------- |
| OCR latency | Collected from `ocr_latency_benchmark.dart` |
| CPU workload time | Collected from `cpu_usage_benchmark.dart` |
| Battery impact | Collected from `battery_impact_benchmark.dart` |

Benchmarks are run using `dart benchmark/run_benchmarks.dart` on a GitHub
Actions macOS runner.
