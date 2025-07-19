import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

/// Simple home page displaying a localized greeting.
class MyHomePage extends StatelessWidget {
  /// Creates a [MyHomePage].
  const MyHomePage({super.key});

  /// Builds the scaffold containing the greeting text.
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: Center(
        child: Semantics(
          label: loc.hello,
          child: Text(loc.hello),
        ),
      ),
    );
  }
}
