part of 'recorder_screen.dart';

class _StopButton extends StatefulWidget {
  @override
  State<_StopButton> createState() => _StopButtonState();
}

class _StopButtonState extends State<_StopButton> {
  late final TextEditingController _fileNameTextController;
  late final FocusNode _fileNameFocusNode;

  @override
  initState() {
    super.initState();
    _fileNameTextController = TextEditingController();
    _fileNameFocusNode = FocusNode();
  }

  @override
  dispose() {
    _fileNameTextController.dispose();
    _fileNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final containerSide = width / 5;
    final stopButtonOuterSide = containerSide / 2.2;
    final stopButtonInnerSide = stopButtonOuterSide / 1.2;

    final recorderBloc = BlocProvider.of<RecorderBloc>(context);

    return SizedBox(
      width: containerSide,
      height: containerSide,
      child: StreamBuilder<RecorderState>(
          stream: recorderBloc.state.recorderStateStream,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: snapshot.hasData
                  ? () async {
                      if (snapshot.data!.isRecording) {
                        recorderBloc
                            .add(const RecorderBlocEvent.stopRecording());
                        _fileNameTextController.text =
                            recorderBloc.state.recordingFileOption.fold(
                          () => _fileNameTextController.text,
                          (file) => file.getName(),
                        );
                        _fileNameFocusNode.requestFocus();
                        await _showDialog(context,recorderBloc);
                      }
                    }
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      FilledRectangle(
                        width: stopButtonOuterSide,
                        height: stopButtonOuterSide,
                        color: snapshot.hasData && snapshot.data!.isRecording
                            ? Colors.blue
                            : Colors.black38,
                      ),
                      FilledRectangle(
                        width: stopButtonInnerSide,
                        height: stopButtonInnerSide,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('Stop', style: smallText),
                  ),
                ],
              ),
            );
          }),
    );
  }

  _showDialog(BuildContext context, RecorderBloc recorderBloc) async =>
      showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SimpleDialog(
              title: Text(
                'Save Recording',
                style: largeText,
                textAlign: TextAlign.center,
              ),
              children: [
                TextField(
                  controller: _fileNameTextController,
                  focusNode: _fileNameFocusNode,
                ), //todo configure the text field
                TextButton(
                    child: Text('Save', style: mediumText),
                    onPressed: () {
                      recorderBloc.add(RecorderBlocEvent.saveRecording(
                          newRecordingFileName: _fileNameTextController.text));
                      _fileNameFocusNode.unfocus();
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text('Delete',
                        style: mediumText.copyWith(color: Colors.red)),
                    onPressed: () {
                      recorderBloc
                          .add(const RecorderBlocEvent.deleteRecording());
                      _fileNameFocusNode.unfocus();
                      Navigator.of(context).pop();
                    }),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          );
        },
      );
}
