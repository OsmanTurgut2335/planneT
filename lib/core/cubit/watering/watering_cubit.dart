import 'package:allplant/core/cubit/watering/watering_state.dart';
import 'package:allplant/core/repository/watering/water_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:allplant/features/models/plant.dart';


class TodaysWateringsCubit extends Cubit<WateringState> {
  final WateringRepository repository;

  TodaysWateringsCubit({required this.repository}) : super(TodaysWateringsLoading()) {
    loadUpcomingWaterings();
  }

  void loadUpcomingWaterings() async {
    emit(TodaysWateringsLoading());
    try {
      final upcomingEvents = await repository.getUpcomingWaterings();
      if (upcomingEvents.isEmpty) {
        emit(TodaysWateringsEmpty());
      } else {
        emit(TodaysWateringsLoaded(upcomingEvents));
      }
    } catch (e) {
      emit(TodaysWateringsError("Error loading upcoming waterings: $e"));
    }
  }

  Future<void> toggleWatered(Plant plant) async {
    try {
      await repository.toggleWatered(plant);
      loadUpcomingWaterings();
    } catch (e) {
      emit(TodaysWateringsError("Error updating watering status: $e"));
    }
  }
}
