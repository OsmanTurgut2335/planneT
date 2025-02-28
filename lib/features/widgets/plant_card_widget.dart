import 'package:allplant/features/models/plant.dart';

import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  static const double _cardRadius = 12.0;
  
  final Plant plant;
  
  const PlantCard({super.key, required this.plant});
  
  @override
  Widget build(BuildContext context) {
    final displayName = plant.nickname?.isNotEmpty == true ? plant.nickname : plant.name;
    
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: _cardRadius),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_cardRadius),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(_cardRadius)),
              child: Image.network(plant.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade900,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(_cardRadius)),
            ),
            child: Text(
              displayName ?? "",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
