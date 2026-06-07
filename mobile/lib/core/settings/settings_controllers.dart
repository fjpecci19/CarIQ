import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../i18n/app_strings.dart';

/// Provider de SharedPreferences. Se sobreescribe en main() con la instancia ya
/// inicializada (ver [main]). Por eso acá lanza si no fue overrideado.
final sharedPrefsProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('sharedPrefsProvider debe ser overrideado'),
);

const _themeKey = 'cariq-theme'; // mismas claves que el frontend web
const _langKey = 'cariq-lang';

/// Controla el modo de tema (claro/oscuro), persistido. Default: oscuro (como
/// el frontend).
class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final saved = ref.watch(sharedPrefsProvider).getString(_themeKey);
    return saved == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  void toggle() {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    state = next;
    ref
        .read(sharedPrefsProvider)
        .setString(_themeKey, next == ThemeMode.dark ? 'dark' : 'light');
  }
}

final themeModeProvider =
    NotifierProvider<ThemeController, ThemeMode>(ThemeController.new);

/// Controla el idioma activo, persistido. Default: español.
class LocaleController extends Notifier<AppLang> {
  @override
  AppLang build() {
    return AppLang.fromCode(ref.watch(sharedPrefsProvider).getString(_langKey));
  }

  void toggle() {
    final next = state == AppLang.es ? AppLang.en : AppLang.es;
    state = next;
    ref.read(sharedPrefsProvider).setString(_langKey, next.code);
  }

  void set(AppLang lang) {
    state = lang;
    ref.read(sharedPrefsProvider).setString(_langKey, lang.code);
  }
}

final localeProvider =
    NotifierProvider<LocaleController, AppLang>(LocaleController.new);

/// Textos del idioma activo. Usar como `ref.watch(stringsProvider).brandsTitle`.
final stringsProvider = Provider<AppStrings>((ref) {
  return appStringsByLang[ref.watch(localeProvider)]!;
});
