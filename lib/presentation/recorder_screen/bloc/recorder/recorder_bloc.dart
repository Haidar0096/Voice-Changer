import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/common/extensions/datetime_extensions.dart';
import 'package:voice_changer/domain/common/extensions/file_extensions.dart';
import 'package:voice_changer/domain/common/service/filesystem_service.dart';
import 'package:voice_changer/domain/recorder/recorder_service.dart';

part 'recorder_bloc.freezed.dart';
part 'recorder_bloc_event.dart';
part 'recorder_bloc_state.dart';

@Injectable()
class RecorderBloc extends Bloc<RecorderBlocEvent, RecorderBlocState> {
  final RecorderService _recorderService;
  final FileSystemService _fileSystemService;
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);

  //the initial state is passed to the super class
  RecorderBloc(this._recorderService, this._fileSystemService)
      : super(const RecorderBlocState()) {
    on<RecorderBlocEvent>((event, emit) async {
      _logger.d('An event has arrived : $event while the state was $state');
      emit(await event.map(
        init: _handleInitEvent,
        startRecording: _handleStartRecordingEvent,
        stopRecording: _handleStopRecordingEvent,
        saveRecording: _handleSaveRecordingEvent,
        appGoInactive: _handleAppGoInactiveEvent,
        deleteRecording: _handleDeleteRecordingEvent,
      ));
      _logger.i('Yielding a new state in response to event $event : $state');
    });
  }

  FutureOr<RecorderBlocState> _handleInitEvent(_InitEvent event) async =>
      (await _recorderService.initRecorder()).fold(
        _errorState,
        (initRecorderResult) async => RecorderBlocState(
          recorderStateStream: initRecorderResult.recorderStateStream,
          recordingDurationStream: initRecorderResult.recordingDurationStream,
        ),
      );

  FutureOr<RecorderBlocState> _handleStartRecordingEvent(
          _StartRecordingEvent event) async =>
      (await _fileSystemService.getDefaultStorageDirectory()).fold(
        _errorState,
        (directory) async => (await _fileSystemService.createFile(
          fileName: DateTime.now().toPathSuitableString(),
          extension: 'aac',
          directory: directory,
        ))
            .fold(
          _errorState,
          (tempFile) async {
            return (await _recorderService.startRecorder(path: tempFile.path))
                .fold(
              _errorState,
              (_) => state.copyWith(
                recordingFileOption: Some(tempFile),
              ),
            );
          },
        ),
      );

  Future<RecorderBlocState> _handleStopRecordingEvent(
          _StopRecordingEvent event) async =>
      (await _recorderService.stopRecorder()).fold(
        _errorState, //failure in stopRecorder
        (_) => state,
      );

  FutureOr<RecorderBlocState> _handleSaveRecordingEvent(
      _SaveRecordingEvent event) async {
    if (event.newRecordingFileName ==
        state.recordingFileOption.toNullable()!.getName()) {
      return state.copyWith(
        recordingFileOption: const None(),
      );
    }
    return (await _fileSystemService.renameFile(
      file: state.recordingFileOption.toNullable()!,
      newFileName: event.newRecordingFileName,
      extension: 'aac',
    ))
        .fold(
      _errorState,
      (_) => state.copyWith(
        recordingFileOption: const None(),
      ),
    );
  }

  FutureOr<RecorderBlocState> _handleDeleteRecordingEvent(
      _DeleteRecordingEvent event) async {
    return (await _fileSystemService.deleteFile(
      state.recordingFileOption.toNullable()!,
    ))
        .fold(
      _errorState,
      (_) => state.copyWith(
        recordingFileOption: const None(),
      ),
    );
  }

  FutureOr<RecorderBlocState> _handleAppGoInactiveEvent(
      _AppGoInactiveEvent event) async {
    if (_recorderService.recorderState.isRecording) {
      (await _recorderService.stopRecorder()).fold(
        _errorState, //failure in stopRecorder
        (_) async {
          return (await _fileSystemService
                  .deleteFile(state.recordingFileOption.toNullable()!))
              .fold(
            _errorState,
            (_) => state.copyWith(
              recordingFileOption: const None(),
            ),
          );
        },
      );
    }
    return state;
  }

  @override
  Future<void> close() async {
    await _recorderService.disposeRecorder();
    _logger.i('disposed recorder bloc');
    super.close();
  }

  FutureOr<RecorderBlocState> _errorState(Failure failure) => RecorderBlocState(
        isError: true,
        errorMessageOption: Some(failure.message),
      );
}
