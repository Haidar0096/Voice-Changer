part of 'recorder_screen.dart';

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Text(
            'Error: ${BlocProvider.of<RecorderBloc>(context).state.errorMessage!}',
            style: mediumText,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
