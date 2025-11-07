class Country {
  final String commonName;
  final String officialName;
  final List<String> capital;
  final int population;
  final Map<String, String> languages;
  final String flag;
  final String region;
  final String subregion;
  final double area;
  final Map<String, dynamic> currencies;
  final List<String> timezones;
  final Map<String, dynamic> idd;

  Country({
    required this.commonName,
    required this.officialName,
    required this.capital,
    required this.population,
    required this.languages,
    required this.flag,
    required this.region,
    required this.subregion,
    required this.area,
    required this.currencies,
    required this.timezones,
    required this.idd,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      commonName: json['name']['common'] ?? '',
      officialName: json['name']['official'] ?? '',
      capital: List<String>.from(json['capital'] ?? []),
      population: json['population'] ?? 0,
      languages: Map<String, String>.from(json['languages'] ?? {}),
      flag: json['flags']['png'] ?? '',
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      area: (json['area'] ?? 0).toDouble(),
      currencies: Map<String, dynamic>.from(json['currencies'] ?? {}),
      timezones: List<String>.from(json['timezones'] ?? []),
      idd: Map<String, dynamic>.from(json['idd'] ?? {}),
    );
  }
}