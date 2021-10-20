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
        BlocProvider.of<PlayerBloc>(context, listen: false).add(const PlayerBlocEvent.appGoInactive());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Recordings',
            style: mediumText,
          ),
        ),
        body: _RecordingsListView(),
      );
}
