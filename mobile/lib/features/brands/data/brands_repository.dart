import '../../../core/network/api_client.dart';
import 'brand.dart';

/// Acceso a datos de marcas. Encapsula los endpoints y el mapeo a modelos.
/// (Solo lectura.)
class BrandsRepository {
  BrandsRepository(this._api);

  final ApiClient _api;

  /// GET /api/brands
  Future<List<Brand>> fetchAll() async {
    final list = await _api.getList('/brands');
    return list.map(Brand.fromJson).toList(growable: false);
  }

  /// GET /api/brands/{id}
  Future<Brand> fetchById(String id) async {
    final json = await _api.getObject('/brands/$id');
    return Brand.fromJson(json);
  }
}
