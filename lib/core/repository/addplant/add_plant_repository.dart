import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';


class AddPlantRepository {

  AddPlantRepository() : plantBox = Hive.box<Plant>('plants');
  final Box<Plant> plantBox;


  Future<void> addPlant(Plant plant) async {
    await plantBox.add(plant);
    
  }


  List<Plant> getAllPlants() {
    return plantBox.values.toList();
  }

  Future<void> deletePlant(int index) async {
    await plantBox.deleteAt(index);
  }


  Future<void> updatePlant(int index, Plant updatedPlant) async {
    await plantBox.putAt(index, updatedPlant);
  }
}
