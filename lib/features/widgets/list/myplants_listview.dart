import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/widgets/card/home_plant_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// list view of the home_plant_card for a horizontal list 
class PlantGuideSection extends StatelessWidget {
  const PlantGuideSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.myPlants, style: Theme.of(context).textTheme.headlineMedium),

        const SizedBox(height: Paddings.largePadding),

        ValueListenableBuilder(
          valueListenable: Hive.box<Plant>('plants').listenable(),
          builder: (context, Box<Plant> box, _) {
            final plants = box.values.toList().cast<Plant>();
            if (plants.isEmpty) {
              return const Center(child: Text(AppStrings.noPlants));
            }
            return SizedBox(
              height: CardHeight.plantCardListHeight,
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

class CardHeight {
  static const double plantCardListHeight = 160.0;
}
