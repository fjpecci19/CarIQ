<script lang="ts">
	import type { Snippet } from 'svelte';

	// Carrusel = scroll horizontal con CSS snap + flechas. Sin librerías.
	let { children }: { children: Snippet } = $props();

	let track: HTMLDivElement;

	function scroll(dir: 1 | -1) {
		track?.scrollBy({ left: dir * Math.min(track.clientWidth * 0.8, 600), behavior: 'smooth' });
	}
</script>

<div class="group relative">
	<div
		bind:this={track}
		class="flex snap-x snap-mandatory [scrollbar-width:thin] gap-4 overflow-x-auto pb-4"
	>
		{@render children()}
	</div>

	<!-- Flechas (ocultas en mobile, donde se hace swipe) -->
	<button
		type="button"
		onclick={() => scroll(-1)}
		class="surface absolute top-1/2 left-0 hidden size-10 -translate-y-1/2 place-items-center rounded-full shadow-lg sm:grid"
		aria-label="Anterior"
	>
		<svg class="size-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
			<path stroke-linecap="round" stroke-linejoin="round" d="M15 6l-6 6 6 6" />
		</svg>
	</button>
	<button
		type="button"
		onclick={() => scroll(1)}
		class="surface absolute top-1/2 right-0 hidden size-10 -translate-y-1/2 place-items-center rounded-full shadow-lg sm:grid"
		aria-label="Siguiente"
	>
		<svg class="size-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
			<path stroke-linecap="round" stroke-linejoin="round" d="M9 6l6 6-6 6" />
		</svg>
	</button>
</div>
