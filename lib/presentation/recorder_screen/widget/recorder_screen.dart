import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/extensions/string_extensions.dart';
import 'package:voice_changer/presentation/common/filled_circle.dart';
import 'package:voice_changer/presentation/common/filled_rectangle.dart';
import 'package:voice_changer/presentation/recorder_screen/bloc/permission_bloc/permission_bloc.dart';
import 'package:voice_changer/presentation/recorder_screen/bloc/recorder_bloc/recorder_bloc.dart';
import 'package:voice_changer/presentation/recordings_screen/widget/recordings_screen.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

part 'error_widget.dart';
part 'loading_widget.dart';
part 'record_button.dart';
part 'recorder_icon_widget.dart';
part 'recorder_screen_components.dart';
part 'recordings_button.dart';
part 'stop_button.dart';

class RecorderScreen extends StatelessWidget {
  const RecorderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<RecorderBloc>(
            create: (context) => serviceLocator.get<RecorderBloc>()
              ..add(const RecorderBlocEvent.init()),
          ),
          BlocProvider<PermissionBloc>(
            create: (context) => serviceLocator.get<PermissionBloc>(),
          )
        ],
        child: Builder(
          //The builder is to ensure that the blocs are available in the nested widget's context
          builder: (context) => BlocBuilder<RecorderBloc, RecorderBlocState>(
            builder: (context, recorderBlocState) {
              if (recorderBlocState.isError) {
                return _ErrorWidget();
              }
              if (recorderBlocState.recorderState.isInitialized) {
                return _RecorderScreenComponents();
              }
              return const _LoadingWidget();
            },
          ),
        ),
      );
}
