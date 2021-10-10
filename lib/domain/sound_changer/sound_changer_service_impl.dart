// import 'dart:io';
//
// import 'package:dartz/dartz.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import 'package:sound_changer/common/exception/failure.dart';
// import 'package:sound_changer/common/service/path_utils_service.dart';
// import 'package:sound_changer/configuration/service_locator.dart';
// import 'package:sound_changer/domain/sound_changer/sound_changer_service.dart';
//
// @Injectable(as: SoundChangerService)
// class SoundChangerServiceImpl implements SoundChangerService {
//   final PathUtilsService _pathUtilsService = PathUtilsService();
//
//   final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
//
//   final FlutterFFmpeg _ffmpeg = FlutterFFmpeg();
//
//   @override
//   Future<Either<Failure, void>> changeTempo({
//     required String inputFilePath,
//     required String outputFilePath,
//     required double value,
//   }) async {
//     try {
//       if (value < 0.5 || value > 100) {
//         throw Exception('tempo value must be between 0.5 and 100');
//       }
//       int changeTempoResult = 0;
//       int moveDataResult = 0;
//       if (inputFilePath != outputFilePath) {
//         //write directly into the output file
//         changeTempoResult = await _ffmpeg
//             .execute('-y -i $inputFilePath -af atempo=$value $outputFilePath');
//       } else {
//         //write into a temp file first then move the data to outputFilePath
//         String extension =
//             _pathUtilsService.getExtensionFromAbsoluteFilePath(outputFilePath);
//         String tempFilePath = await _pathUtilsService
//             .generateDefaultStorageFilePath('tmp', extension);
//         changeTempoResult = await _ffmpeg
//             .execute('-i $inputFilePath -af atempo=$value $tempFilePath');
//         moveDataResult =
//             await _ffmpeg.execute('-y -i $tempFilePath $outputFilePath');
//         File tempFile = File(tempFilePath);
//         await tempFile.delete();
//       }
//       if (changeTempoResult != 0 || moveDataResult != 0) {
//         throw Exception('change tempo command did not execute successfully');
//       }
//       return Right(null);
//     } catch (e) {
//       _logger.e('error occurred in changeTempo()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.changeTempoError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, void>> changeDelay({
//     required String inputFilePath,
//     required String outputFilePath,
//     required double value,
//   }) async {
//     try {
//       if (value < 0 || value > 10) {
//         throw Exception('tempo value must be between 0 and 10');
//       }
//       int changeDelayResult = 0;
//       int moveDataResult = 0;
//       if (inputFilePath != outputFilePath) {
//         //write directly into the output file
//         changeDelayResult = await _ffmpeg.execute(
//             '-y -i $inputFilePath -af \'adelay=$value\' $outputFilePath');
//       } else {
//         //write into a temp file first then move the data to outputFilePath
//         String extension =
//             _pathUtilsService.getExtensionFromAbsoluteFilePath(outputFilePath);
//         String tempFilePath = await _pathUtilsService
//             .generateDefaultStorageFilePath('tmp', extension);
//         changeDelayResult = await _ffmpeg
//             .execute('-i $inputFilePath -af \'adelay=$value\' $tempFilePath');
//         moveDataResult =
//             await _ffmpeg.execute('-y -i $tempFilePath $outputFilePath');
//         File tempFile = File(tempFilePath);
//         await tempFile.delete();
//       }
//       if (changeDelayResult != 0 || moveDataResult != 0) {
//         throw Exception('change delay command did not execute successfully');
//       }
//       return Right(null);
//     } catch (e) {
//       _logger.e('error occurred in changeDelay()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.changeDelayError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, void>> changeEcho({
//     required String inputFilePath,
//     required String outputFilePath,
//     required double inputGain,
//     required double outputGain,
//     required List<int> delays,
//     required List<double> decays,
//   }) async {
//     try {
//       if (inputGain < 0 || inputGain > 1 || outputGain < 0 || outputGain > 1) {
//         throw Exception(
//             'input gain and output gain must be in the range [0,1]');
//       }
//       delays.forEach((delay) {
//         if (delay < 0 || delay > 90000) {
//           throw Exception('delay must be an int in range [0,90000]');
//         }
//       });
//       decays.forEach((decay) {
//         if (decay < 0 || decay > 1) {
//           throw Exception('decay must be a double in range [0,1]');
//         }
//       });
//       if (delays.length != decays.length) {
//         throw Exception('delays and decays must have same lengths');
//       }
//       if (delays.isEmpty || decays.isEmpty) {
//         throw Exception('delays and decays must not be empty');
//       }
//
//       int changeEchoResult = 0;
//       int moveDataResult = 0;
//       String delaysParams = '';
//       String decaysParams = '';
//       for (int i = 0; i < delays.length; i++) {
//         delaysParams += '${delays[i]}${i == delays.length - 1 ? '' : '|'}';
//       }
//       for (int i = 0; i < decays.length; i++) {
//         decaysParams += '${decays[i]}${i == decays.length - 1 ? '' : '|'}';
//       }
//       String echoCommandParams =
//           '$inputGain:$outputGain:$delaysParams:$decaysParams';
//       if (inputFilePath != outputFilePath) {
//         //write directly into the output file
//         changeEchoResult = await _ffmpeg.execute(
//             '-y -i $inputFilePath -af \'aecho=$echoCommandParams\' $outputFilePath');
//       } else {
//         //write into a temp file first then move the data to outputFilePath
//         String extension =
//             _pathUtilsService.getExtensionFromAbsoluteFilePath(outputFilePath);
//         String tempFilePath = await _pathUtilsService
//             .generateDefaultStorageFilePath('tmp', extension);
//         changeEchoResult = await _ffmpeg.execute(
//             '-i $inputFilePath -af \'aecho=$echoCommandParams\' $tempFilePath');
//         moveDataResult =
//             await _ffmpeg.execute('-y -i $tempFilePath $outputFilePath');
//         File tempFile = File(tempFilePath);
//         await tempFile.delete();
//       }
//       if (changeEchoResult != 0 || moveDataResult != 0) {
//         throw Exception('change delay command did not execute successfully');
//       }
//
//       return Right(null);
//     } catch (e) {
//       _logger.e('error occurred in changeEcho()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.changeEchoError(),
//         ),
//       );
//     }
//   }
// }
