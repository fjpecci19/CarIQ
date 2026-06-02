import { writable } from 'svelte/store';
import { browser } from '$app/environment';

export type Theme = 'dark' | 'light';

const STORAGE_KEY = 'cariq-theme';

function initialTheme(): Theme {
	if (!browser) return 'dark'; // default: oscuro
	const saved = localStorage.getItem(STORAGE_KEY);
	return saved === 'light' || saved === 'dark' ? saved : 'dark';
}

export const theme = writable<Theme>(initialTheme());

if (browser) {
	theme.subscribe((value) => {
		localStorage.setItem(STORAGE_KEY, value);
		document.documentElement.classList.toggle('dark', value === 'dark');
	});
}

export function toggleTheme() {
	theme.update((t) => (t === 'dark' ? 'light' : 'dark'));
}
