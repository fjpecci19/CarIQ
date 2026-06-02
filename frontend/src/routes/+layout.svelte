<script lang="ts">
	import './layout.css';
	import favicon from '$lib/assets/favicon.svg';
	import Navbar from '$lib/components/Navbar.svelte';
	import BottomBar from '$lib/components/BottomBar.svelte';

	let { children } = $props();
</script>

<svelte:head><link rel="icon" href={favicon} /></svelte:head>

<div class="app-bg flex min-h-screen flex-col">
	<Navbar />
	<main class="mx-auto w-full max-w-6xl flex-1 px-4 py-8 sm:py-10">
		{@render children()}
	</main>
	<BottomBar />
</div>
