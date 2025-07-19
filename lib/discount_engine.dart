// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
/// Discount engine utilities.
///
/// Provides helpers to apply discounts to prices.
num applyDiscount(num price, num discountRate) {
  return price * (1 - discountRate);
}
