import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../data/country_data.dart';
import '../widgets/country_card.dart';
import '../widgets/detail_card.dart';
import '../widgets/region_expandable.dart';
import '../widgets/search_section.dart';

class CountryContinentNetworkPage extends StatefulWidget {
  const CountryContinentNetworkPage({super.key});

  @override
  State<CountryContinentNetworkPage> createState() =>
      _CountryContinentNetworkPageState();
}

class _CountryContinentNetworkPageState
    extends State<CountryContinentNetworkPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> displayCountries = [];
  bool isLoading = false;
  String? selectedFavorite;
  bool showDefaultCountries = true;
  String currentSearchQuery = '';

  int? hoveredIndex;

  List<String> get suggestions => [...CountryData.dropdownFavorites, ...CountryData.continents, ...CountryData.africanSubregions];

  @override
  void initState() {
    super.initState();
    _loadDefaultCountries();
  }

  Future<void> _loadDefaultCountries() async {
    setState(() {
      isLoading = true;
      showDefaultCountries = true;
      currentSearchQuery = '';
    });

    try {
      final response = await http.get(
          Uri.parse('https://restcountries.com/v3.1/all?fields=name,capital,population,languages,flags,region,subregion,area,currencies,timezones,idd')
      );

      if (response.statusCode == 200) {
        final List<dynamic> allCountries = json.decode(response.body);
        setState(() {
          displayCountries = allCountries.take(8).toList();
        });
      } else {
        _createMockCountries();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading countries: $e');
      }
      _createMockCountries();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _createMockCountries() {
    List<Map<String, dynamic>> mockCountries = [
      {
        'name': {'common': 'United States', 'official': 'United States of America'},
        'capital': ['Washington D.C.'],
        'population': 331002651,
        'languages': {'eng': 'English'},
        'flags': {'png': 'https://flagcdn.com/w320/us.png'},
        'region': 'Americas',
        'subregion': 'North America',
        'area': 9372610.0,
        'currencies': {'USD': {'name': 'United States dollar', 'symbol': '\$'}},
        'timezones': ['UTC-12:00', 'UTC-11:00', 'UTC-10:00', 'UTC-09:00', 'UTC-08:00', 'UTC-07:00', 'UTC-06:00', 'UTC-05:00', 'UTC-04:00', 'UTC+10:00', 'UTC+12:00'],
        'idd': {'root': '+1', 'suffixes': ['']}
      },
      {
        'name': {'common': 'Canada', 'official': 'Canada'},
        'capital': ['Ottawa'],
        'population': 38005238,
        'languages': {'eng': 'English', 'fra': 'French'},
        'flags': {'png': 'https://flagcdn.com/w320/ca.png'},
        'region': 'Americas',
        'subregion': 'North America',
        'area': 9984670.0,
        'currencies': {'CAD': {'name': 'Canadian dollar', 'symbol': '\$'}},
        'timezones': ['UTC-08:00', 'UTC-07:00', 'UTC-06:00', 'UTC-05:00', 'UTC-04:00', 'UTC-03:30'],
        'idd': {'root': '+1', 'suffixes': ['']}
      },
      {
        'name': {'common': 'United Kingdom', 'official': 'United Kingdom of Great Britain and Northern Ireland'},
        'capital': ['London'],
        'population': 67215293,
        'languages': {'eng': 'English'},
        'flags': {'png': 'https://flagcdn.com/w320/gb.png'},
        'region': 'Europe',
        'subregion': 'Northern Europe',
        'area': 242900.0,
        'currencies': {'GBP': {'name': 'British pound', 'symbol': '£'}},
        'timezones': ['UTC-08:00', 'UTC-05:00', 'UTC-04:00', 'UTC-03:00', 'UTC-02:00', 'UTC+00:00', 'UTC+01:00', 'UTC+02:00', 'UTC+06:00'],
        'idd': {'root': '+4', 'suffixes': ['4']}
      },
      {
        'name': {'common': 'France', 'official': 'French Republic'},
        'capital': ['Paris'],
        'population': 67391582,
        'languages': {'fra': 'French'},
        'flags': {'png': 'https://flagcdn.com/w320/fr.png'},
        'region': 'Europe',
        'subregion': 'Western Europe',
        'area': 551695.0,
        'currencies': {'EUR': {'name': 'Euro', 'symbol': '€'}},
        'timezones': ['UTC-10:00', 'UTC-09:30', 'UTC-09:00', 'UTC-08:00', 'UTC-04:00', 'UTC-03:00', 'UTC+01:00', 'UTC+02:00', 'UTC+03:00', 'UTC+04:00', 'UTC+05:00', 'UTC+10:00', 'UTC+11:00', 'UTC+12:00'],
        'idd': {'root': '+3', 'suffixes': ['3']}
      },
      {
        'name': {'common': 'Germany', 'official': 'Federal Republic of Germany'},
        'capital': ['Berlin'],
        'population': 83240525,
        'languages': {'deu': 'German'},
        'flags': {'png': 'https://flagcdn.com/w320/de.png'},
        'region': 'Europe',
        'subregion': 'Western Europe',
        'area': 357114.0,
        'currencies': {'EUR': {'name': 'Euro', 'symbol': '€'}},
        'timezones': ['UTC+01:00'],
        'idd': {'root': '+4', 'suffixes': ['9']}
      },
      {
        'name': {'common': 'Japan', 'official': 'Japan'},
        'capital': ['Tokyo'],
        'population': 125836021,
        'languages': {'jpn': 'Japanese'},
        'flags': {'png': 'https://flagcdn.com/w320/jp.png'},
        'region': 'Asia',
        'subregion': 'Eastern Asia',
        'area': 377930.0,
        'currencies': {'JPY': {'name': 'Japanese yen', 'symbol': '¥'}},
        'timezones': ['UTC+09:00'],
        'idd': {'root': '+8', 'suffixes': ['1']}
      },
      {
        'name': {'common': 'Australia', 'official': 'Commonwealth of Australia'},
        'capital': ['Canberra'],
        'population': 25687041,
        'languages': {'eng': 'English'},
        'flags': {'png': 'https://flagcdn.com/w320/au.png'},
        'region': 'Oceania',
        'subregion': 'Australia and New Zealand',
        'area': 7692024.0,
        'currencies': {'AUD': {'name': 'Australian dollar', 'symbol': '\$'}},
        'timezones': ['UTC+05:00', 'UTC+06:30', 'UTC+07:00', 'UTC+08:00', 'UTC+09:30', 'UTC+10:00', 'UTC+10:30', 'UTC+11:00', 'UTC+11:30'],
        'idd': {'root': '+6', 'suffixes': ['1']}
      },
      {
        'name': {'common': 'Brazil', 'official': 'Federative Republic of Brazil'},
        'capital': ['Brasília'],
        'population': 212559409,
        'languages': {'por': 'Portuguese'},
        'flags': {'png': 'https://flagcdn.com/w320/br.png'},
        'region': 'Americas',
        'subregion': 'South America',
        'area': 8515767.0,
        'currencies': {'BRL': {'name': 'Brazilian real', 'symbol': 'R\$'}},
        'timezones': ['UTC-05:00', 'UTC-04:00', 'UTC-03:00', 'UTC-02:00'],
        'idd': {'root': '+5', 'suffixes': ['5']}
      }
    ];

    setState(() {
      displayCountries = mockCountries;
    });
  }

  Future<void> search(String query) async {
    query = query.trim();
    if (query.isEmpty) {
      setState(() {
        displayCountries = [];
        showDefaultCountries = true;
        currentSearchQuery = '';
      });
      _loadDefaultCountries();
      return;
    }

    setState(() {
      isLoading = true;
      displayCountries = [];
      showDefaultCountries = false;
      currentSearchQuery = query;
    });

    String url = '';

    // Check for African subregions first
    if (CountryData.africanSubregions.map((e) => e.toLowerCase()).contains(query.toLowerCase())) {
      // Search by African subregion
      url = 'https://restcountries.com/v3.1/subregion/${query.toLowerCase()}';
    } else if (CountryData.continents.map((e) => e.toLowerCase()).contains(query.toLowerCase())) {
      // Search by continent
      url = 'https://restcountries.com/v3.1/region/${query.toLowerCase()}';
    } else {
      // Search by country name
      url = 'https://restcountries.com/v3.1/name/${query.toLowerCase()}';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() => displayCountries = data);
      } else {
        setState(() => displayCountries = []);
      }
    } catch (e) {
      setState(() => displayCountries = []);
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showCountryDetails(dynamic country) {
    final name = country['name']['common'] ?? '';

    // Check if we have special regional data for this country
    if (name == 'Ethiopia' || CountryData.countryRegions.containsKey(name)) {
      _showCountryWithRegions(country);
      return;
    }

    final officialName = country['name']['official'] ?? '';
    final capital = country['capital'] != null
        ? (country['capital'] as List).join(', ')
        : 'N/A';
    final population = country['population'] != null
        ? (country['population'] as int).toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )
        : 'N/A';

    final languages = country['languages'] != null
        ? (country['languages'] as Map).values.join(', ')
        : 'N/A';

    final region = country['region'] ?? 'N/A';
    final subregion = country['subregion'] ?? 'N/A';
    final area = country['area'] != null ? '${country['area']} km²' : 'N/A';
    final flag = country['flags'] != null ? country['flags']['png'] : null;

    String currencies = 'N/A';
    if (country['currencies'] != null) {
      final currencyMap = country['currencies'] as Map;
      currencies = currencyMap.entries.map((entry) {
        final currencyData = entry.value as Map;
        return '${currencyData['name']} (${currencyData['symbol'] ?? ''})';
      }).join(', ');
    }

    final timezones = country['timezones'] != null
        ? (country['timezones'] as List).join(', ')
        : 'N/A';

    String callingCode = 'N/A';
    if (country['idd'] != null) {
      final idd = country['idd'] as Map;
      final root = idd['root'] ?? '';
      final suffixes = idd['suffixes'] != null ? (idd['suffixes'] as List).join('') : '';
      callingCode = '$root$suffixes';
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              backgroundColor: Colors.white,
              child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.85
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                                children: [
                                  if (flag != null)
                                    Container(
                                        width: 100,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.3),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4)
                                              )
                                            ]
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                                flag,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                      color: Colors.grey[200],
                                                      child: const Icon(Icons.flag, size: 40, color: Colors.blue)
                                                  );
                                                }
                                            )
                                        )
                                    ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                name,
                                                style: const TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue
                                                )
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                                officialName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis
                                            )
                                          ]
                                      )
                                  )
                                ]
                            )
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                    children: [
                                      DetailCard(icon: Icons.account_balance, title: 'Capital', value: capital),
                                      DetailCard(icon: Icons.people, title: 'Population', value: population),
                                      DetailCard(icon: Icons.language, title: 'Languages', value: languages),
                                      DetailCard(icon: Icons.phone, title: 'Calling Code', value: callingCode),
                                      DetailCard(icon: Icons.attach_money, title: 'Currencies', value: currencies),
                                      DetailCard(icon: Icons.public, title: 'Region', value: region),
                                      DetailCard(icon: Icons.location_on, title: 'Subregion', value: subregion),
                                      DetailCard(icon: Icons.square_foot, title: 'Area', value: area),
                                      DetailCard(icon: Icons.access_time, title: 'Timezones', value: timezones),
                                      const SizedBox(height: 20)
                                    ]
                                )
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.all(24),
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[700],
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        elevation: 4
                                    ),
                                    child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                )
                            )
                        )
                      ]
                  )
              )
          );
        }
    );
  }

  void _showCountryWithRegions(dynamic country) {
    final name = country['name']['common'] ?? '';
    final officialName = country['name']['official'] ?? '';
    final capital = country['capital'] != null
        ? (country['capital'] as List).join(', ')
        : 'N/A';
    final population = country['population'] != null
        ? (country['population'] as int).toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )
        : 'N/A';

    final languages = country['languages'] != null
        ? (country['languages'] as Map).values.join(', ')
        : 'N/A';

    final region = country['region'] ?? 'N/A';
    final subregion = country['subregion'] ?? 'N/A';
    final area = country['area'] != null ? '${country['area']} km²' : 'N/A';
    final flag = country['flags'] != null ? country['flags']['png'] : null;

    String currencies = 'N/A';
    if (country['currencies'] != null) {
      final currencyMap = country['currencies'] as Map;
      currencies = currencyMap.entries.map((entry) {
        final currencyData = entry.value as Map;
        return '${currencyData['name']} (${currencyData['symbol'] ?? ''})';
      }).join(', ');
    }

    final timezones = country['timezones'] != null
        ? (country['timezones'] as List).join(', ')
        : 'N/A';

    String callingCode = 'N/A';
    if (country['idd'] != null) {
      final idd = country['idd'] as Map;
      final root = idd['root'] ?? '';
      final suffixes = idd['suffixes'] != null ? (idd['suffixes'] as List).join('') : '';
      callingCode = '$root$suffixes';
    }

    // Get regions data
    final Map<String, List<String>> regions = name == 'Ethiopia'
        ? CountryData.ethiopianRegions
        : CountryData.countryRegions[name] ?? {};

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              backgroundColor: Colors.white,
              child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.85
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(24),
                            child: Row(
                                children: [
                                  if (flag != null)
                                    Container(
                                        width: 100,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(0.3),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4)
                                              )
                                            ]
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                                flag,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                      color: Colors.grey[200],
                                                      child: const Icon(Icons.flag, size: 40, color: Colors.blue)
                                                  );
                                                }
                                            )
                                        )
                                    ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                name,
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                    color: name == 'Ethiopia' ? Colors.green : Colors.blue
                                                )
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                                officialName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis
                                            )
                                          ]
                                      )
                                  )
                                ]
                            )
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                    children: [
                                      DetailCard(icon: Icons.account_balance, title: 'Capital', value: capital),
                                      DetailCard(icon: Icons.people, title: 'Population', value: population),
                                      DetailCard(icon: Icons.language, title: 'Languages', value: languages),
                                      DetailCard(icon: Icons.phone, title: 'Calling Code', value: callingCode),
                                      DetailCard(icon: Icons.attach_money, title: 'Currencies', value: currencies),
                                      DetailCard(icon: Icons.public, title: 'Region', value: region),
                                      DetailCard(icon: Icons.location_on, title: 'Subregion', value: subregion),
                                      DetailCard(icon: Icons.square_foot, title: 'Area', value: area),
                                      DetailCard(icon: Icons.access_time, title: 'Timezones', value: timezones),

                                      // Regions Section
                                      if (regions.isNotEmpty)
                                        Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.only(bottom: 12),
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: name == 'Ethiopia' ? Colors.green[50] : Colors.blue[50],
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(color: name == 'Ethiopia' ? Colors.green[100]! : Colors.blue[100]!),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black.withOpacity(0.1),
                                                      blurRadius: 4,
                                                      offset: const Offset(0, 2)
                                                  )
                                                ]
                                            ),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      children: [
                                                        Icon(Icons.terrain, size: 24, color: name == 'Ethiopia' ? Colors.green : Colors.blue),
                                                        const SizedBox(width: 16),
                                                        Text(
                                                            '${name} Regions & States',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: name == 'Ethiopia' ? Colors.green : Colors.blue,
                                                                fontWeight: FontWeight.bold
                                                            )
                                                        )
                                                      ]
                                                  ),
                                                  const SizedBox(height: 12),
                                                  ...regions.entries.map((region) =>
                                                      RegionExpandable(
                                                          regionName: region.key,
                                                          zones: region.value,
                                                          color: name == 'Ethiopia' ? Colors.green : Colors.blue
                                                      )
                                                  ).toList()
                                                ]
                                            )
                                        ),
                                      const SizedBox(height: 20)
                                    ]
                                )
                            )
                        ),
                        Container(
                            padding: const EdgeInsets.all(24),
                            child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: name == 'Ethiopia' ? Colors.green[700] : Colors.blue[700],
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        elevation: 4
                                    ),
                                    child: const Text(
                                        'Close',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold
                                        )
                                    )
                                )
                            )
                        )
                      ]
                  )
              )
          );
        }
    );
  }

  void _handleFavoriteChanged(String? value) {
    setState(() {
      selectedFavorite = value;
      if (value != null) {
        _controller.text = value;
        search(value);
      } else {
        _controller.clear();
        setState(() {
          showDefaultCountries = true;
          currentSearchQuery = '';
        });
        _loadDefaultCountries();
      }
    });
  }

  void _handleHover(int index) {
    setState(() {
      hoveredIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
            title: const Text("Explore Countries", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            elevation: 4,
            centerTitle: true
        ),
        body: Container(
            color: Colors.blue[100],
            child: Column(
                children: [
                  SearchSection(
                    controller: _controller,
                    selectedFavorite: selectedFavorite,
                    onFavoriteChanged: _handleFavoriteChanged,
                    onSearch: search,
                    suggestions: suggestions,
                  ),
                  Expanded(
                      child: Container(
                          color: Colors.blue[100],
                          padding: const EdgeInsets.all(16),
                          child: _buildResultsContent()
                      )
                  )
                ]
            )
        )
    );
  }

  Widget _buildResultsContent() {
    if (isLoading) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                    strokeWidth: 3
                ),
                const SizedBox(height: 16),
                const Text("Loading countries...", style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500))
              ]
          )
      );
    }

    if (!isLoading && _controller.text.isNotEmpty && displayCountries.isEmpty) {
      return Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 80, color: Colors.blue[300]),
                const SizedBox(height: 16),
                Text(
                    "No countries found for '${_controller.text}'",
                    style: TextStyle(fontSize: 18, color: Colors.blue[700], fontWeight: FontWeight.w500)
                ),
                const SizedBox(height: 8),
                const Text(
                    "Try a different search term or check your spelling",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 14)
                )
              ]
          )
      );
    }

    if (!isLoading && displayCountries.isNotEmpty) {
      String titleText;
      if (showDefaultCountries) {
        titleText = "Showing ${displayCountries.length} countries - Click any card for details";
      } else if (CountryData.continents.map((e) => e.toLowerCase()).contains(currentSearchQuery.toLowerCase())) {
        titleText = "Showing ${displayCountries.length} countries in $currentSearchQuery - Click any card for details";
      } else if (CountryData.africanSubregions.map((e) => e.toLowerCase()).contains(currentSearchQuery.toLowerCase())) {
        titleText = "Showing ${displayCountries.length} countries in $currentSearchQuery - Click any card for details";
      } else {
        titleText = "Showing ${displayCountries.length} countries for '$currentSearchQuery' - Click any card for details";
      }

      // Single country search - centered layout
      if (displayCountries.length == 1 && !showDefaultCountries) {
        return Column(
            children: [
              const SizedBox(height: 8),
              Text(
                  titleText,
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 16),
              Expanded(
                  child: Center(
                      child: SingleChildScrollView(
                          child: CountryCard(
                            country: displayCountries[0],
                            index: 0,
                            hoveredIndex: hoveredIndex,
                            onHover: _handleHover,
                            onTap: _showCountryDetails,
                          )
                      )
                  )
              )
            ]
        );
      }

      // Multiple countries - grid layout
      return Column(
          children: [
            const SizedBox(height: 8),
            Text(
                titleText,
                style: const TextStyle(fontSize: 16, color: Colors.blue),
                textAlign: TextAlign.center
            ),
            const SizedBox(height: 16),
            Expanded(
                child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isSmallScreen = constraints.maxWidth < 400;
                      return GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: isSmallScreen ? 300 : 340,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: isSmallScreen ? 0.8 : 0.85
                          ),
                          itemCount: displayCountries.length,
                          itemBuilder: (context, index) => CountryCard(
                            country: displayCountries[index],
                            index: index,
                            hoveredIndex: hoveredIndex,
                            onHover: _handleHover,
                            onTap: _showCountryDetails,
                          )
                      );
                    }
                )
            )
          ]
      );
    }

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.public, size: 100, color: Colors.blue[400]),
              const SizedBox(height: 20),
              Text(
                  "Explore Countries of the World",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue[800])
              ),
              const SizedBox(height: 12),
              Text(
                  "Search for a country, continent, or African region to get started",
                  style: TextStyle(fontSize: 16, color: Colors.blue[600]),
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 8),
              Text(
                  "Try: ${CountryData.favoriteCountries.first}, ${CountryData.favoriteContinents.first}, or Eastern Africa",
                  style: TextStyle(fontSize: 14, color: Colors.blue[700], fontWeight: FontWeight.w500)
              )
            ]
        )
    );
  }
}