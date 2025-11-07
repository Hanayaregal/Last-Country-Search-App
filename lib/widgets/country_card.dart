import 'package:flutter/material.dart';

class CountryCard extends StatefulWidget {
  final dynamic country;
  final int index;
  final int? hoveredIndex;
  final Function(int) onHover;
  final Function(dynamic) onTap;

  const CountryCard({
    super.key,
    required this.country,
    required this.index,
    required this.hoveredIndex,
    required this.onHover,
    required this.onTap,
  });

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  bool get isHovered => widget.hoveredIndex == widget.index;

  @override
  Widget build(BuildContext context) {
    final name = widget.country['name']['common'] ?? '';
    final capital = widget.country['capital'] != null
        ? (widget.country['capital'] as List).join(', ')
        : 'N/A';
    final population = widget.country['population'] != null
        ? (widget.country['population'] as int).toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )
        : 'N/A';
    final languages = widget.country['languages'] != null
        ? (widget.country['languages'] as Map).values.join(', ')
        : 'N/A';
    final flag = widget.country['flags'] != null ? widget.country['flags']['png'] : null;

    return MouseRegion(
      onEnter: (_) => widget.onHover(widget.index),
      onExit: (_) => widget.onHover(-1),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.country),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 320,
          height: 280,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: isHovered ? Colors.blue[400]! : Colors.grey.shade300,
              width: isHovered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: isHovered
                ? [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 25,
                spreadRadius: 5,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flag Section
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: flag != null
                      ? Image.network(
                    flag,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.flag, size: 40, color: Colors.blue),
                      );
                    },
                  )
                      : Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.flag, size: 40, color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Country Name
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Country Details
              Flexible(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isCompact = constraints.maxHeight < 80;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildResponsiveDetailRow(Icons.account_balance, 'Capital: $capital', isCompact),
                        _buildResponsiveDetailRow(Icons.people, 'Population: $population', isCompact),
                        _buildResponsiveDetailRow(Icons.language, 'Language: $languages', isCompact),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveDetailRow(IconData icon, String text, bool isCompact) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: isCompact ? 14 : 16, color: Colors.blue[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isCompact ? 10 : 12,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: isCompact ? 1 : 2,
            ),
          ),
        ],
      ),
    );
  }
}