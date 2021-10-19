part of 'recordings_screen.dart';

class _RecordingsScreenComponents extends StatelessWidget {
  const _RecordingsScreenComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Recordings',
            style: mediumText,
          ),
        ),
        body: _RecordingsListView(),
      );
}
