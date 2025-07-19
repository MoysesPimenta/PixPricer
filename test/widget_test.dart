import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pix_pricer/main.dart';

void main() {
  testWidgets('App displays greeting with semantics label', (tester) async {
    await tester.pumpWidget(const PixPricerApp());
    expect(find.bySemanticsLabel('Greeting'), findsOneWidget);
  });
}
