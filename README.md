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

## 🧩 Componentes

### Backend
API REST en Spring Boot (Java 21) con Spring Data MongoDB. Expone los endpoints de marcas y vehículos, y modela de forma flexible los distintos tipos de vehículo (combustión, eléctricos, motos).

### Frontend
Interfaz web en SvelteKit + TypeScript + TailwindCSS. Consume el backend con carga server-side, tiene diseño responsive y modo claro/oscuro.

### Mobile
App Flutter de solo lectura, con arquitectura feature-first, Riverpod para estado y Dio para HTTP. Consume el mismo backend y comparte el catálogo con la web.

### Base de datos
MongoDB con un setup híbrido configurable mediante `SPRING_MONGODB_URI`: una base local levantada por Docker para desarrollo, o MongoDB Atlas en la nube para acceso desde cualquier lugar.

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

## 👤 Autor

**Franco Pecci** — [@fjpecci19](https://github.com/fjpecci19)
