import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/common/extensions/file_extensions.dart';
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';
import 'package:voice_changer/presentation/common/error_widget.dart';
import 'package:voice_changer/presentation/common/loading_widget.dart';
import 'package:voice_changer/presentation/recordings_screen/widget/recordings_screen.dart';
import 'package:voice_changer/presentation/sound_changer_screen/bloc/sound_changer_bloc.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

part 'sound_changer_options.dart';
part 'sound_changer_screen_components.dart';

class SoundChangerScreen extends StatelessWidget {
  static const String routeName = '/sound-changer-screen';

  const SoundChangerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recording =
        ModalRoute.of(context)!.settings.arguments as RecordingDetails;
    return BlocProvider<SoundChangerBloc>(
      create: (context) => serviceLocator.get<SoundChangerBloc>()
        ..add(SoundChangerBlocEvent.init(recording: recording)),
      child: Builder(
        builder: (context) =>
            BlocBuilder<SoundChangerBloc, SoundChangerBlocState>(
          builder: (context, soundChangerBlocState) {
            if (soundChangerBlocState.isError) {
              return ErrorWidget(soundChangerBlocState.errorMessage!);
            }
            if (soundChangerBlocState.isInitialized) {
              return const _SoundChangerScreenComponents();
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
