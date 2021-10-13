import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/common/extensions/directory_extensions.dart';
import 'package:voice_changer/domain/common/service/filesystem_service.dart';
import 'package:voice_changer/domain/recorder/recorder_service.dart';
import 'package:voice_changer/domain/recording/recording_details_service.dart';

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
    on<RecordingsBlocEvent>((event, emit) async {
      _logger.d('An event has arrived : $event while the state was $state');
      emit(state.copyWith(isLoading: true));
      emit(await event.map(
        init: _handleInitEvent,
      ));
      emit(state.copyWith(isLoading: false));
      _logger.i('Yielding a new state in response to event $event : $state');
    });
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
              : RecordingsBlocState(recordings: recordings);
        },
      );

  FutureOr<RecordingsBlocState> _errorState(Failure failure) =>
      RecordingsBlocState(
        isError: true,
        errorMessage: failure.message,
      );
}
