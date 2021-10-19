part of 'recordings_screen.dart';

class _RecordingTileContents extends StatelessWidget {
  final int _index;

  const _RecordingTileContents(this._index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PlayerBloc, PlayerBlocState>(
        builder: (context, playerBlocState) =>
            BlocBuilder<RecordingsBloc, RecordingsBlocState>(
          builder: (context, recordingsBlocState) {
            final playerBloc = BlocProvider.of<PlayerBloc>(context);

            final mq = MediaQuery.of(context);
            final width = mq.size.width;

            bool isPlaying = playerBlocState.playerState.isPlaying;
            bool isPaused = playerBlocState.playerState.isPaused;
            bool isStopped = playerBlocState.playerState.isStopped;

            bool isProcessing = playerBlocState.isProcessing ||
                recordingsBlocState.isProcessing;

            bool isPlayingTile = (isPlaying || isPaused) &&
                recordingsBlocState.recordings[_index] ==
                    playerBlocState.recording;

            return Column(
              children: [
                ListTile(
                  isThreeLine: isPlaying && isPlayingTile,
                  leading: _micIcon(width),
                  title: _title(recordingsBlocState.recordings),
                  subtitle: _subTitle(recordingsBlocState.recordings),
                  trailing: GestureDetector(
                    child: _trailingIcon(
                        isPlaying, isPlayingTile, isProcessing, 60),
                    onTap: isProcessing
                        ? null
                        : _onTap(
                            isStopped,
                            playerBloc,
                            recordingsBlocState.recordings,
                            isPlaying,
                            isPlayingTile,
                            isPaused),
                  ),
                ),
                if ((isPlaying || isPaused) && isPlayingTile)
                  _slider(playerBloc, playerBlocState),
              ],
            );
          },
        ),
      );

  _onTap(
    bool isStopped,
    PlayerBloc playerBloc,
    List<RecordingDetails> recordings,
    bool isPlaying,
    bool isPlayingTile,
    bool isPaused,
  ) {
    return () async {
      if (isStopped) {
        playerBloc.add(PlayerBlocEvent.start(recording: recordings[_index]));
      } else if (isPlaying) {
        if (isPlayingTile) {
          playerBloc.add(const PlayerBlocEvent.pause());
        } else {
          playerBloc.add(
            PlayerBlocEvent.stop(
              onDone: () => playerBloc.add(
                PlayerBlocEvent.start(recording: recordings[_index]),
              ),
            ),
          );
        }
      } else if (isPaused) {
        if (isPlayingTile) {
          playerBloc.add(const PlayerBlocEvent.resume());
        } else {
          playerBloc.add(
            PlayerBlocEvent.stop(
              onDone: () => playerBloc.add(
                PlayerBlocEvent.start(recording: recordings[_index]),
              ),
            ),
          );
        }
      }
    };
  }

  Text _subTitle(recordings) => Text(recordings[_index].duration.toString());

  Icon _micIcon(double width) {
    return Icon(
      Icons.mic_none,
      size: width / 15,
    );
  }

  Text _title(recordings) {
    return Text(
      recordings[_index].name,
      style: mediumText,
    );
  }

  Widget _slider(PlayerBloc playerBloc, PlayerBlocState playerBlocState) {
    final max =
        playerBloc.state.recording?.duration?.inMilliseconds.toDouble() ?? 0.0;
    const min = 0.0;
    double value = playerBloc.state.position.inMilliseconds.toDouble();
    if (value > max) {
      value = max;
    }
    return Slider(
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
  }

  Icon _trailingIcon(
          bool isPlaying, bool isPlayingTile, bool isProcessing, double size) =>
      isPlaying && isPlayingTile
          ? Icon(
              Icons.pause_circle_outline,
              color: isProcessing ? Colors.grey : Colors.red,
              size: size,
            )
          : Icon(
              Icons.play_circle_outline,
              color: isProcessing ? Colors.grey : Colors.blue,
              size: size,
            );
}
