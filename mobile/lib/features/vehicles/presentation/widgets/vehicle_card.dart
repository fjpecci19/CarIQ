import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/settings/settings_controllers.dart';
import '../../../../core/widgets/network_image_box.dart';
import '../../data/vehicle.dart';
import '../vehicle_type_label.dart';

/// Card vertical de un vehículo para listas (Modelos, Detalle de marca).
class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.onTap,
    this.brandName,
  });

  final Vehicle vehicle;
  final VoidCallback onTap;
  final String? brandName;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final subtitle = [
      brandName,
      vehicle.category,
    ].whereType<String>().where((s) => s.isNotEmpty).join(' · ');

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SizedBox(
              width: 110,
              height: 96,
              child: NetworkImageBox(url: vehicle.coverImage),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      vehicle.model,
                      style: textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _TypeChip(type: vehicle.type),
                        const Spacer(),
                        Icon(Icons.chevron_right,
                            color: scheme.onSurfaceVariant),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card horizontal compacta para el carrusel de "destacados" del Home.
class VehicleHeroCard extends ConsumerWidget {
  const VehicleHeroCard({
    super.key,
    required this.vehicle,
    required this.onTap,
    this.brandName,
  });

  final Vehicle vehicle;
  final VoidCallback onTap;
  final String? brandName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 220,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: NetworkImageBox(url: vehicle.coverImage),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.model,
                      style: textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [brandName, vehicle.type.label(ref.watch(stringsProvider))]
                          .whereType<String>()
                          .where((s) => s.isNotEmpty)
                          .join(' · '),
                      style: textTheme.bodySmall
                          ?.copyWith(color: scheme.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TypeChip extends ConsumerWidget {
  const _TypeChip({required this.type});

  final VehicleType type;

  IconData get _icon => switch (type) {
        VehicleType.car => Icons.directions_car_filled_outlined,
        VehicleType.motorcycle => Icons.two_wheeler_outlined,
        VehicleType.truck => Icons.local_shipping_outlined,
        VehicleType.unknown => Icons.help_outline,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_icon, size: 16, color: scheme.primary),
        const SizedBox(width: 4),
        Text(type.label(ref.watch(stringsProvider)),
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: scheme.primary)),
      ],
    );
  }
}
