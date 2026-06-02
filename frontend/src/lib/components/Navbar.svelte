<script lang="ts">
	import { page } from '$app/state';
	import { t } from '$lib/i18n';
	import ThemeToggle from './ThemeToggle.svelte';
	import LanguageSelector from './LanguageSelector.svelte';

	let mobileOpen = $state(false);

	const links = $derived([
		{ href: '/marcas', label: $t.nav.brands },
		{ href: '/modelos', label: $t.nav.models }
	]);

	function isActive(href: string): boolean {
		return page.url.pathname === href || page.url.pathname.startsWith(href + '/');
	}
</script>

<header class="bar sticky top-0 z-40 border-b">
	<nav class="mx-auto flex max-w-6xl items-center gap-4 px-4 py-3">
		<!-- Logo -->
		<a href="/" class="flex items-center gap-2" onclick={() => (mobileOpen = false)}>
			<span
				class="grid size-8 place-items-center rounded-lg bg-linear-to-br from-emerald-600 to-red-600 text-sm font-black text-white dark:from-sky-500 dark:to-blue-600"
			>
				C
			</span>
			<span class="text-lg font-extrabold tracking-tight">
				Car<span class="text-emerald-700 dark:text-sky-400">IQ</span>
			</span>
		</a>

		<!-- Links desktop -->
		<ul class="ml-4 hidden items-center gap-1 sm:flex">
			{#each links as link (link.href)}
				<li>
					<a
						href={link.href}
						class="rounded-full px-3 py-2 text-sm font-medium transition hover:bg-gray-100 dark:hover:bg-white/10"
						class:text-emerald-700={isActive(link.href)}
						class:dark:text-sky-400={isActive(link.href)}
					>
						{link.label}
					</a>
				</li>
			{/each}
		</ul>

		<div class="ml-auto flex items-center gap-1">
			<LanguageSelector />
			<ThemeToggle />
			<!-- Botón menú mobile -->
			<button
				type="button"
				class="btn-ghost !px-2.5 sm:hidden"
				onclick={() => (mobileOpen = !mobileOpen)}
				aria-label="Menú"
				aria-expanded={mobileOpen}
			>
				<svg class="size-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
					{#if mobileOpen}
						<path stroke-linecap="round" d="M6 6l12 12M18 6 6 18" />
					{:else}
						<path stroke-linecap="round" d="M4 7h16M4 12h16M4 17h16" />
					{/if}
				</svg>
			</button>
		</div>
	</nav>

	<!-- Menú mobile -->
	{#if mobileOpen}
		<ul class="border-t border-gray-200 px-4 py-2 sm:hidden dark:border-white/10">
			{#each links as link (link.href)}
				<li>
					<a
						href={link.href}
						onclick={() => (mobileOpen = false)}
						class="block rounded-lg px-3 py-2.5 font-medium hover:bg-gray-100 dark:hover:bg-white/10"
						class:text-emerald-700={isActive(link.href)}
						class:dark:text-sky-400={isActive(link.href)}
					>
						{link.label}
					</a>
				</li>
			{/each}
		</ul>
	{/if}
</header>
