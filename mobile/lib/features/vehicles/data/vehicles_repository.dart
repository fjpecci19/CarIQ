import '../../../core/network/api_client.dart';
import 'vehicle.dart';

/// Acceso a datos de vehículos. (Solo lectura.)
class VehiclesRepository {
  VehiclesRepository(this._api);

  final ApiClient _api;

  /// GET /api/vehicles
  Future<List<Vehicle>> fetchAll() async {
    final list = await _api.getList('/vehicles');
    return list.map(Vehicle.fromJson).toList(growable: false);
  }

  /// GET /api/vehicles/{id}
  Future<Vehicle> fetchById(String id) async {
    final json = await _api.getObject('/vehicles/$id');
    return Vehicle.fromJson(json);
  }
}
