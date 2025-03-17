import 'package:flutter/material.dart';

class CommonPositioned extends StatelessWidget {

  const CommonPositioned({
    super.key,
    this.top ,
    this.left = 0.0,
    this.right = 0.0,
    this.bottom ,
    this.height,
    required this.child,
  });
  final double? top;
  final double left;
  final double right;
  final double? bottom;
  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned(top: top, left: left, right: right, bottom: bottom, height: height, child: child);
  }
}
