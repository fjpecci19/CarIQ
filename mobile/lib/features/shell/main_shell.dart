import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/settings/settings_controllers.dart';
import '../brands/presentation/brands_screen.dart';
import '../home/presentation/home_screen.dart';
import '../vehicles/presentation/vehicles_screen.dart';

/// Tabs principales de la app.
enum AppTab { home, brands, vehicles }

/// Tab seleccionado actualmente. Es un provider para que el Home pueda
/// cambiar de pestaña desde sus "accesos rápidos".
final selectedTabProvider =
    StateProvider<AppTab>((ref) => AppTab.home);

/// Scaffold raíz con BottomNavigationBar.
///
/// Usa un IndexedStack para preservar el estado/scroll de cada tab.
/// Las pantallas de DETALLE se empujan sobre el Navigator raíz (full screen,
/// con su propio botón de volver), que es el patrón nativo esperado en mobile.
class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(selectedTabProvider);
    final strings = ref.watch(stringsProvider);

    return Scaffold(
      body: IndexedStack(
        index: tab.index,
        children: const [
          HomeScreen(),
          BrandsScreen(),
          VehiclesScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (index) =>
            ref.read(selectedTabProvider.notifier).state = AppTab.values[index],
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: strings.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.business_outlined),
            selectedIcon: const Icon(Icons.business),
            label: strings.navBrands,
          ),
          NavigationDestination(
            icon: const Icon(Icons.directions_car_outlined),
            selectedIcon: const Icon(Icons.directions_car),
            label: strings.navModels,
          ),
        ],
      ),
    );
  }
}
