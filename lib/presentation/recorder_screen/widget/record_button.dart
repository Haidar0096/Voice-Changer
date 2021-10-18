part of 'recorder_screen.dart';

class _RecordButton extends StatefulWidget {
  @override
  State<_RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<_RecordButton> {
  double _opacity = 0.0; //used to show animation when user taps the button

  int count = 0;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final r1 = width / 4;
    final r2 = r1 / 1.08;
    final r3 = r2 / 6;

    final recorderBloc = BlocProvider.of<RecorderBloc>(context);

    final permissionBloc = BlocProvider.of<PermissionBloc>(context);
    final isMicrophonePermissionGranted =
        permissionBloc.state.isMicrophonePermissionGranted;

    return StreamBuilder<RecorderInfo>(
      stream: recorderBloc.state.recorderInfoStream,
      builder: (context, snapshot) {
        return SizedBox(
          width: r1,
          height: r1,
          child: GestureDetector(
            onPanDown: (_) => setState(() {
              _opacity = 1.0;
            }),
            onPanEnd: (_) => setState(
              () {
                _opacity = 0.0;
              },
            ),
            onTap: () {
              setState(() {
                if (snapshot.hasData && !snapshot.data!.state.isRecording) {
                  if (isMicrophonePermissionGranted) {
                    recorderBloc.add(const RecorderBlocEvent.startRecording());
                  } else {
                    permissionBloc.add(
                      PermissionBlocEvent.requestMicrophonePermission(
                        onPermanentlyDenied: () async {
                          await _showPermissionDialog(context);
                        },
                        onGranted: () => recorderBloc
                            .add(const RecorderBlocEvent.startRecording()),
                      ),
                    );
                  }
                }
                _opacity = 0.0;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                FilledCircle(
                  color: snapshot.hasData && snapshot.data!.state.isRecording
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).disabledColor,
                  radius: r1,
                ),
                FilledCircle(
                  color: Colors.white,
                  radius: r2,
                ),
                FilledCircle(
                  color: Colors.red,
                  radius: r3,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: _opacity,
                  child: FilledCircle(
                    color: Colors.black12,
                    radius: r1,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _showPermissionDialog(BuildContext context) async {
    final permissionBloc = BlocProvider.of<PermissionBloc>(context);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Text(
              'Permission Required',
              style: mediumText,
              textAlign: TextAlign.center,
            ),
            const Divider(thickness: 3),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        content: Text(
          'Please grant the microphone permission to use the recorder.',
          style: smallText,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child: Text(
              'Grant Permission',
              style: mediumText,
            ),
            onPressed: () {
              permissionBloc.add(const PermissionBlocEvent.openSettingsApp());
              Navigator.of(context).pop();
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
      ),
    );
  }
}
