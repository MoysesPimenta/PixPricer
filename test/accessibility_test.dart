// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'package:flutter_test/flutter_test.dart';
import 'package:accessibility_test/accessibility_test.dart';
import 'package:pix_pricer/main.dart';

void main() {
  testWidgets('app meets text contrast guidelines', (tester) async {
    await tester.pumpWidget(const PixPricerApp());
    await expectLater(
      tester,
      meetsGuideline(textContrastGuideline),
    );
  });
}
