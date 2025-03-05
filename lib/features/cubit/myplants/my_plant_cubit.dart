import 'package:allplant/features/cubit/myplants/my_plants_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:allplant/features/models/plant.dart';


class PlantListCubit extends Cubit<PlantListState> {
  PlantListCubit() : super(PlantListLoading()) {
    loadPlants(); // Başlangıçta bitkileri yükle
  }

  final Box<Plant> _plantBox = Hive.box<Plant>('plants');

  // 🌱 Hive’dan Bitki Listesini Yükle
  void loadPlants() {
    final plants = _plantBox.values.toList();
    if (plants.isEmpty) {
      emit(PlantListEmpty()); // Eğer kutu boşsa, boş state gönder
    } else {
      emit(PlantListLoaded(plants)); // Eğer veri varsa, listeyi yükle
    }
  }

  // ❌ Hive’dan Bitki Silme
  void deletePlant(int index) {
    _plantBox.deleteAt(index);
    loadPlants(); // Silindikten sonra listeyi tekrar yükle
  }
}
