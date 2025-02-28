
import 'package:allplant/core/constants/paddings.dart';
import 'package:flutter/material.dart';


class HeaderText extends StatelessWidget {
  final String text;

  const HeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
          Paddings.textPadding
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
