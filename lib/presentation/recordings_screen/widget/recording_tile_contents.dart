part of 'recordings_screen.dart';

class _RecordingTileContents extends StatefulWidget {
  final int _index;

  const _RecordingTileContents(this._index, {Key? key}) : super(key: key);

  @override
  State<_RecordingTileContents> createState() => _RecordingTileContentsState();
}

class _RecordingTileContentsState extends State<_RecordingTileContents> {
  late final CustomPopupMenuController _popupMenuController;

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
      BlocBuilder<PlayerBloc, PlayerBlocState>(
        builder: (context, playerBlocState) =>
            BlocBuilder<RecordingsBloc, RecordingsBlocState>(
          builder: (context, recordingsBlocState) {
            final playerBloc = BlocProvider.of<PlayerBloc>(context);
            final recordingsBloc = BlocProvider.of<RecordingsBloc>(context);

            final mq = MediaQuery.of(context);
            final width = mq.size.width;

            bool isPlaying = playerBlocState.playerState.isPlaying;
            bool isPaused = playerBlocState.playerState.isPaused;
            bool isStopped = playerBlocState.playerState.isStopped;

            bool isProcessing = playerBlocState.isProcessing ||
                recordingsBlocState.isProcessing;

            bool isPlayingTile = (isPlaying || isPaused) &&
                recordingsBlocState.recordings[widget._index] ==
                    playerBlocState.recording;

            return Column(
              children: [
                CustomPopupMenu(
                  pressType: PressType.singleClick,
                  controller: _popupMenuController,
                  menuBuilder: () => _popupMenu(context, isPlaying, isPaused,
                      isProcessing, playerBloc, recordingsBloc, widget._index),
                  showArrow: false,
                  child: ListTile(
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
                ),
                if ((isPlaying || isPaused) && isPlayingTile)
                  _slider(playerBloc, playerBlocState),
              ],
            );
          },
        ),
      );

  Widget _popupMenu(
      BuildContext context,
      bool isPlaying,
      bool isPaused,
      bool isProcessing,
      PlayerBloc playerBloc,
      RecordingsBloc recordingsBloc,
      int index) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SoundChangerScreen(),
                  ),
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
              onPressed: isProcessing
                  ? null
                  : () {
                      if (isPlaying || isPaused) {
                        playerBloc.add(
                          PlayerBlocEvent.stop(
                            onDone: () => recordingsBloc.add(
                              RecordingsBlocEvent.deleteRecording(
                                recordingsBloc.state.recordings[index].path,
                              ),
                            ),
                          ),
                        );
                        _popupMenuController.hideMenu();
                        return;
                      }
                      recordingsBloc.add(
                        RecordingsBlocEvent.deleteRecording(
                          recordingsBloc.state.recordings[index].path,
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
        playerBloc
            .add(PlayerBlocEvent.start(recording: recordings[widget._index]));
      } else if (isPlaying) {
        if (isPlayingTile) {
          playerBloc.add(const PlayerBlocEvent.pause());
        } else {
          playerBloc.add(
            PlayerBlocEvent.stop(
              onDone: () => playerBloc.add(
                PlayerBlocEvent.start(recording: recordings[widget._index]),
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
                PlayerBlocEvent.start(recording: recordings[widget._index]),
              ),
            ),
          );
        }
      }
    };
  }

  Text _subTitle(recordings) =>
      Text(recordings[widget._index].duration.toString());

  Icon _micIcon(double width) {
    return Icon(
      Icons.mic_none,
      size: width / 15,
    );
  }

  Text _title(recordings) {
    return Text(
      recordings[widget._index].name,
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
