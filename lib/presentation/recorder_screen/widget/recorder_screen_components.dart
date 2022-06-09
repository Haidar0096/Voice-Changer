part of 'recorder_screen.dart';

///The widget of the recorder screen to show  if there is no error
///Above it in the tree there are bloc builders for recorder and permission blocs
/// so these two blocs can be queried inside it and it will rebuild when they change.
class _RecorderScreenComponents extends StatefulWidget {
  @override
  State<_RecorderScreenComponents> createState() =>
      _RecorderScreenComponentsState();
}

class _RecorderScreenComponentsState extends State<_RecorderScreenComponents>
    with WidgetsBindingObserver {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.nothing);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        _logger.d('app inactive');
        BlocProvider.of<RecorderBloc>(context, listen: false)
            .add(const RecorderBlocEvent.appGoInactive());
        break;
      case AppLifecycleState.resumed:
        _logger.d('app resumed');
        BlocProvider.of<PermissionBloc>(context, listen: false)
            .add(const PermissionBlocEvent.checkMicrophonePermission());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final height = mq.size.height;
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
            Positioned(
              width: width - 40,
              height: width - 40,
              top: height / 17,
              left: 0,
              child: _RecorderIconWidget(width - 40),
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
