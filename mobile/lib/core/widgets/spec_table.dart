import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/app_strings.dart';
import '../network/json_utils.dart';
import '../settings/settings_controllers.dart';

/// Renderiza un `Map<String, dynamic>` flexible (engine / consumption / body)
/// como una tabla clave→valor, mostrando SOLO los campos presentes.
///
/// - Ignora valores nulos o vacíos (no muestra "null").
/// - Humaniza las claves (battery_kwh -> "Battery kwh").
/// - Aplana sub-mapas con un pequeño prefijo.
/// - Traduce los booleanos (Sí/No) según el idioma activo.
class SpecTable extends ConsumerWidget {
  const SpecTable({super.key, required this.data});

  final Map<String, dynamic> data;

  /// Aplana el mapa en filas (clave legible, valor formateado), saltando vacíos.
  List<MapEntry<String, String>> _rows(AppStrings strings) {
    final rows = <MapEntry<String, String>>[];
    void walk(Map<String, dynamic> map, String prefix) {
      map.forEach((key, value) {
        if (value == null) return;
        final label = prefix.isEmpty
            ? humanizeKey(key)
            : '$prefix · ${humanizeKey(key)}';
        if (value is Map) {
          walk(asMap(value), label);
        } else {
          final text = value is bool
              ? (value ? strings.commonYes : strings.commonNo)
              : humanizeValue(value);
          if (text.isNotEmpty) rows.add(MapEntry(label, text));
        }
      });
    }

    walk(data, '');
    return rows;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rows = _rows(ref.watch(stringsProvider));
    if (rows.isEmpty) return const SizedBox.shrink();

    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    row.key,
                    style: textTheme.bodyMedium
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    row.value,
                    style: textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
