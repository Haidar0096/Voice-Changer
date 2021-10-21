import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/failure.dart';
import 'package:voice_changer/domain/common/extensions/file_extensions.dart';
import 'package:voice_changer/domain/common/service/filesystem_service.dart';
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';
import 'package:voice_changer/domain/sound_changer/sound_changer_service.dart';

part 'sound_changer_bloc.freezed.dart';

part 'sound_changer_bloc_event.dart';

part 'sound_changer_bloc_state.dart';

@Injectable()
class SoundChangerBloc
    extends Bloc<SoundChangerBlocEvent, SoundChangerBlocState> {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
  final SoundChangerService _soundChangerService;
  final FileSystemService _fileSystemService;

  SoundChangerBloc(this._soundChangerService, this._fileSystemService)
      : super(const SoundChangerBlocState()) {
    on<SoundChangerBlocEvent>(
      (event, emit) async {
        await event.map(
          init: (event) async => await _init(event, emit),
          applyEffects: (event) async => await _applyEffects(event, emit),
          //tempo
          shouldChangeTempoChanged: (event) async =>
              await _shouldChangeTempoChanged(event, emit),
          tempoChanged: (event) async => await _tempoChanged(event, emit),
          //echo
          shouldAddEchoChanged: (event) async =>
              await _shouldAddEchoChanged(event, emit),
          //trim
          shouldTrimChanged: (event) async =>
              await _shouldTrimChanged(event, emit),
          trimStartChanged: (event) async =>
              await _trimStartChanged(event, emit),
          trimEndChanged: (event) async => await _trimEndChanged(event, emit),
          //sample rate
          shouldChangeSampleRateChanged: (event) async =>
              await _shouldChangeSampleRateChanged(event, emit),
          sampleRateChanged: (event) async =>
              await _sampleRateChanged(event, emit),
          //volume
          shouldChangeVolumeChanged: (event) async =>
              await _shouldChangeVolumeChanged(event, emit),
          volumeChanged: (event) async => await _volumeChanged(event, emit),
          //reverse
          shouldReverseChanged: (event) async =>
              await _shouldReverseChanged(event, emit),
        );
      },
    );
  }

  Future _init(_Init event, Emitter<SoundChangerBlocState> emit) async {
    emit(state.copyWith(
      isInitialized: true,
      recording: event.recording,
      trimEnd: event.recording.duration?.inSeconds ?? 1,
    ));
  }

  _shouldChangeTempoChanged(_ShouldChangeTempoChanged event,
          Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(shouldChangeTempo: event.newValue));

  _tempoChanged(
          _TempoChanged event, Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(tempo: event.newValue));

  _shouldAddEchoChanged(
          _ShouldAddEcho event, Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(shouldAddEcho: event.newValue));

  _shouldTrimChanged(_ShouldTrimChanged event,
          Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(shouldTrim: event.newValue));

  _trimStartChanged(
          _TrimStartChanged event, Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(trimStart: event.newValue));

  _trimEndChanged(
          _TrimEndChanged event, Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(trimEnd: event.newValue));

  _shouldChangeSampleRateChanged(_ShouldChangeSampleRateChanged event,
          Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(shouldChangeSampleRate: event.newValue));

  _sampleRateChanged(_SampleRateChanged event,
          Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(sampleRate: event.newValue));

  _shouldChangeVolumeChanged(_ShouldChangeVolumeChanged event,
          Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(shouldChangeVolume: event.newValue));

  _volumeChanged(
          _VolumeChanged event, Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(volume: event.newValue));

  _shouldReverseChanged(_ShouldReverseChanged event,
          Emitter<SoundChangerBlocState> emit) async =>
      emit(state.copyWith(shouldReverse: event.newValue));

  Future _applyEffects(
      _ApplyEffects event, Emitter<SoundChangerBlocState> emit) async {
    emit(state.copyWith(isProcessing: true));
    return (await _fileSystemService.getDefaultStorageDirectory()).fold<Future>(
      (f) async => _emitErrorState(emit, f),
      (defaultStorageDirectory) async {
        File outputFile = File(
            '${defaultStorageDirectory.path}/${event.outputFileName}.${FileExtension.getExtension(state.recording!.path)}');
        List<Failure> failures = [];
        if (state.shouldChangeTempo) {
          await _applyChangeTempo(
              File(state.recording!.path), outputFile, state.tempo, failures);
        }
        if (state.shouldAddEcho) {
          await _applyAddEcho(
              File(state.recording!.path),
              outputFile,
              state.echoInputGain,
              state.echoOutputGain,
              [state.echoDelay],
              [state.echoDecay],
              failures);
        }
        if (state.shouldTrim) {
          await _applyTrim(
            File(state.recording!.path),
            outputFile,
            state.trimStart,
            state.trimEnd,
            failures,
          );
        }
        if (state.shouldChangeSampleRate) {
          await _applySetSampleRate(
            File(state.recording!.path),
            outputFile,
            state.sampleRate,
            failures,
          );
        }
        if (state.shouldChangeVolume) {
          await _applySetVolume(
            File(state.recording!.path),
            outputFile,
            state.volume,
            failures,
          );
        }
        if (state.shouldReverse) {
          await _applyReverse(
              File(state.recording!.path), outputFile, failures);
        }
        emit(state.copyWith(isProcessing: false));
        if (failures.isNotEmpty) {
          emit(
            state.copyWith(
                isError: true,
                errorMessage: 'error(s) occurred while applying sound effects'),
          );
          _logger.e(
              'error(s) occurred while applying sound effects, failures are $failures');
        }
      },
    );
  }

  Future<void> _applyReverse(
      File inputFile, outputFile, List<Failure> failures) async {
    (await _soundChangerService.reverseAudio(
      inputFile: inputFile,
      outputFile: outputFile,
    ))
        .fold<Future>(
      (f) async => failures.add(f),
      (_) async {},
    );
  }

  Future<void> _applySetVolume(File inputFile, File outputFile, double volume,
      List<Failure> failures) async {
    (await _soundChangerService.setVolume(
      inputFile: inputFile,
      outputFile: outputFile,
      volume: volume,
    ))
        .fold<Future>(
      (f) async => failures.add(f),
      (_) async {},
    );
  }

  Future<void> _applySetSampleRate(File inputFile, File outputFile,
      int sampleRate, List<Failure> failures) async {
    (await _soundChangerService.setSampleRate(
      inputFile: inputFile,
      outputFile: outputFile,
      sampleRate: sampleRate,
    ))
        .fold<Future>(
      (f) async => failures.add(f),
      (_) async {},
    );
  }

  Future<void> _applyTrim(File inputFile, File outputFile, int start, int end,
      List<Failure> failures) async {
    (await _soundChangerService.trimSound(
      inputFile: inputFile,
      outputFile: outputFile,
      start: start,
      end: end,
    ))
        .fold<Future>(
      (f) async => failures.add(f),
      (_) async {},
    );
  }

  Future<void> _applyAddEcho(
      File inputFile,
      File outputFile,
      double inputGain,
      double outputGain,
      List<double> delays,
      List<double> decays,
      List<Failure> failures) async {
    (await _soundChangerService.addEcho(
      inputFile: inputFile,
      outputFile: outputFile,
      inputGain: inputGain,
      outputGain: outputGain,
      delays: delays,
      decays: decays,
    ))
        .fold<Future>(
      (f) async => failures.add(f),
      (_) async {},
    );
  }

  Future<void> _applyChangeTempo(File inputFile, File outputFile, double tempo,
      List<Failure> failures) async {
    (await _soundChangerService.changeTempo(
      inputFile: inputFile,
      outputFile: outputFile,
      tempo: tempo,
    ))
        .fold<Future>(
      (f) async => failures.add(f),
      (_) async {},
    );
  }

  void _emitErrorState(Emitter<SoundChangerBlocState> emit, Failure f) =>
      emit(state.copyWith(isError: true, errorMessage: f.message));

  @override
  void onEvent(event) {
    super.onEvent(event);
    _logger.d(
        '[SoundChangerBloc] event has arrived: \n$event\nwhile the state was \n$state\n');
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    _logger.i(
        '[SoundChangerBloc] emitting a new state: \n${transition.nextState}\nin response to event \n${transition.event}\n');
  }
}
