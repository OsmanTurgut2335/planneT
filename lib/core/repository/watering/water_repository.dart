import 'package:allplant/features/models/upcoming_event.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';

class WateringRepository {
  final Box<Plant> plantBox;

  WateringRepository({required this.plantBox});

  Future<List<WateringEvent>> getUpcomingWaterings() async {
    final now = DateTime.now();
    final DateTime normalizedToday = DateTime(now.year, now.month, now.day);

    final DateTime cutoffDate = normalizedToday.add(Duration(days: 3));

    List<WateringEvent> upcomingEvents = [];

    for (var plant in plantBox.values) {

      DateTime nextWateringDate = DateTime(
        plant.lastWateredDate.toLocal().year,
        plant.lastWateredDate.toLocal().month,
        plant.lastWateredDate.toLocal().day,
      );

 
      final nowLocal = DateTime.now().toLocal();
      final DateTime normalizedTodayLocal = DateTime(nowLocal.year, nowLocal.month, nowLocal.day);
      final int frequency = plant.wateringFrequencyInDays;

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
