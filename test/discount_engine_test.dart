import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/discount_engine.dart';

void main() {
  test('applyDiscount calculates 20% off', () {
    expect(applyDiscount(100, 0.2), equals(80));
  });

  test('PercentageOff computes discounted total', () {
    final rule = PercentageOff(10);
    expect(rule.apply(quantity: 2, unitPrice: 50), closeTo(90, 0.001));
  });

  test('XForFixed handles remainder units', () {
    final rule = XForFixed(x: 3, price: 10);
    expect(rule.apply(quantity: 7, unitPrice: 4), closeTo(26, 0.001));
  });

  test('BuyXGetYFree calculates paid units', () {
    final rule = BuyXGetYFree(x: 2, y: 1);
    expect(rule.apply(quantity: 5, unitPrice: 5), closeTo(20, 0.001));
  });

  group('parseDiscountRule', () {
    test('parses percentage off', () {
      final rule = parseDiscountRule('20% off');
      expect(rule, isA<PercentageOff>());
      expect((rule as PercentageOff).percent, 20);
    });

    test('parses x for fixed price', () {
      final rule = parseDiscountRule('3 for \$10');
      expect(rule, isA<XForFixed>());
      final r = rule as XForFixed;
      expect(r.x, 3);
      expect(r.price, 10);
    });

    test('parses buy x get y free', () {
      final rule = parseDiscountRule('buy 2 get 1 free');
      expect(rule, isA<BuyXGetYFree>());
      final r = rule as BuyXGetYFree;
      expect(r.x, 2);
      expect(r.y, 1);
    });
  });
}
