import 'package:allplant/core/cubit/myplants/my_plants_state.dart';
import 'package:allplant/core/repository/myplants/my_plants_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';



class PlantListCubit extends Cubit<PlantListState> {
  PlantListCubit({required this.repository}) : super(PlantListLoading());
  final MyPlantsRepository repository;

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

 Future<void> deletePlant(int index) async {
  try {
    await repository.deletePlant(index);
    loadPlants();
    
  } catch (e) {
    emit(DeletePlantError());
  }
}

}
