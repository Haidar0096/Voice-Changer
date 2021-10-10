import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:voice_changer/domain/common/service/permission_handler_service.dart';

@Injectable(as: PermissionHandlerService)
class PermissionHandlerServiceImpl implements PermissionHandlerService {
  static const String deniedMessage =
      'microphone permission was denied, please grant'
      ' it to continue using the app';
  static const String deniedPermanentlyMessage =
      'microphone permission was denied permanently, please grant'
      ' it to continue using the app';

  @override
  Future<PermissionStatus> requestMicrophonePermission() async {
    ph.PermissionStatus status = await ph.Permission.microphone.request();
    if (status.isGranted) {
      return const PermissionStatus.granted();
    }
    if (status.isPermanentlyDenied) {
      return const PermissionStatus.deniedPermanently();
    }
    return const PermissionStatus.denied();
  }

  @override
  Future<PermissionStatus> checkMicrophonePermission() async {
    bool isGranted = await ph.Permission.microphone.isGranted;
    if (isGranted) {
      return const PermissionStatus.granted();
    }
    return const PermissionStatus.denied();
  }

  @override
  Future<bool> openSettingsApp() async {
    bool result = await ph.openAppSettings();
    return result;
  }
}
