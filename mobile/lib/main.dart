import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/settings/settings_controllers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Cargamos las preferencias (tema/idioma) antes de arrancar para no parpadear.
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: const CarIqApp(),
    ),
  );
}
