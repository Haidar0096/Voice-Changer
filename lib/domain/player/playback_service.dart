// import 'package:dartz/dartz.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sound_changer/domain/common/exception/failure.dart';
//
// part 'playback_service.freezed.dart';
//
// abstract class PlaybackService {
//   /// Initializes the player.
//   /// It is allowed to call this method if initialization has already happened,in which case the same current state is maintained.
//   /// Usually this method must not result in any failures.
//   /// The current state will not be changed if a failure happens.
//   /// <br></br>
//   /// <br></br>
//   /// Returns an [Either] wrapping:
//   ///* The new [PlayerState], in case of success
//   ///* [Failure], in case of failure (no change of the state happens in this case)
//   Future<Either<Failure, PlayerState>> initPlayer();
//
//   /// Disposes the player, and stops it if it is recording.
//   /// It is allowed to call this method if dispose has already happened.
//   /// Usually this method must not result in any failures.
//   /// The current state will not be changed if a failure happens.
//   /// <br></br>
//   /// <br></br>
//   /// Returns an [Either] wrapping:
//   ///* The new [PlayerState], in case of success
//   ///* [Failure], in case of failure (no change of the state happens in this case)
//   Future<Either<Failure, PlayerState>> disposePlayer();
//
//   /// Starts playing the file at the provided location.
//   /// The current state will not be changed if a failure happens.
//   /// When the player finishes, the player's state will become [PlayerState.stopped].
//   ///<br></br>
//   ///<br></br>
//   ///A failure will happen if:
//   ///* the player was uninitialized
//   ///* the player was playing
//   ///* the player was  paused
//   /// <br></br>
//   /// <br></br>
//   /// Params:
//   /// * [whenFinished] : a callback to perform when the playback finishes, usually used to
//   /// notify the UI to update its state
//   /// <br></br>
//   /// <br></br>
//   /// Returns an [Either] wrapping:
//   ///* The new [PlayerState] which contains the [PlaybackDetails], in case of success
//   ///* [Failure], in case of failure (no change of the state happens in this case)
//   Future<Either<Failure, PlayerState>> startPlayback({
//     required String playbackFilePath,
//     Function? whenFinished,
//   });
//
//   /// Pauses the player.
//   /// It is allowed to call this method if the player was paused, in which case the same current state is maintained.
//   /// The current state will not be changed if a failure happens.
//   ///<br></br>
//   ///<br></br>
//   ///A failure will happen if:
//   ///* the player was uninitialized
//   ///* the player was stopped
//   /// <br></br>
//   /// <br></br>
//   /// Returns an [Either] wrapping:
//   ///* The new [PlayerState] which contains the [PlaybackDetails], in case of success
//   ///* [Failure], in case of failure (no change of the state happens in this case)
//   Future<Either<Failure, PlayerState>> pausePlayback();
//
//   /// Resumes the player.
//   /// It is allowed to call this method if the player was playing, in which case the same current state is maintained.
//   /// The current state will not be changed if a failure happens.
//   /// <br></br>
//   /// <br></br>
//   ///A failure will happen if:
//   ///* the player was uninitialized
//   ///* the player was stopped
//   /// <br></br>
//   /// <br></br>
//   /// Returns:
//   ///* The new [PlayerState] which contains the [PlaybackDetails], in case of success
//   ///* [Failure], in case of failure (no change of the state happens in this case)
//   Future<Either<Failure, PlayerState>> resumePlayback();
//
//   /// Stops the player.
//   /// The current state will not be changed if a failure happens.
//   /// <br></br>
//   /// <br></br>
//   ///A failure will happen if:
//   ///* the player was uninitialized
//   /// <br></br>
//   /// <br></br>
//   /// Returns:
//   ///* The new [PlayerState], in case of success
//   ///* [Failure], in case of failure (no change of the state happens in this case)
//   Future<Either<Failure, PlayerState>> stopPlayback();
//
//   ///Returns the available details about the track at the specified path, if successful
//   Future<Either<Failure, TrackInfo>> getTrackInfo(String filePath);
// }
//
// class TrackInfo {
//   final String path;
//
//   final String name;
//
//   ///The duration of the playback, if available
//   final Option<Duration> durationOption;
//
//   TrackInfo({
//     required this.path,
//     required this.name,
//     required this.durationOption,
//   });
//
//   @override
//   String toString() {
//     return 'TrackInfo{path: $path, name: $name, durationOption: $durationOption}';
//   }
// }
//
// class PlaybackDetails {
//   ///The [Stream] of the current position of the playback
//   final Stream<Duration> positionStream;
//
//   PlaybackDetails({
//     required this.positionStream,
//   });
//
//   @override
//   String toString() {
//     return 'PlaybackDetails{positionStream: $positionStream}';
//   }
// }
//
// @freezed
// class PlayerState with _$PlayerState {
//   const factory PlayerState({
//     @Default(false) bool isInitialized,
//     @Default(false) bool isPlaying,
//     @Default(false) bool isPaused,
//     @Default(false) bool isStopped,
//     PlaybackDetails? playbackDetails,
//     TrackInfo? trackInfo,
//   }) = _PlayerState;
// }
