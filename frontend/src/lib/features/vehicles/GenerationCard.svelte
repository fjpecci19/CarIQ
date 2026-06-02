<script lang="ts">
	import type { Generation } from './types';
	import { specEntries, yearRange, formatPrice } from './utils';
	import { t } from '$lib/i18n';

	let { gen }: { gen: Generation } = $props();

	const engine = $derived(specEntries(gen.engine));
	const body = $derived(specEntries(gen.body));
	const consumption = $derived(specEntries(gen.consumption));
	const price = $derived(formatPrice(gen.priceUsd));
	const years = $derived(yearRange(gen));
</script>

{#snippet group(title: string, items: { label: string; value: string | number }[])}
	{#if items.length}
		<div>
			<h4
				class="mb-2 text-xs font-semibold tracking-wide text-gray-500 uppercase dark:text-gray-400"
			>
				{title}
			</h4>
			<dl class="space-y-1.5">
				{#each items as item (item.label)}
					<div class="flex justify-between gap-3 text-sm">
						<dt class="text-gray-500 dark:text-gray-400">{item.label}</dt>
						<dd class="text-right font-medium">{item.value}</dd>
					</div>
				{/each}
			</dl>
		</div>
	{/if}
{/snippet}

<article class="surface p-5 sm:p-6">
	<header
		class="flex flex-wrap items-center justify-between gap-3 border-b border-gray-200 pb-4 dark:border-white/10"
	>
		<div>
			<h3 class="text-lg font-bold tracking-tight">{gen.name ?? 'Generación'}</h3>
			{#if years}
				<p class="text-sm text-gray-500 dark:text-gray-400">{years}</p>
			{/if}
		</div>
		{#if price}
			<span
				class="rounded-full bg-emerald-600/10 px-3 py-1 text-sm font-bold text-emerald-700 dark:bg-sky-500/15 dark:text-sky-300"
			>
				{price}
			</span>
		{/if}
	</header>

	{#if gen.transmission}
		<p class="mt-4 text-sm">
			<span class="text-gray-500 dark:text-gray-400">{$t.spec.transmission}:</span>
			<span class="font-medium">{gen.transmission}</span>
		</p>
	{/if}

	<div class="mt-4 grid gap-6 sm:grid-cols-3">
		{@render group($t.spec.engine, engine)}
		{@render group($t.spec.consumption, consumption)}
		{@render group($t.spec.body, body)}
	</div>
</article>
