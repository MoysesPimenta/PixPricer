// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/discount_engine.dart';

void main() {
  group('applyDiscount', () {
    test('returns original price when rate is 0', () {
      expect(applyDiscount(50, 0), equals(50));
    });

    test('returns zero when rate is 1', () {
      expect(applyDiscount(50, 1), equals(0));
    });

    test('calculates correct value for fractional rates', () {
      expect(applyDiscount(120, 0.25), equals(90));
    });
  });
}
