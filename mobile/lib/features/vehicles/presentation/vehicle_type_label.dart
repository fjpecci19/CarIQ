import '../../../core/i18n/app_strings.dart';
import '../data/vehicle.dart';

/// Resuelve el label legible de un [VehicleType] según el idioma activo.
extension VehicleTypeLabel on VehicleType {
  String label(AppStrings s) => switch (this) {
        VehicleType.car => s.typeCar,
        VehicleType.motorcycle => s.typeMotorcycle,
        VehicleType.truck => s.typeTruck,
        VehicleType.unknown => s.typeUnknown,
      };
}
