part of 'recorder_screen.dart';

///The widget of the recorder screen to show  if there is no error
///Above it in the tree there are bloc builders for recorder and permission blocs
/// so these two blocs can be queried inside it and it will rebuild when they change.
class _RecorderScreenComponents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Recorder', style: mediumText),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _RecorderIconWidget(),
            ),
            Positioned(
              bottom: 0,
              left: width / 10,
              child: _StopButton(),
            ),
            Positioned(
              bottom: 0,
              left: width / 4,
              right: width / 4,
              child: _RecordButton(),
            ),
            Positioned(
              bottom: 0,
              right: width / 10,
              child: _RecordingsButton(),
            ),
          ],
        ),
      ),
    );
  }
}
