<script lang="ts">
	import type { PageData } from './$types';
	import { t } from '$lib/i18n';
	import { typeIcon } from '$lib/features/vehicles/utils';
	import GenerationCard from '$lib/features/vehicles/GenerationCard.svelte';

	let { data }: { data: PageData } = $props();
	const vehicle = $derived(data.vehicle);
	const generations = $derived(vehicle.generations ?? []);
</script>

<svelte:head><title>{vehicle.model} — CarIQ</title></svelte:head>

<!-- breadcrumb -->
<nav class="mb-6 text-sm text-gray-500 dark:text-gray-400">
	<a href="/modelos" class="link-accent">{$t.models.title}</a>
	<span class="mx-1">/</span>
	<span>{vehicle.model}</span>
</nav>

<!-- Cabecera del modelo -->
<header class="surface p-6 sm:p-8">
	<div class="flex items-start gap-4">
		<span class="text-5xl">{typeIcon(vehicle.type)}</span>
		<div class="flex-1">
			<div class="flex flex-wrap items-center gap-2">
				<span class="chip-accent">{$t.types[vehicle.type]}</span>
				{#if vehicle.category}<span class="chip">{vehicle.category}</span>{/if}
			</div>
			<h1 class="mt-2 text-3xl font-black tracking-tight sm:text-4xl">{vehicle.model}</h1>
			{#if data.brand}
				<p class="mt-1 text-gray-500 dark:text-gray-400">
					{$t.models.brand}:
					<a href={`/marcas/${data.brand.id}`} class="link-accent">{data.brand.name}</a>
				</p>
			{/if}
		</div>
	</div>

	{#if vehicle.tags?.length}
		<div class="mt-5 flex flex-wrap gap-1.5">
			{#each vehicle.tags as tag (tag)}
				<span class="chip">#{tag}</span>
			{/each}
		</div>
	{/if}

	{#if vehicle.history}
		<div class="mt-6 border-t border-gray-200 pt-5 dark:border-white/10">
			<h2
				class="mb-2 text-sm font-semibold tracking-wide text-gray-500 uppercase dark:text-gray-400"
			>
				{$t.models.history}
			</h2>
			<p class="prose prose-sm max-w-none dark:prose-invert">{vehicle.history}</p>
		</div>
	{/if}
</header>

<!-- Generaciones -->
<section class="mt-10">
	<h2 class="section-title mb-5">{$t.models.generations}</h2>

	{#if generations.length}
		<div class="space-y-5">
			{#each generations as gen, i (gen.name ?? i)}
				<GenerationCard {gen} />
			{/each}
		</div>
	{:else}
		<p class="surface p-6 text-gray-500 dark:text-gray-400">—</p>
	{/if}
</section>
