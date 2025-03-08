import 'dart:io';

import 'package:allplant/core/widgets/button/add_plant_button.dart';
import 'package:allplant/features/cubit/myplants/my_plant_cubit.dart';
import 'package:allplant/features/cubit/myplants/my_plants_state.dart';
import 'package:allplant/features/models/plant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantListCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Plants"),
          actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
        ),

        body: BlocBuilder<PlantListCubit, PlantListState>(
          builder: (context, state) {
            if (state is PlantListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PlantListEmpty) {
              return const Center(child: Text("Henüz bitki eklemediniz."));
            } else if (state is PlantListLoaded) {
              return Padding(padding: const EdgeInsets.all(16.0), child: plantGridView(state));
            } else {
              return const Center(child: Text("Bir hata oluştu."));
            }
          },
        ),

        floatingActionButton: AddPlantButton(),
      ),
    );
  }

  GridView plantGridView(PlantListLoaded state) {
    return GridView.builder(
      itemCount: state.plants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        final plant = state.plants[index];
        return _buildPlantCard(context, plant, index);
      },
    );
  }

  Widget _buildPlantCard(BuildContext context, Plant plant, int index) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(File(plant.imageUrl), fit: BoxFit.cover),
              ),
            ),
          ),
          Divider(
            color: Colors.grey.shade400, // Çizginin rengi
            thickness: 2.0, // Çizginin kalınlığı
            indent: 10,
            endIndent: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    plant.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFF579133)),
                  onPressed: () {
                    context.read<PlantListCubit>().deletePlant(index);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
