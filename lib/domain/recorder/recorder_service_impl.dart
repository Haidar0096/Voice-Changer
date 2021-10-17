import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
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
      BehaviorSubject.seeded(const RecorderState.uninitialized());

  final BehaviorSubject<Duration> _recordingDurationController =
      BehaviorSubject<Duration>.seeded(Duration.zero);

  final StreamController<double> _recordingVolumeController =
      BehaviorSubject<double>.seeded(0);

  @override
  Stream<RecorderState> get recorderStateStream => _recorderStateSubject.stream;

  @override
  Stream<Duration> get recordingDurationStream =>
      _recordingDurationController.stream;

  @override
  Stream<double> get recordingVolumeStream => _recordingVolumeController.stream;

  @override
  RecorderState get recorderState => _recorderStateSubject.value;

  @override
  Future<Either<Failure, InitRecorderResult>> initRecorder() async {
    try {
      if (_recorderStateSubject.value.isInitialized) {
        return Right(
          InitRecorderResult(
            recorderStateStream: _recorderStateSubject.stream,
            recordingDurationStream: _recordingDurationController.stream,
            recordingVolumeStream: _recordingVolumeController.stream,
          ),
        );
      }
      await _recorder.openAudioSession();
      await _recorder
          .setSubscriptionDuration(const Duration(milliseconds: 50));

      late StreamSubscription<RecordingDisposition> subscription;
      subscription = _recorder.onProgress!.listen(
        (data) {
          _recordingDurationController.add(data.duration);
          if (data.decibels != null) {
            //emitted value from _recordingVolumeController is 10^(decibels/20) % 100
            _recordingVolumeController
                .add((pow(10, data.decibels! / 20) % 100).toDouble());
          }
        },
        onDone: () => subscription.cancel(),
      );

      // if (!_recorderStateController.hasListener) {
      //   throw Exception(
      //       'There must exist a listener to the recorderStateStream when calling initRecorder()');
      // }
      _recorderStateSubject.add(const RecorderState.stopped());
      return Right(
        InitRecorderResult(
          recorderStateStream: _recorderStateSubject.stream,
          recordingDurationStream: _recordingDurationController.stream,
          recordingVolumeStream: _recordingVolumeController.stream,
        ),
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
      _recorderStateSubject.close();
      _recordingDurationController.close();
      _recordingVolumeController.close();
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
  Future<Either<Failure, void>> startRecorder({required File file}) async {
    try {
      if (!_recorderStateSubject.value.isStopped) {
        throw Exception(
            'startRecorder() was called from an illegal state: ${_recorderStateSubject.value}');
      }
      // _logger.i('this recording will be saved into $path');
      await _recorder.startRecorder(toFile: file.path, codec: Codec.aacMP4);
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
