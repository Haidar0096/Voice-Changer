// part of 'player_screen.dart';
//
// class _ErrorWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     PlaybackBlocState playbackBlocState =
//         BlocProvider.of<PlaybackBloc>(context).state;
//     String errorMessage = playbackBlocState.errorMessageOption
//         .getOrElse(() => crashWithMessage(_missingErrorMessage));
//     return Scaffold(
//       appBar: _appBar(),
//       body: Center(
//         child: standardText(errorMessage, TextClass.medium),
//       ),
//     );
//   }
// }
