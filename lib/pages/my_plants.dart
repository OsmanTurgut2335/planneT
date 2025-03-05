import 'dart:io';
import 'package:allplant/core/constants/colors.dart';
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
      create: (context) => PlantListCubit(), // 📌 PlantListCubit'i başlat
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Plants"),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Menü veya Drawer açma işlemleri
              },
            ),
          ],
        ),

        body: BlocBuilder<PlantListCubit, PlantListState>(
          builder: (context, state) {
            if (state is PlantListLoading) {
              return const Center(child: CircularProgressIndicator()); // Yükleniyor animasyonu
            } else if (state is PlantListEmpty) {
              return const Center(child: Text("Henüz bitki eklemediniz."));
            } else if (state is PlantListLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  itemCount: state.plants.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {
                    final plant = state.plants[index];
                    return _buildPlantCard(context, plant, index);
                  },
                ),
              );
            } else {
              return const Center(child: Text("Bir hata oluştu."));
            }
          },
        ),

        floatingActionButton: AddPlantButton(),
      ),
    );
  }

  Widget _buildPlantCard(BuildContext context, Plant plant, int index) {
    final int daysSinceWatered = DateTime.now().difference(plant.lastWateredDate).inDays;

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.cardBackground),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.file(File(plant.imageUrl), fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              plant.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(plant.nickname ?? "No nickname", style: Theme.of(context).textTheme.bodySmall),
          ),

          // Son Sulama Chip
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Chip(
              avatar: const Icon(Icons.water_drop, color: Colors.blue),
              label: Text("$daysSinceWatered gün önce sulandı"),
              backgroundColor: Colors.blue.shade50,
            ),
          ),

          // Silme Butonu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<PlantListCubit>().deletePlant(index); // 📌 Hive’dan silme işlemi
              },
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
