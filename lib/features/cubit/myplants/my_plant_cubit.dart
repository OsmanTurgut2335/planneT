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

  List<DateTime> getWateringDates() {
    final box = Hive.box<Plant>('plants');
    return box.values.map((plant) => plant.lastWateredDate).toList();
  }

  void loadWateringDates() async {
    emit(PlantsCalenderLoading());

    try {
      final box = Hive.box<Plant>('plants');
      final DateTime now = DateTime.now();
      final int currentMonth = now.month;
      final int currentYear = now.year;

      Map<DateTime, List<String>> wateringSchedule = {};

      for (var plant in box.values) {
        //DateTime nextWateringDate = plant.lastWateredDate;
        DateTime nextWateringDate = DateTime(
          plant.lastWateredDate.year,
          plant.lastWateredDate.month,
          plant.lastWateredDate.day,
        );

        final int frequency = plant.wateringFrequencyInDays;

        while (nextWateringDate.month == currentMonth && nextWateringDate.year == currentYear) {
          DateTime keyDate = DateTime(nextWateringDate.year, nextWateringDate.month, nextWateringDate.day);

          if (!wateringSchedule.containsKey(keyDate)) {
            wateringSchedule[keyDate] = [];
          }
          wateringSchedule[keyDate]?.add(plant.name); // Add the plant's name

          // Move to the next watering date
          nextWateringDate = nextWateringDate.add(Duration(days: frequency));
        }
      }

      if (wateringSchedule.isEmpty) {
        emit(PlantsCalenderEmpty());
      } else {
        emit(PlantsCalenderLoaded(wateringSchedule));
      }
    } catch (e) {
      emit(PlantsCalenderError("Sulama tarihleri yüklenirken hata oluştu"));
    }
  }

  // ❌ Hive’dan Bitki Silme
  void deletePlant(int index) {
    _plantBox.deleteAt(index);
    loadPlants(); // Silindikten sonra listeyi tekrar yükle
  }
}
