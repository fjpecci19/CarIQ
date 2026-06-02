<script lang="ts">
	import type { PageData } from './$types';
	import { t } from '$lib/i18n';
	import VehicleCard from '$lib/features/vehicles/VehicleCard.svelte';

	let { data }: { data: PageData } = $props();
	const brand = $derived(data.brand);
</script>

<svelte:head><title>{brand.name} — CarIQ</title></svelte:head>

<!-- breadcrumb -->
<nav class="mb-6 text-sm text-gray-500 dark:text-gray-400">
	<a href="/marcas" class="link-accent">{$t.brands.title}</a>
	<span class="mx-1">/</span>
	<span>{brand.name}</span>
</nav>

<!-- Cabecera de la marca -->
<header class="surface p-6 sm:p-8">
	<div class="flex flex-wrap items-start gap-4">
		{#if brand.logoUrl}
			<img src={brand.logoUrl} alt={brand.name} class="size-16 rounded-2xl object-contain" />
		{:else}
			<span
				class="grid size-16 shrink-0 place-items-center rounded-2xl bg-linear-to-br from-emerald-600/90 to-red-600/90 text-2xl font-black text-white dark:from-sky-500 dark:to-blue-600"
			>
				{brand.name.charAt(0)}
			</span>
		{/if}
		<div class="flex-1">
			<div class="flex flex-wrap items-center gap-3">
				<h1 class="text-3xl font-black tracking-tight">{brand.name}</h1>
				{#if brand.active !== undefined}
					<span class="chip">{brand.active ? $t.brands.active : $t.brands.inactive}</span>
				{/if}
			</div>

			<dl class="mt-4 grid grid-cols-2 gap-x-6 gap-y-2 text-sm sm:grid-cols-3">
				{#if brand.country}
					<div>
						<dt class="text-gray-500 dark:text-gray-400">{$t.brands.country}</dt>
						<dd class="font-semibold">{brand.country}</dd>
					</div>
				{/if}
				{#if brand.foundedYear}
					<div>
						<dt class="text-gray-500 dark:text-gray-400">{$t.brands.founded}</dt>
						<dd class="font-semibold">{brand.foundedYear}</dd>
					</div>
				{/if}
				{#if brand.founder}
					<div>
						<dt class="text-gray-500 dark:text-gray-400">{$t.brands.founder}</dt>
						<dd class="font-semibold">{brand.founder}</dd>
					</div>
				{/if}
			</dl>

			{#if brand.vehicleTypes?.length}
				<div class="mt-4 flex flex-wrap gap-1.5">
					{#each brand.vehicleTypes as vt (vt)}
						<span class="chip-accent">{$t.types[vt]}</span>
					{/each}
				</div>
			{/if}
		</div>
	</div>

	{#if brand.history}
		<div class="mt-6 border-t border-gray-200 pt-5 dark:border-white/10">
			<h2
				class="mb-2 text-sm font-semibold tracking-wide text-gray-500 uppercase dark:text-gray-400"
			>
				{$t.brands.history}
			</h2>
			<p class="prose prose-sm max-w-none dark:prose-invert">{brand.history}</p>
		</div>
	{/if}
</header>

<!-- Modelos de la marca -->
<section class="mt-10">
	<h2 class="section-title mb-5">{$t.brands.modelsOf} {brand.name}</h2>

	{#if data.models.length}
		<div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
			{#each data.models as vehicle (vehicle.id)}
				<VehicleCard {vehicle} />
			{/each}
		</div>
	{:else}
		<p class="surface p-6 text-gray-500 dark:text-gray-400">{$t.brands.noModels}</p>
	{/if}
</section>
