part of 'sound_changer_bloc.dart';

@freezed
class SoundChangerBlocState with _$SoundChangerBlocState {
  const SoundChangerBlocState._();

  const factory SoundChangerBlocState({
    ///[recording] : the recording being edited
    RecordingDetails? recording,
    @Default(false) bool isProcessing,
    @Default(false) bool isInitialized,
    @Default(false) bool isError,
    String? errorMessage,
    //tempo
    @Default(false) bool shouldChangeTempo,
    @Default(SoundChangerService.defaultTempo) double tempo,
    //echo
    @Default(false) bool shouldAddEcho,
    @Default(SoundChangerService.defaultEchoInputGain) double echoInputGain,
    @Default(SoundChangerService.defaultEchoOutputGain) double echoOutputGain,
    @Default(SoundChangerService.defaultEchoDelay) double echoDelay,
    @Default(SoundChangerService.defaultEchoDecay) double echoDecay,
    //trim
    @Default(false) bool shouldTrim,
    @Default(0) int trimStart,
    @Default(0) int trimEnd,
    //sample rate
    @Default(false) bool shouldChangeSampleRate,
    @Default(SoundChangerService.defaultSampleRate) int sampleRate,
    //volume
    @Default(false) bool shouldChangeVolume,
    @Default(SoundChangerService.defaultVolume) double volume,
    //reverse
    @Default(false) bool shouldReverse,
  }) = _SoundChangerBlocState;

  @override
  String toString() => '\nSoundChangerBlocState{\n'
      'recording: $recording\n'
      'isProcessing: $isProcessing\n'
      'isInitialized: $isInitialized\n'
      'isError: $isError\n'
      'errorMessage: $errorMessage\n'
      'shouldChangeTempo: $shouldChangeTempo\n'
      'tempo: $tempo\n'
      'shouldAddEcho: $shouldAddEcho\n'
      'echoInputGain: $echoInputGain\n'
      'echoOutputGain: $echoOutputGain\n'
      'echoDelay: $echoDelay\n'
      'echoDecay: $echoDecay\n'
      'shouldTrim: $shouldTrim\n'
      'trimStart: $trimStart\n'
      'trimEnd: $trimEnd\n'
      'shouldChangeSampleRate: $shouldChangeSampleRate\n'
      'sampleRate: $sampleRate\n'
      'sampleRate: $shouldChangeVolume\n'
      'volume: $volume\n'
      'shouldReverse: $shouldReverse\n'
      '}\n';
}
