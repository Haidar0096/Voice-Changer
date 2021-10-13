// part of 'player_screen.dart';
//
// class _PlayButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//     PlaybackBlocState playbackBlocState = playbackBloc.state;
//
//     bool isProcessing = _isProcessing(context);
//
//     bool isPaused = playbackBlocState.isPaused;
//
//     int selectedFileIndex = playbackBlocState.selectedTrackIndexOption
//         .getOrElse(() => crashWithMessage(_missingSelectedTrackIndex));
//
//     List<TrackInfo> recordingsInfo = playbackBlocState.recordingsInfoOption
//         .getOrElse(() => crashWithMessage(_missingRecordings));
//
//     String selectedFilePath = recordingsInfo[selectedFileIndex].path;
//     return InkWell(
//       child: Icon(
//         Icons.play_circle_outline,
//         size: 60,
//         color: isProcessing ? Colors.grey : null,
//       ),
//       onTap: !isProcessing
//           ? () {
//               if (!isPaused) {
//                 playbackBloc.add(
//                   PlaybackBlocEvent.startPlayback(
//                     filePath: selectedFilePath,
//                     whenFinished: () {
//                       playbackBloc.add(
//                         PlaybackBlocEvent.playbackEnded(),
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 playbackBloc.add(PlaybackBlocEvent.resumePlayback());
//               }
//             }
//           : null,
//     );
//   }
// }
