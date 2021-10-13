part of 'recorder_screen.dart';

class _RecorderIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final containerSide = width;

    final recorderBlocState = BlocProvider.of<RecorderBloc>(context).state;

    return StreamBuilder<RecorderInfo>(
      stream: recorderBlocState.recorderInfoStream,
      builder: (context, snapshot) {
        double sizeFactor =
            (snapshot.hasData && snapshot.data!.state.isRecording
                ? 1 + snapshot.data!.volume / 100
                : 1);
        //line below is to make sure the circle does not get bigger than the container
        sizeFactor %= 2;
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
                color: Theme.of(context).colorScheme.primary,
                radius: r1,
              ),
              FilledCircle(
                color: Theme.of(context).colorScheme.secondary,
                radius: r2,
              ),
              FilledCircle(
                color: Colors.white,
                radius: r3,
              ),
              if ((!snapshot.hasData) || (!snapshot.data!.state.isRecording))
                micIcon
              else
                Text(
                  snapshot.data!.duration.toString(),
                ),
            ],
          ),
        );
      },
    );
  }
}
