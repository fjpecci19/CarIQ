import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/settings/settings_controllers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/network_image_box.dart';
import '../../vehicles/data/vehicle.dart';
import '../../vehicles/presentation/vehicle_detail_screen.dart';
import '../../vehicles/presentation/vehicles_providers.dart';
import '../../vehicles/presentation/widgets/vehicle_card.dart';
import '../data/brand.dart';
import 'brands_providers.dart';

/// Detalle de una marca: info completa + sus modelos (vehículos con ese brandId).
class BrandDetailScreen extends ConsumerWidget {
  const BrandDetailScreen({super.key, required this.brandId});

  final String brandId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brand = ref.watch(brandDetailProvider(brandId));
    final strings = ref.watch(stringsProvider);

    return Scaffold(
      body: AsyncValueView(
        value: brand,
        onRetry: () => ref.invalidate(brandDetailProvider(brandId)),
        builder: (data) => RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(brandDetailProvider(brandId));
            ref.invalidate(vehiclesListProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Text(data.name),
              ),
              SliverToBoxAdapter(child: _BrandHeader(brand: data, strings: strings)),
              _BrandModels(brandId: brandId),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({required this.brand, required this.strings});

  final Brand brand;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final facts = <(IconData, String)>[
      if (brand.country != null) (Icons.public, brand.country!),
      if (brand.foundedYear != null)
        (Icons.calendar_today_outlined, strings.foundedIn(brand.foundedYear!)),
      if (brand.founder != null) (Icons.person_outline, brand.founder!),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 88,
                  height: 88,
                  child: NetworkImageBox(
                    url: brand.logoUrl,
                    fit: BoxFit.contain,
                    fallbackIcon: Icons.business_outlined,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(brand.name,
                        style: textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    for (final fact in facts)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(fact.$1,
                                size: 16, color: scheme.onSurfaceVariant),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(fact.$2,
                                  style: textTheme.bodyMedium),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (brand.vehicleTypes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final type in brand.vehicleTypes) Chip(label: Text(type)),
              ],
            ),
          ],
          if (brand.history != null) ...[
            const SizedBox(height: 16),
            Text(strings.detailHistory, style: textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(brand.history!,
                style: textTheme.bodyMedium?.copyWith(height: 1.5)),
          ],
          const SizedBox(height: 20),
          Text(strings.detailModels, style: textTheme.titleLarge),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// Lista de modelos de la marca (filtra vehículos por brandId).
class _BrandModels extends ConsumerWidget {
  const _BrandModels({required this.brandId});

  final String brandId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehiclesByBrandProvider(brandId));
    final strings = ref.watch(stringsProvider);

    return vehicles.when(
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            strings.brandModelsError,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      data: (list) {
        if (list.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(strings.brandModelsEmpty),
            ),
          );
        }
        return SliverList.separated(
          itemCount: list.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _ModelTile(vehicle: list[index]),
        );
      },
    );
  }
}

class _ModelTile extends StatelessWidget {
  const _ModelTile({required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: VehicleCard(
        vehicle: vehicle,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VehicleDetailScreen(vehicleId: vehicle.id),
          ),
        ),
      ),
    );
  }
}
