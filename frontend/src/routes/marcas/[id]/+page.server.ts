import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { getBrand } from '$lib/features/brands/api';
import { getVehicles } from '$lib/features/vehicles/api';

export const load: PageServerLoad = async ({ params, fetch }) => {
	try {
		const [brand, vehicles] = await Promise.all([getBrand(params.id, fetch), getVehicles(fetch)]);
		// Modelos de esta marca (filtramos por brandId).
		const models = vehicles.filter((v) => v.brandId === brand.id);
		return { brand, models };
	} catch {
		throw error(404, 'Marca no encontrada');
	}
};
