
import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//section of the plant details that shows view of the plant name-ect.

class PlantDetailColumn extends StatelessWidget {

  const PlantDetailColumn({super.key, required this.plant});
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plant.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text('Bitki türü: ${plant.plantType}', style: TextStyle(color: Colors.grey.shade600)),
        const SizedBox(height: Paddings.largePadding),
        Text(
          "Son sulama tarihi: ${DateFormat('M/d/yyyy').format(plant.lastWateredDate)}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: Paddings.largePadding),
      ],
    );
  }
}
