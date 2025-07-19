import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accessibility_test/accessibility_test.dart';

void main() {
  testWidgets('primary blue on white meets contrast', (tester) async {
    const widget = MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Text(
          'Sample',
          style: TextStyle(color: Color(0xFF005A9C)),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await expectLater(tester, meetsGuideline(textContrastGuideline));
  });

  testWidgets('accent yellow on black meets contrast', (tester) async {
    const widget = MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Text(
          'Sample',
          style: TextStyle(color: Color(0xFFFFC20E)),
        ),
      ),
    );
    await tester.pumpWidget(widget);
    await expectLater(tester, meetsGuideline(textContrastGuideline));
  });
}
