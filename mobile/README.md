# CarIQ Mobile

App mobile (Android / iOS) de **solo lectura** que consume el mismo backend REST
de CarIQ (Spring Boot). Hecha en Flutter con Material 3, null-safety y Riverpod.

> Catálogo de marcas y modelos (autos, motos, camiones) con su historia y las
> especificaciones de cada generación.

---

## 1. Estructura (feature-first + core)

Arquitectura **feature-first** con capas pragmáticas (presentación / datos). Al
ser solo lectura no hay capa de "use cases": los repositorios ya son una API de
datos suficientemente simple, y Riverpod (`AsyncValue`) cubre estado y
loading/error sin ceremonia.

```
lib/
├── main.dart                      # bootstrap: runApp(ProviderScope(...))
├── app.dart                       # MaterialApp + temas claro/oscuro
│
├── core/                          # transversal a todas las features
│   ├── config/
│   │   └── environment.dart       # ⭐ ÚNICO lugar para cambiar de backend
│   ├── network/
│   │   ├── api_client.dart        # cliente HTTP central (Dio) + errores tipados
│   │   ├── api_exception.dart
│   │   └── json_utils.dart        # parseo robusto (camelCase/snake_case, Maps)
│   ├── theme/
│   │   └── app_theme.dart         # tema Material 3 alineado al frontend web
│   ├── widgets/
│   │   ├── async_value_view.dart  # loading / error+reintentar / data
│   │   ├── network_image_box.dart # imagen con placeholder y fallback
│   │   └── spec_table.dart        # render de Maps flexibles (solo campos presentes)
│   └── providers.dart             # provider global del ApiClient
│
└── features/
    ├── shell/
    │   └── main_shell.dart         # Scaffold raíz + BottomNavigationBar (3 tabs)
    ├── home/
    │   └── presentation/home_screen.dart
    ├── brands/
    │   ├── data/
    │   │   ├── brand.dart           # modelo tipado + fromJson robusto
    │   │   └── brands_repository.dart
    │   └── presentation/
    │       ├── brands_providers.dart
    │       ├── brands_screen.dart        # lista de marcas
    │       ├── brand_detail_screen.dart  # info + modelos de la marca
    │       └── widgets/brand_card.dart
    └── vehicles/
        ├── data/
        │   ├── vehicle.dart         # modelo + enum VehicleType
        │   ├── generation.dart      # generación (engine/consumption/body flexibles)
        │   └── vehicles_repository.dart
        └── presentation/
            ├── vehicles_providers.dart
            ├── vehicles_screen.dart        # lista de modelos
            ├── vehicle_detail_screen.dart  # historia, tags y generaciones
            └── widgets/vehicle_card.dart
```

**Patrones mobile usados:** `BottomNavigationBar` (Home / Marcas / Modelos) +
navegación por stack para los detalles (`Navigator.push`, full screen con back),
cards, listas con scroll fluido, **pull-to-refresh**, spinner de carga y
**error + reintentar** en cada fetch.

**Datos flexibles:** `engine`, `consumption` y `body` se guardan como
`Map<String, dynamic>` y se muestran con `SpecTable`, que renderiza **solo los
campos presentes** (no muestra `null` ni rompe si falta algo). El `fromJson`
acepta tanto camelCase (como serializa Jackson) como snake_case.

---

## 2. Cambiar entre backend local y nube

Todo se controla en un **único archivo**: [lib/core/config/environment.dart](lib/core/config/environment.dart).

```dart
// 👉 Cambiá esta línea:
static const Environment current = Environment.localAndroid;
```

Entornos disponibles:

| Entorno                  | URL base                         | Cuándo usarlo                                   |
|--------------------------|----------------------------------|-------------------------------------------------|
| `Environment.localAndroid` | `http://10.0.2.2:8080`           | **Emulador Android** (10.0.2.2 = tu PC)         |
| `Environment.localIos`     | `http://localhost:8080`          | **Emulador iOS** / Desktop                      |
| `Environment.localDevice`  | `http://192.168.0.42:8080`       | **Teléfono físico** en la misma Wi-Fi (cambiá la IP) |
| `Environment.cloud`        | `https://...` (tu URL pública)   | Backend desplegado en la nube                   |

> **Por qué importa `localhost` en Flutter:** en el emulador Android `localhost`
> apunta al propio emulador, **no a tu PC** → hay que usar `10.0.2.2`. En el
> emulador iOS / desktop `localhost` sí es tu PC. En un teléfono físico usá la IP
> de tu PC en la LAN (`ipconfig`) y que el backend escuche en `0.0.0.0`.

También se puede sobreescribir la URL sin tocar código:

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.0.42:8080
```

### HTTP en desarrollo (sin HTTPS)

El backend local usa HTTP plano. Ya está habilitado para desarrollo:

- **Android:** [network_security_config.xml](android/app/src/main/res/xml/network_security_config.xml)
  permite cleartext **solo** para `10.0.2.2`, `localhost`, `127.0.0.1` y la IP de
  ejemplo de la LAN (cambiala por la tuya si usás un teléfono físico). Además se
  agregó el permiso `INTERNET`.
- **iOS:** excepciones ATS en [Info.plist](ios/Runner/Info.plist) para `localhost`
  y `127.0.0.1`.

El backend en la nube por HTTPS funciona sin tocar nada de esto.

---

## 3. Cómo correr la app

Requisitos: Flutter 3.44+ (Dart 3.12+). Verificá con `flutter doctor`.

```bash
cd mobile
flutter pub get

# Ver dispositivos/emuladores disponibles
flutter devices

# Correr (elige el dispositivo conectado/emulador abierto)
flutter run
```

Casos típicos:

```bash
# Emulador Android  -> usar Environment.localAndroid (10.0.2.2)
flutter run -d emulator-5554

# Emulador iOS (en Mac) -> usar Environment.localIos (localhost)
flutter run -d <id-del-simulador>

# Teléfono físico Android -> Environment.localDevice con la IP de tu PC
flutter run --dart-define=API_BASE_URL=http://TU_IP:8080
```

Asegurate de tener el backend corriendo (`cd backend && ./mvnw spring-boot:run`,
o vía `docker-compose up`).

### Tests

```bash
flutter test
```

(Cubren el parseo robusto de `Brand`/`Vehicle`, incluyendo Maps flexibles y
campos faltantes.)
