part of 'recorder_screen.dart';

class _StopButton extends StatefulWidget {
  @override
  State<_StopButton> createState() => _StopButtonState();
}

class _StopButtonState extends State<_StopButton> {
  late final TextEditingController _fileNameTextController;

  @override
  initState() {
    super.initState();
    _fileNameTextController = TextEditingController();
  }

  @override
  dispose() {
    _fileNameTextController.dispose();
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
                        _fileNameTextController.text = recorderBloc
                            .state.recordingFileOption
                            .toNullable()!
                            .getName();
                        await _showDialog(context, recorderBloc);
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
                            : Colors.black12,
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
                SimpleDialogOption(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    autofocus: true,
                    controller: _fileNameTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      errorMaxLines: 4,
                    ),
                    validator: (text) {
                      String errorMessage =
                          'file name must contain only alphanumeric/underscore characters';
                      if (text == null ||
                          (!text.isAlphaNumericWithUnderscores())) {
                        return errorMessage;
                      }
                      return null;
                    },
                  ),
                ),
                SimpleDialogOption(
                  child: Text('Save',
                      style: mediumText.copyWith(color: Colors.blue),
                      textAlign: TextAlign.center),
                  onPressed: () {
                    if (_fileNameTextController.text
                        .isAlphaNumericWithUnderscores()) {
                      recorderBloc.add(RecorderBlocEvent.saveRecording(
                          newRecordingFileName: _fileNameTextController.text));
                      Navigator.of(context).pop();
                    }
                  },
                ),
                SimpleDialogOption(
                  child: Text(
                    'Delete',
                    style: mediumText.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    recorderBloc.add(const RecorderBlocEvent.deleteRecording());
                    Navigator.of(context).pop();
                  },
                ),
              ],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          );
        },
      );
}
