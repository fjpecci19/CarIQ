<script lang="ts">
	import { page } from '$app/state';
	import { t } from '$lib/i18n';
</script>

<section class="grid place-items-center py-20 text-center">
	<p class="text-7xl font-black text-emerald-600/80 dark:text-sky-500/80">{page.status}</p>
	<h1 class="mt-4 text-2xl font-bold">{page.error?.message ?? $t.common.notFound}</h1>
	<a href="/" class="btn-primary mt-6">{$t.common.backHome}</a>
</section>
