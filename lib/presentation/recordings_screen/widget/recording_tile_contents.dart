part of 'recordings_screen.dart';

class _RecordingTileContents extends StatelessWidget {
  final double _iconSize = 40;

  final int _index;

  const _RecordingTileContents(this._index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RecordingsBloc, RecordingsBlocState>(
        builder: (context, recordingsBlocState) =>
            BlocBuilder<PlayerBloc, PlayerBlocState>(
          builder: (context, playerBlocState) {
            bool isPlaying = playerBlocState.playerState.isPlaying;
            bool isPaused = playerBlocState.playerState.isPaused;
            bool isPlayingTile = (isPlaying || isPaused) &&
                recordingsBlocState.recordings[_index] ==
                    playerBlocState.recording;
            return IgnorePointer(
              //only the playing tile can be expanded while playing, all other tiles are not tappable
              ignoring: ((isPlaying || isPaused) && !isPlayingTile),
              child: ExpansionTile(
                key: isPlayingTile
                    ? Key(recordingsBlocState.recordings[_index].path)
                    : UniqueKey(),
                initiallyExpanded: isPlayingTile,
                leading: const Icon(Icons.mic),
                title: _title(context),
                subtitle: _subTitle(context),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _playButton(context),
                      _pauseButton(context),
                      _stopButton(context),
                      _editButton(context),
                      if (isPlayingTile) _slider(context),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );

  _title(BuildContext context) {
    final recording =
        BlocProvider.of<RecordingsBloc>(context).state.recordings[_index];
    return Text(recording.name, style: mediumText);
  }

  _subTitle(BuildContext context) {
    final recording =
        BlocProvider.of<RecordingsBloc>(context).state.recordings[_index];
    return Text(recording.duration.toString(), style: mediumText);
  }

  _playButton(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.play_circle_outline,
        size: _iconSize,
      ),
      onTap: () {
        final playerBloc = BlocProvider.of<PlayerBloc>(context);
        final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);
        bool isPaused = playerBloc.state.playerState.isPaused;
        bool isStopped = playerBloc.state.playerState.isStopped;
        if (isPaused) {
          playerBloc.add(const PlayerBlocEvent.resume());
        }
        if (isStopped) {
          playerBloc.add(PlayerBlocEvent.start(
              recording: recordingsBloc.state.recordings[_index]));
        }
      },
    );
  }

  _pauseButton(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.pause_circle_outline,
        size: _iconSize,
      ),
      onTap: () {
        final playerBloc = BlocProvider.of<PlayerBloc>(context);
        bool isPlaying = playerBloc.state.playerState.isPlaying;
        if (isPlaying) {
          playerBloc.add(const PlayerBlocEvent.pause());
        }
      },
    );
  }

  _stopButton(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.stop_circle_outlined,
        size: _iconSize,
      ),
      onTap: () {
        final playerBloc = BlocProvider.of<PlayerBloc>(context);
        bool isPlaying = playerBloc.state.playerState.isPlaying;
        bool isPaused = playerBloc.state.playerState.isPaused;
        if (isPlaying || isPaused) {
          playerBloc.add(const PlayerBlocEvent.stop());
        }
      },
    );
  }

  _editButton(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.edit,
        size: _iconSize - 10,
      ),
      onTap: () {
        final playerBloc = BlocProvider.of<PlayerBloc>(context);
        final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);
        bool isPlaying = playerBloc.state.playerState.isPlaying;
        bool isPaused = playerBloc.state.playerState.isPaused;
        if (isPlaying || isPaused) {
          playerBloc.add(const PlayerBlocEvent.stop());
        }
        Navigator.of(context)
            .pushNamed(
              SoundChangerScreen.routeName,
              arguments: recordingsBloc.state.recordings[_index],
            )
            .then(
              (_) => recordingsBloc.add(
                const RecordingsBlocEvent.refresh(),
              ),
            );
      },
    );
  }

  _slider(BuildContext context) {
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    final max =
        playerBloc.state.recording?.duration?.inMilliseconds.toDouble() ?? 0;
    double value = (playerBloc.state.position.inMilliseconds.toDouble());
    if (value > max) {
      value = max;
    }
    return Slider(
      min: 0.0,
      max: max,
      value: value,
      onChanged: (value) => playerBloc.add(PlayerBlocEvent.seekToPosition(
          Duration(milliseconds: value.round()))),
    );
  }
}
