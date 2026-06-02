<script lang="ts">
	import { t } from '$lib/i18n';
	const year = new Date().getFullYear();
</script>

<footer class="bar mt-16 border-t">
	<div
		class="mx-auto flex max-w-6xl flex-col items-center justify-between gap-3 px-4 py-6 sm:flex-row"
	>
		<div class="flex items-center gap-2">
			<span
				class="grid size-7 place-items-center rounded-md bg-linear-to-br from-emerald-600 to-red-600 text-xs font-black text-white dark:from-sky-500 dark:to-blue-600"
			>
				C
			</span>
			<div class="text-sm">
				<p class="font-bold">CarIQ</p>
				<p class="text-gray-500 dark:text-gray-400">{$t.footer.tagline}</p>
			</div>
		</div>

		<nav class="flex items-center gap-4 text-sm">
			<a href="/" class="link-accent">CarIQ</a>
			<a href="/marcas" class="link-accent">{$t.nav.brands}</a>
			<a href="/modelos" class="link-accent">{$t.nav.models}</a>
		</nav>

		<p class="text-center text-xs text-gray-500 sm:text-right dark:text-gray-400">
			© {year} CarIQ · {$t.footer.rights}
		</p>
	</div>
</footer>
