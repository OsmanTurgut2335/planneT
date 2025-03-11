

import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';

class CalendarRepository {
    final Box<Plant> _plantBox = Hive.box<Plant>('plants');

    
  Future<Map<DateTime, List<String>>> loadWateringDates() async {
    final DateTime now = DateTime.now();
    final int currentMonth = now.month;
    final int currentYear = now.year;
    Map<DateTime, List<String>> wateringSchedule = {};

    for (var plant in _plantBox.values) {
      DateTime nextWateringDate = DateTime(
        plant.lastWateredDate.year,
        plant.lastWateredDate.month,
        plant.lastWateredDate.day,
      );
      final int frequency = plant.wateringFrequencyInDays;

      while (nextWateringDate.month == currentMonth && nextWateringDate.year == currentYear) {
        DateTime keyDate = DateTime(nextWateringDate.year, nextWateringDate.month, nextWateringDate.day);
        wateringSchedule.putIfAbsent(keyDate, () => []);
        wateringSchedule[keyDate]?.add(plant.name);
        nextWateringDate = nextWateringDate.add(Duration(days: frequency));
      }
    }

    return wateringSchedule;
  }

}