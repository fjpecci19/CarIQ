import '../../../core/network/json_utils.dart';

/// Marca de vehículos. Modelo tipado e inmutable.
///
/// `fromJson` es robusto: acepta camelCase (como serializa Jackson) y también
/// snake_case por las dudas, y nunca rompe si falta un campo.
class Brand {
  const Brand({
    required this.id,
    required this.name,
    this.country,
    this.foundedYear,
    this.founder,
    this.logoUrl,
    this.history,
    this.vehicleTypes = const [],
    this.active = true,
  });

  final String id;
  final String name;
  final String? country;
  final int? foundedYear;
  final String? founder;
  final String? logoUrl;
  final String? history;
  final List<String> vehicleTypes;
  final bool active;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: asString(pick(json, ['id', '_id'])),
      name: asString(pick(json, ['name']), fallback: 'Sin nombre'),
      country: asStringOrNull(pick(json, ['country'])),
      foundedYear: asIntOrNull(pick(json, ['foundedYear', 'founded_year'])),
      founder: asStringOrNull(pick(json, ['founder'])),
      logoUrl: asStringOrNull(pick(json, ['logoUrl', 'logo_url'])),
      history: asStringOrNull(pick(json, ['history'])),
      vehicleTypes: asStringList(pick(json, ['vehicleTypes', 'vehicle_types'])),
      active: asBool(pick(json, ['active']), fallback: true),
    );
  }
}
