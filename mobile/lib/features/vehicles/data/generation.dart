import '../../../core/network/json_utils.dart';

/// Una generación de un vehículo (subdocumento embebido y FLEXIBLE).
///
/// `engine`, `consumption` y `body` se conservan como `Map<String, dynamic>`
/// porque su forma varía según el tipo (combustión / eléctrico / moto). La UI
/// muestra solo los campos presentes. No se pierde ni se inventa nada.
class Generation {
  const Generation({
    required this.name,
    this.yearStart,
    this.yearEnd,
    this.transmission,
    this.priceUsd,
    this.engine = const {},
    this.consumption = const {},
    this.body = const {},
    this.images = const [],
  });

  final String name;
  final int? yearStart;
  final int? yearEnd;
  final String? transmission;
  final double? priceUsd;
  final Map<String, dynamic> engine;
  final Map<String, dynamic> consumption;
  final Map<String, dynamic> body;
  final List<String> images;

  factory Generation.fromJson(Map<String, dynamic> json) {
    return Generation(
      name: asString(pick(json, ['name']), fallback: 'Generación'),
      yearStart: asIntOrNull(pick(json, ['yearStart', 'year_start'])),
      yearEnd: asIntOrNull(pick(json, ['yearEnd', 'year_end'])),
      transmission: asStringOrNull(pick(json, ['transmission'])),
      priceUsd: asDoubleOrNull(pick(json, ['priceUsd', 'price_usd'])),
      engine: asMap(pick(json, ['engine'])),
      consumption: asMap(pick(json, ['consumption'])),
      body: asMap(pick(json, ['body'])),
      images: asStringList(pick(json, ['images'])),
    );
  }
}
