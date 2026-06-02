import { API_BASE } from './config';

/**
 * Helper de fetch compartido por todas las features.
 * Recibe el `fetch` de SvelteKit (desde las funciones load) para que
 * funcione bien en SSR; si no se pasa, usa el global.
 */
export async function getJSON<T>(path: string, fetchFn: typeof fetch = fetch): Promise<T> {
	const res = await fetchFn(`${API_BASE}${path}`);
	if (!res.ok) {
		throw new Error(`Error ${res.status} al pedir ${path}`);
	}
	return res.json() as Promise<T>;
}
