part of 'player_bloc.dart';

///[recording] : the recording being played
@freezed
class PlayerBlocState with _$PlayerBlocState {
  const factory PlayerBlocState({
    Stream<PlayerInfo>? playerInfoStream,
    RecordingDetails? recording,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _PlayerBlocState;
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
