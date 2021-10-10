// part of 'player_screen.dart';
//
// class _PlayerPageViewWidget extends StatefulWidget {
//   @override
//   _PlayerPageViewWidgetState createState() => _PlayerPageViewWidgetState();
// }
//
// class _PlayerPageViewWidgetState extends State<_PlayerPageViewWidget>
//     with SingleTickerProviderStateMixin {
//   late PageController _controller;
//   late int _tabIndex;
//
//   @override
//   void initState() {
//     _tabIndex = 0;
//     _controller = PageController();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       body: ChangeNotifierProvider<PageController>.value(
//         value: _controller,
//         child: PageView(
//           physics: NeverScrollableScrollPhysics(),
//           controller: _controller,
//           children: [
//             _PlayerTabWidget(),
//             _EffectsTabWidget(),
//             _RecordingsTabWidget(),
//           ],
//           onPageChanged: (value) => setState(() => _tabIndex = value),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _tabIndex,
//         onTap: (value) {
//           setState(() {
//             _controller.animateToPage(
//               value,
//               duration: Duration(milliseconds: 200),
//               curve: Curves.linear,
//             );
//             _tabIndex = value;
//           });
//         },
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.play_circle_fill),
//             label: 'player',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.edit),
//             label: 'effects',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.file_copy_sharp),
//             label: 'recordings',
//           ),
//         ],
//       ),
//     );
//   }
// }
