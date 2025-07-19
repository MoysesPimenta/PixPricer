import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/discount_engine.dart';

void main() {
  test('applyDiscount calculates 20% off', () {
    expect(applyDiscount(100, 0.2), equals(80));
  });
}
