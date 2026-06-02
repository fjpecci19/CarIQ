<script lang="ts">
	// Input de búsqueda reutilizable. `value` es bindable desde la página.
	let { value = $bindable(''), placeholder = '' }: { value?: string; placeholder?: string } =
		$props();
</script>

<div class="relative">
	<svg
		class="pointer-events-none absolute top-1/2 left-3.5 size-4 -translate-y-1/2 text-gray-400"
		viewBox="0 0 24 24"
		fill="none"
		stroke="currentColor"
		stroke-width="2"
	>
		<circle cx="11" cy="11" r="7" />
		<path stroke-linecap="round" d="m20 20-3.5-3.5" />
	</svg>
	<input
		type="search"
		bind:value
		{placeholder}
		class="w-full rounded-full border border-gray-200 bg-white py-2.5 pr-4 pl-10 text-sm transition outline-none placeholder:text-gray-400 focus:border-emerald-500 dark:border-white/10 dark:bg-white/5 dark:focus:border-sky-400"
	/>
</div>
