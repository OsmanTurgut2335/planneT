import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/widgets/card/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlantGuideSection extends StatelessWidget {
  const PlantGuideSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Bitkilerim", style: Theme.of(context).textTheme.headlineMedium),

        const SizedBox(height: 12),
        // Instead of dummyPlants, use Hive's listenable to fetch live data
        ValueListenableBuilder(
          valueListenable: Hive.box<Plant>('plants').listenable(),
          builder: (context, Box<Plant> box, _) {
            final plants = box.values.toList().cast<Plant>();
            if (plants.isEmpty) {
              return const Center(child: Text("Henüz bitki eklemediniz"));
            }
            return SizedBox(
              height: 160, // height for the horizontal list of cards
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: plants.length,
                itemBuilder: (context, index) {
                  final plant = plants[index];
                  return PlantCard(plant: plant);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
