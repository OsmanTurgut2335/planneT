import 'package:allplant/features/cubit/watering/watering_state.dart';
import 'package:allplant/features/models/upcoming_event.dart';
import 'package:bloc/bloc.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';

class TodaysWateringsCubit extends Cubit<WateringState> {
  TodaysWateringsCubit() : super(TodaysWateringsLoading()) {
    loadUpcomingWaterings();
  }

  final Box<Plant> _plantBox = Hive.box<Plant>('plants');

  void loadUpcomingWaterings() async {
    emit(TodaysWateringsLoading());
    try {
      final box = Hive.box<Plant>('plants');
      final DateTime now = DateTime.now();
      final DateTime normalizedToday = DateTime(now.year, now.month, now.day);
      // Define the cutoff as 3 days from today (inclusive).
      final DateTime cutoffDate = normalizedToday.add(Duration(days: 3));

      List<WateringEvent> upcomingEvents = [];

      for (var plant in box.values) {
        // Normalize the stored last watered date.
        // Use toLocal() when reading from Hive:
        DateTime nextWateringDate = DateTime(
          plant.lastWateredDate.toLocal().year,
          plant.lastWateredDate.toLocal().month,
          plant.lastWateredDate.toLocal().day,
        );

        final now = DateTime.now().toLocal();
        final DateTime normalizedToday = DateTime(now.year, now.month, now.day);

        final int frequency = plant.wateringFrequencyInDays;

        // Loop: add every upcoming watering date that falls within the cutoff.
        while (!nextWateringDate.isAfter(cutoffDate)) {
          // For today, skip if the plant has already been watered.
          if (nextWateringDate.isAtSameMomentAs(normalizedToday) && plant.isWateredToday) {
       
          } else {
            upcomingEvents.add(WateringEvent(plant: plant, wateringDate: nextWateringDate));
          }
          // Move to the next watering date for this plant.
          nextWateringDate = nextWateringDate.add(Duration(days: frequency));
        }
      }

      // Optionally sort events by their watering date.
      upcomingEvents.sort((a, b) => a.wateringDate.compareTo(b.wateringDate));

      if (upcomingEvents.isEmpty) {
        emit(TodaysWateringsEmpty());
      } else {
        // Adjust your state to hold a list of events instead of plants.
        emit(TodaysWateringsLoaded(upcomingEvents));
      }
    } catch (e) {
      emit(TodaysWateringsError("Error loading upcoming waterings: $e"));
    }
  }

  // Toggle the watered status for a given plant.
  Future<void> toggleWatered(Plant plant) async {
    try {
      plant.isWateredToday = !plant.isWateredToday;
      await _plantBox.put(plant.key, plant);
      // Reload the upcoming waterings after updating.
      loadUpcomingWaterings();
    } catch (e) {
      emit(TodaysWateringsError("Error updating watering status: $e"));
    }
  }
}
