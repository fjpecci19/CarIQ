import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network/api_client.dart';

/// Provider global del cliente HTTP. Es un singleton para toda la app.
final apiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient();
  ref.onDispose(client.dispose);
  return client;
});
