import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/features/cubit/addplant/add_plant_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WateringSlider extends StatelessWidget {
  const WateringSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPlantCubit>();
    final wateringFrequency = context.select<AddPlantCubit, int>((cubit) => cubit.state.wateringFrequency);

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: AppColors.deepPine,
        inactiveTrackColor: AppColors.deepPine.withValues(alpha: 0.2),
        thumbColor: AppColors.deepPine,
        overlayColor: AppColors.deepPine.withValues(alpha: 0.2),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
        valueIndicatorColor: const Color(0xFFD8DDD7),
        valueIndicatorTextStyle: const TextStyle(color: Colors.white),
      ),
      child: Slider(
        value: wateringFrequency.toDouble(),
        min: 1,
        max: 30,
        divisions: 29,
        label: wateringFrequency.toString(),
        onChanged: (value) {
          cubit.updateWateringFrequency(value.toInt());
        },
      ),
    );
  }
}
