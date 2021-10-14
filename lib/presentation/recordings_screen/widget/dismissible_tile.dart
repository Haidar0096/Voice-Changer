part of 'recordings_screen.dart';

class _DismissibleTile extends StatelessWidget {
  final int _index;

  const _DismissibleTile(this._index);

  @override
  Widget build(BuildContext context) {
    final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);
    final recordings = recordingsBloc.state.recordings ?? [];
    final playerBloc = BlocProvider.of<PlayerBloc>(context);

    return StreamBuilder<PlayerInfo>(
      stream: playerBloc.state.playerInfoStream,
      builder: (context, snapshot) {
        bool isPlaying = snapshot.data?.state.isPlaying ?? false;
        bool isPaused = snapshot.data?.state.isPaused ?? false;
        return Dismissible(
          key: Key(recordings[_index].path),
          direction: DismissDirection.startToEnd,
          background: Stack(
            children: [
              Container(color: Theme.of(context).errorColor),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text('Release to delete',
                      style: mediumText.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
          confirmDismiss: (direction) async => await showDialog(
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  'Delete recording?',
                  style: mediumText,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  SimpleDialogOption(
                    child: Text('No',
                        style: mediumText.copyWith(color: Colors.blue)),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                  SimpleDialogOption(
                    child: Text('Yes',
                        style: mediumText.copyWith(color: Colors.red)),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
                contentPadding: const EdgeInsets.all(20),
                actionsAlignment: MainAxisAlignment.center,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
          onDismissed: (_) async {
            if (isPlaying || isPaused) {
              playerBloc.add(const PlayerBlocEvent.stop());
            }
            recordingsBloc.add(
              RecordingsBlocEvent.deleteRecording(
                recordings[_index].path,
              ),
            );
          },
          child: _RecordingTileContents(_index),
        );
      },
    );
  }
}
