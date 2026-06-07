import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/settings/settings_controllers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/settings_actions.dart';
import '../../brands/presentation/brands_providers.dart';
import '../../shell/main_shell.dart';
import '../../vehicles/presentation/vehicle_detail_screen.dart';
import '../../vehicles/presentation/vehicles_providers.dart';
import '../../vehicles/presentation/widgets/vehicle_card.dart';

/// Pantalla "Home": bienvenida + accesos rápidos + vehículos destacados.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            ref.invalidate(brandsListProvider);
            return ref.refresh(vehiclesListProvider.future);
          },
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              // Toggles de tema e idioma (el Home no tiene AppBar).
              const Align(
                alignment: Alignment.centerRight,
                child: SettingsActions(),
              ),
              const SizedBox(height: 8),
              const _Hero(),
              const SizedBox(height: 20),
              const _QuickAccess(),
              const SizedBox(height: 24),
              Text(strings.homeFeatured,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              const _FeaturedRow(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Hero extends ConsumerWidget {
  const _Hero();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final strings = ref.watch(stringsProvider);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // Verde -> rojo en claro (como la barrita de acento del frontend);
        // celeste -> azul en oscuro. Texto blanco legible sobre ambos extremos.
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, scheme.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.directions_car_filled, color: Colors.white, size: 36),
          const SizedBox(height: 12),
          const Text('CarIQ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            strings.homeHeroSubtitle,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _QuickAccess extends ConsumerWidget {
  const _QuickAccess();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return Row(
      children: [
        Expanded(
          child: _QuickCard(
            icon: Icons.business_outlined,
            label: strings.navBrands,
            onTap: () =>
                ref.read(selectedTabProvider.notifier).state = AppTab.brands,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickCard(
            icon: Icons.directions_car_outlined,
            label: strings.navModels,
            onTap: () =>
                ref.read(selectedTabProvider.notifier).state = AppTab.vehicles,
          ),
        ),
      ],
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard(
      {required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, size: 32, color: scheme.primary),
              const SizedBox(height: 8),
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedRow extends ConsumerWidget {
  const _FeaturedRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = ref.watch(featuredVehiclesProvider);
    final brandsById = ref.watch(brandsByIdProvider).valueOrNull ?? const {};
    final strings = ref.watch(stringsProvider);

    return SizedBox(
      height: 200,
      child: AsyncValueView(
        value: featured,
        onRetry: () => ref.invalidate(vehiclesListProvider),
        builder: (list) {
          if (list.isEmpty) {
            return Center(child: Text(strings.homeFeaturedEmpty));
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final vehicle = list[index];
              return VehicleHeroCard(
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
          );
        },
      ),
    );
  }
}
