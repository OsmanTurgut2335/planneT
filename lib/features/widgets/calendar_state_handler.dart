import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/cubit/calendar/calendar_state.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// A widget that builds the calendar UI based on the current CalendarState.
// It handles different states like loading, error, empty, and loaded.

class CalendarStateHandler extends StatefulWidget {
  final CalendarState state;

  const CalendarStateHandler({super.key, required this.state});

  @override
  State<CalendarStateHandler> createState() => _CalendarStateHandlerState();
}

class _CalendarStateHandlerState extends State<CalendarStateHandler> {
  final ValueNotifier<DateTime> _selectedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<List<String>> _selectedEvents = ValueNotifier([]);

  @override
  void dispose() {
    _selectedDay.dispose();
    _focusedDay.dispose();
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is PlantsCalenderLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (widget.state is PlantsCalenderError) {
      return Center(
        child: Text((widget.state as PlantsCalenderError).message, style: const TextStyle(color: Colors.red)),
      );
    } else if (widget.state is PlantsCalenderEmpty) {
      return const Center(child: Text(CalendarConstants.nothingToDo));
    } else if (widget.state is PlantsCalenderLoaded) {
      final wateringSchedule = (widget.state as PlantsCalenderLoaded).wateringSchedule;
      return _buildCalendar(wateringSchedule);
    }
    return const SizedBox.shrink();
  }

  Widget _buildCalendar(Map<DateTime, List<String>> wateringSchedule) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, focusedDay, _) {
            return calendarView(focusedDay, wateringSchedule);
          },
        ),

        TodaysEvents(selectedEvents: _selectedEvents),
      ],
    );
  }

  TableCalendar<String> calendarView(DateTime focusedDay, Map<DateTime, List<String>> wateringSchedule) {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(DateTime.now().year, DateTime.now().month + 2, 0),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(_selectedDay.value, day),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: (selectedDay, newFocusedDay) {
        setState(() {
          _selectedDay.value = selectedDay;
          _focusedDay.value = newFocusedDay;
          _selectedEvents.value = _getEventsForDay(selectedDay, wateringSchedule);
        });
      },
      eventLoader: (day) => _getEventsForDay(day, wateringSchedule),
      calendarStyle: const CalendarStyle(
        markersMaxCount: CalendarConstants.markersMaxCount,
        todayDecoration: CalendarConstants.todayDecoration,
        selectedDecoration: CalendarConstants.selectedDecoration,
        markerDecoration: CalendarConstants.markerDecoration,
      ),
    );
  }

  List<String> _getEventsForDay(DateTime day, Map<DateTime, List<String>> wateringSchedule) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);

    return wateringSchedule[normalizedDay] ?? [];
  }
}

class TodaysEvents extends StatelessWidget {
  const TodaysEvents({super.key, required ValueNotifier<List<String>> selectedEvents})
    : _selectedEvents = selectedEvents;

  final ValueNotifier<List<String>> _selectedEvents;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: _selectedEvents,
      builder: (context, selectedEvents, _) {
        return Padding(
          padding: const EdgeInsets.all(Paddings.defaultPadding),
          child:
              selectedEvents.isNotEmpty
                  ? WateringPlantsColumn(events: selectedEvents)
                  : const Padding(
                    padding: EdgeInsets.all(Paddings.defaultPadding),
                    child: Text(CalendarConstants.noWatering),
                  ),
        );
      },
    );
  }
}

class WateringPlantsColumn extends StatelessWidget {
  const WateringPlantsColumn({super.key, required this.events});
  final List<String> events;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(Paddings.defaultPadding),
          child: Text(CalendarConstants.plantsToWater, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),

        ...events.map(
          (plantName) => Card(
            margin: const EdgeInsets.symmetric(vertical: Paddings.defaultPadding / 2),
            child: ListTile(leading: const Icon(Icons.local_florist, color: Colors.green), title: Text(plantName)),
          ),
        ),
      ],
    );
  }
}

class CalendarConstants {
  const CalendarConstants._();
  static const noWatering = "Bu tarihte sulama yok.";
  static const plantsToWater = "Bu tarihte sulanması gereken bitkiler:";
  static const nothingToDo = "Bu tarihte yapılacak bir şey yok!";


  static const int markersMaxCount = 1;


  static const BoxDecoration todayDecoration = BoxDecoration(color: Colors.blue, shape: BoxShape.circle);


  static const BoxDecoration selectedDecoration = BoxDecoration(color: Colors.green, shape: BoxShape.circle);


  static const BoxDecoration markerDecoration = BoxDecoration(color: AppColors.deepPine, shape: BoxShape.rectangle);
}
