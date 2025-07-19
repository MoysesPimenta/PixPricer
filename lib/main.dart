import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'src/presentation/camera_screen.dart';
import 'src/presentation/cart_list_screen.dart';
import 'src/presentation/reconcile_screen.dart';
import 'src/presentation/settings_screen.dart';

void main() {
  runApp(const PixPricerApp());
}

/// Root widget of the PixPricer application.
///
/// Configures localization delegates and sets up the home page.
class PixPricerApp extends StatelessWidget {
  /// Creates a [PixPricerApp].
  const PixPricerApp({super.key});

  /// Builds the [MaterialApp] with localization support.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

/// Home page presenting navigation to core features.
class MyHomePage extends StatelessWidget {
  /// Creates a [MyHomePage].
  const MyHomePage({super.key});

  /// Builds the scaffold containing navigation buttons.
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              button: true,
              label: loc.cameraScreenTitle,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CameraScreen()),
                ),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
                child: Text(loc.cameraScreenTitle),
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              button: true,
              label: loc.cartListTitle,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CartListScreen()),
                ),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
                child: Text(loc.cartListTitle),
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              button: true,
              label: loc.reconcileScreenTitle,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ReconcileScreen()),
                ),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
                child: Text(loc.reconcileScreenTitle),
              ),
            ),
            const SizedBox(height: 16),
            Semantics(
              button: true,
              label: loc.settingsButton,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                ),
                style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
                child: Text(loc.settingsButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
