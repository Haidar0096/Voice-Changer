import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
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

  PlayerBloc(this._playerService) : super(const PlayerBlocState()) {
    on<PlayerBlocEvent>(
      (event, emit) async {
        if (state.isProcessing) {
          _logger.w(
              'an event arrived while state.isProcessing was true (will skip this event):'
              '\nevent is:\n$event\nstate is:\n$state\n');
          return;
        }
        await event.map(
          init: (event) async => await _handleInitEvent(event, emit),
          start: (event) async => await _handleStartEvent(event, emit),
          pause: (event) async => await _handlePauseEvent(event, emit),
          resume: (event) async => await _handleResumeEvent(event, emit),
          stop: (event) async => await _handleStopEvent(event, emit),
          seekToPosition: (event) async =>
              await _handleSeekToPositionEvent(event, emit),
          appGoInactive: (event) async =>
              await _handleAppGoInactiveEvent(event, emit),
        );
      },
    );
  }

  Future<void> _handleInitEvent(
      _Init event, Emitter<PlayerBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _playerService.initPlayer()).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (initStateResult) async {
        emit(state.copyWith(isProcessing: false));
        final futures = [
          emit.forEach<PlayerState>(
            initStateResult.playerStateStream,
            onData: (playerState) => state.copyWith(
              playerState: playerState,
              recording: playerState.isStopped ? null : state.recording,
            ),
          ),
          emit.forEach<Duration>(
            initStateResult.positionStream,
            onData: (position) => state.copyWith(
              position: position,
            ),
          ),
        ];
        return Future.wait(futures);
      },
    );
  }

  Future<void> _handleStartEvent(
      _Start event, Emitter<PlayerBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _playerService.startPlayer(file: File(event.recording.path)))
        .fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async => emit(
        state.copyWith(
          isProcessing: false,
          recording: event.recording,
        ),
      ),
    );
  }

  Future<void> _handlePauseEvent(
      _Pause event, Emitter<PlayerBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _playerService.pausePlayer()).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async => emit(state.copyWith(isProcessing: false)),
    );
  }

  Future<void> _handleResumeEvent(
      _Resume event, Emitter<PlayerBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _playerService.resumePlayer()).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async => emit(state.copyWith(isProcessing: false)),
    );
  }

  Future<void> _handleStopEvent(
      _Stop event, Emitter<PlayerBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _playerService.stopPlayer()).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async {
        emit(
          state.copyWith(
            isProcessing: false,
            recording: null,
          ),
        );
        if (event.onDone != null) {
          await event.onDone!();
        }
      },
    );
  }

  Future<void> _handleSeekToPositionEvent(
      _SeekToPosition event, Emitter<PlayerBlocState> emit) async {
    // emit(state.copyWith(isProcessing: true));
    return (await _playerService.seekToPosition(event.position)).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async {},
      // (_) async => emit(state.copyWith(isProcessing: false)),
    );
  }

  Future<void> _handleAppGoInactiveEvent(
      _AppGoInactiveEvent event, Emitter<PlayerBlocState> emit) async {
    if (_playerService.playerState.isPlaying ||
        _playerService.playerState.isPaused) {
      emit(state.copyWith(isProcessing: true));
      return (await _playerService.stopPlayer()).fold<Future>(
        (f) async => _emitErrorState(emit, f),
        (_) async => emit(
          state.copyWith(
            isProcessing: false,
            recording: null,
          ),
        ),
      );
    }
  }

  void _emitErrorState(Emitter<PlayerBlocState> emit, Failure f) =>
      emit(state.copyWith(isError: true, errorMessage: f.message));

  @override
  void onEvent(event) {
    super.onEvent(event);
    _logger.d(
        '[PlayerBloc] event has arrived: \n$event\nwhile the state was \n$state\n');
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    _logger.i(
        '[PlayerBloc] emitting a new state: \n${transition.nextState}\nin response to event \n${transition.event}\n');
  }

  @override
  Future<void> close() async {
    await _playerService.disposePlayer();
    _logger.i('disposed player bloc');
    super.close();
  }
}
