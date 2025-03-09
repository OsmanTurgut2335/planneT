import 'package:allplant/core/constants/app_colors.dart';
import 'package:allplant/core/constants/strings.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({super.key, required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${AppStrings.lastWateredLabel} ${selectedDate.toString().split(' ')[0]}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today, color: AppColors.deepPine),
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              onDateSelected(pickedDate);
            }
          },
        ),
      ],
    );
  }
}
