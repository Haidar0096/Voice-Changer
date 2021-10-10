part of 'recorder_bloc.dart';

@freezed
class RecorderBlocEvent with _$RecorderBlocEvent {
  const factory RecorderBlocEvent.init() = _InitEvent;

  ///This event is fired when record button is pressed
  const factory RecorderBlocEvent.startRecording() = _StartRecordingEvent;

  ///This event is fired when stop button is pressed
  const factory RecorderBlocEvent.stopRecording() = _StopRecordingEvent;

  ///This event is fired when the save button is pressed after stopping the recording
  const factory RecorderBlocEvent.saveRecording({
    required String newRecordingFileName,
  }) = _SaveRecordingEvent;

  const factory RecorderBlocEvent.deleteRecording() = _DeleteRecordingEvent;

  ///This event is fired when the app goes inactive
  const factory RecorderBlocEvent.appGoInactive() = _AppGoInactiveEvent;
}
