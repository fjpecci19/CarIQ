import type { PageServerLoad } from './$types';
import { getBrands } from '$lib/features/brands/api';
import { getVehicles } from '$lib/features/vehicles/api';
import type { Brand } from '$lib/features/brands/types';
import type { Vehicle } from '$lib/features/vehicles/types';

export const load: PageServerLoad = async ({ fetch }) => {
	const [brands, vehicles] = await Promise.all([getBrands(fetch), getVehicles(fetch)]);

	// Un vehículo representativo por marca (el primero que encontremos).
	const featured = brands
		.map((brand) => {
			const vehicle = vehicles.find((v) => v.brandId === brand.id);
			return vehicle ? { brand, vehicle } : null;
		})
		.filter((x): x is { brand: Brand; vehicle: Vehicle } => x !== null);

	return { featured, brandCount: brands.length, vehicleCount: vehicles.length };
};
