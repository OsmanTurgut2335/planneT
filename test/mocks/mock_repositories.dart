import 'package:allplant/core/repository/addplant/add_plant_repository.dart';
import 'package:allplant/core/repository/calendar/calendar_repository.dart';
import 'package:allplant/core/repository/myplants/my_plants_repository.dart';
import 'package:allplant/core/repository/watering/water_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockMyPlantsRepository extends Mock implements MyPlantsRepository {}

class MockCalendarRepository extends Mock implements CalendarRepository {}

class MockWateringRepository extends Mock implements WateringRepository {}

class MockAddPlantRepository extends Mock implements AddPlantRepository {}
