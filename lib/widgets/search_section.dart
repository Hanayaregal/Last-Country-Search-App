import 'package:flutter/material.dart';
import '../data/country_data.dart';

class SearchSection extends StatelessWidget {
  final TextEditingController controller;
  final String? selectedFavorite;
  final Function(String?) onFavoriteChanged;
  final Function(String) onSearch;
  final List<String> suggestions;

  const SearchSection({
    super.key,
    required this.controller,
    required this.selectedFavorite,
    required this.onFavoriteChanged,
    required this.onSearch,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isSmallScreen = constraints.maxWidth < 600;

          if (isSmallScreen) {
            return _buildSmallScreenLayout();
          } else {
            return _buildLargeScreenLayout();
          }
        },
      ),
    );
  }

  Widget _buildSmallScreenLayout() {
    return Column(
      children: [
        // Search Field
        Container(
          width: double.infinity,
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return suggestions.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            },
            fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
              if (this.controller.text != controller.text) {
                this.controller.text = controller.text;
              }
              return TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) {
                  this.controller.text = value;
                },
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Search country, continent, or African region...",
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, size: 20, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              );
            },
            onSelected: onSearch,
          ),
        ),
        const SizedBox(height: 12),

        // Search Button and Dropdown in row
        Row(
          children: [
            Expanded(
              child: _buildSearchButton(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDropdown(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLargeScreenLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Search Field
        Container(
          width: 250,
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return suggestions.where((option) => option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()));
            },
            fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
              if (this.controller.text != controller.text) {
                this.controller.text = controller.text;
              }
              return TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) {
                  this.controller.text = value;
                },
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: "Search country, continent, or African region...",
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, size: 20, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              );
            },
            onSelected: onSearch,
          ),
        ),
        const SizedBox(width: 12),
        _buildSearchButton(),
        const SizedBox(width: 12),
        Container(
          width: 200,
          child: _buildDropdown(),
        ),
      ],
    );
  }

  Widget _buildSearchButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[900]!.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ElevatedButton(
          onPressed: () => onSearch(controller.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue[700],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text(
            "Search",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: DropdownButtonFormField<String>(
        value: selectedFavorite,
        hint: const Text(
          "Quick Select",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        isExpanded: true,
        dropdownColor: Colors.white,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        items: [
          const DropdownMenuItem(
            value: null,
            child: Text("All Countries", style: TextStyle(fontSize: 14)),
          ),
          const DropdownMenuItem(
            value: "African Regions",
            child: Text("🌍 African Regions", style: TextStyle(fontSize: 14)),
          ),
          ...CountryData.favoriteContinents.map((e) => DropdownMenuItem(
            value: e,
            child: Text("🌍 $e", style: const TextStyle(fontSize: 14)),
          )).toList(),
          ...CountryData.favoriteCountries.map((e) => DropdownMenuItem(
            value: e,
            child: Text("🇺🇳 $e", style: const TextStyle(fontSize: 14)),
          )).toList(),
          ...CountryData.africanSubregions.map((e) => DropdownMenuItem(
            value: e,
            child: Text("📍 $e", style: const TextStyle(fontSize: 14)),
          )).toList(),
        ],
        onChanged: onFavoriteChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}