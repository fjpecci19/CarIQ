// Todos los textos de la UI en un solo lugar, listos para i18n futuro.
// Cambiar el idioma alterna estos textos (no traduce los datos del backend,
// que vienen en español). Si más adelante se quiere una librería de i18n,
// las claves ya están separadas por sección.

export type Lang = 'es' | 'en';

export const translations = {
	es: {
		nav: { brands: 'Marcas', models: 'Modelos' },
		home: {
			heroEyebrow: 'Tu catálogo de vehículos',
			heroTitle: 'Encontrá el vehículo de tus sueños',
			heroSubtitle:
				'Explorá marcas legendarias y modelos icónicos. Especificaciones, generaciones e historia, todo en un solo lugar.',
			ctaBrands: 'Explorar marcas',
			ctaModels: 'Ver todos los modelos',
			carouselTitle: 'Uno por marca',
			carouselSubtitle: 'Un vistazo a lo mejor de cada fabricante'
		},
		brands: {
			title: 'Marcas',
			subtitle: 'Todos los fabricantes del catálogo',
			country: 'País',
			founded: 'Fundación',
			founder: 'Fundador',
			vehicleTypes: 'Tipos de vehículo',
			viewModels: 'Ver modelos',
			active: 'Activa',
			inactive: 'Inactiva',
			history: 'Historia',
			modelsOf: 'Modelos de',
			noModels: 'No hay modelos cargados para esta marca.',
			searchPlaceholder: 'Buscar marca o país…'
		},
		models: {
			title: 'Modelos',
			subtitle: 'Todos los vehículos del catálogo',
			brand: 'Marca',
			category: 'Categoría',
			type: 'Tipo',
			tags: 'Etiquetas',
			history: 'Historia',
			generations: 'Generaciones',
			viewDetail: 'Ver detalle',
			from: 'Desde',
			backToBrand: 'Ver marca',
			searchPlaceholder: 'Buscar modelo, marca o categoría…',
			all: 'Todos'
		},
		spec: {
			engine: 'Motor',
			body: 'Carrocería',
			consumption: 'Consumo',
			transmission: 'Transmisión',
			price: 'Precio'
		},
		types: { car: 'Auto', motorcycle: 'Moto', truck: 'Camión' },
		footer: {
			tagline: 'Catálogo de vehículos — autos, motos y camiones.',
			madeWith: 'Hecho con SvelteKit + Tailwind',
			rights: 'Proyecto educativo. Datos con fines demostrativos.'
		},
		common: { notFound: 'No encontrado', backHome: 'Volver al inicio', noResults: 'Sin resultados' }
	},
	en: {
		nav: { brands: 'Brands', models: 'Models' },
		home: {
			heroEyebrow: 'Your vehicle catalog',
			heroTitle: 'Find the vehicle of your dreams',
			heroSubtitle:
				'Explore legendary brands and iconic models. Specs, generations and history, all in one place.',
			ctaBrands: 'Explore brands',
			ctaModels: 'See all models',
			carouselTitle: 'One per brand',
			carouselSubtitle: 'A glimpse of the best from each maker'
		},
		brands: {
			title: 'Brands',
			subtitle: 'Every maker in the catalog',
			country: 'Country',
			founded: 'Founded',
			founder: 'Founder',
			vehicleTypes: 'Vehicle types',
			viewModels: 'View models',
			active: 'Active',
			inactive: 'Inactive',
			history: 'History',
			modelsOf: 'Models by',
			noModels: 'No models loaded for this brand.',
			searchPlaceholder: 'Search brand or country…'
		},
		models: {
			title: 'Models',
			subtitle: 'Every vehicle in the catalog',
			brand: 'Brand',
			category: 'Category',
			type: 'Type',
			tags: 'Tags',
			history: 'History',
			generations: 'Generations',
			viewDetail: 'View detail',
			from: 'From',
			backToBrand: 'View brand',
			searchPlaceholder: 'Search model, brand or category…',
			all: 'All'
		},
		spec: {
			engine: 'Engine',
			body: 'Body',
			consumption: 'Consumption',
			transmission: 'Transmission',
			price: 'Price'
		},
		types: { car: 'Car', motorcycle: 'Motorcycle', truck: 'Truck' },
		footer: {
			tagline: 'Vehicle catalog — cars, motorcycles and trucks.',
			madeWith: 'Built with SvelteKit + Tailwind',
			rights: 'Educational project. Data for demo purposes.'
		},
		common: { notFound: 'Not found', backHome: 'Back home', noResults: 'No results' }
	}
} as const;

export type Translation = (typeof translations)['es'];
