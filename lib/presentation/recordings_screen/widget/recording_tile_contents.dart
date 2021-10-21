part of 'recordings_screen.dart';

class _RecordingTileContents extends StatefulWidget {
  final int _index;

  const _RecordingTileContents(this._index, {Key? key}) : super(key: key);

  @override
  State<_RecordingTileContents> createState() => _RecordingTileContentsState();
}

class _RecordingTileContentsState extends State<_RecordingTileContents> {
  late final CustomPopupMenuController _popupMenuController;

  final double _iconSize = 40;

  @override
  void initState() {
    super.initState();
    _popupMenuController = CustomPopupMenuController();
  }

  @override
  dispose() {
    _popupMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RecordingsBloc, RecordingsBlocState>(
        builder: (context, recordingsBlocState) =>
            BlocBuilder<PlayerBloc, PlayerBlocState>(
          builder: (context, playerBlocState) {
            bool isPlaying = playerBlocState.playerState.isPlaying;
            bool isPaused = playerBlocState.playerState.isPaused;
            bool isPlayingTile = (isPlaying || isPaused) &&
                recordingsBlocState.recordings[widget._index] ==
                    playerBlocState.recording;
            return IgnorePointer(
              ignoring: ((isPlaying || isPaused) && !isPlayingTile),
              child: CustomPopupMenu(
                pressType: PressType.longPress,
                controller: _popupMenuController,
                menuBuilder: () => _popupMenu(context),
                showArrow: true,
                child: ExpansionTile(
                  key: UniqueKey(),
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
                        if (isPlayingTile) _slider(context),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _popupMenu(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final playerBloc = BlocProvider.of<PlayerBloc>(context);
    final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);
    bool isPlaying = playerBloc.state.playerState.isPlaying;
    bool isPaused = playerBloc.state.playerState.isPaused;
    return Container(
      width: width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child: Text('edit', style: mediumText),
              onPressed: () {
                if (isPlaying || isPaused) {
                  playerBloc.add(const PlayerBlocEvent.stop());
                }
                _popupMenuController.hideMenu();
                Navigator.of(context).pushReplacementNamed(
                  SoundChangerScreen.routeName,
                  arguments: recordingsBloc.state.recordings[widget._index],
                );
              },
            ),
          ),
          const Divider(
            thickness: 3.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              child:
                  Text('delete', style: mediumText.copyWith(color: Colors.red)),
              onPressed: () {
                if (isPlaying || isPaused) {
                  playerBloc.add(
                    PlayerBlocEvent.stop(
                      onDone: () => recordingsBloc.add(
                        RecordingsBlocEvent.deleteRecording(
                          recordingsBloc.state.recordings[widget._index].path,
                        ),
                      ),
                    ),
                  );
                  _popupMenuController.hideMenu();
                  return;
                }
                recordingsBloc.add(
                  RecordingsBlocEvent.deleteRecording(
                    recordingsBloc.state.recordings[widget._index].path,
                  ),
                );
                _popupMenuController.hideMenu();
              },
            ),
          ),
        ],
      ),
    );
  }

  _title(BuildContext context) {
    final recording = BlocProvider.of<RecordingsBloc>(context)
        .state
        .recordings[widget._index];
    return Text(recording.name, style: mediumText);
  }

  _subTitle(BuildContext context) {
    final recording = BlocProvider.of<RecordingsBloc>(context)
        .state
        .recordings[widget._index];
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
              recording: recordingsBloc.state.recordings[widget._index]));
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
