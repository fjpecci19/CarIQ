/// Configuración de entornos / backend.
///
/// ───────────────────────────────────────────────────────────────────────────
///  ÚNICO LUGAR para cambiar a qué backend apunta la app.
/// ───────────────────────────────────────────────────────────────────────────
///
/// Para alternar de backend, cambiá [AppConfig.current] por el entorno deseado.
///
/// OJO con "localhost" en Flutter (clave para desarrollo):
///   • Emulador Android  -> "localhost" es el PROPIO emulador, NO tu PC.
///                          Usá 10.0.2.2 (alias del host desde el emulador).
///   • Emulador iOS / Web / Desktop -> "localhost" SÍ apunta a tu PC.
///   • Dispositivo físico (Android o iOS) -> usá la IP de tu PC en la LAN
///     (ej: http://192.168.0.42:8080). Tu teléfono y tu PC deben estar en la
///     misma red Wi-Fi, y el backend debe escuchar en 0.0.0.0.
library;

enum Environment {
  /// Backend local visto desde un EMULADOR ANDROID.
  /// 10.0.2.2 es el alias que el emulador usa para llegar al host (tu PC).
  localAndroid('http://10.0.2.2:8080'),

  /// Backend local visto desde EMULADOR iOS / WEB / DESKTOP.
  localIos('http://localhost:8080'),

  /// Backend local desde un DISPOSITIVO FÍSICO en la misma red Wi-Fi.
  /// Reemplazá la IP por la de tu PC (ipconfig / ifconfig).
  localDevice('http://192.168.0.7:8080'),

  /// Backend desplegado en la nube (URL pública).
  /// Reemplazá por tu URL real cuando lo tengas.
  cloud('https://cariq-backend.tu-dominio.com');

  const Environment(this.baseUrl);

  /// URL base del backend, SIN el sufijo "/api" (lo agrega el ApiClient).
  final String baseUrl;
}

/// Configuración activa de la app.
class AppConfig {
  AppConfig._();

  /// 👉 CAMBIÁ ESTA LÍNEA para alternar de backend.
  ///
  /// Por defecto apunta al backend local desde emulador Android, que es el
  /// caso más común en desarrollo en Windows.
  ///
  /// También se puede sobreescribir en tiempo de compilación sin tocar código:
  ///   flutter run --dart-define=API_BASE_URL=http://192.168.0.42:8080
  static const Environment current = Environment.localDevice;

  /// Permite overridear la URL vía --dart-define sin recompilar el enum.
  /// Si no se pasa, usa la URL del entorno [current].
  static const String _override = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  /// URL base efectiva del backend (sin "/api").
  static String get baseUrl =>
      _override.isNotEmpty ? _override : current.baseUrl;

  /// Prefijo de la API REST.
  static String get apiBaseUrl => '$baseUrl/api';

  /// Timeout para las llamadas HTTP.
  static const Duration requestTimeout = Duration(seconds: 15);
}
