part of 'recordings_screen.dart';

class _RecordingsScreenComponents extends StatelessWidget {
  const _RecordingsScreenComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;

    final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);
    final recordings = recordingsBloc.state.recordings ?? [];
    final playerBloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recordings',
          style: mediumText,
        ),
      ),
      body: ListView.builder(
        itemCount: recordings.length,
        itemBuilder: (context, index) => Card(
          child: StreamBuilder<PlayerInfo>(
              stream: playerBloc.state.playerInfoStream,
              builder: (context, snapshot) {
                bool isPlaying = snapshot.data?.state.isPlaying ?? false;
                bool isPaused = snapshot.data?.state.isPaused ?? false;
                bool isStopped = snapshot.data?.state.isStopped ?? false;
                bool isPlayingTile = (isPlaying || isPaused) &&
                    recordings[index].path ==
                        playerBloc.state.playingFile?.path;
                late final Icon trailingIcon;
                const playIcon = Icon(
                  Icons.play_circle_outline,
                  color: Colors.blue,
                );
                const pauseIcon = Icon(
                  Icons.pause_circle_outline,
                  color: Colors.red,
                );
                if (isPlaying && isPlayingTile) {
                  trailingIcon = pauseIcon;
                } else {
                  trailingIcon = playIcon;
                }

                late Slider slider;

                final max =
                    recordings[index].duration?.inMilliseconds.toDouble() ??
                        0.0;
                const min = 0.0;
                double value =
                    snapshot.data?.position.inMilliseconds.toDouble() ?? 0.0;
                if (value > max) {
                  value = max;
                }
                slider = Slider(
                  value: value,
                  min: min,
                  max: max,
                  onChanged: (value) {
                    playerBloc.add(
                      PlayerBlocEvent.seekToPosition(
                        Duration(
                          milliseconds: value.round(),
                        ),
                      ),
                    );
                  },
                );
                return Dismissible(
                  key: Key(recordings[index].name),
                  direction: DismissDirection.startToEnd,
                  background: Stack(
                    children: [
                      Container(color: Theme.of(context).errorColor),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Text('Release to delete',
                              style: mediumText.copyWith(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  confirmDismiss: (direction) async {
                    bool shouldDelete = await showDialog(
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
                                  style:
                                      mediumText.copyWith(color: Colors.blue)),
                              onPressed: () => Navigator.of(context).pop(false),
                            ),
                            SimpleDialogOption(
                              child: Text('Yes',
                                  style:
                                      mediumText.copyWith(color: Colors.red)),
                              onPressed: () => Navigator.of(context).pop(true),
                            ),
                          ],
                          contentPadding: const EdgeInsets.all(20),
                          actionsAlignment: MainAxisAlignment.center,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    );
                    if (shouldDelete) {
                      if (isPlaying || isPaused) {
                        playerBloc.add(const PlayerBlocEvent.stop());
                      }
                      recordingsBloc.add(
                        RecordingsBlocEvent.deleteRecording(
                          File(recordings[index].path),
                        ),
                      );
                    }
                    return shouldDelete;
                  },
                  child: Column(
                    children: [
                      ListTile(
                        isThreeLine: isPlaying && isPlayingTile,
                        leading: Icon(
                          Icons.mic_none,
                          size: width / 15,
                        ),
                        title: Text(
                          recordings[index].name,
                          style: mediumText,
                        ),
                        subtitle: Text(recordings[index].duration.toString()),
                        trailing: GestureDetector(
                          child: trailingIcon,
                          onTap: () async {
                            if (isStopped) {
                              playerBloc.add(
                                PlayerBlocEvent.start(
                                  file: File(recordings[index].path),
                                  onDone: () => playerBloc.add(
                                      const PlayerBlocEvent.playbackEnded()),
                                ),
                              );
                            } else if (isPlaying) {
                              if (isPlayingTile) {
                                playerBloc.add(const PlayerBlocEvent.pause());
                              } else {
                                playerBloc.add(const PlayerBlocEvent.stop());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                playerBloc.add(
                                  PlayerBlocEvent.start(
                                    file: File(recordings[index].path),
                                    onDone: () => playerBloc.add(
                                        const PlayerBlocEvent.playbackEnded()),
                                  ),
                                );
                              }
                            } else if (isPaused) {
                              if (isPlayingTile) {
                                playerBloc.add(const PlayerBlocEvent.resume());
                              } else {
                                playerBloc.add(const PlayerBlocEvent.stop());
                                await Future.delayed(
                                    const Duration(milliseconds: 50));
                                playerBloc.add(
                                  PlayerBlocEvent.start(
                                    file: File(recordings[index].path),
                                    onDone: () => playerBloc.add(
                                        const PlayerBlocEvent.playbackEnded()),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ),
                      if ((isPlaying || isPaused) && isPlayingTile) slider,
                    ],
                  ),
                );
              }),
          elevation: 0,
        ),
      ),
    );
  }
}
