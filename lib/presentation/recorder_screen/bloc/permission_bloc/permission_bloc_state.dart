part of 'permission_bloc.dart';

@freezed
class PermissionBlocState with _$PermissionBlocState {
  const PermissionBlocState._();

  const factory PermissionBlocState({
    @Default(false) bool isMicrophonePermissionGranted,
  }) = _PermissionBlocState;

  @override
  String toString() {
    return '\nPermissionBlocState{\n'
        'isMicrophonePermissionGranted:$isMicrophonePermissionGranted,\n'
        '}\n';
  }
}
