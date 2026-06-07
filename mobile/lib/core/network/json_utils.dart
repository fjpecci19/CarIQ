/// Helpers para parsear JSON de forma ROBUSTA.
///
/// El backend (Jackson, sin estrategia de naming) serializa los campos tipados
/// en camelCase (foundedYear, brandId, yearStart, priceUsd...), mientras que los
/// sub-documentos flexibles (engine/consumption/body) conservan las claves tal
/// como están en Mongo (snake_case: battery_kwh, range_km, displacement_cc...).
///
/// Para no acoplarnos a un único estilo, estos helpers aceptan VARIAS claves
/// candidatas y nunca rompen si un campo falta o viene con otro tipo.
library;

/// Devuelve el primer valor no nulo entre [keys] del mapa [json].
Object? pick(Map<String, dynamic> json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value != null) return value;
  }
  return null;
}

String? asStringOrNull(Object? value) {
  if (value == null) return null;
  final str = value.toString().trim();
  return str.isEmpty ? null : str;
}

String asString(Object? value, {String fallback = ''}) =>
    asStringOrNull(value) ?? fallback;

int? asIntOrNull(Object? value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString());
}

double? asDoubleOrNull(Object? value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is num) return value.toDouble();
  return double.tryParse(value.toString());
}

bool asBool(Object? value, {bool fallback = false}) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  final str = value?.toString().toLowerCase();
  if (str == 'true') return true;
  if (str == 'false') return false;
  return fallback;
}

/// Convierte cualquier lista JSON en `List<String>` (descarta nulos/vacíos).
List<String> asStringList(Object? value) {
  if (value is! List) return const [];
  return value
      .map(asStringOrNull)
      .whereType<String>()
      .toList(growable: false);
}

/// Convierte un valor en `Map<String, dynamic>` seguro (vacío si no aplica).
Map<String, dynamic> asMap(Object? value) {
  if (value is Map) {
    return value.map((key, val) => MapEntry(key.toString(), val));
  }
  return const {};
}

/// Convierte una lista de objetos JSON en `List<Map<String, dynamic>>`.
List<Map<String, dynamic>> asMapList(Object? value) {
  if (value is! List) return const [];
  return value.whereType<Map>().map(asMap).toList(growable: false);
}

/// Convierte una clave snake_case / camelCase en un label legible.
/// p.ej. "battery_kwh" -> "Battery kwh", "rangeKm" -> "Range km".
String humanizeKey(String key) {
  final spaced = key
      .replaceAll('_', ' ')
      .replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
          (m) => '${m[1]} ${m[2]}')
      .trim();
  if (spaced.isEmpty) return key;
  return spaced[0].toUpperCase() + spaced.substring(1);
}

/// Formatea un valor de un Map flexible para mostrarlo (listas -> "a, b, c").
/// Los booleanos los traduce el llamador (SpecTable) según el idioma.
String humanizeValue(Object? value) {
  if (value is List) {
    return value.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).join(', ');
  }
  return value?.toString() ?? '';
}
