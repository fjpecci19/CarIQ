import 'package:dio/dio.dart';

import '../config/environment.dart';
import 'api_exception.dart';

/// Cliente HTTP centralizado para toda la app, basado en [Dio].
///
/// - baseUrl y timeouts se configuran una sola vez desde [AppConfig].
/// - Decodifica JSON automáticamente.
/// - Traduce errores de red / HTTP a [ApiException] con mensajes en español.
///
/// Es de SOLO LECTURA: únicamente expone helpers GET.
class ApiClient {
  ApiClient({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: AppConfig.apiBaseUrl,
              connectTimeout: AppConfig.requestTimeout,
              receiveTimeout: AppConfig.requestTimeout,
              responseType: ResponseType.json,
              headers: const {'Accept': 'application/json'},
            ));

  final Dio _dio;

  /// GET que devuelve un objeto JSON (`Map`).
  Future<Map<String, dynamic>> getObject(String path) async {
    final data = await _get(path);
    if (data is Map<String, dynamic>) return data;
    throw const ApiException(ApiErrorKind.format);
  }

  /// GET que devuelve una lista JSON (`List`).
  Future<List<Map<String, dynamic>>> getList(String path) async {
    final data = await _get(path);
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().toList(growable: false);
    }
    throw const ApiException(ApiErrorKind.format);
  }

  Future<dynamic> _get(String path) async {
    try {
      final response = await _dio.get<dynamic>(path);
      return response.data;
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  ApiException _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const ApiException(ApiErrorKind.timeout);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return const ApiException(ApiErrorKind.connection);
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        if (status == 404) {
          return const ApiException(ApiErrorKind.notFound, statusCode: 404);
        }
        return ApiException(ApiErrorKind.server, statusCode: status);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
        return const ApiException(ApiErrorKind.unknown);
    }
  }

  void dispose() => _dio.close(force: true);
}
