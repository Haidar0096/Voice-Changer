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
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  dispose() {
    WidgetsBinding.instance!.removeObserver(this);
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
                            Navigator.of(context)
                                .pushReplacementNamed(RecorderScreen.routeName);
                          },
                  ),
                ),
                body: Stack(
                  children: [
                    if (isProcessing)
                      Container(
                        width: width,
                        height: height,
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    _RecordingsListView(),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: isProcessing
                      ? null
                      : () {
                          BlocProvider.of<PlayerBloc>(context)
                              .add(const PlayerBlocEvent.stop());
                          Navigator.of(context)
                              .pushReplacementNamed(RecorderScreen.routeName);
                        },
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            },
          );
        },
      );
}
