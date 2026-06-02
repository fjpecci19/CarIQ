<script lang="ts">
	import { lang, type Lang } from '$lib/i18n';

	let open = $state(false);
	const options: { code: Lang; label: string }[] = [
		{ code: 'es', label: 'ES' },
		{ code: 'en', label: 'EN' }
	];

	function pick(code: Lang) {
		lang.set(code);
		open = false;
	}
</script>

<div class="relative">
	<button
		type="button"
		onclick={() => (open = !open)}
		class="btn-ghost !px-3"
		aria-haspopup="listbox"
		aria-expanded={open}
		aria-label="Seleccionar idioma"
	>
		<svg class="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
			<circle cx="12" cy="12" r="9" />
			<path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18" />
		</svg>
		<span class="text-sm font-semibold">{$lang.toUpperCase()}</span>
	</button>

	{#if open}
		<!-- cierra al clickear fuera -->
		<button
			class="fixed inset-0 z-10 cursor-default"
			onclick={() => (open = false)}
			aria-hidden="true"
		></button>
		<ul
			class="surface absolute right-0 z-20 mt-2 w-28 overflow-hidden p-1 shadow-xl"
			role="listbox"
		>
			{#each options as o (o.code)}
				<li>
					<button
						type="button"
						onclick={() => pick(o.code)}
						class="flex w-full items-center justify-between rounded-lg px-3 py-2 text-sm hover:bg-gray-100 dark:hover:bg-white/10"
						class:font-bold={$lang === o.code}
						role="option"
						aria-selected={$lang === o.code}
					>
						{o.label}
						{#if $lang === o.code}
							<span class="text-emerald-600 dark:text-sky-400">●</span>
						{/if}
					</button>
				</li>
			{/each}
		</ul>
	{/if}
</div>
