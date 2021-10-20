import 'package:flutter/material.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

class ErrorWidget extends StatelessWidget {
  final String message;

  const ErrorWidget(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(
            'Error: $message',
            style: mediumText,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
