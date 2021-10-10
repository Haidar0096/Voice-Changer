part of 'recorder_screen.dart';

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String errorMessage = BlocProvider.of<RecorderBloc>(context)
        .state
        .errorMessageOption
        .toNullable()!;
    return Scaffold(
      body: Center(
        child: Text(
          'Error: $errorMessage',
          style: mediumText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
