// import 'package:bloc/bloc.dart';
//
// void main() async {
//   MyBloc bloc = MyBloc(MyBlocState.initial());
//   bloc.add(EventA());
//   bloc.add(EventA());
// }
//
// class MyBloc extends Bloc<MyBlocEvent, MyBlocState> {
//   MyBloc(initialState) : super(initialState) {
//     on<EventA>(
//       (event, emit) async {
//           print('handling event A');
//           emit(MyBlocState(true));
//           await Future.delayed(Duration(seconds: 3));
//           emit(MyBlocState(false));
//           print('done handling event A');
//       },
//     );
//     on<EventB>(
//       (event, emit) {},
//     );
//   }
// }
//
// abstract class MyBlocEvent {}
//
// class EventA extends MyBlocEvent {}
//
// class EventB extends MyBlocEvent {}
//
// class MyBlocState {
//   final bool isProcessing;
//
//   factory MyBlocState.initial() => MyBlocState(false);
//
//   MyBlocState(this.isProcessing);
// }


// void main(){
//   print(RegExp(r'(^\d*\.?\d*)').hasMatch('-1.1'));
// }
