import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/settings/settings_controllers.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/settings_actions.dart';
import 'brand_detail_screen.dart';
import 'brands_providers.dart';
import 'widgets/brand_card.dart';

/// Pantalla "Marcas": lista vertical de todas las marcas.
class BrandsScreen extends ConsumerWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brands = ref.watch(brandsListProvider);
    final strings = ref.watch(stringsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.brandsTitle),
        actions: const [SettingsActions()],
      ),
      body: AsyncValueView(
        value: brands,
        onRetry: () => ref.invalidate(brandsListProvider),
        builder: (list) {
          if (list.isEmpty) {
            return Center(child: Text(strings.brandsEmpty));
          }
          return RefreshIndicator(
            onRefresh: () => ref.refresh(brandsListProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final brand = list[index];
                return BrandCard(
                  brand: brand,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BrandDetailScreen(brandId: brand.id),
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
