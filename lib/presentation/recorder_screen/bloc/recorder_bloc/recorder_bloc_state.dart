part of 'recorder_bloc.dart';

@freezed
class RecorderBlocState with _$RecorderBlocState {
  const RecorderBlocState._();

  ///[volume] : The volume of the current recording, if there is any
  ///[duration] : The duration of the current recording, if there is any.
  ///[recorderState] : The current state of the recorder.
  const factory RecorderBlocState({
    @Default(RecorderState.uninitialized()) RecorderState recorderState,
    @Default(Duration.zero) Duration duration,
    @Default(0) double volume,
    RecordingDetails? recording,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _RecorderBlocState;

  @override
  String toString() {
    return '\nRecorderBlocState{\n'
        'recorderState: $recorderState,\n'
        'duration: $duration,\n'
        'volume: $volume,\n'
        'recording: $recording,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessage,\n'
        '}\n';
  }
}
