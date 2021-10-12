part of 'recorder_screen.dart';

class _RecorderIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final containerSide = width;

    final recorderBloc = BlocProvider.of<RecorderBloc>(context);

    return StreamBuilder<RecorderState>(
        stream: recorderBloc.state.recorderStateStream,
        builder: (context, stateSnapshot) {
          return StreamBuilder<double>(
              stream: recorderBloc.state.recordingVolumeStream,
              builder: (context, volumeSnapshot) {
                double sizeFactor = stateSnapshot.hasData &&
                        stateSnapshot.data!.isRecording &&
                        volumeSnapshot.hasData
                    ? 1 + volumeSnapshot.data! / 100
                    : 1;
                final r1 = containerSide / 2 * sizeFactor;
                final r2 = r1 / 1.08;
                final r3 = r2 / 1.08;
                final r4 = r3 / 3;

                final micIcon = Icon(
                  Icons.mic_none_sharp,
                  color: Colors.black38,
                  size: r4,
                );

                return SizedBox(
                  width: containerSide,
                  height: containerSide,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      FilledCircle(
                        color: primaryColor,
                        radius: r1,
                      ),
                      FilledCircle(
                        color: Colors.grey,
                        radius: r2,
                      ),
                      FilledCircle(
                        color: Colors.white,
                        radius: r3,
                      ),
                      if (!stateSnapshot.hasData ||
                          !stateSnapshot.data!.isRecording)
                        micIcon
                      else
                        StreamBuilder<Duration>(
                          stream: recorderBloc.state.recordingDurationStream,
                          initialData: Duration.zero,
                          builder: (context, durationSnapshot) =>
                              durationSnapshot.hasData
                                  ? Text(durationSnapshot.data.toString(),
                                      style: mediumText)
                                  : micIcon,
                        ),
                    ],
                  ),
                );
              });
        });
  }
}
