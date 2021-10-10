// part of 'player_screen.dart';
//
// class _OverrideOriginalFileCheckBoxWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: BlocProvider.of<SoundEffectsBloc>(context)
//               .state
//               .shouldOverrideOriginalFile,
//           onChanged: (bool? value) {
//             BlocProvider.of<SoundEffectsBloc>(context).add(
//                 SoundEffectsBlocEvent.shouldOverrideOriginalFileChanged(
//                     newValue: value!));
//           },
//         ),
//         standardText('override original file', TextClass.medium),
//       ],
//     );
//   }
// }
