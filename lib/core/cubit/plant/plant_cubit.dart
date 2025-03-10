import 'package:allplant/features/models/plant.dart';
import 'package:allplant/core/repository/plant/plant_repository.dart';
import 'package:bloc/bloc.dart';


import 'plant_state.dart';

class PlantCubit extends Cubit<PlantState> {
  final PlantRepository plantRepository;

  PlantCubit(this.plantRepository) : super(PlantInitial());

  Future<void> addPlant(Plant plant) async {
    try {
      emit(PlantLoading()); 
      await plantRepository.addPlant(plant);
      emit(PlantAdded()); 
    } catch (e) {
      emit(PlantError("Bitki eklenirken hata oluştu"));
    }
  }
  
}
