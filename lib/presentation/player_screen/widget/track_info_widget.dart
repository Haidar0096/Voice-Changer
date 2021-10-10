// part of 'player_screen.dart';
//
// class _TrackInfoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBlocState playbackBlocState =
//         BlocProvider.of<PlaybackBloc>(context).state;
//
//     List<TrackInfo> recordingsInfo = playbackBlocState.recordingsInfoOption
//         .getOrElse(() => crashWithMessage(_missingRecordings));
//     int selectedFileIndex = playbackBlocState.selectedTrackIndexOption
//         .getOrElse(() => crashWithMessage(_missingSelectedTrackIndex));
//     TrackInfo selectedTrackInfo = recordingsInfo[selectedFileIndex];
//
//     Duration? duration = selectedTrackInfo.durationOption.fold(() => null, id);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: standardText(
//             'track index: $selectedFileIndex',
//             TextClass.medium,
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: standardText(
//               'track name: ${selectedTrackInfo.name}',
//               TextClass.medium,
//               textAlign: TextAlign.start,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: standardText(
//             'track duration: ${duration ?? 'unknown'}',
//             TextClass.medium,
//           ),
//         ),
//       ],
//     );
//   }
// }
