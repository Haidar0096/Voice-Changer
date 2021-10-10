// part of 'player_screen.dart';
//
// class _ChangeDelaySliderWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     SoundEffectsBloc soundEffectsBloc =
//         BlocProvider.of<SoundEffectsBloc>(context);
//     SoundEffectsBlocState soundEffectsBlocState = soundEffectsBloc.state;
//
//     double value = soundEffectsBlocState.delay;
//
//     bool isProcessing = _isProcessing(context);
//     return Column(
//       children: [
//         standardText('delay = $value', TextClass.medium),
//         Slider(
//           // divisions: 99 * 10 + 5, //lol :p
//           divisions: 10 * 10,
//           min: 0,
//           max: 10,
//           value: value,
//           onChanged: isProcessing
//               ? null
//               : (newValue) {
//                   soundEffectsBloc.add(SoundEffectsBlocEvent.delayChanged(
//                       newValue: newValue.toPrecision(2)));
//                 },
//         ),
//       ],
//     );
//   }
// }
