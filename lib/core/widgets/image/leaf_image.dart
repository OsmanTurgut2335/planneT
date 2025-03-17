import 'package:flutter/material.dart';

enum LeafPosition { topRight, bottomRight }

class LeafImage extends StatelessWidget {

  const LeafImage({required this.position, super.key});
  final LeafPosition position;

  @override
  Widget build(BuildContext context) {
    switch (position) {
      case LeafPosition.topRight:
        return Positioned(top: 0, right: 0, child: Image.asset('assets/images/leaf.png', width: 150));
      case LeafPosition.bottomRight:
        return Positioned(bottom: 0, right: 0, child: Image.asset('assets/images/leaf_downwards.png', width: 150));
    }
  }
}
