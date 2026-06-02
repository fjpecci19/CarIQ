import { env } from '$env/dynamic/private';

/**
 * URL base del backend. Centralizada acá para no hardcodearla en cada fetch.
 *
 * Todo el fetch de datos se hace server-side (desde los +page.server.ts), por eso
 * usamos una variable de entorno PRIVADA: el navegador nunca conoce ni llama
 * directamente al backend, lo que además evita problemas de CORS.
 *
 * - En local (sin Docker): por defecto http://localhost:8080
 * - En Docker: se sobreescribe con API_URL_INTERNAL=http://backend:8080
 *   (nombre del servicio dentro de la red de Docker).
 *
 * Si algún día necesitás llamar al backend desde el cliente, usá la env var
 * pública PUBLIC_API_URL (ej: http://localhost:8080) en ese código en particular.
 */
const API_ORIGIN = env.API_URL_INTERNAL ?? 'http://localhost:8080';

export const API_BASE = `${API_ORIGIN}/api`;
