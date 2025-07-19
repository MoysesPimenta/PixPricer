import 'package:flutter_test/flutter_test.dart';
import 'package:pix_pricer/discount_rules.dart';

void main() {
  group('BuyXGetY', () {
    test('charges for two of three with buy2get1 rule', () {
      final rule = BuyXGetY(buy: 2, free: 1);
      expect(rule.apply(quantity: 3, unitPrice: 10), 20);
    });

    test('handles partial groups correctly', () {
      final rule = BuyXGetY(buy: 2, free: 1);
      // 4 items should charge for 3
      expect(rule.apply(quantity: 4, unitPrice: 5), 15);
    });
  });
}
