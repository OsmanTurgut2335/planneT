
import 'package:allplant/features/models/plant.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddPlantRepository {
  final Box<Plant> plantBox;
  final ImagePicker _picker = ImagePicker();

  AddPlantRepository() : plantBox = Hive.box<Plant>('plants');

  // 🌱 Yeni bir bitki ekle
  Future<void> addPlant(Plant plant) async {
    await plantBox.add(plant);
  }

  // 🔄 Tüm bitkileri getir
  List<Plant> getAllPlants() {
    return plantBox.values.toList();
  }


  // 🗑 Bir bitkiyi sil
  Future<void> deletePlant(int index) async {
    await plantBox.deleteAt(index);
  }

  // ✏ Bir bitkiyi güncelle
  Future<void> updatePlant(int index, Plant updatedPlant) async {
    await plantBox.putAt(index, updatedPlant);
  }


}
