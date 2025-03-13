import 'package:allplant/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:allplant/core/constants/paddings.dart';
import 'package:allplant/core/cubit/watering/watering_cubit.dart';
import 'package:allplant/core/cubit/watering/watering_state.dart';
import 'package:allplant/core/provider/provider_factory.dart';

class UpcomingWateringsList extends StatelessWidget {
  const UpcomingWateringsList({super.key});

  @override
  Widget build(BuildContext context) {
    return buildWateringProvider(
      child: BlocBuilder<TodaysWateringsCubit, WateringState>(
        builder: (context, state) {
          if (state is TodaysWateringsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodaysWateringsError) {
            return Center(child: ErrorMessage(wateringState: state));
          } else if (state is TodaysWateringsEmpty) {
            return const Center(child: Text("No upcoming waterings!"));
          } else if (state is TodaysWateringsLoaded) {
            final events = state.plants;

            return SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Paddings.borderRadius)),
                    child: ListTile(
                      leading: const Icon(Icons.alarm, color: AppColors.iconColor, size: _Constants.iconSize),
                      title: Text(event.plant.name),
                      subtitle: Text(_buildSubtitle(event.wateringDate)),
                      trailing: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          context.read<TodaysWateringsCubit>().toggleWatered(event.plant);
                        },
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _buildSubtitle(DateTime wateringDate) {
    final daysLeft = _daysUntil(wateringDate);
    if (daysLeft <= 0) {
      return "Bugün sulanmalı";
    } else if (daysLeft == 1) {
      return "Yarın sulanmalı";
    } else {
      return "$daysLeft gün içinde sulanmalı";
    }
  }

  int _daysUntil(DateTime wateringDate) {
    final now = DateTime.now();
    final normalizedNow = DateTime(now.year, now.month, now.day);
    final normalizedWateringDate = DateTime(wateringDate.year, wateringDate.month, wateringDate.day);
    return normalizedWateringDate.difference(normalizedNow).inDays;
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, required this.wateringState});

  final TodaysWateringsError wateringState;

  @override
  Widget build(BuildContext context) {
    return Text(wateringState.message, style: const TextStyle(color: Colors.red));
  }
}

class _Constants {
  const _Constants._();
  // static const double cardHeight = 300;
  static const double iconSize = 30;
}
