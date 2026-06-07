import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../data/brand.dart';
import '../data/brands_repository.dart';

final brandsRepositoryProvider = Provider<BrandsRepository>((ref) {
  return BrandsRepository(ref.watch(apiClientProvider));
});

/// Lista de todas las marcas (GET /api/brands).
final brandsListProvider = FutureProvider<List<Brand>>((ref) {
  return ref.watch(brandsRepositoryProvider).fetchAll();
});

/// Detalle de una marca (GET /api/brands/{id}).
final brandDetailProvider =
    FutureProvider.family<Brand, String>((ref, id) {
  return ref.watch(brandsRepositoryProvider).fetchById(id);
});

/// Índice marca por id, para resolver el nombre de la marca de un vehículo
/// sin pedirla de nuevo a la red. Reutiliza [brandsListProvider].
final brandsByIdProvider = FutureProvider<Map<String, Brand>>((ref) async {
  final brands = await ref.watch(brandsListProvider.future);
  return {for (final b in brands) b.id: b};
});
