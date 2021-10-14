part of 'recordings_screen.dart';

class _RecordingsScreenComponents extends StatelessWidget {
  const _RecordingsScreenComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recordings =
        (BlocProvider.of<RecordingsBloc>(context).state.recordings ?? []);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recordings',
          style: mediumText,
        ),
      ),
      body: ListView.builder(
        itemCount: recordings.length,
        itemBuilder: (context, index) => _RecordingCard(index),
      ),
    );
  }
}
