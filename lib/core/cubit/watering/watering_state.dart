import 'package:allplant/features/models/upcoming_event.dart';

abstract class WateringState {}

class TodaysWateringsLoading extends WateringState {}

// Plants that need watering today.
class TodaysWateringsLoaded extends WateringState {
  TodaysWateringsLoaded(this.plants);
  final List<WateringEvent> plants;
}

class TodaysWateringsEmpty extends WateringState {}

class TodaysWateringsError extends WateringState {
  TodaysWateringsError(this.message);
  final String message;
}

class ToggleWateredSuccess extends WateringState {}

class ToggleWateredError extends WateringState {
  ToggleWateredError(this.message);
  final String message;
}
