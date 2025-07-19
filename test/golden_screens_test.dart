import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/main.dart';

void main() {
  testWidgets('home screen light/dark golden', (tester) async {
    final lightPng = File('test/goldens/home_light.base64');
    final darkPng = File('test/goldens/home_dark.base64');
    final lightPath = 'test/goldens/home_light.png';
    final darkPath = 'test/goldens/home_dark.png';
    File(lightPath).writeAsBytesSync(
      base64Decode(lightPng.readAsStringSync()),
    );
    File(darkPath).writeAsBytesSync(
      base64Decode(darkPng.readAsStringSync()),
    );

    await tester.pumpWidget(const PixPricerApp());
    await expectLater(
      find.byType(PixPricerApp),
      matchesGoldenFile(lightPath),
    );
    await tester.binding.setSurfaceSize(const Size(800, 600));
    tester.binding.window.platformBrightnessTestValue = Brightness.dark;
    await tester.pumpWidget(const PixPricerApp());
    await expectLater(
      find.byType(PixPricerApp),
      matchesGoldenFile(darkPath),
    );

    // Clean up generated PNGs to keep repository binary-free.
    File(lightPath).deleteSync();
    File(darkPath).deleteSync();
  });
}
