part of 'player_bloc.dart';

///[playingFile] : the file being played
@freezed
class PlayerBlocState with _$PlayerBlocState {
  const factory PlayerBlocState({
    Stream<PlayerState>? playerStateStream,
    Stream<Duration>? positionStream,
    File? playingFile,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _PlayerBlocState;
}
