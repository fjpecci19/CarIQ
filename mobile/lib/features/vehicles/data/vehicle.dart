import '../../../core/network/json_utils.dart';
import 'generation.dart';

/// Tipo de vehículo. `unknown` cubre valores inesperados sin romper.
/// El label legible se resuelve según el idioma (ver extensión VehicleTypeLabel).
enum VehicleType {
  car('car'),
  motorcycle('motorcycle'),
  truck('truck'),
  unknown('unknown');

  const VehicleType(this.raw);

  final String raw;

  static VehicleType fromRaw(String? value) {
    return VehicleType.values.firstWhere(
      (t) => t.raw == value,
      orElse: () => VehicleType.unknown,
    );
  }
}

/// Vehículo del catálogo. Modelo tipado e inmutable.
class Vehicle {
  const Vehicle({
    required this.id,
    required this.brandId,
    required this.type,
    required this.model,
    this.category,
    this.tags = const [],
    this.history,
    this.generations = const [],
  });

  final String id;
  final String brandId;
  final VehicleType type;
  final String model;
  final String? category;
  final List<String> tags;
  final String? history;
  final List<Generation> generations;

  /// Imagen representativa: primera imagen de la primera generación que tenga.
  String? get coverImage {
    for (final gen in generations) {
      if (gen.images.isNotEmpty) return gen.images.first;
    }
    return null;
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: asString(pick(json, ['id', '_id'])),
      brandId: asString(pick(json, ['brandId', 'brand_id'])),
      type: VehicleType.fromRaw(asStringOrNull(pick(json, ['type']))),
      model: asString(pick(json, ['model']), fallback: 'Modelo'),
      category: asStringOrNull(pick(json, ['category'])),
      tags: asStringList(pick(json, ['tags'])),
      history: asStringOrNull(pick(json, ['history'])),
      generations: asMapList(pick(json, ['generations']))
          .map(Generation.fromJson)
          .toList(growable: false),
    );
  }
}
