<script lang="ts">
	import type { PageData } from './$types';
	import { t } from '$lib/i18n';
	import Carousel from '$lib/components/Carousel.svelte';
	import VehicleCard from '$lib/features/vehicles/VehicleCard.svelte';

	let { data }: { data: PageData } = $props();
</script>

<svelte:head><title>CarIQ — {$t.home.heroEyebrow}</title></svelte:head>

<!-- Hero -->
<section class="relative overflow-hidden rounded-3xl px-6 py-16 text-center sm:px-10 sm:py-24">
	<!-- glow decorativo -->
	<div
		class="pointer-events-none absolute inset-0 -z-10 bg-linear-to-br from-emerald-600/5 via-transparent to-red-600/5 dark:from-sky-500/10 dark:to-blue-700/10"
	></div>

	<p class="text-sm font-semibold tracking-widest text-emerald-700 uppercase dark:text-sky-400">
		{$t.home.heroEyebrow}
	</p>
	<h1 class="mx-auto mt-4 max-w-3xl text-4xl font-black tracking-tight sm:text-6xl">
		{$t.home.heroTitle}
	</h1>
	<p class="mx-auto mt-5 max-w-2xl text-lg text-gray-600 dark:text-gray-300">
		{$t.home.heroSubtitle}
	</p>

	<div class="mt-8 flex flex-wrap items-center justify-center gap-3">
		<a href="/marcas" class="btn-primary">{$t.home.ctaBrands}</a>
		<a href="/modelos" class="btn-outline">{$t.home.ctaModels}</a>
	</div>

	<!-- stats -->
	<div class="mt-10 flex items-center justify-center gap-8 text-sm">
		<div>
			<p class="text-3xl font-black text-emerald-700 dark:text-sky-400">{data.brandCount}</p>
			<p class="text-gray-500 dark:text-gray-400">{$t.nav.brands}</p>
		</div>
		<div class="h-10 w-px bg-gray-200 dark:bg-white/10"></div>
		<div>
			<p class="text-3xl font-black text-red-600 dark:text-blue-400">{data.vehicleCount}</p>
			<p class="text-gray-500 dark:text-gray-400">{$t.nav.models}</p>
		</div>
	</div>
</section>

<!-- Carrusel: uno por marca -->
<section class="mt-14">
	<div class="mb-5 flex items-end justify-between gap-4">
		<div>
			<h2 class="section-title">{$t.home.carouselTitle}</h2>
			<p class="mt-1 text-gray-500 dark:text-gray-400">{$t.home.carouselSubtitle}</p>
			<div class="accent-rule mt-3"></div>
		</div>
	</div>

	<Carousel>
		{#each data.featured as item (item.vehicle.id)}
			<div class="w-72 shrink-0 snap-start">
				<VehicleCard vehicle={item.vehicle} brandName={item.brand.name} />
			</div>
		{/each}
	</Carousel>
</section>
