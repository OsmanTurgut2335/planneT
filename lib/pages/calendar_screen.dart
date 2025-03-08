import 'package:allplant/features/cubit/myplants/my_plant_cubit.dart';
import 'package:allplant/features/cubit/myplants/my_plants_state.dart';
import 'package:allplant/features/widgets/calendar_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlantListCubit()..loadWateringDates(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Sulama Takvimi")),
        body: BlocBuilder<PlantListCubit, PlantListState>(
          builder: (context, state) {
            return CalendarStateHandler(state: state); 
          },
        ),
      ),
    );
  }
}
