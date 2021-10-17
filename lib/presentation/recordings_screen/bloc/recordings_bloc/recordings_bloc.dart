import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/common/extensions/directory_extensions.dart';
import 'package:voice_changer/domain/common/service/filesystem_service.dart';
import 'package:voice_changer/domain/recorder/recorder_service.dart';
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';

part 'recordings_bloc.freezed.dart';

part 'recordings_bloc_event.dart';

part 'recordings_bloc_state.dart';

@Injectable()
class RecordingsBloc extends Bloc<RecordingsBlocEvent, RecordingsBlocState> {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
  final FileSystemService _fileSystemService;
  final RecordingDetailsService _recordingDetailsService;

  RecordingsBloc(this._fileSystemService, this._recordingDetailsService)
      : super(const RecordingsBlocState()) {
    on<RecordingsBlocEvent>(
      (event, emit) async {
        emit(state.copyWith(isProcessing: true));
        emit(
          await event.map(
            init: _handleInitEvent,
            deleteRecording: _handleDeleteRecordingEvent,
          ),
        );
        emit(state.copyWith(isProcessing: false));
      },
    );
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

  FutureOr<RecordingsBlocState> _handleInitEvent(_Init value) async =>
      (await _fileSystemService.getDefaultStorageDirectory()).fold(
        _errorState,
        (defaultStorageDirectory) async {
          Failure? failure;
          List<RecordingDetails> recordings = [];
          for (final file in defaultStorageDirectory.getFiles(
            extension: RecorderService.defaultCodec,
          )) {
            (await _recordingDetailsService.getRecordingDetails(file)).fold(
                (f) => failure = f, (recording) => recordings.add(recording));
            if (failure != null) {
              break;
            }
          }
          return failure != null
              ? _errorState(failure!)
              : state.copyWith(recordings: recordings);
        },
      );

  FutureOr<RecordingsBlocState> _handleDeleteRecordingEvent(
          _DeleteRecordingEvent event) async =>
      (await _fileSystemService.deleteFile(File(event.path))).fold(
        _errorState,
        (_) {
          state.recordings!.removeWhere((rec) => rec.path == event.path);
          return state;
        },
      );

  FutureOr<RecordingsBlocState> _errorState(Failure failure) =>
      RecordingsBlocState(
        isError: true,
        errorMessage: failure.message,
      );
}
