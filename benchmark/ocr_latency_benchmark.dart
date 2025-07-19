import 'dart:async';
import 'dart:io';

/// Simulates OCR processing to benchmark latency.
Future<void> main() async {
  final sw = Stopwatch()..start();
  await Future<void>.delayed(const Duration(milliseconds: 50));
  sw.stop();
  final result = 'OCR latency: ${sw.elapsedMilliseconds} ms';
  stdout.writeln(result);
  await File('benchmark/results/ocr_latency.txt').create(recursive: true);
  File('benchmark/results/ocr_latency.txt').writeAsStringSync(result);
}
