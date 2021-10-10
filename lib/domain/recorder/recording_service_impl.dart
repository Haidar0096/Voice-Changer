import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';

import 'recorder_service.dart';

///This implementation uses a third party dependency (flutter_sound_recorder)
///to implement recorder services. It also manages the state of the recorder internally.
@Injectable(as: RecorderService)
class RecorderServiceImpl implements RecorderService {
  ///The recorder class from the flutter_sound_recorder package
  final FlutterSoundRecorder _recorder =
      FlutterSoundRecorder(logLevel: Level.nothing);

  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);

  final BehaviorSubject<RecorderState> _recorderStateSubject =
      BehaviorSubject.seeded(RecorderService.initialRecorderState);

  final StreamController<Duration> _recordingDurationController =
      StreamController<Duration>.broadcast();

  @override
  RecorderState get recorderState => _recorderStateSubject.value;

  @override
  Future<Either<Failure, InitRecorderResult>> initRecorder() async {
    try {
      if (_recorderStateSubject.value.isInitialized) {
        return Right(
          InitRecorderResult(
              recorderStateStream: _recorderStateSubject.stream,
              recordingDurationStream: _recordingDurationController.stream),
        );
      }
      await _recorder.openAudioSession();
      await _recorder.setSubscriptionDuration(const Duration(milliseconds: 50));

      _recorder.onProgress
          ?.listen((data) => _recordingDurationController.add(data.duration));

      // if (!_recorderStateController.hasListener) {
      //   throw Exception(
      //       'There must exist a listener to the recorderStateStream when calling initRecorder()');
      // }
      _recorderStateSubject.add(const RecorderState.stopped());
      return Right(
        InitRecorderResult(
            recorderStateStream: _recorderStateSubject.stream,
            recordingDurationStream: _recordingDurationController.stream),
      );
    } catch (e) {
      _logger.e('error occurred in initRecorder()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.initRecorderError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> disposeRecorder() async {
    if (!_recorderStateSubject.value.isInitialized) {
      return const Right(null);
    }
    try {
      await _recorder.closeAudioSession();
      _recorderStateSubject.add(const RecorderState.uninitialized());
      _recorderStateSubject.close();
      _recordingDurationController.close();
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in disposeRecorder()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.disposeRecorderError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> startRecorder({required String path}) async {
    try {
      if (!_recorderStateSubject.value.isStopped) {
        throw Exception(
            'startRecorder() was called from an illegal state: ${_recorderStateSubject.value}');
      }
      // _logger.i('this recording will be saved into $path');
      await _recorder.startRecorder(toFile: path);
      _recorderStateSubject.add(const RecorderState.recording());
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in startRecorder()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.startRecorderError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> pauseRecorder() async {
    try {
      if (!_recorderStateSubject.value.isInitialized ||
          _recorderStateSubject.value.isStopped) {
        throw Exception(
            'pauseRecorder() was called from an illegal state: ${_recorderStateSubject.value}');
      }
      if (_recorderStateSubject.value.isPaused) {
        return const Right(null);
      }
      await _recorder.pauseRecorder();
      _recorderStateSubject.add(const RecorderState.paused());
      //no change to recording details here
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in pauseRecorder()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.pauseRecorderError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resumeRecorder() async {
    try {
      if (_recorderStateSubject.value.isRecording) {
        return const Right(null);
      }
      if (_recorderStateSubject.value.isPaused) {
        await _recorder.resumeRecorder();
        _recorderStateSubject.add(const RecorderState.recording());
        //no change to recording details here
        return const Right(null);
      }
      throw Exception(
          'resumeRecorder() was called from an illegal state: ${_recorderStateSubject.value}');
    } catch (e) {
      _logger.e('error occurred in resumeRecorder()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.resumeRecorderError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> stopRecorder() async {
    try {
      if (!_recorderStateSubject.value.isInitialized) {
        throw Exception(
            'stopRecorder() was called from an illegal state: $_recorderStateSubject.value');
      }
      await _recorder.stopRecorder();
      _recorderStateSubject.add(const RecorderState.stopped());
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in stopRecorder()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.stopRecorderError(),
        ),
      );
    }
  }
}
