import 'package:flutter/material.dart';

/// Imagen de red con placeholder de carga y fallback ante error o URL vacía.
/// Nunca rompe la UI si la imagen no existe o falla.
class NetworkImageBox extends StatelessWidget {
  const NetworkImageBox({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.fallbackIcon = Icons.directions_car_filled_outlined,
  });

  final String? url;
  final BoxFit fit;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = Container(
      color: scheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(fallbackIcon, size: 40, color: scheme.onSurfaceVariant),
    );

    if (url == null || url!.isEmpty) return placeholder;

    return Image.network(
      url!,
      fit: fit,
      errorBuilder: (_, _, _) => placeholder,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: scheme.surfaceContainerHighest,
          alignment: Alignment.center,
          child: const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}
