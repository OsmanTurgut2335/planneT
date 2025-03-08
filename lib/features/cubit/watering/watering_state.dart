
import 'package:allplant/features/models/plant.dart';
import 'package:allplant/features/models/upcoming_event.dart';

abstract class WateringState {}

class TodaysWateringsLoading extends WateringState {}

class TodaysWateringsLoaded extends WateringState {
  final List<WateringEvent> plants; // Plants that need watering today.
  TodaysWateringsLoaded(this.plants);
}

class TodaysWateringsEmpty extends WateringState {}

class TodaysWateringsError extends WateringState {
  final String message;
  TodaysWateringsError(this.message);
}
