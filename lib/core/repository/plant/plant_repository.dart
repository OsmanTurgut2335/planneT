import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';


class PlantRepository {
  Future<void> addPlant(Plant plant) async {
    final box = await Hive.openBox<Plant>('plants');
    await box.add(plant);
  }
}
