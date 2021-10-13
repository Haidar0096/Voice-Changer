// part of 'sound_effects_bloc.dart';
//
// typedef void OnApplyEffectsSuccess(
//     bool shouldOverrideOriginalFile, String outputFilePath);
// typedef void OnApplyEffectsError(List<Failure> failures);
//
// @freezed
// class SoundEffectsBlocEvent with _$SoundEffectsBlocEvent {
//   ///[onSuccess] : a function to be executed when the effects are applied successfully
//   ///[onError] : a function to be executed when the effects are not applied successfully
//   const factory SoundEffectsBlocEvent.applyEffectsEvent({
//     required String inputFilePath,
//     required OnApplyEffectsSuccess onSuccess,
//     required OnApplyEffectsError onError,
//   }) = _ApplyEffectsEvent;
//
//   const factory SoundEffectsBlocEvent.tempoChanged({required double newValue}) =
//       _TempoChangedEvent;
//
//   const factory SoundEffectsBlocEvent.delayChanged({required double newValue}) =
//       _DelayChangedEvent;
//
//   const factory SoundEffectsBlocEvent.echoChanged(
//       {required EchoType newValue}) = _EchoChangedEvent;
//
//   const factory SoundEffectsBlocEvent.shouldOverrideOriginalFileChanged(
//       {required bool newValue}) = _ShouldOverrideOriginalFileChangedEvent;
// }
