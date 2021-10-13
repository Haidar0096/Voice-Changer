// part of 'playback_bloc.dart';
//
// @freezed
// class PlaybackBlocEvent with _$PlaybackBlocEvent {
//   const factory PlaybackBlocEvent.init() = _InitEvent;
//
//   const factory PlaybackBlocEvent.startPlayback({
//     required String filePath,
//     required Function whenFinished,
//   }) = _StartPlaybackEvent;
//
//   const factory PlaybackBlocEvent.pausePlayback() = _PausePlaybackEvent;
//
//   const factory PlaybackBlocEvent.resumePlayback() = _ResumePlaybackEvent;
//
//   const factory PlaybackBlocEvent.stopPlayback() = _StopPlaybackEvent;
//
//   const factory PlaybackBlocEvent.playbackEnded() = _PlaybackEndedEvent;
//
//   const factory PlaybackBlocEvent.trackChanged({required int newIndex}) =
//       _TrackChangedEvent;
//
//   ///[result] : the result of the applying of sound effects, true if success, false otherwise
//   const factory PlaybackBlocEvent.applySoundEffectsEndedEvent({
//     required bool result,
//     bool? shouldTrackIndexChange,
//     String? outputFilePath,
//     List<Failure>? failures,
//   }) = _ApplySoundEffectsEndedEvent;
// }
