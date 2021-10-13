// part of 'player_screen.dart';
//
// class _PlayerControlsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     bool isPlaying = BlocProvider.of<PlaybackBloc>(context).state.isPlaying;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _PreviousTrackButtonWidget(),
//             SizedBox(width: 20),
//             if (isPlaying) _PauseButtonWidget() else _PlayButtonWidget(),
//             SizedBox(width: 20),
//             _NextTrackButtonWidget(),
//           ],
//         ),
//         SizedBox(height: 20),
//         _PlaybackInfoWidget(),
//       ],
//     );
//   }
// }
