import { getJSON } from '$lib/http';
import type { Brand } from './types';

export const getBrands = (fetchFn?: typeof fetch) => getJSON<Brand[]>('/brands', fetchFn);

export const getBrand = (id: string, fetchFn?: typeof fetch) =>
	getJSON<Brand>(`/brands/${id}`, fetchFn);
