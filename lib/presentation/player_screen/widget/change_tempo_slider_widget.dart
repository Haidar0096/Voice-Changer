// part of 'player_screen.dart';
//
// class _ChangeTempoSliderWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SoundEffectsBloc soundEffectsBloc =
//         BlocProvider.of<SoundEffectsBloc>(context);
//     SoundEffectsBlocState soundEffectsBlocState = soundEffectsBloc.state;
//
//      double value = soundEffectsBlocState.tempo;
//
//     bool isProcessing = _isProcessing(context);
//     return Column(
//       children: [
//         standardText('tempo = $value', TextClass.medium),
//         Slider(
//           // divisions: 99 * 10 + 5, //lol :p
//           divisions: 15,
//           min: 0.5,
//           max: 2,
//           value: value,
//           onChanged: isProcessing
//               ? null
//               : (newValue) {
//                   soundEffectsBloc.add(SoundEffectsBlocEvent.tempoChanged(
//                       newValue: newValue.toPrecision(2)));
//                 },
//         ),
//       ],
//     );
//   }
// }
