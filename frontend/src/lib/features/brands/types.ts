import type { VehicleType } from '../vehicles/types';

// Tipos de la feature "brands". Campos en camelCase tal cual los devuelve el backend.
export interface Brand {
	id: string;
	name: string;
	country?: string;
	foundedYear?: number;
	founder?: string;
	logoUrl?: string;
	history?: string;
	vehicleTypes?: VehicleType[];
	active?: boolean;
}
