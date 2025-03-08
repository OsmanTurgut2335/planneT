import 'package:allplant/features/cubit/watering/watering_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:allplant/features/cubit/watering/watering_state.dart';


class UpcomingWateringsList extends StatelessWidget {
  const UpcomingWateringsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the cubit and immediately load the upcoming waterings.
      create: (_) => TodaysWateringsCubit()..loadUpcomingWaterings(),
      child: BlocBuilder<TodaysWateringsCubit, WateringState>(
        builder: (context, state) {
          if (state is TodaysWateringsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodaysWateringsError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          } else if (state is TodaysWateringsEmpty) {
            return const Center(child: Text("No upcoming waterings!"));
          } else if (state is TodaysWateringsLoaded) {
            final events = state.plants; // This should be List<WateringEvent>

            return SizedBox(
              height: 300,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.alarm, color: Colors.green, size: 30),
                      title: Text(event.plant.name),
                      subtitle: Text(_buildSubtitle(event.wateringDate)),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          // Mark as watered. Note: This toggles the status on the plant itself.
                          context.read<TodaysWateringsCubit>().toggleWatered(event.plant);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// Returns a friendly message depending on how many days are left.
  String _buildSubtitle(DateTime wateringDate) {
    final daysLeft = _daysUntil(wateringDate);
    if (daysLeft <= 0) {
      return "Bugün sulanmalı";
    } else if (daysLeft == 1) {
      return "Yarın sulanmalı";
    } else {
      return "$daysLeft gün içinde sulanmalı";
    }
  }

  /// Normalizes both the current date and the given [wateringDate] to midnight,
  /// then returns the difference in whole days.
  int _daysUntil(DateTime wateringDate) {
    final now = DateTime.now();
    final normalizedNow = DateTime(now.year, now.month, now.day);
    final normalizedWateringDate = DateTime(
      wateringDate.year,
      wateringDate.month,
      wateringDate.day,
    );
    return normalizedWateringDate.difference(normalizedNow).inDays;
  }
}
