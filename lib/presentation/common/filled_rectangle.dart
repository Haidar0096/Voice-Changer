import 'package:flutter/material.dart';

class FilledRectangle extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const FilledRectangle({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
    );
  }
}
