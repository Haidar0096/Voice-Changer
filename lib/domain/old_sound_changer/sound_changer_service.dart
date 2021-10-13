// import 'package:dartz/dartz.dart';
// import 'package:sound_changer/common/exception/failure.dart';
//
// abstract class SoundChangerService {
//   ///Params:
//   ///* [value] must be between 0.5 and 100
//   Future<Either<Failure, void>> changeTempo({
//     required String inputFilePath,
//     required String outputFilePath,
//     required double value,
//   });
//
//   ///Params:
//   ///* [value] must be between 0 and 10
//   Future<Either<Failure, void>> changeDelay({
//     required String inputFilePath,
//     required String outputFilePath,
//     required double value,
//   });
//
//   ///*[inputGain] : input gain of reflected signal ( range : [0,1] )
//   ///*[outputGain] : output gain of reflected signal ( range : [0,1] )
//   ///*[delays] : list of time intervals in milliseconds between original signal and reflections
//   ///*[decays] : list of loudness of reflected signals
//   Future<Either<Failure, void>> changeEcho(
//       {required String inputFilePath,
//         required String outputFilePath,
//         required double inputGain,
//         required double outputGain,
//         required List<int> delays,
//         required List<double> decays,
//       });
// }
