import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_handler_service.freezed.dart';

///A service for managing permissions for the app.
abstract class PermissionHandlerService {
  /// Requests microphone permission (**it does not open app settings**).
  ///<br></br>
  ///<br></br>
  /// Returns:
  /// * [PermissionStatus.granted] if granted
  /// * [PermissionStatus.denied] if denied
  /// * [PermissionStatus.deniedPermanently] if denied permanently
  Future<PermissionStatus> requestMicrophonePermission();

  ///Checks the status of the microphone permission.
  ///<br></br>
  ///<br></br>
  ///Returns:
  /// * [PermissionStatus.granted] if granted
  /// * [PermissionStatus.denied] if denied
  Future<PermissionStatus> checkMicrophonePermission();

  ///Opens the settings app.
  ///<br></br>
  ///<br></br>
  /// Returns:
  /// * true if it could be opened
  /// * false if it couldn't be opened.
  Future<bool> openSettingsApp();
}

///Represents the state of a permission, which may be:
@freezed
class PermissionStatus with _$PermissionStatus {
  const PermissionStatus._();

  ///The permission is granted
  const factory PermissionStatus.granted() = _Granted;

  ///The permission is denied (it is not known if it is denied once or permanently)
  const factory PermissionStatus.denied() = _Denied;

  ///The permission is denied permanently
  const factory PermissionStatus.deniedPermanently() =
      _DeniedPermanently;

  bool get isGranted => this is _Granted;

  bool get isDenied => this is _Denied;

  bool get isDeniedPermanently => this is _DeniedPermanently;
}
