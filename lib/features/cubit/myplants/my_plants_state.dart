import 'package:allplant/features/models/plant.dart';

abstract class PlantListState {}

class PlantListLoading extends PlantListState {}

class PlantListLoaded extends PlantListState {
  final List<Plant> plants;
  PlantListLoaded(this.plants);
}

class PlantListEmpty extends PlantListState {}

class PlantListError extends PlantListState {
  final String message;
  PlantListError(this.message);
}


class PlantsCalenderLoading extends PlantListState {} // Yükleniyor

class PlantsCalenderLoaded extends PlantListState {
  final Map<DateTime, List<String>> wateringSchedule;
  PlantsCalenderLoaded(this.wateringSchedule);
}

class PlantsCalenderEmpty extends PlantListState {} // Veri yok

class PlantsCalenderError extends PlantListState {
  final String message;
  PlantsCalenderError(this.message);
}



