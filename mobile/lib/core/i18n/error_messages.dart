import '../network/api_exception.dart';
import 'app_strings.dart';

/// Traduce un error de la capa de datos al idioma activo.
extension ApiErrorMessages on AppStrings {
  String messageForError(Object error) {
    if (error is! ApiException) return errorUnknown;
    return switch (error.kind) {
      ApiErrorKind.timeout => errorTimeout,
      ApiErrorKind.connection => errorConnection,
      ApiErrorKind.notFound => errorNotFound,
      ApiErrorKind.format => errorFormat,
      ApiErrorKind.server => serverError(error.statusCode),
      ApiErrorKind.unknown => errorUnknown,
    };
  }
}
