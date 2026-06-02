import { getJSON } from '$lib/http';
import type { Vehicle } from './types';

export const getVehicles = (fetchFn?: typeof fetch) => getJSON<Vehicle[]>('/vehicles', fetchFn);

export const getVehicle = (id: string, fetchFn?: typeof fetch) =>
	getJSON<Vehicle>(`/vehicles/${id}`, fetchFn);
