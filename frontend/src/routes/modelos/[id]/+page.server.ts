import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { getVehicle } from '$lib/features/vehicles/api';
import { getBrand } from '$lib/features/brands/api';

export const load: PageServerLoad = async ({ params, fetch }) => {
	let vehicle;
	try {
		vehicle = await getVehicle(params.id, fetch);
	} catch {
		throw error(404, 'Modelo no encontrado');
	}
	// La marca a la que pertenece (si falla, seguimos sin romper la página).
	const brand = await getBrand(vehicle.brandId, fetch).catch(() => null);
	return { vehicle, brand };
};
