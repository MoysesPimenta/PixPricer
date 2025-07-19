// Copyright (c) 2025 Shopping Bill App Project
// SPDX-License-Identifier: MIT
/// Localization utilities used across the app.
///
/// Contains simple helpers to retrieve localized strings without a
/// [BuildContext] instance.
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Returns the greeting string for the provided [locale].
String greetingForLocale(Locale locale) {
  return switch (locale.languageCode) {
    'es' => 'Hola',
    'pt' => 'Olá',
    _ => 'Hello',
  };
}

/// List of locales supported by the application.
List<Locale> supportedLocales() => AppLocalizations.supportedLocales;
