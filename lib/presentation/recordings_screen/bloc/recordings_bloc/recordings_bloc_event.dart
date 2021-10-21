part of 'recordings_bloc.dart';

@freezed
class RecordingsBlocEvent with _$RecordingsBlocEvent {
  const factory RecordingsBlocEvent.init() = _Init;

  const factory RecordingsBlocEvent.refresh() = _Refresh;

  const factory RecordingsBlocEvent.deleteRecording(String path) =
      _DeleteRecordingEvent;
}
