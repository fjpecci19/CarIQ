import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/settings/settings_controllers.dart';
import 'core/theme/app_theme.dart';
import 'features/shell/main_shell.dart';

/// Widget raíz de la app CarIQ.
class CarIqApp extends ConsumerWidget {
  const CarIqApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'CarIQ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      home: const MainShell(),
    );
  }
}
