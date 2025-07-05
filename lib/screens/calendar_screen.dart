//  The main screen that displays the watering calendar.
// It creates a CalendarCubit and passes its state to CalendarStateHandler.

import 'package:allplant/core/cubit/calendar/calendar_cubit.dart';
import 'package:allplant/core/cubit/calendar/calendar_state.dart';

import 'package:allplant/core/repository/calendar/calendar_repository.dart';

import 'package:allplant/features/widgets/calendar_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarCubit _calendarCubit;
  @override
  void initState() {
    super.initState();
    _calendarCubit = CalendarCubit(calendarRepository: CalendarRepository());
    _calendarCubit.loadWateringDates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _calendarCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text('Sulama Takvimi')),
        body: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            return CalendarStateHandler(state: state);
          },
        ),
      ),
    );
  }
}

class CalendarStrings {
  const CalendarStrings._();
  static const wateringSchedule = 'Sulama Takvimi';
}
