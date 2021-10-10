// part of 'player_screen.dart';
//
// class _ChangeEchoWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SoundEffectsBloc soundEffectsBloc =
//         BlocProvider.of<SoundEffectsBloc>(context);
//     SoundEffectsBlocState soundEffectsBlocState = soundEffectsBloc.state;
//
//     EchoType value = soundEffectsBlocState.echo;
//
//     bool isProcessing = _isProcessing(context);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: standardText('echo:  ', TextClass.medium),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: DropdownButton<EchoType>(
//             value: value,
//             onChanged: isProcessing
//                 ? null
//                 : (newValue) {
//                     if (newValue != null) {
//                       soundEffectsBloc.add(SoundEffectsBlocEvent.echoChanged(
//                           newValue: newValue));
//                     }
//                   },
//             items: [
//               DropdownMenuItem(
//                 child: standardText('None', TextClass.medium),
//                 onTap: () {},
//                 value: EchoType.None,
//               ),
//               DropdownMenuItem(
//                 child: standardText('Low', TextClass.medium),
//                 onTap: () {},
//                 value: EchoType.Low,
//               ),
//               DropdownMenuItem(
//                 child: standardText('Medium', TextClass.medium),
//                 onTap: () {},
//                 value: EchoType.Medium,
//               ),
//               DropdownMenuItem(
//                 child: standardText('Heavy', TextClass.medium),
//                 onTap: () {},
//                 value: EchoType.Heavy,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
