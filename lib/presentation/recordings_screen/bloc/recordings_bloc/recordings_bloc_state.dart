part of 'recordings_bloc.dart';

@freezed
class RecordingsBlocState with _$RecordingsBlocState {
  const factory RecordingsBlocState({
    List<RecordingDetails>? recordings,
    @Default(false) bool isProcessing,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _RecordingsBlocState;
}
