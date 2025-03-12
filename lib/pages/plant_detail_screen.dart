import 'dart:io';
import 'package:allplant/core/constants/paddings.dart';

import 'package:allplant/core/provider/provider_factory.dart';

import 'package:allplant/core/widgets/column/plant_details.dart';
import 'package:allplant/core/widgets/positioned/common_positioned.dart';
import 'package:allplant/features/widgets/calendar/plant_care_schedule.dart';
import 'package:flutter/material.dart';
import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/features/models/plant.dart';

import 'package:go_router/go_router.dart';


class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
     return buildWateringProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text(plant.name.toUpperCase()),
          backgroundColor: Colors.transparent,
          leading: IconButton(icon: const Icon(Icons.arrow_back_outlined), onPressed: () => context.go('/plants')),
        ),
        backgroundColor: AppColors.alternateScaffoldBackground,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = constraints.maxHeight;
              final screenWidth = constraints.maxWidth;

              return Stack(
                children: [
                  _PlantHeaderImage(imagePath: plant.imageUrl, height: screenHeight * 0.25),
                  CommonPositioned(
                    top: screenHeight * 0.2,
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Paddings.sizedBoxPadding),
                            color: AppColors.scaffoldBackground,
                          ),
                          padding: const EdgeInsets.all(Paddings.sizedBoxPadding),
                          child: PlantDetailColumn(plant: plant),
                        ),
                        const SizedBox(height: Paddings.sizedBoxPadding * 2),
                        PlantNextWateringsWidget(plant: plant),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PlantHeaderImage extends StatelessWidget {
  final String imagePath;
  final double height;

  const _PlantHeaderImage({required this.imagePath, required this.height});

  @override
  Widget build(BuildContext context) {
    return CommonPositioned(top: 0, height: height, child: Image.file(File(imagePath), fit: BoxFit.fitWidth));
  }
}

class PlantNextWateringsWidget extends StatelessWidget {
  final Plant plant;

  const PlantNextWateringsWidget({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Paddings.sizedBoxPadding),
      child: Column(
        children: [
          const Text("Gelecek 3 Gün Planı", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: Paddings.sizedBoxPadding / 2),
          PlantCareSchedule(plant: plant),
        ],
      ),
    );
  }
}
