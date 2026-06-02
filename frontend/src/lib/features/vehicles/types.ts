// Tipos de la feature "vehicles". El backend devuelve las generaciones de
// forma flexible (engine/body/consumption cambian según el tipo: combustión,
// eléctrico, moto...), por eso usamos Record<string, unknown> + opcionales.

export type VehicleType = 'car' | 'motorcycle' | 'truck';

export interface Generation {
	name?: string;
	yearStart?: number;
	yearEnd?: number | null; // null / ausente => sigue vigente
	transmission?: string;
	priceUsd?: number;
	engine?: Record<string, unknown>;
	body?: Record<string, unknown>;
	consumption?: Record<string, unknown>;
	images?: string[];
	[key: string]: unknown;
}

export interface Vehicle {
	id: string;
	brandId: string; // referencia a Brand.id
	type: VehicleType;
	model: string;
	category?: string;
	tags?: string[];
	history?: string;
	generations?: Generation[];
}
