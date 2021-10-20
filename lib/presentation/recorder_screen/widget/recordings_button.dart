part of 'recorder_screen.dart';

class _RecordingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final containerSide = width / 5;

    return SizedBox(
      width: containerSide,
      height: containerSide,
      child: BlocBuilder<RecorderBloc, RecorderBlocState>(
        builder: (context, recorderBlocState) {
          return GestureDetector(
            onTap: !recorderBlocState.recorderState.isRecording
                ? () => Navigator.of(context)
                    .pushReplacementNamed(RecordingsScreen.routeName)
                : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.menu,
                  size: containerSide / 2.2,
                  color: recorderBlocState.recorderState.isRecording
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).colorScheme.secondary,
                ),
                Text('recordings', style: smallText),
              ],
            ),
          );
        },
      ),
    );
  }
}
