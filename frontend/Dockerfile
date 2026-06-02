# ---------- Stage 1: build ----------
FROM node:22-alpine AS build
WORKDIR /app

# Instala dependencias (incluye devDependencies, necesarias para compilar)
COPY package*.json ./
RUN npm install

# Copia el resto del código y genera el build de producción (adapter-node)
COPY . .
RUN npm run build

# Elimina las dependencias de desarrollo para una imagen de runtime más liviana
RUN npm prune --omit=dev

# ---------- Stage 2: runtime ----------
FROM node:22-alpine AS runtime
WORKDIR /app

ENV NODE_ENV=production
# adapter-node escucha en este puerto (configurable con PORT)
ENV PORT=3000

# Solo necesitamos el build, las deps de producción y el package.json
COPY --from=build /app/build ./build
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json

EXPOSE 3000

CMD ["node", "build"]
