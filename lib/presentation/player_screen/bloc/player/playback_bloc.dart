// import 'dart:async';
// import 'dart:io';
//
// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import 'package:sound_changer/common/exception/exception_utils.dart';
// import 'package:sound_changer/common/exception/failure.dart';
// import 'package:sound_changer/common/service/path_utils_service.dart';
// import 'package:sound_changer/configuration/service_locator.dart';
// import 'package:sound_changer/domain/player/playback_service.dart';
//
// part 'playback_bloc.freezed.dart';
// part 'playback_bloc_event.dart';
// part 'playback_bloc_state.dart';
//
// @Injectable()
// class PlaybackBloc extends Bloc<PlaybackBlocEvent, PlaybackBlocState> {
//   final PlaybackService _playbackService;
//   final PathUtilsService _pathUtilsService;
//   final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
//
//   PlaybackBloc(
//     this._playbackService,
//     this._pathUtilsService,
//   ) : super(PlaybackBlocState());
//
//   @override
//   Stream<PlaybackBlocState> mapEventToState(
//     PlaybackBlocEvent event,
//   ) async* {
//     _logger.d('An event has arrived : $event while the state was $state');
//     yield state.copyWith(
//       isProcessing: true,
//     );
//     yield await event.map(
//       init: _handleInitEvent,
//       startPlayback: _handleStartPlaybackEvent,
//       pausePlayback: _handlePausePlaybackEvent,
//       resumePlayback: _handleResumePlaybackEvent,
//       stopPlayback: _handleStopPlaybackEvent,
//       playbackEnded: _handlePlaybackEndedEvent,
//       trackChanged: _handleTrackChangedEvent,
//       applySoundEffectsEndedEvent: _handleApplySoundEffectsEndedEvent,
//     );
//     yield state.copyWith(
//       isProcessing: false,
//     );
//     _logger.i('Yielding a new state : $state');
//   }
//
//   Future<List<TrackInfo>> _getRecordingFiles() async {
//     Directory defaultStorageDirectory =
//         await _pathUtilsService.getDefaultStorageDirectory();
//     List<File> recordingsFiles =
//         _pathUtilsService.getFilesInDirectory(defaultStorageDirectory);
//     List<TrackInfo> recordingsInfo = [];
//     for (File file in recordingsFiles) {
//       (await _playbackService.getTrackInfo(file.path)).fold(
//         (failureDescription) => crashWithMessage(
//             'error occurred while retrieving recordings: $failureDescription'),
//         recordingsInfo.add,
//       );
//     }
//     return recordingsInfo;
//   }
//
//   Future<PlaybackBlocState> _handleInitEvent(_InitEvent event) async =>
//       (await _playbackService.initPlayer()).fold(
//         _errorState,
//         (playerState) async => PlaybackBlocState(
//           isInitialized: playerState.isInitialized,
//           recordingsInfoOption: Some(await _getRecordingFiles()),
//         ),
//       );
//
//   Future<PlaybackBlocState> _handleStartPlaybackEvent(
//           _StartPlaybackEvent event) async =>
//       (await _playbackService.startPlayback(
//         playbackFilePath: event.filePath,
//         whenFinished: event.whenFinished,
//       ))
//           .fold(
//         _errorState,
//         (playerState) async {
//           return state.copyWith(
//             isPlaying: playerState.isPlaying,
//             isPaused: playerState.isPaused,
//             playbackDetailsOption: optionOf(playerState.playbackDetails),
//           );
//         },
//       );
//
//   Future<PlaybackBlocState> _handlePausePlaybackEvent(
//           _PausePlaybackEvent event) async =>
//       (await _playbackService.pausePlayback()).fold(
//         _errorState,
//         (playerState) async => state.copyWith(
//           isPlaying: playerState.isPlaying,
//           isPaused: playerState.isPaused,
//         ),
//       );
//
//   Future<PlaybackBlocState> _handleResumePlaybackEvent(
//           _ResumePlaybackEvent event) async =>
//       (await _playbackService.resumePlayback()).fold(
//         _errorState,
//         (playerState) async => state.copyWith(
//           isPlaying: playerState.isPlaying,
//           isPaused: playerState.isPaused,
//         ),
//       );
//
//   Future<PlaybackBlocState> _handleStopPlaybackEvent(
//           _StopPlaybackEvent event) async =>
//       (await _playbackService.stopPlayback()).fold(
//         _errorState,
//         (playerState) async => state.copyWith(
//           isPlaying: playerState.isPlaying,
//           isPaused: playerState.isPaused,
//           playbackDetailsOption: optionOf(playerState.playbackDetails),
//         ),
//       );
//
//   Future<PlaybackBlocState> _handlePlaybackEndedEvent(
//           _PlaybackEndedEvent value) async =>
//       state.copyWith(
//         isPlaying: false,
//         isPaused: false,
//         playbackDetailsOption: None(),
//       );
//
//   ///this event must only happen if the state was stopped
//   Future<PlaybackBlocState> _handleTrackChangedEvent(
//           _TrackChangedEvent event) async =>
//       state.copyWith(
//         selectedTrackIndexOption: Some(event.newIndex),
//         playbackDetailsOption: None(),
//       );
//
//   Future<PlaybackBlocState> _handleApplySoundEffectsEndedEvent(
//       _ApplySoundEffectsEndedEvent event) async {
//     if (event.result == true) {
//       List<TrackInfo> recordingsInfo = state.recordingsInfoOption.getOrElse(
//           () => crashWithMessage(
//               'expected recordingsInfoOption to be Some, but it was None'));
//
//       int selectedTrackIndex = state.selectedTrackIndexOption.getOrElse(() =>
//           crashWithMessage(
//               'expected selectedTrackIndexOption to be Some, but it was None'));
//
//       if (event.shouldTrackIndexChange!) {
//         //add the new recording file to the list of recordings
//         TrackInfo newTrackInfo =
//             (await _playbackService.getTrackInfo(event.outputFilePath!)).fold(
//           (failureDescription) => crashWithMessage(
//               'error occurred while getting info of the edited track'),
//           id,
//         );
//         recordingsInfo.add(newTrackInfo);
//         print('the new recording\'s TrackInfo is $newTrackInfo');
//       } else {
//         //recalculate the duration for the overwritten track
//         TrackInfo newTrackInfo = (await _playbackService
//                 .getTrackInfo(recordingsInfo[selectedTrackIndex].path))
//             .fold(
//           (failureDescription) => crashWithMessage(
//               'error occurred while getting info of the edited track'),
//           id,
//         );
//         recordingsInfo[selectedTrackIndex] = newTrackInfo;
//         print('the new recording\'s TrackInfo is $newTrackInfo');
//       }
//       return state.copyWith(
//         selectedTrackIndexOption: !event.shouldTrackIndexChange!
//             ? state.selectedTrackIndexOption
//             : Some(recordingsInfo.length - 1),
//         recordingsInfoOption: Some(recordingsInfo),
//         playbackDetailsOption: None(),
//       );
//     } else {
//       return _errorState(
//         Failure(
//           'error(s) occurred while applying effects',
//           ErrorCode.applyEffectsError(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Future<void> close() async {
//     await _playbackService.disposePlayer();
//     _logger.i('disposed player');
//     super.close();
//   }
//
//   Future<PlaybackBlocState> _errorState(
//           Failure failureDescription) async =>
//       PlaybackBlocState(
//         isError: true,
//         errorMessageOption: Some(failureDescription.message),
//       );
// }
