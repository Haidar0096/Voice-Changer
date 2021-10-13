// part of 'player_screen.dart';
//
// class _NextTrackButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//     PlaybackBlocState playbackBlocState = playbackBloc.state;
//
//     bool isProcessing = _isProcessing(context);
//
//     List<TrackInfo> recordingsInfo =
//         playbackBlocState.recordingsInfoOption.getOrElse(
//       () => crashWithMessage(_missingRecordings),
//     );
//     int recordingFilesListLength = recordingsInfo.length;
//
//     int selectedTrackIndex = playbackBlocState.selectedTrackIndexOption
//         .getOrElse(() => crashWithMessage(_missingSelectedTrackIndex));
//
//     int nextTrackIndex = (selectedTrackIndex + 1) % recordingFilesListLength;
//
//     return InkWell(
//       child: Icon(
//         Icons.arrow_forward,
//         size: 60,
//         color: isProcessing ? Colors.grey : null,
//       ),
//       onTap: !isProcessing
//           ? () {
//               if (playbackBloc.state.isPlaying || playbackBloc.state.isPaused) {
//                 playbackBloc.add(PlaybackBlocEvent.stopPlayback());
//               }
//               playbackBloc.add(
//                 PlaybackBlocEvent.trackChanged(newIndex: nextTrackIndex),
//               );
//             }
//           : null,
//     );
//   }
// }
