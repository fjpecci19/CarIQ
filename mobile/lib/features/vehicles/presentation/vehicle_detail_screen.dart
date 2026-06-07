import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/i18n/app_strings.dart';
import '../../../core/settings/settings_controllers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/network_image_box.dart';
import '../../../core/widgets/spec_table.dart';
import '../../brands/presentation/brands_providers.dart';
import '../data/generation.dart';
import '../data/vehicle.dart';
import 'vehicle_type_label.dart';
import 'vehicles_providers.dart';

/// Detalle de un modelo: historia, tags y cada generación con sus specs.
class VehicleDetailScreen extends ConsumerWidget {
  const VehicleDetailScreen({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicle = ref.watch(vehicleDetailProvider(vehicleId));
    final strings = ref.watch(stringsProvider);

    return Scaffold(
      body: AsyncValueView(
        value: vehicle,
        onRetry: () => ref.invalidate(vehicleDetailProvider(vehicleId)),
        builder: (data) {
          final brandName =
              ref.watch(brandsByIdProvider).valueOrNull?[data.brandId]?.name;
          return RefreshIndicator(
            onRefresh: () async =>
                ref.invalidate(vehicleDetailProvider(vehicleId)),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(pinned: true, title: Text(data.model)),
                SliverToBoxAdapter(
                  child: _VehicleHeader(
                      vehicle: data, brandName: brandName, strings: strings),
                ),
                SliverList.builder(
                  itemCount: data.generations.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: _GenerationCard(
                        generation: data.generations[index], strings: strings),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _VehicleHeader extends StatelessWidget {
  const _VehicleHeader(
      {required this.vehicle, required this.strings, this.brandName});

  final Vehicle vehicle;
  final AppStrings strings;
  final String? brandName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final subtitle = [brandName, vehicle.type.label(strings), vehicle.category]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .join(' · ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (vehicle.coverImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: NetworkImageBox(url: vehicle.coverImage),
              ),
            ),
          const SizedBox(height: 12),
          Text(vehicle.model,
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(subtitle,
                style: textTheme.bodyMedium
                    ?.copyWith(color: scheme.onSurfaceVariant)),
          ],
          if (vehicle.tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final tag in vehicle.tags)
                  Chip(
                    label: Text(tag),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          ],
          if (vehicle.history != null) ...[
            const SizedBox(height: 16),
            Text(strings.detailHistory, style: textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(vehicle.history!,
                style: textTheme.bodyMedium?.copyWith(height: 1.5)),
          ],
          const SizedBox(height: 20),
          Text(strings.detailGenerations, style: textTheme.titleLarge),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

/// Card de una generación: específicamente diseñada para la estructura flexible.
class _GenerationCard extends StatelessWidget {
  const _GenerationCard({required this.generation, required this.strings});

  final Generation generation;
  final AppStrings strings;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final yearRange =
        strings.yearRange(generation.yearStart, generation.yearEnd);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título + rango de años
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(generation.name,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
                if (yearRange.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(yearRange,
                        style: textTheme.labelMedium?.copyWith(
                            color: scheme.onSecondaryContainer)),
                  ),
              ],
            ),

            // Galería de imágenes (si hay)
            if (generation.images.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: generation.images.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: NetworkImageBox(url: generation.images[i]),
                    ),
                  ),
                ),
              ),
            ],

            // Datos principales (precio / transmisión)
            if (generation.priceUsd != null || generation.transmission != null)
              ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  if (generation.priceUsd != null)
                    _Highlight(
                      icon: Icons.sell_outlined,
                      label: strings.specPrice,
                      value: _formatPrice(generation.priceUsd!),
                    ),
                  if (generation.transmission != null)
                    _Highlight(
                      icon: Icons.settings_outlined,
                      label: strings.specTransmission,
                      value: generation.transmission!,
                    ),
                ],
              ),
            ],

            // Bloques flexibles: solo se renderizan si tienen contenido.
            _SpecBlock(title: strings.specEngine, data: generation.engine),
            _SpecBlock(
                title: strings.specConsumption, data: generation.consumption),
            _SpecBlock(title: strings.specBody, data: generation.body),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    final str = price.round().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return 'USD \$$buffer';
  }
}

class _Highlight extends StatelessWidget {
  const _Highlight(
      {required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: scheme.primary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: textTheme.labelSmall
                    ?.copyWith(color: scheme.onSurfaceVariant)),
            Text(value,
                style: textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

/// Renderiza un bloque de specs SOLO si el mapa tiene datos.
class _SpecBlock extends StatelessWidget {
  const _SpecBlock({required this.title, required this.data});

  final String title;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(title,
            style: textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 6),
        SpecTable(data: data),
      ],
    );
  }
}
