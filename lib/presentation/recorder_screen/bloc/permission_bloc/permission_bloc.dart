import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/exception/exception_utils.dart';
import 'package:voice_changer/domain/common/service/permission_handler_service.dart';

part 'permission_bloc.freezed.dart';
part 'permission_bloc_event.dart';
part 'permission_bloc_state.dart';

@Injectable()
class PermissionBloc extends Bloc<PermissionBlocEvent, PermissionBlocState> {
  final PermissionHandlerService _permissionHandlerService;
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.debug);

  PermissionBloc(this._permissionHandlerService)
      : super(const PermissionBlocState()) {
    on<PermissionBlocEvent>((event, emit) async {
      emit(await event.map(
        checkMicrophonePermission: _handleCheckMicrophonePermission,
        requestMicrophonePermission: _handleRequestMicrophonePermission,
        openSettingsApp: _handleOpenSettingsApp,
      ));
    });
  }

  FutureOr<PermissionBlocState> _handleCheckMicrophonePermission(
          _CheckMicrophonePermissionEvent event) async =>
      (await _permissionHandlerService.checkMicrophonePermission()).maybeWhen(
        granted: () async {
          if (event.onGranted != null) {
            await Future.value(event.onGranted!());
          }
          return state.copyWith(isMicrophonePermissionGranted: true);
        },
        denied: () async {
          if (event.onDenied != null) {
            await Future.value(event.onDenied!());
          }
          return state.copyWith(isMicrophonePermissionGranted: false);
        },
        orElse: () => crashWithMessage(
            'an error has occurred: checkMicrophonePermission returned a wrong value'),
      );

  FutureOr<PermissionBlocState> _handleRequestMicrophonePermission(
          _RequestMicrophonePermissionEvent event) async =>
      (await _permissionHandlerService.requestMicrophonePermission()).when(
        granted: () async {
          if (event.onGranted != null) {
            await Future.value(event.onGranted!());
          }
          return state.copyWith(isMicrophonePermissionGranted: true);
        },
        denied: () async {
          if (event.onDenied != null) {
            await Future.value(event.onDenied!());
          }
          return state.copyWith(isMicrophonePermissionGranted: false);
        },
        deniedPermanently: () async {
          if (event.onPermanentlyDenied != null) {
            await Future.value(event.onPermanentlyDenied!());
          }
          return state.copyWith(isMicrophonePermissionGranted: false);
        },
      );

  FutureOr<PermissionBlocState> _handleOpenSettingsApp(
      _OpenSettingsAppEvent event) async {
    await _permissionHandlerService.openSettingsApp();
    return state;
  }

  @override
  void onEvent(event) {
    super.onEvent(event);
    _logger.d(
        '[PermissionBloc] event has arrived: \n$event\nwhile the state was \n$state\n');
  }

  @override
  void onTransition(transition) {
    super.onTransition(transition);
    _logger.i(
        '[PermissionBloc] emitting a new state: \n${transition.nextState}\nin response to event \n${transition.event}\n');
  }

  @override
  Future<void> close() async {
    _logger.i('disposed permission bloc');
    super.close();
  }
}
