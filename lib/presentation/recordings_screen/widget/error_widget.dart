part of 'recordings_screen.dart';

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? playerBlocErrorMessage =
        BlocProvider.of<PlayerBloc>(context).state.errorMessage;
    String? recordingsBlocErrorMessage =
        BlocProvider.of<RecordingsBloc>(context).state.errorMessage;
    return Scaffold(
      body: Center(
        child: Text(
          'Error: ${playerBlocErrorMessage ?? ''} ${recordingsBlocErrorMessage != null ? 'and $recordingsBlocErrorMessage' : ''}',
          style: mediumText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
