/// Discount rule model and implementations.
///
/// Provides classes to represent discount rules and logic to parse
/// rule expressions. Each rule can compute the total price for a
/// quantity of items at a given unit price.

/// Base class for all discount rules.
abstract class DiscountRule {
  /// Creates a [DiscountRule].
  const DiscountRule();

  /// Returns the price after applying the discount for [quantity] items
  /// each costing [unitPrice].
  double apply({required int quantity, required double unitPrice});
}

/// Percentage off the total price.
class PercentageOff extends DiscountRule {
  /// Percentage value between 0 and 100.
  final double percent;

  /// Creates a [PercentageOff] rule with [percent].
  const PercentageOff(this.percent);

  @override
  double apply({required int quantity, required double unitPrice}) {
    final total = quantity * unitPrice;
    return total * (1 - percent / 100);
  }
}

/// Fixed price for [x] units (e.g. 3 for \$10).
class XForFixed extends DiscountRule {
  /// Number of units the fixed price applies to.
  final int x;

  /// Fixed total price for [x] units.
  final double price;

  /// Creates an [XForFixed] rule.
  const XForFixed({required this.x, required this.price});

  @override
  double apply({required int quantity, required double unitPrice}) {
    final groups = quantity ~/ x;
    final remainder = quantity % x;
    return groups * price + remainder * unitPrice;
  }
}

/// Buy [x] items and get [y] additional items free.
class BuyXGetYFree extends DiscountRule {
  /// Number of items to buy to trigger the free items.
  final int x;

  /// Number of items given for free when [x] are purchased.
  final int y;

  /// Creates a [BuyXGetYFree] rule.
  const BuyXGetYFree({required this.x, required this.y});

  @override
  double apply({required int quantity, required double unitPrice}) {
    final cycle = x + y;
    final fullCycles = quantity ~/ cycle;
    final remaining = quantity % cycle;
    final paidUnits = fullCycles * x + (remaining > x ? x : remaining);
    return paidUnits * unitPrice;
  }
}


/// Parses a textual representation of a discount rule.
DiscountRule? parseDiscountRule(String text) {
  final normalized = text.toLowerCase().trim();
  if (normalized.endsWith('% off')) {
    final value = normalized.split('%').first.trim();
    final percent = double.tryParse(value);
    if (percent != null) {
      return PercentageOff(percent);
    }
  }
  if (normalized.contains(' for ')) {
    final parts = normalized.split(' for ');
    final x = int.tryParse(parts.first.trim());
    final price = double.tryParse(parts.last.replaceAll('\$', '').trim());
    if (x != null && price != null) {
      return XForFixed(x: x, price: price);
    }
  }
  if (normalized.startsWith('buy') &&
      normalized.contains('get') &&
      normalized.endsWith('free')) {
    final nums = RegExp(r'\d+').allMatches(normalized)
        .map((m) => m.group(0))
        .toList();
    if (nums.length >= 2) {
      final x = int.parse(nums[0]!);
      final y = int.parse(nums[1]!);
      return BuyXGetYFree(x: x, y: y);
    }
  }
  return null;
}
