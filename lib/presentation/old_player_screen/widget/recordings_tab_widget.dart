// part of 'player_screen.dart';
//
// class _RecordingsTabWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//     PlaybackBlocState playbackBlocState = playbackBloc.state;
//     bool isPlaybackBlocProcessing = playbackBlocState.isProcessing;
//
//     SoundEffectsBloc soundEffectsBloc =
//         BlocProvider.of<SoundEffectsBloc>(context);
//     SoundEffectsBlocState soundEffectsBlocState = soundEffectsBloc.state;
//     bool isSoundEffectsBlocProcessing = soundEffectsBlocState.isProcessing;
//
//     bool isProcessing =
//         isPlaybackBlocProcessing || isSoundEffectsBlocProcessing;
//
//     List<TrackInfo> recordingsInfo = playbackBloc.state.recordingsInfoOption
//         .getOrElse(() => crashWithMessage(_missingRecordings));
//
//     bool isPlaying = playbackBloc.state.isPlaying;
//     bool isPaused = playbackBloc.state.isPaused;
//
//     return Column(
//       children: [
//         Divider(thickness: 3),
//         standardText('Select a track', TextClass.medium),
//         Divider(thickness: 3),
//         Expanded(
//           child: ListView.builder(
//             itemCount: recordingsInfo.length,
//             itemBuilder: (context, index) {
//               TrackInfo selectedTrackInfo = recordingsInfo[index];
//               var selectedTrackName = selectedTrackInfo.name;
//               return ListTile(
//                 title: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: standardText(
//                     '$index : $selectedTrackName',
//                     TextClass.medium,
//                   ),
//                 ),
//                 enabled: !isProcessing,
//                 onTap: () {
//                   if (isPlaying || isPaused) {
//                     playbackBloc.add(PlaybackBlocEvent.stopPlayback());
//                   }
//                   playbackBloc
//                       .add(PlaybackBlocEvent.trackChanged(newIndex: index));
//                   context.read<PageController>().animateToPage(
//                         0,
//                         duration: Duration(milliseconds: 200),
//                         curve: Curves.linear,
//                       );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
