import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/widgets/button/add_plant_button.dart';


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
      appBar: AppBar(title: const Text(_HomeViewStrings.title)),
      body: SafeArea(
        child: Column(
          children: [
           
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Paddings.largePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Paddings.largePadding),

                      const PlantGuideSection(),
                      const SizedBox(height: Paddings.largePadding),

                      Text(_HomeViewStrings.upcomingWatering, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: Paddings.largePadding),
                      const UpcomingWateringsList(),

                    ],
                  ),
                ),
              ),
            ),

    
            const Padding(padding: EdgeInsets.all(Paddings.defaultPadding), child: DidYouKnowSection()),
          ],
        ),
      ),
      floatingActionButton: AddPlantButton(),
    );
  }
}
/// Home ekranı için string sabitleri
class _HomeViewStrings {
  const _HomeViewStrings._();

  static const String title = 'Ana Ekran';
  static const String upcomingWatering = 'Yaklaşan Sulamalar';
}