part of 'player_bloc.dart';

///[recording] : the recording being played
@freezed
class PlayerBlocState with _$PlayerBlocState {
  const PlayerBlocState._();

  const factory PlayerBlocState({
    @Default(PlayerState.uninitialized()) PlayerState playerState,
    @Default(Duration.zero) Duration position,
    RecordingDetails? recording,
    @Default(false) bool isProcessing,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _PlayerBlocState;

  @override
  String toString() {
    return '\nPlayerBlocState{\n'
        'playerState: $playerState\n'
        'position: $position\n'
        'recording: $recording,\n'
        'isProcessing: $isProcessing,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessage,\n'
        '}\n';
  }
}
