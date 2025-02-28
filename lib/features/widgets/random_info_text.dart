import 'package:flutter/material.dart';

class DidYouKnowSection extends StatelessWidget {
  final String info;

  const DidYouKnowSection({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Text("Bunu biliyor muydun?", style: Theme.of(context).textTheme.headlineMedium),
          Text(info, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
