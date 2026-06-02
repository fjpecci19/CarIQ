import type { PageServerLoad } from './$types';
import { getVehicles } from '$lib/features/vehicles/api';
import { getBrands } from '$lib/features/brands/api';

export const load: PageServerLoad = async ({ fetch }) => {
	const [vehicles, brands] = await Promise.all([getVehicles(fetch), getBrands(fetch)]);
	// Mapa id -> nombre de marca para mostrarlo en cada card.
	const brandNames: Record<string, string> = Object.fromEntries(brands.map((b) => [b.id, b.name]));
	return { vehicles, brandNames };
};
