// part of 'player_screen.dart';
//
// class PlayerScreenWidget extends StatefulWidget {
//   @override
//   _PlayerScreenWidgetState createState() => _PlayerScreenWidgetState();
// }
//
// class _PlayerScreenWidgetState extends State<PlayerScreenWidget>
//     with WidgetsBindingObserver {
//   final Logger _logger = serviceLocator.get<Logger>(param1: Level.nothing);
//
//   late final PlaybackBloc _playbackBloc;
//
//   @override
//   void initState() {
//     super.initState();
//     _playbackBloc = serviceLocator.get<PlaybackBloc>();
//     Future.delayed(
//       Duration.zero,
//       () => _playbackBloc.add(PlaybackBlocEvent.init()),
//     );
//     WidgetsBinding.instance!.addObserver(this);
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance!.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.inactive:
//         _logger.d('inactive');
//         if (_playbackBloc.state.isPlaying) {
//           _playbackBloc.add(PlaybackBlocEvent.pausePlayback());
//         }
//         break;
//       default:
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => SafeArea(
//         child: MultiBlocProvider(
//           providers: [
//             BlocProvider(create: (context) => _playbackBloc),
//             BlocProvider(
//                 create: (context) => serviceLocator.get<SoundEffectsBloc>()),
//           ],
//           child: Builder(
//             builder: (context) =>
//                 BlocBuilder<SoundEffectsBloc, SoundEffectsBlocState>(
//               builder: (context, soundEffectsBlocState) =>
//                   BlocBuilder<PlaybackBloc, PlaybackBlocState>(
//                 builder: (context, playbackBlocState) {
//                   if (playbackBlocState.isError) {
//                     return _ErrorWidget();
//                   }
//                   if (!playbackBlocState.isInitialized) {
//                     return _WaitingWidget();
//                   }
//                   //the player is initialized at this point
//                   if (playbackBlocState.selectedTrackIndexOption.isNone()) {
//                     //if there is no selected track yet
//                     var recordingFiles = playbackBlocState.recordingsInfoOption
//                         .getOrElse(() => crashWithMessage(_missingRecordings));
//                     if (recordingFiles.isNotEmpty) {
//                       //if recordings list is not empty
//                       return _RecordingsWidget();
//                     } else {
//                       //if recordings list is empty
//                       return _NoRecordingsWidget();
//                     }
//                   } else {
//                     //if there is a selected track already (this also means that recordings list is not empty)
//                     return _PlayerPageViewWidget();
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       );
// }
