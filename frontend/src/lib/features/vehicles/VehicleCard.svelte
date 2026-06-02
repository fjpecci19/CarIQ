<script lang="ts">
	import type { Vehicle } from './types';
	import { vehicleImage, priceFrom, formatPrice, typeIcon } from './utils';
	import { t } from '$lib/i18n';

	let { vehicle, brandName }: { vehicle: Vehicle; brandName?: string } = $props();

	const img = $derived(vehicleImage(vehicle));
	const price = $derived(formatPrice(priceFrom(vehicle)));
</script>

<a
	href={`/modelos/${vehicle.id}`}
	class="surface card-hover group flex h-full flex-col overflow-hidden"
>
	<!-- Imagen o placeholder (el backend no trae imágenes por ahora) -->
	<div class="relative aspect-[16/10] overflow-hidden">
		{#if img}
			<img
				src={img}
				alt={vehicle.model}
				loading="lazy"
				class="size-full object-cover transition duration-300 group-hover:scale-105"
			/>
		{:else}
			<div
				class="grid size-full place-items-center bg-linear-to-br from-gray-100 to-gray-200 dark:from-white/[0.06] dark:to-white/[0.02]"
			>
				<span class="text-5xl opacity-80 transition duration-300 group-hover:scale-110">
					{typeIcon(vehicle.type)}
				</span>
			</div>
		{/if}
		<span class="chip-accent absolute top-3 left-3 backdrop-blur">{$t.types[vehicle.type]}</span>
	</div>

	<div class="flex flex-1 flex-col gap-1 p-4">
		{#if brandName}
			<p class="text-xs font-semibold tracking-wide text-gray-500 uppercase dark:text-gray-400">
				{brandName}
			</p>
		{/if}
		<h3 class="text-lg font-bold tracking-tight">{vehicle.model}</h3>
		{#if vehicle.category}
			<p class="text-sm text-gray-500 dark:text-gray-400">{vehicle.category}</p>
		{/if}

		<div class="mt-3 flex items-end justify-between gap-2 pt-2">
			{#if price}
				<span class="text-sm font-semibold">
					<span class="text-gray-400">{$t.models.from}</span>
					{price}
				</span>
			{:else}
				<span></span>
			{/if}
			<span class="link-accent text-sm whitespace-nowrap">{$t.models.viewDetail} →</span>
		</div>
	</div>
</a>
