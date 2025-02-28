
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/widgets/plant_card.dart';
import 'package:flutter/material.dart';

class PlantGuideSection extends StatelessWidget {
  PlantGuideSection({super.key});
  final dummyPlants = [
    Plant(
      name: "Monstera Deliciosa",
      imageUrl: "https://picsum.photos/160",
      lastWateredDate: DateTime.now(),
      wateringFrequencyInDays: 7,
    ),
    Plant(
      name: "Yucca",
      imageUrl: "https://picsum.photos/160",
      lastWateredDate: DateTime.now().subtract(Duration(days: 2)),
      wateringFrequencyInDays: 10,
    ),
    Plant(
      name: "Peperomia Raindrop",
      imageUrl: "https://picsum.photos/160",
      lastWateredDate: DateTime.now().subtract(Duration(days: 5)),
      wateringFrequencyInDays: 14,
    ),
    Plant(
      name: "Peperomia Raindrop",
      imageUrl: "https://picsum.photos/160",
      lastWateredDate: DateTime.now().subtract(Duration(days: 5)),
      wateringFrequencyInDays: 14,
    ),
    Plant(
      name: "Peperomia Raindrop",
      imageUrl: "https://picsum.photos/160",
      lastWateredDate: DateTime.now().subtract(Duration(days: 5)),
      wateringFrequencyInDays: 14,
    ),
    Plant(
      name: "Peperomia Raindrop",
      imageUrl: "https://picsum.photos/160",
      lastWateredDate: DateTime.now().subtract(Duration(days: 5)),
      wateringFrequencyInDays: 14,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Bitkilerim", style: Theme.of(context).textTheme.headlineMedium),

            GestureDetector(
              onTap: () {
                // "View all" tıklandığında yapılacaklar
              },
              child: Text(
                "View all",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Yatay kaydırılabilir kartlar
        PlantCardListView(dummyPlants: dummyPlants),
      ],
    );
  }
}

class PlantCardListView extends StatelessWidget {
  const PlantCardListView({super.key, required this.dummyPlants});

  final List<Plant> dummyPlants;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // Kartların yüksekliği
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dummyPlants.length,
        itemBuilder: (context, index) {
          final plant = dummyPlants[index];
          return PlantCard(plant: plant);
        },
      ),
    );
  }
}
