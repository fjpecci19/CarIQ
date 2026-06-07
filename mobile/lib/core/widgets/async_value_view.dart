import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../i18n/error_messages.dart';
import '../settings/settings_controllers.dart';

/// Renderiza un [AsyncValue] manejando los 3 estados de forma uniforme:
///   • loading -> spinner centrado
///   • error   -> mensaje (traducido) + botón "Reintentar"
///   • data    -> [builder]
///
/// [onRetry] se llama al tocar "Reintentar" (típicamente `ref.invalidate(...)`).
class AsyncValueView<T> extends ConsumerWidget {
  const AsyncValueView({
    super.key,
    required this.value,
    required this.builder,
    required this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) builder;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ErrorRetry(
        message: ref.watch(stringsProvider).messageForError(error),
        onRetry: onRetry,
      ),
      data: builder,
    );
  }
}

/// Vista de error reutilizable con acción de reintento.
class ErrorRetry extends ConsumerWidget {
  const ErrorRetry({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final strings = ref.watch(stringsProvider);
    // Se centra cuando hay espacio y permite scroll si el contenedor es chico
    // (p.ej. el carrusel de "destacados" del Home), evitando overflow.
    return LayoutBuilder(
      builder: (context, constraints) {
        final minHeight =
            constraints.maxHeight.isFinite ? constraints.maxHeight : 0.0;
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_off_rounded, size: 48, color: scheme.error),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    FilledButton.tonalIcon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh),
                      label: Text(strings.commonRetry),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
