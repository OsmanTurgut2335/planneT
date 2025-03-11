import 'dart:io';
import 'package:allplant/core/cubit/watering/watering_cubit.dart';
import 'package:allplant/core/cubit/watering/watering_state.dart';
import 'package:allplant/core/repository/watering/water_repository.dart';
import 'package:flutter/material.dart';
import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => TodaysWateringsCubit(repository: WateringRepository(plantBox: Hive.box<Plant>('plants'))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back_outlined), onPressed: () => context.go('/plants')),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight * 0.2,
              child: Image.file(File(plant.imageUrl), fit: BoxFit.fitWidth),
            ),
            Positioned(
              top: screenHeight * 0.18,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.scaffoldBackground,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(plant.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        Text("Bitki türü: ${plant.plantType}", style: TextStyle(color: Colors.grey.shade600)),
                        const SizedBox(height: 16),
                        Text(
                          "Son sulama tarihi: ${DateFormat('M/d/yyyy').format(plant.lastWateredDate)}",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text("Gelecek 3 Gün Planı", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        // The care schedule is now built by filtering the events from the cubit for this plant
                        _buildCareScheduleForPlant(plant),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.alternateScaffoldBackground,
      ),
    );
  }

  /// This widget uses a BlocBuilder to retrieve the upcoming watering events
  /// from TodaysWateringsCubit, then filters them for the given [plant]
  /// and displays a row with the upcoming watering dates.
  Widget _buildCareScheduleForPlant(Plant plant) {
    return BlocBuilder<TodaysWateringsCubit, WateringState>(
      builder: (context, state) {
        if (state is TodaysWateringsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodaysWateringsError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        } else if (state is TodaysWateringsEmpty) {
          return const Center(child: Text("No upcoming waterings!"));
        } else if (state is TodaysWateringsLoaded) {
          // Filter events for the specific plant
          final plantEvents = state.plants.where((event) => event.plant.name == plant.name).toList();

          final now = DateTime.now();
          final DateTime normalizedToday = DateTime(now.year, now.month, now.day);

          // Build a widget for each of the next 3 days
          List<Widget> dayWidgets = [];
          for (int i = 0; i < 3; i++) {
            final day = normalizedToday.add(Duration(days: i));
            final bool wateringScheduled = plantEvents.any((event) => isSameDay(event.wateringDate, day));
            dayWidgets.add(
              Expanded(
                child: Column(
                  children: [
                    Text("${day.month}/${day.day}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: wateringScheduled ? Colors.green : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        wateringScheduled ? "Sulama Var" : "Sulama Yok",
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: dayWidgets);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
