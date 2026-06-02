# 🚗 CarIQ

Catálogo y enciclopedia de vehículos — marcas, modelos, historia y especificaciones técnicas.

CarIQ es una aplicación web full-stack para explorar marcas de vehículos (autos, motos, camiones y eléctricos), su historia y las especificaciones técnicas de cada modelo.

## 🛠️ Stack

- **Backend:** Java 21 + Spring Boot 4, Spring Data MongoDB, Maven
- **Frontend:** SvelteKit + TypeScript + TailwindCSS
- **Base de datos:** MongoDB 7
- **Infraestructura:** Docker + Docker Compose

## 📦 Estructura

CarIQ/
├── backend/              # API REST (Spring Boot)
├── frontend/             # Interfaz web (SvelteKit)
└── docker-compose.yml    # Orquesta MongoDB + backend + frontend

## 🚀 Cómo ejecutar

Requisitos: Docker y Docker Compose.

```bash
docker compose up --build
```

| Servicio  | URL                    |
|-----------|------------------------|
| Frontend  | http://localhost:3000  |
| Backend   | http://localhost:8080  |
| MongoDB   | localhost:27017        |

Para detener:

```bash
docker compose down
```

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
- Estructura preparada para múltiples idiomas

## 🗺️ Roadmap

- [ ] Endpoints de escritura protegidos por API Key
- [ ] Panel de administración
- [ ] Comparador de modelos
- [ ] Buscador con filtros

## 👤 Autor

**Franco Pecci** — [@fjpecci19](https://github.com/fjpecci19)
