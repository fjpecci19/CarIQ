import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/settings/settings_controllers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/settings_actions.dart';
import '../../brands/presentation/brands_providers.dart';
import 'vehicle_detail_screen.dart';
import 'vehicles_providers.dart';
import 'widgets/vehicle_card.dart';

/// Pantalla "Modelos": lista de todos los vehículos.
class VehiclesScreen extends ConsumerWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehiclesListProvider);
    final strings = ref.watch(stringsProvider);
    // El índice de marcas es opcional: si falla, simplemente no mostramos
    // el nombre de la marca en la card (no rompe la lista de modelos).
    final brandsById = ref.watch(brandsByIdProvider).valueOrNull ?? const {};

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.vehiclesTitle),
        actions: const [SettingsActions()],
      ),
      body: AsyncValueView(
        value: vehicles,
        onRetry: () => ref.invalidate(vehiclesListProvider),
        builder: (list) {
          if (list.isEmpty) {
            return Center(child: Text(strings.vehiclesEmpty));
          }
          return RefreshIndicator(
            onRefresh: () {
              ref.invalidate(brandsListProvider);
              return ref.refresh(vehiclesListProvider.future);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final vehicle = list[index];
                return VehicleCard(
                  vehicle: vehicle,
                  brandName: brandsById[vehicle.brandId]?.name,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          VehicleDetailScreen(vehicleId: vehicle.id),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
