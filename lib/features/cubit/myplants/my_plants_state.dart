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
