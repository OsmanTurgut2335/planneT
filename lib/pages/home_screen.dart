import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/widgets/button/add_plant_button.dart';
import 'package:allplant/core/widgets/image/leaf_image.dart';

import 'package:allplant/features/widgets/list/myplants_listview.dart';
import 'package:allplant/features/widgets/text/random_info_text.dart';

import 'package:allplant/features/widgets/list/upcoming_water_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ana Ekran")),
      body: Stack(
        children: [
          const LeafImage(position: LeafPosition.topRight),
          //  const LeafImage(position: LeafPosition.bottomRight),
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Paddings.homeScreenPadding),

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

                          DidYouKnowSection(),
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
