part of 'recorder_bloc.dart';

@freezed
class RecorderBlocState with _$RecorderBlocState {
  const RecorderBlocState._();

  const factory RecorderBlocState({
    Stream<RecorderInfo>? recorderInfoStream,
    RecordingDetails? recording,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _RecorderBlocState;

  @override
  String toString() {
    return '\nRecorderBlocState{\n'
        'recorderInfoStream: $recorderInfoStream,\n'
        'recording: $recording,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessage,\n'
        '}\n';
  }
}

class RecorderInfo {
  ///The current state of the recorder.
  final RecorderState state;

  ///The duration of the current recording, if there is any.
  final Duration duration;

  ///The volume of the current recording, if there is any
  final double volume;

  RecorderInfo(this.state, this.duration, this.volume);

  @override
  String toString() {
    return 'RecorderInfo{state: $state, duration: $duration, volume: $volume}';
  }
}
