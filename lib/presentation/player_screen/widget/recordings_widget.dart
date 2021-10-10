// part of 'player_screen.dart';
//
// class _RecordingsWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var playbackBloc = BlocProvider.of<PlaybackBloc>(context);
//
//     List<TrackInfo> recordingsInfo = playbackBloc.state.recordingsInfoOption
//         .getOrElse(() => crashWithMessage(_missingRecordings));
//     return Scaffold(
//       appBar: _appBar(),
//       body: Column(
//         children: [
//           Divider(thickness: 3),
//           standardText('Select a track', TextClass.medium),
//           Divider(thickness: 3),
//           Expanded(
//             child: ListView.builder(
//               itemCount: recordingsInfo.length,
//               itemBuilder: (context, index) {
//                 TrackInfo trackInfo = recordingsInfo[index];
//                 return ListTile(
//                   title: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: standardText(
//                       '$index : ${trackInfo.name}',
//                       TextClass.medium,
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   onTap: () {
//                     playbackBloc
//                         .add(PlaybackBlocEvent.trackChanged(newIndex: index));
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
