import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/player/player_service.dart';

@Injectable(as: PlayerService)
class PLayerServiceImpl implements PlayerService {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
  final just_audio.AudioPlayer _player = just_audio.AudioPlayer();

  final BehaviorSubject<PlayerState> _playerStateSubject =
      BehaviorSubject<PlayerState>.seeded(const PlayerState.uninitialized());

  final BehaviorSubject<Duration> _positionSubject =
      BehaviorSubject<Duration>.seeded(Duration.zero);

  @override
  Stream<Duration> get positionStream => _positionSubject.stream;

  @override
  Stream<PlayerState> get playerStateStream => _playerStateSubject.stream;

  @override
  PlayerState get playerState => _playerStateSubject.value;

  @override
  Future<Either<Failure, InitPlayerResult>> initPlayer() async {
    try {
      if (!_playerStateSubject.value.isInitialized) {
        late StreamSubscription<Duration> subscription;
        subscription = _player.positionStream.listen(
          (duration) => _positionSubject.add(duration),
          onDone: () => subscription.cancel(),
        );
        _playerStateSubject.add(const PlayerState.stopped());
      }
      return Right(
        InitPlayerResult(
          playerStateStream: _playerStateSubject.stream,
          positionStream: _positionSubject.stream,
        ),
      );
    } catch (e) {
      _logger.e('error occurred in initPlayer()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.initPlayerError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> disposePlayer() async {
    try {
      if (!_playerStateSubject.value.isInitialized) {
        return const Right(null);
      }
      await _player.dispose();
      _playerStateSubject.add(const PlayerState.uninitialized());
      await _playerStateSubject.close();
      await _positionSubject.close();
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in disposePlayer()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.disposePlayerError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> startPlayer({
    required File file,
    Function? onDone,
  }) async {
    try {
      if (!_playerStateSubject.value.isStopped) {
        throw Exception(
            'startPlayback() was called from an illegal state: ${_playerStateSubject.value}');
      }
      await _player.setFilePath(file.path);

      late StreamSubscription<just_audio.ProcessingState> subscription;
      subscription = _player.processingStateStream.listen(
        (processingState) async {
          if (processingState == just_audio.ProcessingState.completed ||
              processingState == just_audio.ProcessingState.idle) {
            await subscription.cancel();
            _playerStateSubject.add(const PlayerState.stopped());
            if (onDone != null) {
              await onDone();
            }
          }
        },
      );
      _player.play();
      _playerStateSubject.add(const PlayerState.playing());
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in startPlayer()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.startPlayerError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> pausePlayer() async {
    try {
      if (_playerStateSubject.value.isPaused) {
        return const Right(null);
      }
      if (_playerStateSubject.value.isPlaying) {
        await _player.pause();
        _playerStateSubject.add(const PlayerState.paused());
        return const Right(null);
      }
      throw Exception(
          'pausePlayback() was called from an illegal state: ${_playerStateSubject.value}');
    } catch (e) {
      _logger.e('error occurred in pausePlayer()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.pausePlayerError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resumePlayer() async {
    try {
      if (_playerStateSubject.value.isPlaying) {
        return const Right(null);
      }
      if (_playerStateSubject.value.isPaused) {
        _player.play();
        _playerStateSubject.add(const PlayerState.playing());
        return const Right(null);
      }
      throw Exception(
          'resumePlayback() was called from an illegal state: ${_playerStateSubject.value}');
    } catch (e) {
      _logger.e('error occurred in resumePlayer()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.resumePlayerError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> stopPlayer() async {
    try {
      if (!_playerStateSubject.value.isInitialized) {
        throw Exception(
            'stopPlayback() was called from an illegal state: ${_playerStateSubject.value}');
      }
      await _player.stop();
      _playerStateSubject.add(const PlayerState.stopped());
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in stopPlayback()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.stopPlayerError(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> seekToPosition(Duration position) async {
    try {
      if (_playerStateSubject.value.isStopped ||
          !_playerStateSubject.value.isInitialized) {
        throw Exception(
            'seekToPosition() was called from an illegal state: ${_playerStateSubject.value}');
      }
      await _player.seek(position);
      return const Right(null);
    } catch (e) {
      _logger.e('error occurred in seekToPosition()', e);
      return Left(
        Failure(
          Failure.defaultErrorMessage,
          const ErrorCode.seekToPositionError(),
        ),
      );
    }
  }
}
