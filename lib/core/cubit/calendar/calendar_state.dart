abstract class CalendarState{}

class PlantsCalenderLoading extends CalendarState {} 

class PlantsCalenderLoaded extends CalendarState {
  PlantsCalenderLoaded(this.wateringSchedule);
  final Map<DateTime, List<String>> wateringSchedule;
}

class PlantsCalenderEmpty extends CalendarState {}

class PlantsCalenderError extends CalendarState {
  PlantsCalenderError(this.message);
  final String message;
}
