import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

class Failure {
  ///The default error message that is returned to be displayed to
  ///the user in case of error
  static const String defaultErrorMessage =
      'An error has occurred, please refresh or restart the app';

  ///represents a message that can be displayed to the user
  final String message;

  ///can be used by the app to identify the source and nature of the error
  ///from a predefined list of errors present at [ErrorCode] class
  final ErrorCode errorCode;

  Failure(this.message, this.errorCode);
}

@freezed
class ErrorCode with _$ErrorCode {
  const factory ErrorCode.initRecorderError() = _InitRecorderError;

  const factory ErrorCode.disposeRecorderError() = _DisposeRecorderError;

  const factory ErrorCode.startRecorderError() = _StartRecorderError;

  const factory ErrorCode.pauseRecorderError() = _PauseRecorderError;

  const factory ErrorCode.resumeRecorderError() = _ResumeRecorderError;

  const factory ErrorCode.stopRecorderError() = _StopRecorderError;

  const factory ErrorCode.initPlayerError() = _InitPlayerError;

  const factory ErrorCode.disposePlayerError() = _DisposePlayerError;

  const factory ErrorCode.startPlayerError() = _StartPlayerError;

  const factory ErrorCode.pausePlayerError() = _PausePlayerError;

  const factory ErrorCode.resumePlayerError() = _ResumePlayerError;

  const factory ErrorCode.stopPlayerError() = _StopPlayerError;

  const factory ErrorCode.getTrackDetailsError() = _GetTrackDetailsError;

  const factory ErrorCode.changeTempoError() = _ChangeTempoError;

  const factory ErrorCode.changeDelayError() = _ChangeDelayError;

  const factory ErrorCode.changeEchoError() = _ChangeEchoError;

  const factory ErrorCode.applyEffectsError() = _ApplyEffectsError;

  const factory ErrorCode.getDefaultStorageDirectoryError() =
      _GetDefaultStorageDirectoryError;

  const factory ErrorCode.createFileError() = _CreateFileError;

  const factory ErrorCode.deleteFileError() = _DeleteFileError;

  const factory ErrorCode.renameFileError() = _RenameFileError;
}
