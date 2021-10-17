part of 'recordings_bloc.dart';

@freezed
class RecordingsBlocState with _$RecordingsBlocState {
  const RecordingsBlocState._();
  const factory RecordingsBlocState({
    List<RecordingDetails>? recordings,
    @Default(false) bool isProcessing,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _RecordingsBlocState;

  @override
  String toString() {
    return '\nRecordingsBlocState{\n'
        'recordings: $recordings\n'
        'isProcessing: $isProcessing,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessage,\n'
        '}\n';
  }
}
