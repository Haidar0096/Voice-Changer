// part of 'player_screen.dart';
//
// class _PauseButtonWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBloc playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//
//     bool isProcessing = _isProcessing(context);
//
//     return InkWell(
//       child: Icon(
//         Icons.pause_circle_outline,
//         size: 60,
//         color: isProcessing ? Colors.grey : null,
//       ),
//       onTap: !isProcessing
//           ? () {
//               playbackBloc.add(
//                 PlaybackBlocEvent.pausePlayback(),
//               );
//             }
//           : null,
//     );
//   }
// }
