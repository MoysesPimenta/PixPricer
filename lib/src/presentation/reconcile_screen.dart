import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

/// Screen to reconcile scanned items with a receipt.
class ReconcileScreen extends ConsumerWidget {
  /// Creates a [ReconcileScreen].
  const ReconcileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    final items = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(title: Text(loc.reconcileScreenTitle)),
      body: items.isEmpty
          ? Center(child: Text(loc.cartEmptyMessage))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  key: Key('diff_row_$index'),
                  title: Text(item.name),
                  trailing: Text(item.price.toStringAsFixed(2)),
                );
              },
            ),
    );
  }
}
