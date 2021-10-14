part of 'recordings_screen.dart';

class _RecordingCard extends StatelessWidget {
  final int _index;

  const _RecordingCard(this._index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _DismissibleTile(_index),
      elevation: 0,
    );
  }
}
