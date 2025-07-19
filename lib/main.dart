import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const PixPricerApp());
}

class PixPricerApp extends StatelessWidget {
  const PixPricerApp({super.key});

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('PixPricer')),
      body: Center(
        child: Semantics(
          label: loc.text('hello'),
          child: Text(loc.text('hello')),
        ),
      ),
    );
  }
}
