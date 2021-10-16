part of 'recorder_screen.dart';

class _RecorderIconWidget extends StatelessWidget {
  final double _containerSide;

  const _RecorderIconWidget(this._containerSide);

  @override
  Widget build(BuildContext context) {
    final recorderBlocState = BlocProvider.of<RecorderBloc>(context).state;

    return StreamBuilder<RecorderInfo>(
      stream: recorderBlocState.recorderInfoStream,
      builder: (context, snapshot) {
        double sizeFactor =
            (snapshot.hasData && snapshot.data!.state.isRecording
                ? (1 + snapshot.data!.volume / 100)
                : 1);
        sizeFactor %= 2; //to ensure r1<_containerSide

        final r1 = _containerSide / 2;
        final r2 = r1 / 1.08;
        final r3 = r2 / 1.08;
        final r4 = r3 / 3;

        final micIcon = Icon(
          Icons.mic_none_sharp,
          color: Colors.black38,
          size: r4,
        );

        return SizedBox(
          width: _containerSide,
          height: _containerSide,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.2,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 200),
                  scale: sizeFactor,
                  child: FilledCircle(
                    radius: r1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    ((!snapshot.hasData) || (!snapshot.data!.state.isRecording))
                        ? micIcon
                        : Text(
                            snapshot.data!.duration.toString(),
                          ),
                transitionBuilder: (child, animation) => ScaleTransition(
                  child: child,
                  scale: animation,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
