import 'package:allplant/features/models/plant.dart';

abstract class PlantListState {}

class PlantListLoading extends PlantListState {}

class PlantListLoaded extends PlantListState {
  PlantListLoaded(this.plants);
  final List<Plant> plants;
}

class PlantListEmpty extends PlantListState {}

class PlantListError extends PlantListState {
  PlantListError(this.message);
  final String message;
}





