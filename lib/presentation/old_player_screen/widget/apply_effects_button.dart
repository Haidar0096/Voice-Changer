// part of 'player_screen.dart';
//
// class _ApplyEffectsButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//     PlaybackBlocState playbackBlocState = playbackBloc.state;
//
//     int selectedFileIndex = playbackBlocState.selectedTrackIndexOption
//         .getOrElse(() => crashWithMessage(_missingSelectedTrackIndex));
//
//     List<TrackInfo> recordingsInfo = playbackBlocState.recordingsInfoOption
//         .getOrElse(() => crashWithMessage(_missingRecordings));
//
//     String selectedFilePath = recordingsInfo[selectedFileIndex].path;
//
//     SoundEffectsBloc soundEffectsBloc =
//         BlocProvider.of<SoundEffectsBloc>(context);
//
//     bool isProcessing = _isProcessing(context);
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: isProcessing
//           ? CircularProgressIndicator()
//           : standardButton(
//               child: standardText(
//                 'apply effects',
//                 TextClass.medium,
//               ),
//               onPressed: () async {
//                 if (playbackBlocState.isPlaying || playbackBlocState.isPaused) {
//                   playbackBloc.add(PlaybackBlocEvent.stopPlayback());
//                 }
//                 soundEffectsBloc.add(
//                   SoundEffectsBlocEvent.applyEffectsEvent(
//                     inputFilePath: selectedFilePath,
//                     onSuccess: (bool shouldOverrideOriginalFile,
//                         String outputFilePath) {
//                       playbackBloc.add(
//                         PlaybackBlocEvent.applySoundEffectsEndedEvent(
//                           result: true,
//                           shouldTrackIndexChange: !shouldOverrideOriginalFile,
//                           outputFilePath: outputFilePath,
//                         ),
//                       );
//                       context.read<PageController>().animateToPage(
//                             0,
//                             duration: Duration(milliseconds: 200),
//                             curve: Curves.linear,
//                           );
//                     },
//                     onError: (failures) => playbackBloc.add(
//                       PlaybackBlocEvent.applySoundEffectsEndedEvent(
//                         result: false,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
