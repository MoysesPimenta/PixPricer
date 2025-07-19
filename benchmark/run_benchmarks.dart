import 'dart:io';

/// Runs all benchmark scenarios sequentially.
Future<void> main() async {
  await Process.run('dart', ['benchmark/ocr_latency_benchmark.dart']);
  await Process.run('dart', ['benchmark/cpu_usage_benchmark.dart']);
  await Process.run('dart', ['benchmark/battery_impact_benchmark.dart']);
}
