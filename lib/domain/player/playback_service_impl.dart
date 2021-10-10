// import 'dart:async';
//
// import 'package:dartz/dartz.dart';
// import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
// import 'package:flutter_ffmpeg/media_information.dart';
// import 'package:injectable/injectable.dart';
// import 'package:just_audio/just_audio.dart' as justAudio;
// import 'package:logger/logger.dart';
// import 'package:sound_changer/configuration/service_locator.dart';
// import 'package:sound_changer/domain/common/exception/failure.dart';
// import 'package:sound_changer/domain/common/service/path_utils_service.dart';
// import 'package:sound_changer/domain/player/playback_service.dart';
//
// @Injectable(as: PlaybackService)
// class PlaybackServiceImpl implements PlaybackService {
//   final justAudio.AudioPlayer _player = justAudio.AudioPlayer();
//
//   final PathUtilsService _pathUtilsService = PathUtilsService();
//
//   final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
//
//   PlayerState _playerState = PlayerState();
//
//   @override
//   Future<Either<Failure, PlayerState>> initPlayer() async {
//     try {
//       if (!_playerState.isInitialized) {
//         _playerState = PlayerState(
//           isInitialized: true,
//           isStopped: true,
//         );
//       }
//       return Right(_playerState);
//     } catch (e) {
//       _logger.e('error occurred in initPlayer()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.initPlayerError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, PlayerState>> disposePlayer() async {
//     if (!_playerState.isInitialized) {
//       return Right(_playerState);
//     }
//     try {
//       await _player.dispose();
//       _playerState = PlayerState();
//       return Right(_playerState);
//     } catch (e) {
//       _logger.e('error occurred in disposePlayer()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.disposePlayerError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, PlayerState>> startPlayback({
//     required String playbackFilePath,
//     Function? whenFinished,
//   }) async {
//     try {
//       if (!_playerState.isStopped) {
//         throw Exception(
//             'startPlayback() was called from an illegal state: $_playerState');
//       }
//
//       await _player.setFilePath(playbackFilePath);
//
//       Duration? duration;
//       FlutterFFprobe ffprobe = FlutterFFprobe();
//       MediaInformation mediaInfo =
//           await ffprobe.getMediaInformation(playbackFilePath);
//       String? durationString = mediaInfo.getMediaProperties()?['duration'];
//       if (durationString != null) {
//         duration = _parseDuration(durationString);
//       }
//
//       late StreamSubscription<justAudio.ProcessingState> subscription;
//       subscription = _player.processingStateStream.listen(
//         (processingState) async {
//           if (processingState == justAudio.ProcessingState.completed ||
//               processingState == justAudio.ProcessingState.idle) {
//             await subscription.cancel();
//             _playerState = PlayerState(
//               isInitialized: true,
//               isStopped: true,
//             );
//             if (whenFinished != null) {
//               await whenFinished();
//             }
//           }
//         },
//       );
//
//       _player.play();
//       _playerState = PlayerState(
//         isInitialized: true,
//         isPlaying: true,
//         playbackDetails: PlaybackDetails(
//           positionStream: _player.positionStream,
//         ),
//         trackInfo: TrackInfo(
//           path: playbackFilePath,
//           name: _pathUtilsService.getFileNameFromPath(path: playbackFilePath),
//           durationOption: optionOf(duration),
//         ),
//       );
//       return Right(_playerState);
//     } catch (e) {
//       _logger.e('error occurred in startPlayback()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.startPlayerError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, PlayerState>> pausePlayback() async {
//     try {
//       if (_playerState.isPaused) {
//         return Right(_playerState);
//       }
//       if (_playerState.isPlaying) {
//         await _player.pause();
//         _playerState = _playerState.copyWith(
//           isPlaying: false,
//           isPaused: true,
//         );
//         return Right(_playerState);
//       }
//       throw Exception(
//           'pausePlayback() was called from an illegal state: $_playerState');
//     } catch (e) {
//       _logger.e('error occurred in pausePlayback()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.pausePlayerError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, PlayerState>> resumePlayback() async {
//     try {
//       if (_playerState.isPlaying) {
//         return Right(_playerState);
//       }
//       if (_playerState.isPaused) {
//         _player.play();
//         _playerState = _playerState.copyWith(
//           isPlaying: true,
//           isPaused: false,
//         );
//         return Right(_playerState);
//       }
//       throw Exception(
//           'resumePlayback() was called from an illegal state: $_playerState');
//     } catch (e) {
//       _logger.e('error occurred in resumePlayback()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.resumePlayerError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<Either<Failure, PlayerState>> stopPlayback() async {
//     try {
//       if (!_playerState.isInitialized) {
//         throw Exception(
//             'stopPlayback() was called from an illegal state: $_playerState');
//       }
//       await _player.stop();
//       _playerState = PlayerState(
//         isInitialized: true,
//         isStopped: true,
//       );
//       return Right(_playerState);
//     } catch (e) {
//       _logger.e('error occurred in stopPlayback()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.stopPlayerError(),
//         ),
//       );
//     }
//   }
//
//   Future<Either<Failure, TrackInfo>> getTrackInfo(String filePath) async {
//     try {
//       Duration? duration;
//       FlutterFFprobe ffprobe = FlutterFFprobe();
//       MediaInformation mediaInfo = await ffprobe.getMediaInformation(filePath);
//       String? durationString = mediaInfo.getMediaProperties()?['duration'];
//       if (durationString != null) {
//         duration = _parseDuration(durationString);
//       }
//       if (durationString != null) {
//         duration = _parseDuration(durationString);
//       }
//       return Right(
//         TrackInfo(
//           path: filePath,
//           name: _pathUtilsService.getFileNameFromPath(path: filePath),
//           durationOption: optionOf(duration),
//         ),
//       );
//     } catch (e) {
//       _logger.e('error occurred in getTrackDetails()', e);
//       return Left(
//         Failure(
//           Failure.defaultErrorMessage,
//           ErrorCode.getTrackDetailsError(),
//         ),
//       );
//     }
//   }
//
//   Duration _parseDuration(String durationString) {
//     //example of the durationString: 1.536000
//     int seconds = int.parse(durationString.split('.')[0]);
//     int milliseconds =
//         int.parse(durationString.split('.')[1].substring(0, 1)) * 100;
//     return Duration(seconds: seconds, milliseconds: milliseconds);
//   }
// }
