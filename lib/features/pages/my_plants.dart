import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:allplant/core/cubit/myplants/my_plants_cubit.dart';
import 'package:allplant/core/cubit/myplants/my_plants_state.dart';
import 'package:allplant/core/repository/myplants/my_plants_repository.dart';
import 'package:allplant/core/widgets/button/add_plant_button.dart';
import 'package:allplant/features/widgets/card/my_plants_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantListCubit(repository: MyPlantsRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.myPlants)),

        body: BlocBuilder<PlantListCubit, PlantListState>(
          builder: (context, state) {
            if (state is PlantListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlantListEmpty) {
              return const Center(child: Text(AppStrings.noPlants));
            } else if (state is PlantListLoaded) {
              return Padding(padding: const EdgeInsets.all(Paddings.largePadding), child: plantGridView(state));
            } else {
              return const Center(child: Text(AppStrings.error));
            }
          },
        ),

        floatingActionButton: const AddPlantButton(),
      ),
    );
  }

  GridView plantGridView(PlantListLoaded state) {
    return GridView.builder(
      itemCount: state.plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Paddings.gridSpacing,
        mainAxisSpacing: Paddings.gridSpacing,
        childAspectRatio: MyPlantsConstants.gridAspectRatio,
      ),
      itemBuilder: (context, index) {
        final plant = state.plants[index];
        return MyPlantsCard(plant: plant, index: index);
      },
    );
  }
}

class MyPlantsConstants {
  const MyPlantsConstants._();

  static const double indent = 10;
  static const double gridAspectRatio = 0.7;
}
