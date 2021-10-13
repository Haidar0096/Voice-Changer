import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
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

  final _recordingInfoSubject = BehaviorSubject<RecorderInfo>();

  //the initial state is passed to the super class
  RecorderBloc(this._recorderService, this._fileSystemService)
      : super(const RecorderBlocState()) {
    on<RecorderBlocEvent>((event, emit) async {
      emit(
        await event.map(
          init: _handleInitEvent,
          startRecording: _handleStartRecordingEvent,
          stopRecording: _handleStopRecordingEvent,
          saveRecording: _handleSaveRecordingEvent,
          appGoInactive: _handleAppGoInactiveEvent,
          deleteRecording: _handleDeleteRecordingEvent,
        ),
      );
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

  FutureOr<RecorderBlocState> _handleInitEvent(_InitEvent _) async =>
      (await _recorderService.initRecorder()).fold(
        _errorState,
        (initRecorderResult) async {
          late final StreamSubscription<RecorderInfo> subscription;
          subscription =
              Rx.combineLatest3<RecorderState, Duration, double, RecorderInfo>(
            initRecorderResult.recorderStateStream,
            initRecorderResult.recordingDurationStream,
            initRecorderResult.recordingVolumeStream,
            (s, d, v) => RecorderInfo(s, d, v),
          ).listen(
                  (event) => _recordingInfoSubject.add(
                        RecorderInfo(
                          event.state,
                          event.duration,
                          event.volume,
                        ),
                      ),
                  onDone: () => subscription.cancel());
          return RecorderBlocState(
            recorderInfoStream: _recordingInfoSubject.stream,
          );
        },
      );

  FutureOr<RecorderBlocState> _handleStartRecordingEvent(
          _StartRecordingEvent event) async =>
      (await _fileSystemService.getDefaultStorageDirectory()).fold(
        _errorState,
        (directory) async => (await _fileSystemService.createFile(
          fileName: DateTime.now().toPathSuitableString(),
          extension: RecorderService.defaultCodec,
          path: directory.path,
        ))
            .fold(
          _errorState,
          (tempFile) async {
            return (await _recorderService.startRecorder(file: tempFile)).fold(
              _errorState,
              (_) => state.copyWith(
                recordingFile: tempFile,
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
    if (event.newRecordingFileName == state.recordingFile!.getName()) {
      return state.copyWith(
        recordingFile: null,
      );
    }
    return (await _fileSystemService.renameFile(
      file: state.recordingFile!,
      newFileName: event.newRecordingFileName,
      extension: RecorderService.defaultCodec,
    ))
        .fold(
      _errorState,
      (_) => state.copyWith(
        recordingFile: null,
      ),
    );
  }

  FutureOr<RecorderBlocState> _handleDeleteRecordingEvent(
      _DeleteRecordingEvent event) async {
    return (await _fileSystemService.deleteFile(
      state.recordingFile!,
    ))
        .fold(
      _errorState,
      (_) => state.copyWith(
        recordingFile: null,
      ),
    );
  }

  FutureOr<RecorderBlocState> _handleAppGoInactiveEvent(
      _AppGoInactiveEvent event) async {
    if (_recorderService.recorderState.isRecording) {
      (await _recorderService.stopRecorder()).fold(
        _errorState, //failure in stopRecorder
        (_) async {
          return (await _fileSystemService.deleteFile(state.recordingFile!))
              .fold(
            _errorState,
            (_) => state.copyWith(
              recordingFile: null,
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
    await _recordingInfoSubject.close();
    _logger.i('disposed recorder bloc');
    super.close();
  }

  FutureOr<RecorderBlocState> _errorState(Failure failure) => RecorderBlocState(
        isError: true,
        errorMessage: failure.message,
      );
}
