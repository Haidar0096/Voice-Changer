import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/domain/recording_details/recording_details_service.dart';
import 'package:voice_changer/presentation/recordings_screen/bloc/player_bloc/player_bloc.dart';
import 'package:voice_changer/presentation/recordings_screen/bloc/recordings_bloc/recordings_bloc.dart';
import 'package:voice_changer/presentation/sound_changer_screen/widget/sound_changer_screen.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

part 'error_widget.dart';

part 'loading_widget.dart';

part 'recording_tile_contents.dart';

part 'recordings_listview.dart';

part 'recordings_screen_components.dart';

class RecordingsScreen extends StatelessWidget {
  const RecordingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator.get<RecordingsBloc>()
              ..add(const RecordingsBlocEvent.init()),
          ),
          BlocProvider(
            create: (_) => serviceLocator.get<PlayerBloc>()
              ..add(const PlayerBlocEvent.init()),
          ),
        ],
        child: Builder(
          builder: (context) =>
              BlocBuilder<RecordingsBloc, RecordingsBlocState>(
            builder: (context, recordingsBlocState) =>
                BlocBuilder<PlayerBloc, PlayerBlocState>(
              builder: (context, playerBlocState) {
                if (playerBlocState.isError || recordingsBlocState.isError) {
                  return _ErrorWidget();
                } else {
                  if (playerBlocState.playerState.isInitialized &&
                      recordingsBlocState.isInitialized) {
                    return const _RecordingsScreenComponents();
                  } else {
                    return const _LoadingWidget();
                  }
                }
              },
            ),
          ),
        ),
      );
}
