import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pix_pricer/main.dart';

void main() {
  testWidgets('App displays hello text', (tester) async {
    await tester.pumpWidget(const PixPricerApp());
    expect(find.text('Hello'), findsOneWidget);
    expect(find.bySemanticsLabel('Hello'), findsOneWidget);
  });

  testWidgets('App displays hola text for Spanish locale', (tester) async {
    await tester.binding.setLocale('es', 'ES');
    await tester.pumpWidget(const PixPricerApp());
    await tester.pump();
    expect(find.text('Hola'), findsOneWidget);
    expect(find.bySemanticsLabel('Hola'), findsOneWidget);
  });
}
