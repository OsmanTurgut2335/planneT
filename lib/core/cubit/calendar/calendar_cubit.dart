import 'package:allplant/core/cubit/calendar/calendar_state.dart';
import 'package:allplant/core/repository/calendar/calendar_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit({required this.calendarRepository}) : super(PlantsCalenderInitial());
  final CalendarRepository calendarRepository;
  
  Future<void> loadWateringDates() async {
    emit(PlantsCalenderLoading());
    try {
      final wateringSchedule = await calendarRepository.loadWateringDates();
      if (wateringSchedule.isEmpty) {
        emit(PlantsCalenderEmpty());
      } else {
        emit(PlantsCalenderLoaded(wateringSchedule));
      }
    } catch (e) {
      emit(PlantsCalenderError('Sulama tarihleri yüklenirken hata oluştu'));
    }
  }
}
