// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:injectable/injectable.dart';
// import 'package:logger/logger.dart';
// import 'package:meta/meta.dart';
// import 'package:sound_changer/common/exception/failure.dart';
// import 'package:sound_changer/common/service/path_utils_service.dart';
// import 'package:sound_changer/configuration/service_locator.dart';
// import 'package:sound_changer/domain/sound_changer/sound_changer_service.dart';
//
// part 'sound_effects_bloc.freezed.dart';
//
// part 'sound_effects_event.dart';
//
// part 'sound_effects_state.dart';
//
// @Injectable()
// class SoundEffectsBloc
//     extends Bloc<SoundEffectsBlocEvent, SoundEffectsBlocState> {
//   final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);
//   final SoundChangerService _soundChangerService;
//   final PathUtilsService _pathUtilsService;
//
//   SoundEffectsBloc(
//     this._soundChangerService,
//     this._pathUtilsService,
//   ) : super(SoundEffectsBlocState());
//
//   @override
//   Stream<SoundEffectsBlocState> mapEventToState(
//     SoundEffectsBlocEvent event,
//   ) async* {
//     _logger.d('An event has arrived : $event while the state was $state');
//     yield state.copyWith(
//       isProcessing: true,
//     );
//     yield await event.map(
//       applyEffectsEvent: _handleApplyEffectsEvent,
//       tempoChanged: _handleTempoChangedEvent,
//       shouldOverrideOriginalFileChanged:
//           _handleShouldOverrideOriginalFileChangedEvent,
//       delayChanged: _handleDelayChangedEvent,
//       echoChanged: _handleEchoChangedEvent,
//     );
//     yield state.copyWith(
//       isProcessing: false,
//     );
//     _logger.i('Yielding a new state : $state');
//   }
//
//   ///this event must only happen if the PlaybackBlocState was stopped
//   Future<SoundEffectsBlocState> _handleApplyEffectsEvent(
//       _ApplyEffectsEvent event) async {
//     List<Failure> failures = [];
//
//     String extension =
//         _pathUtilsService.getExtensionFromAbsoluteFilePath(event.inputFilePath);
//     String outputFilePath = state.shouldOverrideOriginalFile
//         ? event.inputFilePath
//         : await _pathUtilsService.generateDefaultStorageFilePath(
//             'rec_edited',
//             extension,
//           );
//
//     await _changeTempo(event, outputFilePath, failures);
//     await _changeDelay(event, outputFilePath, failures);
//     await _changeEcho(event, outputFilePath, failures);
//
//     if (failures.isNotEmpty) {
//       event.onError(failures);
//       return state;
//     }
//
//     event.onSuccess(state.shouldOverrideOriginalFile, outputFilePath);
//     return state;
//   }
//
//   Future<void> _changeTempo(_ApplyEffectsEvent event, String outputFilePath,
//           List<Failure> failures) async =>
//       (await _soundChangerService.changeTempo(
//         inputFilePath: event.inputFilePath,
//         outputFilePath: outputFilePath,
//         value: state.tempo,
//       ))
//           .fold(failures.add, (_) {});
//
//   Future<void> _changeDelay(_ApplyEffectsEvent event, String outputFilePath,
//           List<Failure> failures) async =>
//       (await _soundChangerService.changeDelay(
//         inputFilePath: event.inputFilePath,
//         outputFilePath: outputFilePath,
//         value: state.delay,
//       ))
//           .fold(failures.add, (_) {});
//
//   Future<void> _changeEcho(_ApplyEffectsEvent event, String outputFilePath,
//       List<Failure> failures) async {
//     switch (state.echo) {
//       case EchoType.None:
//         return;
//       case EchoType.Low:
//         (await _soundChangerService.changeEcho(
//           inputFilePath: event.inputFilePath,
//           outputFilePath: outputFilePath,
//           inputGain: 1,
//           outputGain: 1,
//           delays: [200],
//           decays: [0.5],
//         ))
//             .fold(failures.add, (_) {});
//         return;
//       case EchoType.Medium:
//         (await _soundChangerService.changeEcho(
//           inputFilePath: event.inputFilePath,
//           outputFilePath: outputFilePath,
//           inputGain: 1,
//           outputGain: 1,
//           delays: [1000, 3000],
//           decays: [0.5, 0.5],
//         ))
//             .fold(failures.add, (_) {});
//         return;
//       case EchoType.Heavy:
//         (await _soundChangerService.changeEcho(
//           inputFilePath: event.inputFilePath,
//           outputFilePath: outputFilePath,
//           inputGain: 1,
//           outputGain: 1,
//           delays: [1000, 2000, 3000],
//           decays: [1, 0.8, 0.6],
//         ))
//             .fold(failures.add, (_) {});
//         return;
//     }
//   }
//
//   Future<SoundEffectsBlocState> _handleTempoChangedEvent(
//           _TempoChangedEvent event) async =>
//       state.copyWith(tempo: event.newValue);
//
//   Future<SoundEffectsBlocState> _handleDelayChangedEvent(
//           _DelayChangedEvent event) async =>
//       state.copyWith(delay: event.newValue);
//
//   Future<SoundEffectsBlocState> _handleEchoChangedEvent(
//           _EchoChangedEvent event) async =>
//       state.copyWith(echo: event.newValue);
//
//   Future<SoundEffectsBlocState> _handleShouldOverrideOriginalFileChangedEvent(
//           _ShouldOverrideOriginalFileChangedEvent event) async =>
//       state.copyWith(shouldOverrideOriginalFile: event.newValue);
// }
