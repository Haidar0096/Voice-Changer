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
        backgroundColor: Colors.white,
        title: Text(
          'Recordings',
          style: mediumText.copyWith(color: Colors.black),
        ),
        foregroundColor: primaryColor,
      ),
      body: ListView.builder(
        itemCount: recordings.length,
        itemBuilder: (context, index) => Card(
          child: StreamBuilder<PlayerState>(
              stream: playerBloc.state.playerStateStream,
              builder: (context, snapshot) {
                bool isPlaying = snapshot.data?.isPlaying ?? false;
                bool isPaused = snapshot.data?.isPaused ?? false;
                bool isStopped = snapshot.data?.isStopped ?? false;
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
                return Column(
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
                      trailing: InkWell(
                        child: trailingIcon,
                        onTap: () async {
                          if (isStopped) {
                            playerBloc.add(
                              PlayerBlocEvent.start(
                                file: File(recordings[index].path),
                                onDone: () => playerBloc
                                    .add(const PlayerBlocEvent.playbackEnded()),
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
                    if ((isPlaying || isPaused) && isPlayingTile)
                      StreamBuilder<Duration>(
                        stream: playerBloc.state.positionStream,
                        initialData: Duration.zero,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final max = recordings[index]
                                    .duration
                                    ?.inMilliseconds
                                    .toDouble() ??
                                0.0;
                            const min = 0.0;
                            double value =
                                snapshot.data!.inMilliseconds.toDouble();
                            if (value > max) {
                              value = max;
                            }
                            return Slider(
                              value: value,
                              min: min,
                              max: max,
                              onChanged: (_) {},
                            );
                          }
                          return Container();
                        },
                      ),
                  ],
                );
              }),
          elevation: 0,
        ),
      ),
    );
  }
}
