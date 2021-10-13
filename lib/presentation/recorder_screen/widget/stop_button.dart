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
    final stopButtonOuterSide = containerSide / 2.5;
    final stopButtonInnerSide = stopButtonOuterSide / 1.2;

    final recorderBloc = BlocProvider.of<RecorderBloc>(context);

    return StreamBuilder<RecorderInfo>(
        stream: recorderBloc.state.recorderInfoStream,
        builder: (context, snapshot) {
          return SizedBox(
            width: containerSide,
            height: containerSide,
            child: GestureDetector(
              onTap: snapshot.hasData && snapshot.data!.state.isRecording
                  ? () async {
                      recorderBloc.add(const RecorderBlocEvent.stopRecording());
                      _fileNameTextController.text =
                          recorderBloc.state.recordingFile!.getName();
                      await _showDialog(context);
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
                        color:
                            snapshot.hasData && snapshot.data!.state.isRecording
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).disabledColor,
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
            ),
          );
        });
  }

  _showDialog(BuildContext context) async {
    final recorderBloc = BlocProvider.of<RecorderBloc>(context);
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;
    return showDialog(
      context: context,
      builder: (ctx) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child: Container(
              width: width / 1.2,
              height: height / 2.2,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14.0, bottom: 14),
                      child: Text(
                        'Save Recording',
                        style: mediumText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Divider(thickness: 3),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        autofocus: true,
                        controller: _fileNameTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          errorMaxLines: 4,
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text('Save',
                          style: mediumText.copyWith(color: Colors.blue)),
                      onPressed: () {
                        if (_isValidFileName(_fileNameTextController.text)) {
                          recorderBloc.add(RecorderBlocEvent.saveRecording(
                              newRecordingFileName:
                                  _fileNameTextController.text));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'file name must contain only alphanumeric/underscore characters'
                                  ', and must not be empty'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      child: Text('Delete',
                          style: mediumText.copyWith(color: Colors.red)),
                      onPressed: () {
                        recorderBloc
                            .add(const RecorderBlocEvent.deleteRecording());
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidFileName(String? text) =>
      text != null && text.isAlphaNumericWithUnderscores() && text.isNotEmpty;
}
