import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/models/upcoming_event.dart';
import 'package:hive/hive.dart';

class WateringRepository {

  WateringRepository({required this.plantBox});
  final Box<Plant> plantBox;

  Future<List<WateringEvent>> getUpcomingWaterings() async {
    final now = DateTime.now();
    final  normalizedToday = DateTime(now.year, now.month, now.day);

    final  cutoffDate = normalizedToday.add(const Duration(days: 3));

    List<WateringEvent> upcomingEvents = [];

    for (var plant in plantBox.values) {

      var nextWateringDate = DateTime(
        plant.lastWateredDate.toLocal().year,
        plant.lastWateredDate.toLocal().month,
        plant.lastWateredDate.toLocal().day,
      );

 
      final nowLocal = DateTime.now().toLocal();
      final  normalizedTodayLocal = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
      final  frequency = plant.wateringFrequencyInDays;

      while (!nextWateringDate.isAfter(cutoffDate)) {
  
        if (nextWateringDate.isAtSameMomentAs(normalizedTodayLocal) && plant.isWateredToday) {
       
        } else {
          upcomingEvents.add(WateringEvent(plant: plant, wateringDate: nextWateringDate));
        }
   
        nextWateringDate = nextWateringDate.add(Duration(days: frequency));
      }
    }


    upcomingEvents.sort((a, b) => a.wateringDate.compareTo(b.wateringDate));
    return upcomingEvents;
  }

  Future<void> toggleWatered(Plant plant) async {
    plant.isWateredToday = !plant.isWateredToday;
    await plantBox.put(plant.key, plant);
  }
}
