import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
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
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';

part 'recorder_bloc.freezed.dart';
part 'recorder_bloc_event.dart';
part 'recorder_bloc_state.dart';

@Injectable()
class RecorderBloc extends Bloc<RecorderBlocEvent, RecorderBlocState> {
  final RecorderService _recorderService;
  final FileSystemService _fileSystemService;
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);

  RecorderBloc(this._recorderService, this._fileSystemService)
      : super(const RecorderBlocState()) {
    on<RecorderBlocEvent>(
      (event, emit) async {
        await event.map(
          init: (event) async => await _handleInitEvent(event, emit),
          startRecording: (event) async =>
              await _handleStartRecordingEvent(event, emit),
          stopRecording: (event) async =>
              await _handleStopRecordingEvent(event, emit),
          saveRecording: (event) async =>
              await _handleSaveRecordingEvent(event, emit),
          appGoInactive: (event) async =>
              await _handleAppGoInactiveEvent(event, emit),
          deleteRecording: (event) async =>
              await _handleDeleteRecordingEvent(event, emit),
        );
      },
    );
  }

  Future _handleInitEvent(
          _InitEvent _, Emitter<RecorderBlocState> emit) async =>
      (await _recorderService.initRecorder()).fold<Future>(
        (f) async => _emitErrorState(emit, f),
        (initRecorderResult) async {
          final futures = [
            emit.forEach<RecorderState>(
              initRecorderResult.recorderStateStream,
              onData: (recorderState) =>
                  state.copyWith(recorderState: recorderState),
            ),
            emit.forEach<Duration>(
              initRecorderResult.recordingDurationStream,
              onData: (duration) => state.copyWith(duration: duration),
            ),
            emit.forEach<double>(
              initRecorderResult.recordingVolumeStream,
              onData: (volume) => state.copyWith(volume: volume),
            ),
          ];
          return Future.wait(futures);
        },
      );

  Future _handleStartRecordingEvent(
          _StartRecordingEvent event, Emitter<RecorderBlocState> emit) async =>
      (await _fileSystemService.getDefaultStorageDirectory()).fold<Future>(
        (f) async => _emitErrorState(emit, f),
        (directory) async => (await _fileSystemService.createFile(
          fileName: 'rec_${DateTime.now().toPathSuitableString()}',
          extension: RecorderService.defaultCodec,
          path: directory.path,
        ))
            .fold<Future>(
          (f) async => _emitErrorState(emit, f),
          (file) async {
            return (await _recorderService.startRecorder(file: file))
                .fold<Future>(
              (f) async => _emitErrorState(emit, f),
              (_) async => emit(
                state.copyWith(
                  recording: RecordingDetails(
                    name: FileExtension.getName(file.path),
                    path: file.path,
                    duration: null, //not interested in this field here
                  ),
                ),
              ),
            );
          },
        ),
      );

  Future _handleStopRecordingEvent(
          _StopRecordingEvent event, Emitter<RecorderBlocState> emit) async =>
      (await _recorderService.stopRecorder()).fold<Future>(
        (f) async => _emitErrorState(emit, f), //failure in stopRecorder
        (_) async {},
      );

  Future _handleSaveRecordingEvent(
      _SaveRecordingEvent event, Emitter<RecorderBlocState> emit) async {
    if (event.newRecordingFileName == state.recording!.name) {
      emit(state.copyWith(recording: null));
      return;
    }
    return (await _fileSystemService.renameFile(
      file: File(state.recording!.path),
      newFileName: event.newRecordingFileName,
      extension: RecorderService.defaultCodec,
    ))
        .fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async => emit(state.copyWith(recording: null)),
    );
  }

  Future _handleDeleteRecordingEvent(
      _DeleteRecordingEvent event, Emitter<RecorderBlocState> emit) async {
    return (await _fileSystemService.deleteFile(
      File(state.recording!.path),
    ))
        .fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (_) async => emit(state.copyWith(recording: null)),
    );
  }

  Future _handleAppGoInactiveEvent(
      _AppGoInactiveEvent event, Emitter<RecorderBlocState> emit) async {
    if (state.recorderState.isRecording) {
      (await _recorderService.stopRecorder()).fold<Future>(
        (f) async => _emitErrorState(emit, f), //failure in stopRecorder
        (_) async {
          return (await _fileSystemService
                  .deleteFile(File(state.recording!.path)))
              .fold<Future>(
            (f) async => _emitErrorState(emit, f),
            (_) async => emit(state.copyWith(recording: null)),
          );
        },
      );
    }
  }

  void _emitErrorState(Emitter<RecorderBlocState> emit, Failure f) =>
      emit(state.copyWith(isError: true, errorMessage: f.message));

  @override
  void onEvent(event) {
    super.onEvent(event);
    _logger.d(
        '[RecorderBloc] event has arrived: \n$event\nwhile the state was \n$state\n');
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    _logger.i(
        '[RecorderBloc] emitting a new state: \n${transition.nextState}\nin response to event \n${transition.event}\n');
  }

  @override
  Future<void> close() async {
    await _recorderService.disposeRecorder();
    _logger.i('disposed recorder bloc');
    super.close();
  }
}
