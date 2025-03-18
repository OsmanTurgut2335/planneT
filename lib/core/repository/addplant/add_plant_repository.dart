import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';


class AddPlantRepository {

  AddPlantRepository() : plantBox = Hive.box<Plant>('plants');
  final Box<Plant> plantBox;


  Future<void> addPlant(Plant plant) async {
    await plantBox.add(plant);
    
  }


 
}
