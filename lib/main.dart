import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const PixPricerApp());
}

/// The root widget of the PixPricer application.
///
/// Sets up localization and provides the [MyHomePage] as the home widget.
class PixPricerApp extends StatelessWidget {
  /// Creates a [PixPricerApp].
  const PixPricerApp({super.key});

  /// Builds the application [MaterialApp] widget.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PixPricer',
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

/// Displays the initial greeting screen of the app.
class MyHomePage extends StatelessWidget {
  /// Creates a [MyHomePage] widget.
  const MyHomePage({super.key});

  /// Builds the home page containing a greeting message.
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('PixPricer')),
      body: Center(
        child: Semantics(
          label: 'Greeting',
          child: Text(loc.text('hello')),
        ),
      ),
    );
  }
}
