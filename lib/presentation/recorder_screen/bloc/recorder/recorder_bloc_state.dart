part of 'recorder_bloc.dart';

@freezed
class RecorderBlocState with _$RecorderBlocState {
  const RecorderBlocState._();

  ///[recordingFile] : the file that the current recording is recording into, if there is one
  ///[recordingDurationStream] : the stream of durations of the current recording, if there is one
  const factory RecorderBlocState({
    Stream<RecorderState>? recorderStateStream,
    Stream<Duration>? recordingDurationStream,
    Stream<double>? recordingVolumeStream,
    File? recordingFile,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _RecorderBlocState;

  @override
  String toString() {
    return '\nRecorderBlocState{\n'
        'recorderState: $recorderStateStream,\n'
        'recordingDetailsStream: $recordingDurationStream,\n'
        'recordingVolumeStream: $recordingVolumeStream,\n'
        'recordingFile: $recordingFile,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessage,\n'
        '}\n';
  }
}
