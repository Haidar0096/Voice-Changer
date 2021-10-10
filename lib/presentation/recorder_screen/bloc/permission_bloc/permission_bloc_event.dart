part of 'permission_bloc.dart';

@freezed
class PermissionBlocEvent with _$PermissionBlocEvent {
  ///[onGranted] : a callback to execute if the permission was granted
  const factory PermissionBlocEvent.requestMicrophonePermission({
    Function? onGranted,
    Function? onDenied,
    Function? onPermanentlyDenied,
  }) = _RequestMicrophonePermissionEvent;

  ///[onGranted] : a callback to execute if the permission was granted
  const factory PermissionBlocEvent.checkMicrophonePermission({
    Function? onGranted,
    Function? onDenied,
  }) = _CheckMicrophonePermissionEvent;

  const factory PermissionBlocEvent.openSettingsApp() = _OpenSettingsAppEvent;
}
