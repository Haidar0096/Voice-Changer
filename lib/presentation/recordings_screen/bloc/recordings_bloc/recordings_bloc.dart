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
        await event.map(
          init: (event) async => await _handleInitEvent(event, emit),
          deleteRecording: (event) async =>
              await _handleDeleteRecordingEvent(event, emit),
        );
      },
    );
  }

  Future _handleInitEvent(
      _Init value, Emitter<RecordingsBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _fileSystemService.getDefaultStorageDirectory()).fold<Future>(
      (f) async => _emitErrorState(emit, f),
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
        if (failure != null) {
          _emitErrorState(emit, failure!);
        } else {
          emit(
            state.copyWith(
              isInitialized: true,
              isProcessing: false,
              recordings: List.unmodifiable(recordings),
              // recordings: recordings,
            ),
          );
        }
      },
    );
  }

  Future _handleDeleteRecordingEvent(
      _DeleteRecordingEvent event, Emitter<RecordingsBlocState> emit) async {
    final tempRecordings =
        state.recordings.whereNot((rec) => rec.path == event.path).toList();
    //emit a state with the selected recording removed,so that UI doesn't have to wait to update
    //in case of error no need to restore the previous recordings list
    emit(state.copyWith(isProcessing: true, recordings: tempRecordings));
    return (await _fileSystemService.deleteFile(File(event.path))).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async {
        emit(
          state.copyWith(
            isProcessing: false,
            recordings: List.unmodifiable(tempRecordings),
            // recordings: newRecordingsList,
          ),
        );
      },
    );
  }

  void _emitErrorState(Emitter<RecordingsBlocState> emit, Failure f) =>
      emit(RecordingsBlocState(isError: true, errorMessage: f.message));

  @override
  void onEvent(event) {
    super.onEvent(event);
    _logger.d(
        '[RecordingsBloc] event has arrived: \n$event\nwhile the state was \n$state\n');
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    _logger.i(
        '[RecordingsBloc] emitting a new state: \n${transition.nextState}\nin response to event \n${transition.event}\n');
  }
}
