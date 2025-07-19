// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/localization_helpers.dart';

void main() {
  test('greetingForLocale returns Spanish greeting', () {
    expect(greetingForLocale(const Locale('es')), 'Hola');
  });

  test('supportedLocales contains English', () {
    expect(supportedLocales().any((l) => l.languageCode == 'en'), isTrue);
  });
}
