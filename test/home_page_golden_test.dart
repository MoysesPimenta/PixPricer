// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pix_pricer/main.dart';

void main() {
  testWidgets('Home page English golden', (tester) async {
    await tester.pumpWidget(const PixPricerApp());
    await expectLater(
      find.byType(PixPricerApp),
      matchesGoldenFile('goldens/home_en.png'),
    );
  });

  testWidgets('Home page Spanish golden', (tester) async {
    await tester.binding.setLocale('es', 'ES');
    await tester.pumpWidget(const PixPricerApp());
    await tester.pump();
    await expectLater(
      find.byType(PixPricerApp),
      matchesGoldenFile('goldens/home_es.png'),
    );
  });
}
