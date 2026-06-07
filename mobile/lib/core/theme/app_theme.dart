import 'package:flutter/material.dart';

/// Tema Material 3 de CarIQ, alineado con el frontend web:
///   • Claro  -> fondo blanco, acento verde esmeralda (con detalle rojo italiano).
///   • Oscuro -> fondo azul medianoche, acento celeste/azul.
class AppTheme {
  AppTheme._();

  // Acentos tomados del frontend (Tailwind).
  static const Color _emerald = Color(0xFF059669); // emerald-600 (verde)
  static const Color _emeraldDark = Color(0xFF047857); // emerald-700
  static const Color _italianRed = Color(0xFFDC2626); // red-600 (rojo detalle)
  static const Color _sky = Color(0xFF0EA5E9); // sky-500 (oscuro)

  // Neutros del modo claro (grises Tailwind) para que el blanco sea blanco y no
  // quede teñido de verde por el seed.
  static const Color _gray900 = Color(0xFF111827); // texto
  static const Color _gray600 = Color(0xFF4B5563); // texto atenuado
  static const Color _gray200 = Color(0xFFE5E7EB); // bordes

  // Superficies del modo oscuro (azul medianoche del frontend).
  static const Color _midnight = Color(0xFF05070D);
  static const Color _midnightSurface = Color(0xFF070B1A);

  static ThemeData light() {
    final base = ColorScheme.fromSeed(
      seedColor: _emerald,
      brightness: Brightness.light,
    );
    // Blanco neutro + verde de primario + rojo en secundario/terciario, para que
    // los detalles (botones, chips, píldoras de año) muestren verde y rojo.
    final scheme = base.copyWith(
      surface: Colors.white,
      onSurface: _gray900,
      onSurfaceVariant: _gray600,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF9FAFB), // gray-50
      surfaceContainer: const Color(0xFFF3F4F6), // gray-100
      surfaceContainerHigh: const Color(0xFFECEEF1),
      surfaceContainerHighest: const Color(0xFFE5E7EB), // gray-200
      outlineVariant: _gray200,
      primary: _emerald,
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFD1FAE5), // emerald-100
      onPrimaryContainer: _emeraldDark,
      secondary: _italianRed,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFFEE2E2), // red-100
      onSecondaryContainer: const Color(0xFF991B1B), // red-800
      tertiary: _italianRed,
      onTertiary: Colors.white,
    );
    return _build(scheme, scaffold: Colors.white);
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: _sky,
      brightness: Brightness.dark,
    ).copyWith(
      surface: _midnightSurface,
      // Acento secundario azul (frontend oscuro: barra celeste -> azul).
      secondary: const Color(0xFF2563EB), // blue-600
    );
    return _build(scheme, scaffold: _midnight);
  }

  static ThemeData _build(ColorScheme scheme, {required Color scaffold}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide(color: scheme.outlineVariant),
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
