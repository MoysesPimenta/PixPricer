// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
/// Discount rule abstractions and helpers.
///
/// Provides a base [DiscountRule] interface and a simple
/// [BuyXGetY] implementation used for unit testing.
abstract class DiscountRule {
  /// Applies the discount to the given [quantity] and [unitPrice].
  num apply({required int quantity, required num unitPrice});
}

/// A "buy X get Y free" style discount.
class BuyXGetY implements DiscountRule {
  /// Quantity that must be purchased before getting the free units.
  final int buy;

  /// Quantity awarded for free per group of [buy] items.
  final int free;

  /// Creates a [BuyXGetY] rule.
  const BuyXGetY({required this.buy, required this.free});

  @override
  num apply({required int quantity, required num unitPrice}) {
    final groupSize = buy + free;
    final groups = quantity ~/ groupSize;
    final remaining = quantity % groupSize;
    final payable = groups * buy + (remaining > buy ? buy : remaining);
    return unitPrice * payable;
  }
}
