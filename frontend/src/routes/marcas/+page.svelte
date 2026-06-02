<script lang="ts">
	import type { PageData } from './$types';
	import { t } from '$lib/i18n';
	import BrandCard from '$lib/features/brands/BrandCard.svelte';
	import SearchBar from '$lib/components/SearchBar.svelte';

	let { data }: { data: PageData } = $props();

	let query = $state('');

	// Filtra por nombre o país (sin distinguir mayúsculas/acentos básicos).
	const filtered = $derived.by(() => {
		const q = query.trim().toLowerCase();
		if (!q) return data.brands;
		return data.brands.filter((b) => [b.name, b.country].some((f) => f?.toLowerCase().includes(q)));
	});
</script>

<svelte:head><title>{$t.brands.title} — CarIQ</title></svelte:head>

<header class="mb-6">
	<h1 class="section-title">{$t.brands.title}</h1>
	<p class="mt-1 text-gray-500 dark:text-gray-400">{$t.brands.subtitle}</p>
	<div class="accent-rule mt-3"></div>
</header>

<div class="mb-7 max-w-md">
	<SearchBar bind:value={query} placeholder={$t.brands.searchPlaceholder} />
</div>

{#if filtered.length}
	<div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
		{#each filtered as brand (brand.id)}
			<BrandCard {brand} />
		{/each}
	</div>
{:else}
	<p class="surface p-6 text-center text-gray-500 dark:text-gray-400">{$t.common.noResults}</p>
{/if}
