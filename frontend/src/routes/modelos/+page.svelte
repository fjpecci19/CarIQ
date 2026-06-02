<script lang="ts">
	import type { PageData } from './$types';
	import { t } from '$lib/i18n';
	import type { VehicleType } from '$lib/features/vehicles/types';
	import VehicleCard from '$lib/features/vehicles/VehicleCard.svelte';
	import SearchBar from '$lib/components/SearchBar.svelte';

	let { data }: { data: PageData } = $props();

	// Filtros (cliente): tipo + texto libre.
	let filter = $state<'all' | VehicleType>('all');
	let query = $state('');
	const types: ('all' | VehicleType)[] = ['all', 'car', 'motorcycle', 'truck'];

	const filtered = $derived.by(() => {
		const q = query.trim().toLowerCase();
		return data.vehicles.filter((v) => {
			if (filter !== 'all' && v.type !== filter) return false;
			if (!q) return true;
			// busca en modelo, categoría, tags y nombre de la marca
			return [v.model, v.category, data.brandNames[v.brandId], ...(v.tags ?? [])].some((f) =>
				f?.toLowerCase().includes(q)
			);
		});
	});

	// Clases del botón de filtro según esté activo o no (evitamos class: con `:` de Tailwind).
	const activeBtn =
		'border-emerald-600 bg-emerald-600 text-white dark:border-sky-500 dark:bg-sky-500';
	const idleBtn = 'border-gray-200 hover:bg-gray-100 dark:border-white/10 dark:hover:bg-white/10';
</script>

<svelte:head><title>{$t.models.title} — CarIQ</title></svelte:head>

<header class="mb-6">
	<h1 class="section-title">{$t.models.title}</h1>
	<p class="mt-1 text-gray-500 dark:text-gray-400">{$t.models.subtitle}</p>
	<div class="accent-rule mt-3"></div>
</header>

<!-- Buscador + filtro por tipo -->
<div class="mb-7 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
	<div class="w-full sm:max-w-sm">
		<SearchBar bind:value={query} placeholder={$t.models.searchPlaceholder} />
	</div>
	<div class="flex flex-wrap gap-2">
		{#each types as vt (vt)}
			<button
				type="button"
				onclick={() => (filter = vt)}
				class="rounded-full border px-4 py-1.5 text-sm font-medium transition {filter === vt
					? activeBtn
					: idleBtn}"
			>
				{vt === 'all' ? $t.models.all : $t.types[vt]}
			</button>
		{/each}
	</div>
</div>

{#if filtered.length}
	<div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
		{#each filtered as vehicle (vehicle.id)}
			<VehicleCard {vehicle} brandName={data.brandNames[vehicle.brandId]} />
		{/each}
	</div>
{:else}
	<p class="surface p-6 text-center text-gray-500 dark:text-gray-400">{$t.common.noResults}</p>
{/if}
