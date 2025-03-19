import 'package:allplant/core/cubit/watering/watering_state.dart';
import 'package:allplant/core/repository/watering/water_repository.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:bloc/bloc.dart';

class TodaysWateringsCubit extends Cubit<WateringState> {
  TodaysWateringsCubit({required this.repository})
    : super(TodaysWateringsLoading()) {
    loadUpcomingWaterings();
  }
  final WateringRepository repository;

  Future<void> loadUpcomingWaterings() async {
    emit(TodaysWateringsLoading());
    try {
      final upcomingEvents = await repository.getUpcomingWaterings();
      if (upcomingEvents.isEmpty) {
        emit(TodaysWateringsEmpty());
      } else {
        emit(TodaysWateringsLoaded(upcomingEvents));
      }
    } catch (e) {
      emit(TodaysWateringsError('Error loading upcoming waterings: $e'));
    }
  }

  Future<void> toggleWatered(Plant plant) async {
    try {
      await repository.toggleWatered(plant);
      emit(ToggleWateredSuccess());
      await loadUpcomingWaterings();
    } catch (e) {
      emit(ToggleWateredError('Error updating watering status: $e'));
    }
  }
}
