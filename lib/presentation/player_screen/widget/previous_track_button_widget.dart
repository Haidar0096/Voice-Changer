// part of 'player_screen.dart';
//
// class _PreviousTrackButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//     PlaybackBlocState playbackBlocState = playbackBloc.state;
//
//     bool isPaused = playbackBlocState.isPaused;
//     bool isPlaying = playbackBlocState.isPlaying;
//
//     bool isProcessing = _isProcessing(context);
//
//     List<TrackInfo> recordingFiles =
//         playbackBlocState.recordingsInfoOption.getOrElse(
//       () => crashWithMessage(_missingRecordings),
//     );
//     int recordingFilesListLength = recordingFiles.length;
//
//     int selectedTrackIndex = playbackBlocState.selectedTrackIndexOption
//         .getOrElse(() => crashWithMessage(_missingSelectedTrackIndex));
//     //see https://stackoverflow.com/a/60182730/9142279 to know how modulo is calculated in dart
//     int previousTrackIndex =
//         (selectedTrackIndex - 1) % recordingFilesListLength;
//
//     return InkWell(
//       child: Icon(
//         Icons.arrow_back,
//         size: 60,
//         color: isProcessing ? Colors.grey : null,
//       ),
//       onTap: !isProcessing
//           ? () {
//               if (isPlaying || isPaused) {
//                 playbackBloc.add(PlaybackBlocEvent.stopPlayback());
//               }
//               playbackBloc.add(
//                 PlaybackBlocEvent.trackChanged(newIndex: previousTrackIndex),
//               );
//             }
//           : null,
//     );
//   }
// }
