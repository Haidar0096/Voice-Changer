part of 'recorder_bloc.dart';

@freezed
class RecorderBlocState with _$RecorderBlocState {
  const RecorderBlocState._();

  ///[recordingFile] : the file that the current recording is recording into, if there is one
  ///[recordingDurationStream] : the stream of durations of the current recording, if there is one
  const factory RecorderBlocState({
    @Default(Stream.empty()) Stream<RecorderState> recorderStateStream,
    @Default(Stream.empty()) Stream<Duration> recordingDurationStream,
    @Default(None()) Option<File> recordingFileOption,
    @Default(false) bool isError,
    @Default(None()) Option<String> errorMessageOption,
  }) = _RecorderBlocState;

  @override
  String toString() {
    return '\nRecorderBlocState{\n'
        'recorderState: $recorderStateStream,\n'
        'recordingDetailsStream: $recordingDurationStream,\n'
        'recordingFileName: $recordingFileOption,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessageOption,\n'
        '}\n';
  }
}
