class CountryData {
  static const List<String> continents = [
    "Africa",
    "Americas",
    "Asia",
    "Europe",
    "Oceania"
  ];

  static const List<String> africanSubregions = [
    "Eastern Africa",
    "Western Africa",
    "Northern Africa",
    "Southern Africa",
    "Middle Africa"
  ];

  static const List<String> favoriteContinents = [
    "Africa",
    "Asia",
    "Europe",
    "Oceania"
  ];

  static const List<String> favoriteCountries = [
    "Ethiopia",
    "India",
    "China",
    "Mexico"
  ];

  static const Map<String, List<String>> ethiopianRegions = {
    "Amhara": ["Gondar", "Gojjam", "Wollo", "Shoa", "Bahir Dar"],
    "Tigray": ["Mekele", "Axum", "Adwa", "Shire", "Humera"],
    "Oromia": ["Adama", "Jimma", "Bale", "Borana", "Harar"],
    "SNNPR": ["Hawassa", "Wolayita", "Gamo", "Gofa", "Konso"],
    "Afar": ["Semera", "Awash", "Dubti", "Logiya"],
    "Somali": ["Jijiga", "Gode", "Kebri Dahar", "Degehabur"],
    "Benishangul-Gumuz": ["Asosa", "Metekel", "Kemash"],
    "Gambela": ["Gambela", "Itang", "Gog"],
    "Addis Ababa": ["Central", "Eastern", "Western", "Southern", "Northern"],
    "Dire Dawa": ["City Zone 1", "City Zone 2", "Rural Areas"]
  };

  static const Map<String, Map<String, List<String>>> countryRegions = {
    "United States": {
      "Northeast": ["New York", "Massachusetts", "Pennsylvania", "New Jersey"],
      "Midwest": ["Illinois", "Ohio", "Michigan", "Indiana"],
      "South": ["Texas", "Florida", "Georgia", "North Carolina"],
      "West": ["California", "Washington", "Colorado", "Arizona"]
    },
    "India": {
      "North": ["Uttar Pradesh", "Punjab", "Haryana", "Delhi"],
      "South": ["Tamil Nadu", "Karnataka", "Kerala", "Andhra Pradesh"],
      "East": ["West Bengal", "Bihar", "Odisha", "Jharkhand"],
      "West": ["Maharashtra", "Gujarat", "Rajasthan", "Goa"]
    },
    "China": {
      "North": ["Beijing", "Tianjin", "Hebei", "Shanxi"],
      "East": ["Shanghai", "Jiangsu", "Zhejiang", "Anhui"],
      "South": ["Guangdong", "Fujian", "Hainan", "Guangxi"],
      "West": ["Sichuan", "Yunnan", "Gansu", "Qinghai"]
    },
    "Brazil": {
      "North": ["Amazonas", "Pará", "Rondônia", "Acre"],
      "Northeast": ["Bahia", "Pernambuco", "Ceará", "Maranhão"],
      "Central-West": ["Goiás", "Mato Grosso", "Distrito Federal"],
      "Southeast": ["São Paulo", "Rio de Janeiro", "Minas Gerais", "Espírito Santo"],
      "South": ["Rio Grande do Sul", "Santa Catarina", "Paraná"]
    },
    "Germany": {
      "North": ["Schleswig-Holstein", "Hamburg", "Lower Saxony", "Bremen"],
      "West": ["North Rhine-Westphalia", "Rhineland-Palatinate", "Saarland"],
      "South": ["Bavaria", "Baden-Württemberg", "Hesse"],
      "East": ["Berlin", "Brandenburg", "Saxony", "Saxony-Anhalt", "Thuringia"]
    }
  };

  static List<String> get dropdownFavorites => [...favoriteContinents, ...favoriteCountries, ...africanSubregions];
}