part of 'recordings_screen.dart';

class _RecordingTileContents extends StatelessWidget {
  final int _index;

  const _RecordingTileContents(this._index);

  @override
  Widget build(BuildContext context) {
    final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);
    final recordings = recordingsBloc.state.recordings ?? [];
    final playerBloc = BlocProvider.of<PlayerBloc>(context);

    final mq = MediaQuery.of(context);
    final width = mq.size.width;

    return StreamBuilder<PlayerInfo>(
        stream: playerBloc.state.playerInfoStream,
        builder: (context, snapshot) {
          bool isPlaying = snapshot.data?.state.isPlaying ?? false;
          bool isPaused = snapshot.data?.state.isPaused ?? false;
          bool isStopped = snapshot.data?.state.isStopped ?? false;
          bool isPlayingTile = (isPlaying || isPaused) &&
              recordings[_index] == playerBloc.state.recording;

          Icon trailingIcon = _trailingIcon(isPlaying, isPlayingTile);

          Slider slider = _slider(playerBloc, snapshot);

          return Column(
            children: [
              ListTile(
                isThreeLine: isPlaying && isPlayingTile,
                leading: Icon(
                  Icons.mic_none,
                  size: width / 15,
                ),
                title: Text(
                  recordings[_index].name,
                  style: mediumText,
                ),
                subtitle: Text(recordings[_index].duration.toString()),
                trailing: GestureDetector(
                  child: trailingIcon,
                  onTap: () async {
                    if (isStopped) {
                      playerBloc.add(
                        PlayerBlocEvent.start(
                          recording: recordings[_index],
                          onDone: () => playerBloc
                              .add(const PlayerBlocEvent.playbackEnded()),
                        ),
                      );
                    } else if (isPlaying) {
                      if (isPlayingTile) {
                        playerBloc.add(const PlayerBlocEvent.pause());
                      } else {
                        playerBloc.add(const PlayerBlocEvent.stop());
                        await Future.delayed(const Duration(milliseconds: 50));
                        playerBloc.add(
                          PlayerBlocEvent.start(
                            recording: recordings[_index],
                            onDone: () => playerBloc
                                .add(const PlayerBlocEvent.playbackEnded()),
                          ),
                        );
                      }
                    } else if (isPaused) {
                      if (isPlayingTile) {
                        playerBloc.add(const PlayerBlocEvent.resume());
                      } else {
                        playerBloc.add(const PlayerBlocEvent.stop());
                        await Future.delayed(const Duration(milliseconds: 50));
                        playerBloc.add(
                          PlayerBlocEvent.start(
                            recording: recordings[_index],
                            onDone: () => playerBloc
                                .add(const PlayerBlocEvent.playbackEnded()),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              if ((isPlaying || isPaused) && isPlayingTile) slider,
            ],
          );
        });
  }

  Slider _slider(PlayerBloc playerBloc, AsyncSnapshot<PlayerInfo> snapshot) {
    late Slider slider;

    final max =
        playerBloc.state.recording?.duration?.inMilliseconds.toDouble() ?? 0.0;
    const min = 0.0;
    double value = snapshot.data?.position.inMilliseconds.toDouble() ?? 0.0;
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
    return slider;
  }

  Icon _trailingIcon(bool isPlaying, bool isPlayingTile) {
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
    return trailingIcon;
  }
}
