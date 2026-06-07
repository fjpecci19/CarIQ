import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/vehicle.dart';
import '../data/vehicles_repository.dart';

final vehiclesRepositoryProvider = Provider<VehiclesRepository>((ref) {
  return VehiclesRepository(ref.watch(apiClientProvider));
});

/// Lista de todos los vehículos (GET /api/vehicles).
final vehiclesListProvider = FutureProvider<List<Vehicle>>((ref) {
  return ref.watch(vehiclesRepositoryProvider).fetchAll();
});

/// Detalle de un vehículo (GET /api/vehicles/{id}).
final vehicleDetailProvider =
    FutureProvider.family<Vehicle, String>((ref, id) {
  return ref.watch(vehiclesRepositoryProvider).fetchById(id);
});

/// Vehículos de una marca (filtra la lista completa por brandId).
/// Reutiliza [vehiclesListProvider] para no hacer otra llamada de red.
final vehiclesByBrandProvider =
    FutureProvider.family<List<Vehicle>, String>((ref, brandId) async {
  final all = await ref.watch(vehiclesListProvider.future);
  return all.where((v) => v.brandId == brandId).toList(growable: false);
});

/// Algunos vehículos "destacados" para el Home (los primeros disponibles).
final featuredVehiclesProvider = FutureProvider<List<Vehicle>>((ref) async {
  final all = await ref.watch(vehiclesListProvider.future);
  return all.take(8).toList(growable: false);
});
