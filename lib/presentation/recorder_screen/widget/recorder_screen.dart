import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/extensions/file_extensions.dart';
import 'package:voice_changer/domain/common/extensions/string_extensions.dart';
import 'package:voice_changer/domain/recorder/recorder_service.dart';
import 'package:voice_changer/presentation/common/filled_circle.dart';
import 'package:voice_changer/presentation/common/filled_rectangle.dart';
import 'package:voice_changer/presentation/recorder_screen/bloc/permission_bloc/permission_bloc.dart';
import 'package:voice_changer/presentation/recorder_screen/bloc/recorder/recorder_bloc.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

part 'error_widget.dart';
part 'loading_widget.dart';
part 'record_button.dart';
part 'recorder_icon_widget.dart';
part 'recorder_widget.dart';
part 'recordings_button.dart';
part 'stop_button.dart';

class RecorderScreenWidget extends StatefulWidget {
  const RecorderScreenWidget({Key? key}) : super(key: key);

  @override
  _RecorderScreenWidgetState createState() => _RecorderScreenWidgetState();
}

class _RecorderScreenWidgetState extends State<RecorderScreenWidget>
    with WidgetsBindingObserver {
  final Logger _logger = serviceLocator.get<Logger>(param1: Level.nothing);

  late final RecorderBloc _recorderBloc;
  late final PermissionBloc _permissionBloc;

  @override
  void initState() {
    super.initState();
    _recorderBloc = serviceLocator.get<RecorderBloc>()
      ..add(const RecorderBlocEvent.init());
    _permissionBloc = serviceLocator.get<PermissionBloc>();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        _logger.d('app inactive');
        _recorderBloc.add(const RecorderBlocEvent.appGoInactive());
        break;
      case AppLifecycleState.resumed:
        _logger.d('app resumed');
        _permissionBloc
            .add(const PermissionBlocEvent.checkMicrophonePermission());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<RecorderBloc>(
            create: (context) => _recorderBloc,
          ),
          BlocProvider<PermissionBloc>(
            create: (context) => _permissionBloc,
          )
        ],
        child: Builder(
          //The builder is to ensure that the blocs are available in the nested widget's context
          builder: (context) =>
              BlocBuilder<PermissionBloc, PermissionBlocState>(
            builder: (context, permissionBlocState) =>
                BlocBuilder<RecorderBloc, RecorderBlocState>(
              builder: (context, recorderBlocState) {
                if (recorderBlocState.isError) {
                  return _ErrorWidget();
                } else {
                  return StreamBuilder<RecorderState>(
                      stream: recorderBlocState.recorderStateStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ||
                            (snapshot.hasData &&
                                !snapshot.data!.isInitialized)) {
                          return const _LoadingWidget();
                        }
                        return _RecorderWidget();
                      });
                }
              },
            ),
          ),
        ),
      );
}
