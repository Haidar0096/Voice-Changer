part of 'player_bloc.dart';

///[recording] : the recording being played
@freezed
class PlayerBlocState with _$PlayerBlocState {
  const PlayerBlocState._();

  const factory PlayerBlocState({
    Stream<PlayerInfo>? playerInfoStream,
    RecordingDetails? recording,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _PlayerBlocState;

  @override
  String toString() {
    return '\nPlayerBlocState{\n'
        'playerInfoStream: $playerInfoStream\n'
        'recording: $recording,\n'
        'isError: $isError,\n'
        'errorMessage: $errorMessage,\n'
        '}\n';
  }
}

class PlayerInfo {
  final PlayerState state;
  final Duration position;

  PlayerInfo(this.state, this.position);

  @override
  String toString() {
    return 'PlayerInfo{playerState: $state, position: $position}';
  }
}
