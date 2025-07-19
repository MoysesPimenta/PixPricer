import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

/// Displays the list of items in the cart and allows export.
class CartListScreen extends ConsumerWidget {
  /// Creates a [CartListScreen].
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(cartProvider);
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.cartListTitle)),
      body: items.isEmpty
          ? Center(child: Text(loc.cartEmptyMessage))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.name),
                  trailing: Text(item.price.toStringAsFixed(2)),
                );
              },
            ),
    );
  }
}
