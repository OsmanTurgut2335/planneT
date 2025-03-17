import 'package:allplant/features/models/plant.dart';

class WateringEvent {

  WateringEvent({
    required this.plant,
    required this.wateringDate,
  });
  final Plant plant;
  final DateTime wateringDate;
}
