/// Tipo de error de la capa de datos. La UI lo traduce al idioma activo
/// (ver AppStrings), por eso acá no guardamos el texto final.
enum ApiErrorKind { timeout, connection, notFound, server, format, unknown }

/// Excepción de la capa de datos. Lleva el [kind] (para localizar el mensaje)
/// y opcionalmente el [statusCode].
class ApiException implements Exception {
  const ApiException(this.kind, {this.statusCode});

  final ApiErrorKind kind;
  final int? statusCode;

  @override
  String toString() => 'ApiException($kind, status: $statusCode)';
}
