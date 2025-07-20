// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pix_pricer/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const cameraChannel = MethodChannel('plugins.flutter.io/camera');

  setUpAll(() {
    cameraChannel.setMockMethodCallHandler((methodCall) async {
      // Provide fake image path when camera takes a picture.
      if (methodCall.method == 'takePicture') {
        return 'assets/test/price_tag.jpg';
      }
      return null;
    });
  });

  tearDownAll(() {
    cameraChannel.setMockMethodCallHandler(null);
  });

  testWidgets('camera → cart → reconciliation flow', (tester) async {
    await tester.pumpWidget(const PixPricerApp());

    // Navigate to the camera screen and capture a picture.
    await tester.tap(find.text('Camera'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Scan Price Tag'));
    await tester.pumpAndSettle();

    // Return to the home screen.
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verify item appears in the cart with correct price.
    await tester.tap(find.text('Cart'));
    await tester.pumpAndSettle();
    expect(find.text('Scanned Item'), findsOneWidget);
    expect(find.text('1.23'), findsOneWidget);

    // Navigate to the reconciliation screen and verify diff rows.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reconcile'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('diff_row_0')), findsOneWidget);
  });
}
