import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/player/player_service.dart';

part 'player_bloc.freezed.dart';
part 'player_bloc_event.dart';
part 'player_bloc_state.dart';

@Injectable()
class PlayerBloc extends Bloc<PlayerBlocEvent, PlayerBlocState> {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
  final PlayerService _playerService;

  PlayerBloc(this._playerService) : super(const PlayerBlocState()) {
    on<PlayerBlocEvent>((event, emit) async {
      _logger.d('An event has arrived : $event while the state was $state');
      emit(await event.map(
        init: _handleInitEvent,
        start: _handleStartEvent,
        pause: _handlePauseEvent,
        resume: _handleResumeEvent,
        stop: _handleStopEvent,
        playbackEnded: _handlePlaybackEndedEvent,
        appGoInactive: _handleAppGoInactiveEvent,
      ));
      _logger.i('Yielding a new state in response to event $event : $state');
    });
  }

  FutureOr<PlayerBlocState> _handleInitEvent(_Init event) async =>
      (await _playerService.initPlayer()).fold(
        _errorState,
        (initPlayerResult) => PlayerBlocState(
          playerStateStream: initPlayerResult.playerStateStream,
          positionStream: initPlayerResult.positionStream,
        ),
      );

  FutureOr<PlayerBlocState> _handleStartEvent(_Start event) async =>
      (await _playerService.startPlayer(file: event.file, onDone: event.onDone))
          .fold(
        _errorState,
        (_) => state.copyWith(playingFile: event.file),
      );

  FutureOr<PlayerBlocState> _handlePauseEvent(_Pause event) async =>
      (await _playerService.pausePlayer()).fold(
        _errorState,
        (_) => state,
      );

  FutureOr<PlayerBlocState> _handleResumeEvent(_Resume event) async =>
      (await _playerService.resumePlayer()).fold(
        _errorState,
        (_) => state,
      );

  FutureOr<PlayerBlocState> _handleStopEvent(_Stop event) async =>
      (await _playerService.stopPlayer()).fold(
        _errorState,
        (_) => state.copyWith(
          playingFile: null,
        ),
      );

  FutureOr<PlayerBlocState> _handlePlaybackEndedEvent(
          _PlaybackEnded event) async =>
      (await _playerService.stopPlayer()).fold(
        _errorState,
        (_) => state.copyWith(
          playingFile: null,
        ),
      );

  FutureOr<PlayerBlocState> _errorState(Failure f) => PlayerBlocState(
        isError: true,
        errorMessage: f.message,
      );

  FutureOr<PlayerBlocState> _handleAppGoInactiveEvent(
      _AppGoInactiveEvent event) async {
    if (_playerService.playerState.isPlaying ||
        _playerService.playerState.isPaused) {
      return (await _playerService.stopPlayer()).fold(
        _errorState,
        (_) => state.copyWith(playingFile: null),
      );
    }
    return state;
  }

  @override
  Future<void> close() async {
    await _playerService.disposePlayer();
    _logger.i('disposed player bloc');
    super.close();
  }
}
