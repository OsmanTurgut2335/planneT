

import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';

class CalendarRepository {
    final Box<Plant> _plantBox = Hive.box<Plant>('plants');

    
  Future<Map<DateTime, List<String>>> loadWateringDates() async {
    final  now = DateTime.now();
    final  currentMonth = now.month;
    final  currentYear = now.year;
    final Map<DateTime, List<String>> wateringSchedule = {};

    for (final plant in _plantBox.values) {
      DateTime nextWateringDate = DateTime(
        plant.lastWateredDate.year,
        plant.lastWateredDate.month,
        plant.lastWateredDate.day,
      );
      final  frequency = plant.wateringFrequencyInDays;

      while (nextWateringDate.month == currentMonth && nextWateringDate.year == currentYear) {
        final keyDate = DateTime(nextWateringDate.year, nextWateringDate.month, nextWateringDate.day);
        wateringSchedule.putIfAbsent(keyDate, () => []);
        wateringSchedule[keyDate]?.add(plant.name);
        nextWateringDate = nextWateringDate.add(Duration(days: frequency));
      }
    }

    return wateringSchedule;
  }

}
