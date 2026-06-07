import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/app_strings.dart';
import '../settings/settings_controllers.dart';

/// Botones de tema (claro/oscuro) e idioma (es/en), pensados para usar como
/// `actions` de un AppBar. Replican el ThemeToggle + LanguageSelector del
/// frontend web.
class SettingsActions extends ConsumerWidget {
  const SettingsActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final lang = ref.watch(localeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Toggle de tema
        IconButton(
          tooltip: isDark ? 'Modo claro' : 'Modo oscuro',
          icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
          onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
        ),
        // Selector de idioma (muestra el idioma al que cambiaría)
        TextButton(
          onPressed: () => ref.read(localeProvider.notifier).toggle(),
          child: Text(
            lang == AppLang.es ? 'EN' : 'ES',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
