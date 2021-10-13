part of 'recorder_screen.dart';

class _RecordingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final containerSide = width / 5;

    final recorderBloc = BlocProvider.of<RecorderBloc>(context);
    return SizedBox(
      width: containerSide,
      height: containerSide,
      child: StreamBuilder<RecorderInfo>(
          stream: recorderBloc.state.recorderInfoStream,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: snapshot.hasData && !snapshot.data!.state.isRecording
                  ? () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RecordingsScreen(),
                        ),
                      )
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.menu,
                    size: containerSide / 2.2,
                    color: snapshot.hasData && snapshot.data!.state.isRecording
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  Text('recordings', style: smallText),
                ],
              ),
            );
          }),
    );
  }
}
