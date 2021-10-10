part of 'recorder_screen.dart';

class _RecorderIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final r1 = width / 1.7; //radius 1
    final r2 = r1 / 1.04;
    final r3 = r2 / 1.09;
    final r4 = r3 / 1.8;

    final recorderBloc = BlocProvider.of<RecorderBloc>(context);

    return SizedBox(
      width: r1,
      height: r1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FilledCircle(
            color: Colors.blue,
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
          StreamBuilder<RecorderState>(
            stream: recorderBloc.state.recorderStateStream,
            builder: (context, recorderStateSnapshot) {
              Widget micIcon = Icon(
                Icons.mic_none_sharp,
                color: Colors.black38,
                size: r4,
              );
              if (!recorderStateSnapshot.hasData) {
                return micIcon;
              }
              if (!recorderStateSnapshot.data!.isRecording) {
                return micIcon;
              }
              return StreamBuilder<Duration>(
                stream: recorderBloc.state.recordingDurationStream,
                initialData: Duration.zero,
                builder: (context, durationSnapshot) => durationSnapshot.hasData
                    ? Text(durationSnapshot.data.toString(), style: mediumText)
                    : micIcon,
              );
            },
          ),
        ],
      ),
    );
  }
}
