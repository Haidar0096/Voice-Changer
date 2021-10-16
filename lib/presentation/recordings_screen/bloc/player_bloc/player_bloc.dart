import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/player/player_service.dart';
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';

part 'player_bloc.freezed.dart';

part 'player_bloc_event.dart';

part 'player_bloc_state.dart';

@Injectable()
class PlayerBloc extends Bloc<PlayerBlocEvent, PlayerBlocState> {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
  final PlayerService _playerService;

  final _playerInfoSubject = BehaviorSubject<PlayerInfo>();

  PlayerBloc(this._playerService) : super(const PlayerBlocState()) {
    on<PlayerBlocEvent>((event, emit) async {
      emit(await event.map(
        init: _handleInitEvent,
        start: _handleStartEvent,
        pause: _handlePauseEvent,
        resume: _handleResumeEvent,
        stop: _handleStopEvent,
        playbackEnded: _handlePlaybackEndedEvent,
        seekToPosition: _handleSeekToPositionEvent,
        appGoInactive: _handleAppGoInactiveEvent,
      ));
    });
  }

  @override
  void onEvent(event) {
    super.onEvent(event);
    _logger.d('An event has arrived : $event while the state was $state');
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    _logger.i(
        'Emitting a new state: ${transition.nextState} in response to event ${transition.event}');
  }

  FutureOr<PlayerBlocState> _handleInitEvent(_Init event) async =>
      (await _playerService.initPlayer()).fold(
        _errorState,
        (initPlayerResult) {
          late StreamSubscription<PlayerInfo> subscription;
          subscription = Rx.combineLatest2<PlayerState, Duration, PlayerInfo>(
            initPlayerResult.playerStateStream,
            initPlayerResult.positionStream,
            (s, p) => PlayerInfo(s, p),
          ).listen(
            (event) => _playerInfoSubject.add(
              PlayerInfo(
                event.state,
                event.position,
              ),
            ),
            onDone: () => subscription.cancel(),
          );
          return PlayerBlocState(
            playerInfoStream: _playerInfoSubject.stream,
          );
        },
      );

  FutureOr<PlayerBlocState> _handleStartEvent(_Start event) async =>
      (await _playerService.startPlayer(
        file: File(event.recording.path),
        onDone: event.onDone,
      ))
          .fold(
        _errorState,
        (_) => state.copyWith(
          recording: event.recording,
        ),
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
          recording: null,
        ),
      );

  FutureOr<PlayerBlocState> _handlePlaybackEndedEvent(
          _PlaybackEnded event) async =>
      (await _playerService.stopPlayer()).fold(
        _errorState,
        (_) => state.copyWith(
          recording: null,
        ),
      );

  FutureOr<PlayerBlocState> _handleSeekToPositionEvent(
          _SeekToPosition event) async =>
      (await _playerService.seekToPosition(event.position)).fold(
        _errorState,
        (_) => state,
      );

  FutureOr<PlayerBlocState> _handleAppGoInactiveEvent(
      _AppGoInactiveEvent event) async {
    if (_playerService.playerState.isPlaying ||
        _playerService.playerState.isPaused) {
      return (await _playerService.stopPlayer()).fold(
        _errorState,
        (_) => state.copyWith(recording: null),
      );
    }
    return state;
  }

  FutureOr<PlayerBlocState> _errorState(Failure f) => PlayerBlocState(
        isError: true,
        errorMessage: f.message,
      );

  @override
  Future<void> close() async {
    await _playerService.disposePlayer();
    await _playerInfoSubject.close();
    _logger.i('disposed player bloc');
    super.close();
  }
}
