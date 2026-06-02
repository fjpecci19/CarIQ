import { writable, derived } from 'svelte/store';
import { browser } from '$app/environment';
import { translations, type Lang } from './translations';

const STORAGE_KEY = 'cariq-lang';

function initialLang(): Lang {
	if (!browser) return 'es';
	const saved = localStorage.getItem(STORAGE_KEY);
	return saved === 'en' || saved === 'es' ? saved : 'es';
}

/** Idioma actual (persiste en localStorage). */
export const lang = writable<Lang>(initialLang());

if (browser) {
	lang.subscribe((value) => localStorage.setItem(STORAGE_KEY, value));
}

/** Textos del idioma activo: usar como `$t.nav.brands` en los componentes. */
export const t = derived(lang, ($lang) => translations[$lang]);

export { type Lang } from './translations';
