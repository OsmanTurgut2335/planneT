import 'dart:io';

import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:allplant/core/cubit/myplants/my_plant_cubit.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/pages/my_plants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

//widget to display each of the plants in my plants screen

class MyPlantsCard extends StatelessWidget {
  final Plant plant;
  final int index;
  const MyPlantsCard({super.key, required this.plant, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed('plantDetail', pathParameters: {'id': plant.name.toString()}, extra: plant);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Paddings.borderRadius),
          color: AppColors.plantCardBackground,
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(Paddings.defaultPadding),
                child: Image.file(File(plant.imageUrl), fit: BoxFit.cover),
              ),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 2.0,
              indent: MyPlantsConstants.indent,
              endIndent: MyPlantsConstants.indent,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Paddings.defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: Paddings.defaultPadding / 2),
                      child: Text(
                        plant.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.iconColor),
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text(AppStrings.delete),
                              content: const Text(MyPlantsString.approveText),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text(AppStrings.cancel)),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text(AppStrings.delete)),
                              ],
                            ),
                      );
                      if (confirmed ?? false) {
                        context.read<PlantListCubit>().deletePlant(index);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPlantsString {
  MyPlantsString._();
  static const approveText = "Bitkiyi silmek istediğinize emin misiniz?";
}
