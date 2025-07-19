// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pix_pricer/main.dart';

void main() {
  testWidgets('home shows navigation buttons', (tester) async {
    await tester.pumpWidget(const PixPricerApp());
    expect(find.text('Camera'), findsOneWidget);
    expect(find.bySemanticsLabel('Camera'), findsOneWidget);
  });

  testWidgets('Spanish locale displays translated button', (tester) async {
    await tester.binding.setLocale('es', 'ES');
    await tester.pumpWidget(const PixPricerApp());
    await tester.pump();
    expect(find.text('Cámara'), findsOneWidget);
  });
}
