import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';

class MyPlantsRepository {
  final Box<Plant> _plantBox = Hive.box<Plant>('plants');

  Future<List<Plant>> loadPlants() async {
    final box = await Hive.openBox<Plant>('plants');
    return box.values.toList();
  }

  List<DateTime> getWateringDates() {
    return _plantBox.values.map((plant) => plant.lastWateredDate).toList();
  }

  Future<void> deletePlant(int index) async {
    await _plantBox.deleteAt(index);
  }
}
