import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/widgets/plant_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlantGuideSection extends StatelessWidget {
  const PlantGuideSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Row with title and "View all"
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Bitkilerim",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(
              onTap: () {
                // Handle "View all" tap
              },
              child: Text(
                "View all",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Instead of dummyPlants, use Hive's listenable to fetch live data
        ValueListenableBuilder(
          valueListenable: Hive.box<Plant>('plants').listenable(),
          builder: (context, Box<Plant> box, _) {
            final plants = box.values.toList().cast<Plant>();
            if (plants.isEmpty) {
              return const Center(child: Text("No plants added yet"));
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
