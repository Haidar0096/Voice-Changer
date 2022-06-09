part of 'recordings_screen.dart';

class _RecordingsScreenComponents extends StatefulWidget {
  const _RecordingsScreenComponents({Key? key}) : super(key: key);

  @override
  State<_RecordingsScreenComponents> createState() =>
      _RecordingsScreenComponentsState();
}

class _RecordingsScreenComponentsState
    extends State<_RecordingsScreenComponents> with WidgetsBindingObserver {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.nothing);

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _showSnackBar());
    WidgetsBinding.instance.addObserver(this);
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showSnackBar() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'swipe to delete a recording',
          textAlign: TextAlign.center,
          style: mediumText,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        _logger.d('app inactive');
        BlocProvider.of<PlayerBloc>(context, listen: false)
            .add(const PlayerBlocEvent.appGoInactive());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PlayerBloc, PlayerBlocState>(
        builder: (context, playerBlocState) {
          return BlocBuilder<RecordingsBloc, RecordingsBlocState>(
            builder: (context, recordingsBlocState) {
              final mq = MediaQuery.of(context);
              final width = mq.size.width;
              final height = mq.size.height;
              bool isProcessing = playerBlocState.isProcessing ||
                  recordingsBlocState.isProcessing;
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Recordings',
                    style: mediumText,
                  ),
                  centerTitle: true,
                  leading: InkWell(
                    child: const Icon(Icons.arrow_back),
                    onTap: isProcessing
                        ? null
                        : () {
                            BlocProvider.of<PlayerBloc>(context)
                                .add(const PlayerBlocEvent.stop());
                            Navigator.of(context).pop();
                          },
                  ),
                ),
                body: Stack(
                  children: [
                    if (isProcessing)
                      SizedBox(
                        width: width,
                        height: height,
                        child: const IgnorePointer(),
                      ),
                    const _RecordingsListView(),
                  ],
                ),
              );
            },
          );
        },
      );
}
