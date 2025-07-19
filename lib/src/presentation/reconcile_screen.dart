import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Screen to reconcile scanned items with a receipt.
class ReconcileScreen extends StatelessWidget {
  /// Creates a [ReconcileScreen].
  const ReconcileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.reconcileScreenTitle)),
      body: Center(
        child: Semantics(
          button: true,
          label: loc.reconcileButton,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
            child: Text(loc.reconcileButton),
          ),
        ),
      ),
    );
  }
}
