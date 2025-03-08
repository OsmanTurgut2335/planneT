// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:allplant/features/cubit/myplants/my_plants_state.dart';

class CalendarStateHandler extends StatefulWidget {
  final PlantListState state; // 🔥 Artık dışarıdan state alıyor!

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
      return const Center(child: Text("Bugün yapılacak bir şey yok!"));
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
            return TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime.now(),
              lastDay: DateTime(DateTime.now().year, DateTime.now().month + 2, 0),
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay.value, day),
              onDaySelected: (selectedDay, newFocusedDay) {
                setState(() {
                  _selectedDay.value = selectedDay;
                  _focusedDay.value = newFocusedDay;
                  _selectedEvents.value = _getEventsForDay(selectedDay, wateringSchedule);
                });
              },
              eventLoader: (day) => _getEventsForDay(day, wateringSchedule),
              calendarStyle: const CalendarStyle(
                markersMaxCount: 1,
                todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                markerDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.rectangle),
              ),
            );
          },
        ),

        ValueListenableBuilder<List<String>>(
          valueListenable: _selectedEvents,
          builder: (context, selectedEvents, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  selectedEvents.isNotEmpty
                      ? WateringPlantsColumn(events: selectedEvents)
                      : const Padding(padding: EdgeInsets.all(8.0), child: Text("Bugün sulama yok.")),
            );
          },
        ),
      ],
    );
  }

  List<String> _getEventsForDay(DateTime day, Map<DateTime, List<String>> wateringSchedule) {
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    print(wateringSchedule);
    print(normalizedDay);
    print(wateringSchedule[normalizedDay]);
    return wateringSchedule[normalizedDay] ?? [];
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
          padding: EdgeInsets.all(8.0),
          child: Text("Bugün sulanması gereken bitkiler:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        // 🔥 Replace Wrap with a Column of Cards
        ...events.map(
          (plantName) => Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(leading: const Icon(Icons.local_florist, color: Colors.green), title: Text(plantName)),
          ),
        ),
      ],
    );
  }
}
