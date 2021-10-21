part of 'sound_changer_bloc.dart';

@freezed
class SoundChangerBlocEvent with _$SoundChangerBlocEvent {
  const factory SoundChangerBlocEvent.init(
      {required RecordingDetails recording}) = _Init;

  //tempo
  const factory SoundChangerBlocEvent.shouldChangeTempoChanged(bool newValue) =
      _ShouldChangeTempoChanged;

  const factory SoundChangerBlocEvent.tempoChanged(double newValue) =
      _TempoChanged;

  //echo
  const factory SoundChangerBlocEvent.shouldAddEchoChanged(bool newValue) =
      _ShouldAddEcho;

  //trim
  const factory SoundChangerBlocEvent.shouldTrimChanged(bool newValue) =
      _ShouldTrimChanged;

  const factory SoundChangerBlocEvent.trimStartChanged(int newValue) =
      _TrimStartChanged;

  const factory SoundChangerBlocEvent.trimEndChanged(int newValue) =
      _TrimEndChanged;

  //sample rate
  const factory SoundChangerBlocEvent.shouldChangeSampleRateChanged(
      bool newValue) = _ShouldChangeSampleRateChanged;

  const factory SoundChangerBlocEvent.sampleRateChanged(int newValue) =
      _SampleRateChanged;

  //volume
  const factory SoundChangerBlocEvent.shouldChangeVolumeChanged(bool newValue) =
      _ShouldChangeVolumeChanged;

  const factory SoundChangerBlocEvent.volumeChanged(double newValue) =
      _VolumeChanged;

  //reverse
  const factory SoundChangerBlocEvent.shouldReverseChanged(bool newValue) =
      _ShouldReverseChanged;

  const factory SoundChangerBlocEvent.applyEffects(String outputFileName) =
      _ApplyEffects;
}
