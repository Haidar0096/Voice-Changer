part of 'recordings_bloc.dart';

@freezed
class RecordingsBlocEvent with _$RecordingsBlocEvent {
  const factory RecordingsBlocEvent.init() = _Init;

  const factory RecordingsBlocEvent.deleteRecording(File file) =
      _DeleteRecordingEvent;
}
