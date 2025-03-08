import 'package:allplant/features/models/plant.dart';

class WateringEvent {
  final Plant plant;
  final DateTime wateringDate;

  WateringEvent({
    required this.plant,
    required this.wateringDate,
  });
}
