part of 'player_bloc.dart';

@freezed
class PlayerBlocEvent with _$PlayerBlocEvent {
  const factory PlayerBlocEvent.init() = _Init;

  const factory PlayerBlocEvent.start({
    required RecordingDetails recording,
    Function? onDone,
  }) = _Start;

  const factory PlayerBlocEvent.pause() = _Pause;

  const factory PlayerBlocEvent.resume() = _Resume;

  const factory PlayerBlocEvent.stop({
    Function? onDone,
  }) = _Stop;

  const factory PlayerBlocEvent.seekToPosition(Duration position) =
      _SeekToPosition;

  ///This event is fired when the app goes inactive
  const factory PlayerBlocEvent.appGoInactive() = _AppGoInactiveEvent;
}