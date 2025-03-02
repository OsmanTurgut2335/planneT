import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/repository/plant_repository.dart';
import 'package:bloc/bloc.dart';


import 'plant_state.dart';

class PlantCubit extends Cubit<PlantState> {
  final PlantRepository plantRepository;

  PlantCubit(this.plantRepository) : super(PlantInitial());

  Future<void> addPlant(Plant plant) async {
    try {
      emit(PlantLoading()); // Yükleniyor state'i
      await plantRepository.addPlant(plant);
      emit(PlantAdded()); // Başarıyla eklendi state'i
    } catch (e) {
      emit(PlantError("Bitki eklenirken hata oluştu"));
    }
  }
}
