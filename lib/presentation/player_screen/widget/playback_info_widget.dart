// part of 'player_screen.dart';
//
// class _PlaybackInfoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//     PlaybackBlocState playbackBlocState = playbackBloc.state;
//
//     if (playbackBlocState.playbackDetailsOption.isNone())
//       return _StoppedSliderWidget('time elapsed: ${Duration.zero}');
//
//     if (!playbackBlocState.isPlaying && !playbackBlocState.isPaused)
//       return _StoppedSliderWidget('time elapsed: ${Duration.zero}');
//
//     List<TrackInfo> recordingsInfo = playbackBlocState.recordingsInfoOption
//         .getOrElse(() => crashWithMessage(_missingRecordings));
//     int selectedFileIndex = playbackBlocState.selectedTrackIndexOption
//         .getOrElse(() => crashWithMessage(_missingSelectedTrackIndex));
//     TrackInfo trackInfo = recordingsInfo[selectedFileIndex];
//
//     bool isDurationKnown = trackInfo.durationOption.isSome();
//     if (!isDurationKnown) {
//       return _StoppedSliderWidget('time elapsed: ${Duration.zero}');
//     }
//
//     PlaybackDetails playbackDetails = playbackBlocState.playbackDetailsOption
//         .getOrElse(() => crashWithMessage(_missingPlaybackDetails));
//     Stream<Duration> positionStream = playbackDetails.positionStream;
//     return StreamBuilder<Duration>(
//       stream: positionStream,
//       initialData: Duration.zero,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           double duration = trackInfo.durationOption
//               .getOrElse(() => crashWithMessage(_missingDuration))
//               .inMilliseconds
//               .toDouble();
//           double position = snapshot.data!.inMilliseconds.toDouble();
//           double value = position / duration;
//           double min = 0;
//           double max = 1;
//           if (value > max) {
//             return _StoppedSliderWidget('time elapsed: ${Duration.zero}');
//           }
//           return Column(
//             children: [
//               Slider(
//                 min: min,
//                 max: max,
//                 value: value,
//                 onChanged: (_) {},
//               ),
//               standardText('time elapsed: ${snapshot.data}', TextClass.medium),
//             ],
//           );
//         }
//         return _StoppedSliderWidget('time elapsed: ${Duration.zero}');
//       },
//     );
//   }
// }
