import 'package:flutter/material.dart';

class RegionExpandable extends StatelessWidget {
  final String regionName;
  final List<String> zones;
  final Color color;

  const RegionExpandable({
    super.key,
    required this.regionName,
    required this.zones,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ExpansionTile(
          leading: Icon(Icons.place, color: color),
          title: Text(
            regionName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: zones.map((zone) => Chip(
                  label: Text(zone),
                  backgroundColor: color.withOpacity(0.2),
                  labelStyle: TextStyle(color: color),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}