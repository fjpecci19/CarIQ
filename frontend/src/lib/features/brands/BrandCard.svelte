<script lang="ts">
	import type { Brand } from './types';
	import { t } from '$lib/i18n';

	let { brand }: { brand: Brand } = $props();
</script>

<div class="surface card-hover flex h-full flex-col p-5">
	<div class="flex items-start gap-3">
		<!-- Logo o inicial (logoUrl viene vacío en el backend actual) -->
		{#if brand.logoUrl}
			<img src={brand.logoUrl} alt={brand.name} class="size-12 rounded-xl object-contain" />
		{:else}
			<span
				class="grid size-12 shrink-0 place-items-center rounded-xl bg-linear-to-br from-emerald-600/90 to-red-600/90 text-lg font-black text-white dark:from-sky-500 dark:to-blue-600"
			>
				{brand.name.charAt(0)}
			</span>
		{/if}
		<div class="min-w-0 flex-1">
			<h3 class="truncate text-lg font-bold tracking-tight">{brand.name}</h3>
			{#if brand.country}
				<p class="text-sm text-gray-500 dark:text-gray-400">{brand.country}</p>
			{/if}
		</div>
		{#if brand.active !== undefined}
			<span
				class="chip"
				class:!text-emerald-700={brand.active}
				class:!border-emerald-500={brand.active}
			>
				{brand.active ? $t.brands.active : $t.brands.inactive}
			</span>
		{/if}
	</div>

	<!-- Meta -->
	<dl class="mt-4 space-y-1 text-sm">
		{#if brand.foundedYear}
			<div class="flex justify-between gap-2">
				<dt class="text-gray-500 dark:text-gray-400">{$t.brands.founded}</dt>
				<dd class="font-medium">{brand.foundedYear}</dd>
			</div>
		{/if}
		{#if brand.founder}
			<div class="flex justify-between gap-2">
				<dt class="text-gray-500 dark:text-gray-400">{$t.brands.founder}</dt>
				<dd class="truncate text-right font-medium">{brand.founder}</dd>
			</div>
		{/if}
	</dl>

	{#if brand.history}
		<p class="mt-3 line-clamp-3 text-sm text-gray-600 dark:text-gray-300">{brand.history}</p>
	{/if}

	{#if brand.vehicleTypes?.length}
		<div class="mt-3 flex flex-wrap gap-1.5">
			{#each brand.vehicleTypes as vt (vt)}
				<span class="chip">{$t.types[vt]}</span>
			{/each}
		</div>
	{/if}

	<div class="mt-5 pt-1">
		<a href={`/marcas/${brand.id}`} class="btn-primary w-full">{$t.brands.viewModels}</a>
	</div>
</div>
