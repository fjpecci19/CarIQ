# 🚗 CarIQ

Catálogo y enciclopedia de vehículos — marcas, modelos, historia y especificaciones técnicas.

CarIQ es una aplicación full-stack para explorar marcas de vehículos (autos, motos, camiones y eléctricos), su historia y las especificaciones técnicas de cada modelo. Incluye una interfaz web y una app mobile (Android/iOS) que consumen el mismo backend REST.

## 🛠️ Stack

- **Backend:** Java 21 + Spring Boot 4, Spring Data MongoDB, Maven
- **Frontend:** SvelteKit + TypeScript + TailwindCSS
- **Mobile:** Flutter (Material 3) + Riverpod + Dio — app de solo lectura
- **Base de datos:** MongoDB 7
- **Infraestructura:** Docker + Docker Compose

## 📦 Estructura

    CarIQ/
    ├── backend/              # API REST (Spring Boot)
    ├── frontend/             # Interfaz web (SvelteKit)
    ├── mobile/               # App mobile Android/iOS (Flutter)
    └── docker-compose.yml    # Orquesta MongoDB + backend + frontend

## 🚀 Cómo ejecutar

Requisitos: Docker y Docker Compose.

```bash
docker compose up --build
```

Esto levanta los tres servicios (base de datos, backend y frontend) juntos.

Para detener:

```bash
docker compose down
```

## 📱 App mobile

App Flutter (Android/iOS) de **solo lectura** que consume el mismo backend REST.
Material 3, modo claro/oscuro alineado al frontend, Riverpod y Dio.

```bash
cd mobile
flutter pub get
flutter run
```

El backend se configura en un **único lugar**: `mobile/lib/core/config/environment.dart`.
Tené en cuenta que en el **emulador Android** `localhost` no es tu PC → usá
`http://10.0.2.2:8080` (el emulador iOS sí acepta `localhost`). Detalles completos
(entornos, IP para dispositivo físico, HTTP en desarrollo) en
[mobile/README.md](mobile/README.md).

## 🔌 API

| Método | Endpoint             | Descripción               |
|--------|----------------------|---------------------------|
| GET    | `/api/brands`        | Lista todas las marcas    |
| GET    | `/api/brands/{id}`   | Una marca por ID          |
| GET    | `/api/vehicles`      | Lista todos los vehículos |
| GET    | `/api/vehicles/{id}` | Un vehículo por ID        |

## ✨ Características

- Catálogo de marcas con su historia y datos de origen
- Modelos con especificaciones técnicas por generación
- Soporte para combustión, eléctricos y motos
- Diseño responsive con modo claro y oscuro
- App mobile Android/iOS (Flutter) de solo lectura sobre el mismo backend
- Estructura preparada para múltiples idiomas

## 🗺️ Roadmap

- [ ] Endpoints de escritura protegidos por API Key
- [ ] Panel de administración
- [ ] Comparador de modelos
- [ ] Buscador con filtros

## 👤 Autor

**Franco Pecci** — [@fjpecci19](https://github.com/fjpecci19)
