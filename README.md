# 🚗 CarIQ

Catálogo y enciclopedia de vehículos — marcas, modelos, historia y especificaciones técnicas.

CarIQ es una aplicación full-stack para explorar marcas de vehículos (autos, motos, camiones y eléctricos), su historia y las especificaciones técnicas de cada modelo. Incluye una interfaz web y una app mobile que consumen el mismo backend REST.

## 🛠️ Stack

- **Backend:** Java 21 + Spring Boot 4, Spring Data MongoDB, Maven
- **Frontend:** SvelteKit + TypeScript + TailwindCSS
- **Mobile:** Flutter (Material 3, feature-first) + Riverpod + Dio
- **Base de datos:** MongoDB 7 (local o Atlas en la nube)
- **Infraestructura:** Docker + Docker Compose

## 📦 Estructura

    CarIQ/
    ├── backend/              # API REST (Spring Boot)
    ├── frontend/             # Interfaz web (SvelteKit)
    ├── mobile/               # App mobile (Flutter)
    └── docker-compose.yml    # Orquesta MongoDB + backend + frontend

## 🚀 Cómo ejecutar

Requisitos: Docker y Docker Compose.

```bash
docker compose up --build
```

Para detener:

```bash
docker compose down
```

### Base de datos: local o nube

El backend toma la conexión desde la variable `SPRING_MONGODB_URI`. Sin definirla, usa el MongoDB local del `docker-compose`; con una URI de MongoDB Atlas, usa la base en la nube. Copiá `.env.example` a `.env` y completá según el caso.

## 📱 App mobile

App Flutter de solo lectura que consume el mismo backend REST.

```bash
cd mobile
flutter pub get
flutter run
```

El backend se configura en `mobile/lib/core/config/environment.dart`. Más detalles en [mobile/README.md](mobile/README.md).

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
- App mobile sobre el mismo backend
- Conexión configurable: MongoDB local o Atlas

## 🗺️ Roadmap

- [ ] Endpoints de escritura protegidos por API Key
- [ ] Panel de administración
- [ ] Comparador de modelos
- [ ] Buscador con filtros

## 👤 Autor

**Franco Pecci** — [@fjpecci19](https://github.com/fjpecci19)
