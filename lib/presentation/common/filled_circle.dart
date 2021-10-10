import 'package:flutter/material.dart';

class FilledCircle extends StatelessWidget {
  final double radius;
  final Color color;

  const FilledCircle({
    Key? key,
    required this.radius,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipOval(
        child: Container(
          width: radius,
          height: radius,
          color: color,
        ),
      );
}
