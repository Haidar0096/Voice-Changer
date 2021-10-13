part of 'player_bloc.dart';

///[playingFile] : the file being played
@freezed
class PlayerBlocState with _$PlayerBlocState {
  const factory PlayerBlocState({
    Stream<PlayerInfo>? playerInfoStream,
    File? playingFile,
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
