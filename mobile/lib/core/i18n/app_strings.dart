/// Idiomas soportados (mismo set que el frontend web).
enum AppLang {
  es('es', 'Español'),
  en('en', 'English');

  const AppLang(this.code, this.label);

  final String code;
  final String label;

  static AppLang fromCode(String? code) =>
      AppLang.values.firstWhere((l) => l.code == code, orElse: () => AppLang.es);
}

/// Todos los textos de la UI en un solo lugar (espejo de translations.ts del
/// frontend). No traduce los datos del backend, solo la interfaz.
///
/// Se usa con la instancia del idioma activo: `strings.brandsTitle`.
class AppStrings {
  const AppStrings({
    required this.navHome,
    required this.navBrands,
    required this.navModels,
    required this.homeHeroSubtitle,
    required this.homeFeatured,
    required this.homeFeaturedEmpty,
    required this.brandsTitle,
    required this.brandsEmpty,
    required this.detailHistory,
    required this.detailModels,
    required this.brandModelsEmpty,
    required this.brandModelsError,
    required this.vehiclesTitle,
    required this.vehiclesEmpty,
    required this.detailGenerations,
    required this.specPrice,
    required this.specTransmission,
    required this.specEngine,
    required this.specConsumption,
    required this.specBody,
    required this.typeCar,
    required this.typeMotorcycle,
    required this.typeTruck,
    required this.typeUnknown,
    required this.commonRetry,
    required this.commonYes,
    required this.commonNo,
    required this.errorTimeout,
    required this.errorConnection,
    required this.errorNotFound,
    required this.errorFormat,
    required this.errorUnknown,
    required this.toPresent,
    required this.foundedInLabel,
    required this.sinceLabel,
    required this.serverErrorTemplate,
  });

  // Navegación / tabs
  final String navHome;
  final String navBrands;
  final String navModels;

  // Home
  final String homeHeroSubtitle;
  final String homeFeatured;
  final String homeFeaturedEmpty;

  // Marcas
  final String brandsTitle;
  final String brandsEmpty;
  final String detailHistory;
  final String detailModels;
  final String brandModelsEmpty;
  final String brandModelsError;

  // Modelos
  final String vehiclesTitle;
  final String vehiclesEmpty;
  final String detailGenerations;

  // Specs
  final String specPrice;
  final String specTransmission;
  final String specEngine;
  final String specConsumption;
  final String specBody;

  // Tipos de vehículo
  final String typeCar;
  final String typeMotorcycle;
  final String typeTruck;
  final String typeUnknown;

  // Comunes
  final String commonRetry;
  final String commonYes;
  final String commonNo;

  // Errores
  final String errorTimeout;
  final String errorConnection;
  final String errorNotFound;
  final String errorFormat;
  final String errorUnknown;

  // Plantillas parametrizadas (se completan con valores)
  final String toPresent; // "presente" / "present"
  final String foundedInLabel; // "Fundada en" / "Founded in"
  final String sinceLabel; // "desde" / "since"
  final String serverErrorTemplate; // contiene {code}

  String foundedIn(int year) => '$foundedInLabel $year';
  String since(int year) => '$sinceLabel $year';

  /// Rango de años legible manejando nulls: "2018 – 2022", "2018 – presente",
  /// "2018", o "" si no hay datos.
  String yearRange(int? start, int? end) {
    if (start == null && end == null) return '';
    final startStr = start?.toString() ?? '?';
    if (end == null) return '$startStr – $toPresent';
    if (start == end) return startStr;
    return '$startStr – $end';
  }

  /// "El servidor respondió con un error (500)."
  String serverError(int? code) =>
      serverErrorTemplate.replaceFirst('{code}', code?.toString() ?? '?');
}

const _es = AppStrings(
  navHome: 'Inicio',
  navBrands: 'Marcas',
  navModels: 'Modelos',
  homeHeroSubtitle:
      'Explorá marcas y modelos de autos, motos y camiones, con su historia y especificaciones.',
  homeFeatured: 'Destacados',
  homeFeaturedEmpty: 'Sin destacados por ahora.',
  brandsTitle: 'Marcas',
  brandsEmpty: 'No hay marcas para mostrar.',
  detailHistory: 'Historia',
  detailModels: 'Modelos',
  brandModelsEmpty: 'Esta marca todavía no tiene modelos cargados.',
  brandModelsError: 'No se pudieron cargar los modelos.',
  vehiclesTitle: 'Modelos',
  vehiclesEmpty: 'No hay modelos para mostrar.',
  detailGenerations: 'Generaciones',
  specPrice: 'Precio',
  specTransmission: 'Transmisión',
  specEngine: 'Motor',
  specConsumption: 'Consumo',
  specBody: 'Carrocería',
  typeCar: 'Auto',
  typeMotorcycle: 'Moto',
  typeTruck: 'Camión',
  typeUnknown: 'Vehículo',
  commonRetry: 'Reintentar',
  commonYes: 'Sí',
  commonNo: 'No',
  errorTimeout:
      'La conexión tardó demasiado. Verificá que el backend esté corriendo.',
  errorConnection:
      'No se pudo conectar con el servidor. Revisá la URL del backend y tu conexión.',
  errorNotFound: 'No se encontró el recurso solicitado.',
  errorFormat: 'No se pudo interpretar la respuesta del servidor.',
  errorUnknown: 'Ocurrió un error inesperado.',
  toPresent: 'presente',
  foundedInLabel: 'Fundada en',
  sinceLabel: 'desde',
  serverErrorTemplate: 'El servidor respondió con un error ({code}).',
);

const _en = AppStrings(
  navHome: 'Home',
  navBrands: 'Brands',
  navModels: 'Models',
  homeHeroSubtitle:
      'Explore brands and models of cars, motorcycles and trucks, with their history and specs.',
  homeFeatured: 'Featured',
  homeFeaturedEmpty: 'No featured items yet.',
  brandsTitle: 'Brands',
  brandsEmpty: 'No brands to show.',
  detailHistory: 'History',
  detailModels: 'Models',
  brandModelsEmpty: 'This brand has no models loaded yet.',
  brandModelsError: 'Could not load the models.',
  vehiclesTitle: 'Models',
  vehiclesEmpty: 'No models to show.',
  detailGenerations: 'Generations',
  specPrice: 'Price',
  specTransmission: 'Transmission',
  specEngine: 'Engine',
  specConsumption: 'Consumption',
  specBody: 'Body',
  typeCar: 'Car',
  typeMotorcycle: 'Motorcycle',
  typeTruck: 'Truck',
  typeUnknown: 'Vehicle',
  commonRetry: 'Retry',
  commonYes: 'Yes',
  commonNo: 'No',
  errorTimeout:
      'The connection timed out. Make sure the backend is running.',
  errorConnection:
      'Could not connect to the server. Check the backend URL and your connection.',
  errorNotFound: 'The requested resource was not found.',
  errorFormat: 'Could not parse the server response.',
  errorUnknown: 'An unexpected error occurred.',
  toPresent: 'present',
  foundedInLabel: 'Founded in',
  sinceLabel: 'since',
  serverErrorTemplate: 'The server returned an error ({code}).',
);

/// Tabla de traducciones por idioma.
const Map<AppLang, AppStrings> appStringsByLang = {
  AppLang.es: _es,
  AppLang.en: _en,
};
