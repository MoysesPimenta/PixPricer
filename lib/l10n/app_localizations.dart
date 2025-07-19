import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Simple localization loader for the app.
class AppLocalizations {
  /// Creates an instance for the given [locale].
  AppLocalizations(this.locale);

  /// The locale for which the translations are loaded.
  final Locale locale;
  late Map<String, String> _sentences;

  /// Supported locales for the application.
  static const supportedLocales = [
    Locale('en'),
    Locale('pt', 'BR'),
    Locale('es', 'ES'),
  ];

  /// Delegate to integrate with [MaterialApp].
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Retrieve the current [AppLocalizations] from the context.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Loads the locale-specific JSON from assets.
  Future<bool> load() async {
    final name = locale.countryCode?.isEmpty ?? true
        ? locale.languageCode
        : '${locale.languageCode}_${locale.countryCode}';
    final data = await rootBundle.loadString('assets/translations/$name.arb');
    final Map<String, dynamic> map = jsonDecode(data);
    _sentences = map.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  /// Returns the localized string for [key].
  String text(String key) => _sentences[key] ?? key;

  /// All localized getters.
  String get hello => text('hello');
  String get cameraTitle => text('camera_title');
  String get cartTitle => text('cart_title');
  String get reconcileTitle => text('reconcile_title');
  String get scanButton => text('scan_button');
  String get addItemButton => text('add_item_button');
  String get checkoutButton => text('checkout_button');
  String get settingsTitle => text('settings_title');
  String get languageLabel => text('language_label');
  String get confirm => text('confirm');
  String get cancel => text('cancel');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.contains(
      Locale(locale.languageCode, locale.countryCode),
    );
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
