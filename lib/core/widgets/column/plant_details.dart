
import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlantDetailColumn extends StatelessWidget {
  final Plant plant;

  const PlantDetailColumn({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plant.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text("Bitki türü: ${plant.plantType}", style: TextStyle(color: Colors.grey.shade600)),
        const SizedBox(height: Paddings.sizedBoxPadding),
        Text(
          "Son sulama tarihi: ${DateFormat('M/d/yyyy').format(plant.lastWateredDate)}",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        const SizedBox(height: Paddings.sizedBoxPadding),
      ],
    );
  }
}
