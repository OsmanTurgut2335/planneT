
import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/cubit/watering/watering_cubit.dart';
import 'package:allplant/core/cubit/watering/watering_state.dart';
import 'package:allplant/features/models/upcoming_event.dart';
import 'package:flutter/material.dart';

import 'package:allplant/features/models/plant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class PlantCareSchedule extends StatelessWidget {
  const PlantCareSchedule({
    super.key,
    required this.plant,
  });

  final Plant plant;

  /// This widget uses a BlocBuilder to retrieve the upcoming watering events
  /// from TodaysWateringsCubit, then filters them for the given [plant]
  /// and displays a row with the upcoming watering dates.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodaysWateringsCubit, WateringState>(
      builder: (context, state) {
        if (state is TodaysWateringsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodaysWateringsError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        } else if (state is TodaysWateringsEmpty) {
          return const Center(child: Text("No upcoming waterings!"));
        } else if (state is TodaysWateringsLoaded) {

    
          final plantEvents = state.plants.where((event) => event.plant.name == plant.name).toList();

          final now = DateTime.now();
          final DateTime normalizedToday = DateTime(now.year, now.month, now.day);

      
          List<Widget> dayWidgets = dayWidgetBuilder(normalizedToday, plantEvents);

          return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: dayWidgets);
        }
        return const SizedBox.shrink();
      },
    );
  }



  List<Widget> dayWidgetBuilder(DateTime normalizedToday, List<WateringEvent> plantEvents) {
     // Build a widget for each of the next 3 days
    List<Widget> dayWidgets = [];
    for (int i = 0; i < 3; i++) {
      final day = normalizedToday.add(Duration(days: i));
      final bool wateringScheduled = plantEvents.any((event) => isSameDay(event.wateringDate, day));
      dayWidgets.add(
      _DayWidget(day: day, wateringScheduled: wateringScheduled)
      );
    }
    return dayWidgets;
  }
}


class _DayWidget extends StatelessWidget {
  const _DayWidget({
    required this.day,
    required this.wateringScheduled,
  });

  final DateTime day;
  final bool wateringScheduled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            "${day.month}/${day.day}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Paddings.defaultPadding , vertical: Paddings.defaultPadding/2),
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
    );
  }
}