import 'package:allplant/core/cubit/myplants/my_plants_state.dart';
import 'package:allplant/core/repository/myplants/my_plants_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



class PlantListCubit extends Cubit<PlantListState> {
  final MyPlantsRepository repository;

  PlantListCubit({required this.repository}) : super(PlantListLoading()) {
    loadPlants();
  }

  void loadPlants() {
    final plants = repository.loadPlants();
    if (plants.isEmpty) {
      emit(PlantListEmpty());
    } else {
      emit(PlantListLoaded(plants));
    }
  }

  List<DateTime> getWateringDates() {
    return repository.getWateringDates();
  }

  void loadWateringDates() async {
    emit(PlantsCalenderLoading());
    try {
      final wateringSchedule = await repository.loadWateringDates();
      if (wateringSchedule.isEmpty) {
        emit(PlantsCalenderEmpty());
      } else {
        emit(PlantsCalenderLoaded(wateringSchedule));
      }
    } catch (e) {
      emit(PlantsCalenderError("Sulama tarihleri yüklenirken hata oluştu"));
    }
  }

  void deletePlant(int index) {
    repository.deletePlant(index);
    loadPlants();
  }
}
