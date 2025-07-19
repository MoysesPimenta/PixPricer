import 'package:accessibility_test/accessibility_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app meets accessibility guidelines', (tester) async {
    final results = await AccessibilityTester.run(tester);
    expect(results.passed, isTrue, reason: results.summary);
  });
}
