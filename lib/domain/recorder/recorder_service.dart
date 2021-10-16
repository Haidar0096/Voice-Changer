import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';

part 'recorder_service.freezed.dart';

///The contract which provides the necessary functions of a recorder.
///To use the service without errors, you must first call [initRecorder] and when done call [disposeRecorder]. After calling dispose,
/// the service instance must not be used again or otherwise unknown states might be reached.
abstract class RecorderService {
  static const String defaultCodec = 'mp4';

  ///Stream of the states of the recorder, it is seeded with value [RecorderState.uninitialized()]
  Stream<RecorderState> get recorderStateStream;

  ///Stream of the durations of the current recording, it is seeded with value [Duration.zero]
  Stream<Duration> get recordingDurationStream;

  ///Stream of the volume of the current recording at this point in time
  ///0 is the minimum value and 100 is the maximum. It is seeded with value 0
  Stream<double> get recordingVolumeStream;

  ///The latest recorder state emitted
  RecorderState get recorderState;

  /// Initializes the recorder.
  /// It is allowed to call this method if initialization has already happened,in which case the same current state is maintained.
  /// Usually this method must not result in any failures.
  /// The current state will not be changed if a failure happens.
  /// <br></br>
  /// <br></br>
  /// Returns an [Either] wrapping:
  ///* [InitRecorderResult], in case of success
  ///* [Failure], in case of failure (no change of the state happens in this case)
  Future<Either<Failure, InitRecorderResult>> initRecorder();

  /// Disposes the recorder, and stops it if it is recording.
  /// It is allowed to call this method if dispose has already happened.
  /// Usually this method must not result in any failures.
  /// The current state will not be changed if a failure happens.
  /// <br></br>
  /// <br></br>
  /// Returns an [Either] wrapping:
  ///* nothing, in case of success
  ///* [Failure], in case of failure (no change of the state happens in this case)
  Future<Either<Failure, void>> disposeRecorder();

  /// Starts the recorder.
  /// The current state will not be changed if a failure happens.
  ///<br></br>
  ///<br></br>
  ///A failure will happen if:
  ///* the recorder was uninitialized
  ///* the recorder was recording
  ///* the recorder was  paused
  /// <br></br>
  /// <br></br>
  /// By default the codec will be inferred from the file name extension from the path
  /// provided to this method, but it should be a known codec (aac for example)
  /// <br></br>
  /// <br></br>
  /// - [file]: the file to record into
  /// <br></br>
  /// <br></br>
  /// Returns an [Either] wrapping:
  ///* nothing, in case of success
  ///* [Failure], in case of failure (no change of the state happens in this case)
  Future<Either<Failure, void>> startRecorder({required File file});

  /// Pauses the recorder.
  /// It is allowed to call this method if the recorder was paused, in which case the same current state is maintained.
  /// The current state will not be changed if a failure happens.
  ///<br></br>
  ///<br></br>
  ///A failure will happen if:
  ///* the recorder was uninitialized
  ///* the recorder was stopped
  /// <br></br>
  /// <br></br>
  /// Returns an [Either] wrapping:
  ///* nothing, in case of success
  ///* [Failure], in case of failure (no change of the state happens in this case)
  Future<Either<Failure, void>> pauseRecorder();

  /// Resumes the recorder.
  /// It is allowed to call this method if the recorder was recording, in which case the same current state is maintained.
  /// The current state will not be changed if a failure happens.
  /// <br></br>
  /// <br></br>
  ///A failure will happen if:
  ///* the recorder was uninitialized
  ///* the recorder was stopped
  /// <br></br>
  /// <br></br>
  /// Returns an [Either] wrapping:
  ///* nothing, in case of success
  ///* [Failure], in case of failure (no change of the state happens in this case)
  Future<Either<Failure, void>> resumeRecorder();

  /// Stops the recorder.
  /// The current state will not be changed if a failure happens.
  /// <br></br>
  /// <br></br>
  ///A failure will happen if:
  ///* the recorder was uninitialized
  /// <br></br>
  /// <br></br>
  /// Returns an [Either] wrapping:
  ///* nothing, in case of success
  ///* [Failure], in case of failure (no change of the state happens in this case)
  Future<Either<Failure, void>> stopRecorder();
}

@freezed
class RecorderState with _$RecorderState {
  const RecorderState._();

  const factory RecorderState.uninitialized() = _UninitializedRecorderState;

  const factory RecorderState.recording() = _RecordingRecorderState;

  const factory RecorderState.paused() = _PausedRecorderState;

  const factory RecorderState.stopped() = _StoppedRecorderState;

  bool get isInitialized => this is! _UninitializedRecorderState;

  bool get isRecording => this is _RecordingRecorderState;

  bool get isPaused => this is _PausedRecorderState;

  bool get isStopped => this is _StoppedRecorderState;
}

class InitRecorderResult {
  ///Stream of states of the recorder
  final Stream<RecorderState> recorderStateStream;

  ///Stream of durations of the current recording
  final Stream<Duration> recordingDurationStream;

  ///Stream of the volume of the current recording at this point in time
  ///0 is the minimum value and 100 is the maximum
  final Stream<double> recordingVolumeStream;

  InitRecorderResult({
    required this.recorderStateStream,
    required this.recordingDurationStream,
    required this.recordingVolumeStream,
  });
}
