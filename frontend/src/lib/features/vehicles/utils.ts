import type { Generation, Vehicle, VehicleType } from './types';

/** Etiquetas legibles para las claves de specs flexibles (con fallback). */
const SPEC_LABELS: Record<string, string> = {
	type: 'Tipo',
	fuel: 'Combustible',
	displacement_l: 'Cilindrada (L)',
	displacement_cc: 'Cilindrada (cc)',
	horsepower: 'Potencia (HP)',
	power_kw: 'Potencia (kW)',
	torque_nm: 'Torque (Nm)',
	battery_kwh: 'Batería (kWh)',
	range_km: 'Autonomía (km)',
	doors: 'Puertas',
	seats: 'Asientos',
	city_l100km: 'Ciudad (L/100km)',
	highway_l100km: 'Ruta (L/100km)',
	avg_l100km: 'Promedio (L/100km)',
	kwh_100km: 'kWh/100km'
};

/** Fallback: snake_case / camelCase -> "Título Legible". */
function humanize(key: string): string {
	return key
		.replace(/_/g, ' ')
		.replace(/([a-z])([A-Z])/g, '$1 $2')
		.replace(/\b\w/g, (c) => c.toUpperCase());
}

/**
 * Pares { label, value } "mostrables" de un objeto flexible (engine/body/
 * consumption...), salteando nulos/vacíos/objetos anidados. Así renderizamos
 * lo que venga sin mostrar "undefined".
 */
export function specEntries(obj: unknown): { label: string; value: string | number }[] {
	if (!obj || typeof obj !== 'object') return [];
	return Object.entries(obj as Record<string, unknown>)
		.filter(([, v]) => v !== null && v !== undefined && v !== '' && typeof v !== 'object')
		.map(([k, v]) => ({ label: SPEC_LABELS[k] ?? humanize(k), value: v as string | number }));
}

/** Primera generación con datos (o undefined). */
export function firstGeneration(vehicle: Vehicle): Generation | undefined {
	return vehicle.generations?.[0];
}

/** Imagen representativa: primera imagen de la primera generación que tenga. */
export function vehicleImage(vehicle: Vehicle): string | undefined {
	for (const gen of vehicle.generations ?? []) {
		if (gen.images?.length) return gen.images[0];
	}
	return undefined;
}

/** Rango de años: "2010 – 2015", "2018 – Presente", "2010". */
export function yearRange(gen: Generation): string {
	if (!gen.yearStart) return '';
	if (gen.yearEnd) return `${gen.yearStart} – ${gen.yearEnd}`;
	return `${gen.yearStart} – Presente`;
}

const priceFmt = new Intl.NumberFormat('en-US', {
	style: 'currency',
	currency: 'USD',
	maximumFractionDigits: 0
});

export function formatPrice(value?: number): string | undefined {
	return typeof value === 'number' ? priceFmt.format(value) : undefined;
}

/** Precio "desde" del vehículo (mínimo entre sus generaciones). */
export function priceFrom(vehicle: Vehicle): number | undefined {
	const prices = (vehicle.generations ?? [])
		.map((g) => g.priceUsd)
		.filter((p): p is number => typeof p === 'number');
	return prices.length ? Math.min(...prices) : undefined;
}

/** Emoji/ícono según el tipo de vehículo (usado en placeholders). */
export function typeIcon(type: VehicleType): string {
	return type === 'motorcycle' ? '🏍️' : type === 'truck' ? '🚚' : '🚗';
}
