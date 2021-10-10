// part of 'playback_bloc.dart';
//
// @freezed
// class PlaybackBlocState with _$PlaybackBlocState {
//   const PlaybackBlocState._();
//
//   ///* [isProcessing] : whether the bloc is processing a certain event
//   ///* [currentPlaybackPosition] : the position of the current playback
//   ///* [currentPlaybackDuration] : the duration of the current playback
//   const factory PlaybackBlocState({
//     @Default(false) bool isInitialized,
//     @Default(false) bool isPlaying,
//     @Default(false) bool isPaused,
//     @Default(false) bool isError,
//     @Default(false) bool isProcessing,
//     @Default(None()) Option<String> errorMessageOption,
//     @Default(None()) Option<int> selectedTrackIndexOption,
//     @Default(None()) Option<PlaybackDetails> playbackDetailsOption,
//     @Default(None()) Option<List<TrackInfo>> recordingsInfoOption,
//   }) = _PlaybackBlocState;
//
//   @override
//   String toString() => 'PlaybackBlocState{\n'
//       ' isInitialized: $isInitialized,'
//       ' isPlaying: $isPlaying,'
//       ' isPaused: $isPaused,'
//       ' isError: $isError,'
//       ' isProcessing: $isProcessing,\n'
//       ' errorMessageOption: ${errorMessageOption},\n'
//       ' selectedTrackIndexOption: ${selectedTrackIndexOption},\n'
//       ' playbackDetailsOption: $playbackDetailsOption,\n'
//       ' recordingsInfoOption: ${recordingsInfoOption.isNone() ? 'None,\n' : 'List of length ='
//           ' ${recordingsInfoOption.getOrElse(() => []).length}\n'}'
//       '}';
// }
