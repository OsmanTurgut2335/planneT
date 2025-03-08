import 'dart:math';

import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/widgets/button/add_plant_button.dart';
import 'package:allplant/features/widgets/image/leaf_image.dart';
import 'package:allplant/features/widgets/myplants_listview.dart';
import 'package:allplant/features/widgets/random_info_text.dart';

import 'package:allplant/features/widgets/upcoming_water_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //DUMMY DATA
  final randomFacts = [
    "Bitkiler oksijen üretir ve havayı temizler.",
    "Monstera Deliciosa'nın dev yaprakları doğal deliklere sahiptir.",
    "Kaktüsler su depolayarak kuraklığa dayanır.",
    "Orkide çiçekleri çok uzun süre canlı kalabilir.",
  ];

  late String selectedFact;

  @override
  void initState() {
    super.initState();
    final random = Random();
    selectedFact = randomFacts[random.nextInt(randomFacts.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ana Ekran")),
      body: Stack(
        children: [
          // Arka plan ve dekoratif görseller
          const LeafImage(position: LeafPosition.topLeft),
          const LeafImage(position: LeafPosition.bottomRight),

          // İçeriği kapsayan alan
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Paddings.homeScreenPadding),

                // Üst kısım scrollable
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Paddings.homeScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bitki Rehberi
                          PlantGuideSection(),

                          const SizedBox(height: Paddings.homeScreenPadding),

                          Text("Yaklaşan Sulamalar", style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: Paddings.homeScreenPadding),

                          const UpcomingWateringsList(),

                          DidYouKnowSection(info: selectedFact),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: AddPlantButton(),
    );
  }
}
