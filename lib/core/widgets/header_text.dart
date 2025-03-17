
import 'package:allplant/core/constants/paddings.dart';
import 'package:flutter/material.dart';


class HeaderText extends StatelessWidget {

  const HeaderText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
          Paddings.defaultPadding
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
