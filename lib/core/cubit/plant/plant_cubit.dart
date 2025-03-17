import 'package:allplant/core/cubit/plant/plant_state.dart';
import 'package:allplant/core/repository/plant/plant_repository.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:bloc/bloc.dart';

class PlantCubit extends Cubit<PlantState> {

  PlantCubit(this.plantRepository) : super(PlantInitial());
  final PlantRepository plantRepository;

  Future<void> addPlant(Plant plant) async {
    try {
      emit(PlantLoading()); 
      await plantRepository.addPlant(plant);
      emit(PlantAdded()); 
    } catch (e) {
      emit(PlantError('Bitki eklenirken hata oluştu'));
    }
  }
  
}
