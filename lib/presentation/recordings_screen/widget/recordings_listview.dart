part of 'recordings_screen.dart';

class _RecordingsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RecordingsBloc, RecordingsBlocState>(
        builder: (context, recordingsBlocState) {
          bool isPlaying = false;
          bool isPaused = false;
          bool isProcessing = false;

          final playerBloc = BlocProvider.of<PlayerBloc>(context);
          final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);

          return BlocListener<PlayerBloc, PlayerBlocState>(
            listener: (context, playerBlocState) {
              isPlaying = playerBlocState.playerState.isPlaying;
              isPaused = playerBlocState.playerState.isPaused;
              isProcessing = playerBlocState.isProcessing ||
                  recordingsBlocState.isProcessing;
            },
            child: ListView.builder(
              itemCount: recordingsBlocState.recordings.length,
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                background: _dismissibleBackground(context),
                confirmDismiss: (direction) async =>
                    isProcessing ? false : await _confirmDismiss(context),
                onDismissed: (_) async {
                  if (isPlaying || isPaused) {
                    playerBloc.add(
                      PlayerBlocEvent.stop(
                        onDone: () => recordingsBloc.add(
                          RecordingsBlocEvent.deleteRecording(
                            recordingsBlocState.recordings[index].path,
                          ),
                        ),
                      ),
                    );
                    return;
                  }
                  recordingsBloc.add(
                    RecordingsBlocEvent.deleteRecording(
                      recordingsBlocState.recordings[index].path,
                    ),
                  );
                },
                child: _RecordingTileContents(index),
              ),
            ),
          );
        },
      );

  Future<bool?> _confirmDismiss(BuildContext context) async => await showDialog(
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
                child:
                    Text('No', style: mediumText.copyWith(color: Colors.blue)),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              SimpleDialogOption(
                child:
                    Text('Yes', style: mediumText.copyWith(color: Colors.red)),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
            contentPadding: const EdgeInsets.all(20),
            actionsAlignment: MainAxisAlignment.center,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
      );

  Stack _dismissibleBackground(BuildContext context) => Stack(
        children: [
          Container(color: Theme.of(context).errorColor),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text('Release to delete',
                  style: mediumText.copyWith(color: Colors.white)),
            ),
          ),
        ],
      );
}
