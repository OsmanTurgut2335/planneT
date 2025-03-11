abstract class CalendarState{}

class PlantsCalenderLoading extends CalendarState {} 

class PlantsCalenderLoaded extends CalendarState {
  final Map<DateTime, List<String>> wateringSchedule;
  PlantsCalenderLoaded(this.wateringSchedule);
}

class PlantsCalenderEmpty extends CalendarState {}

class PlantsCalenderError extends CalendarState {
  final String message;
  PlantsCalenderError(this.message);
}
