import type { PageServerLoad } from './$types';
import { getBrands } from '$lib/features/brands/api';

export const load: PageServerLoad = async ({ fetch }) => {
	const brands = await getBrands(fetch);
	return { brands };
};
