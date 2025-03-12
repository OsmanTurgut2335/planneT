// core/providers/watering_provider.dart

import 'package:allplant/core/cubit/watering/watering_cubit.dart';
import 'package:allplant/core/repository/watering/water_repository.dart';
import 'package:allplant/features/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

Widget buildWateringProvider({required Widget child}) {
  return BlocProvider(
    create: (context) => TodaysWateringsCubit(
      repository: WateringRepository(plantBox: Hive.box<Plant>('plants')),
    ),
    child: child,
  );
}
