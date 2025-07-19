import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Representation of an item in the cart.
class CartItem {
  /// Creates a [CartItem] with a [name] and [price].
  CartItem({required this.name, required this.price});

  /// Item name.
  final String name;

  /// Item price.
  final double price;
}

/// State notifier managing the list of [CartItem]s in the cart.
class CartNotifier extends StateNotifier<List<CartItem>> {
  /// Creates a [CartNotifier] with an optional initial list.
  CartNotifier([List<CartItem>? initial]) : super(initial ?? <CartItem>[]);

  /// Adds an [item] to the cart.
  void addItem(CartItem item) {
    state = [...state, item];
  }

  /// Clears all items from the cart.
  void clear() {
    state = <CartItem>[];
  }
}

/// Provider for the cart state.
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
