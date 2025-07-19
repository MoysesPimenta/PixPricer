import 'dart:io';
import 'dart:math';

/// Measures approximate CPU workload by performing heavy computations.
void main() {
  final sw = Stopwatch()..start();
  var sum = 0.0;
  for (var i = 0; i < 1000000; i++) {
    sum += sqrt(i);
  }
  sw.stop();
  final cpuTime = sw.elapsedMilliseconds;
  final result = 'CPU workload time: \$cpuTime ms';
  stdout.writeln(result);
  File('benchmark/results/cpu_usage.txt')
    ..createSync(recursive: true)
    ..writeAsStringSync(result);
}
