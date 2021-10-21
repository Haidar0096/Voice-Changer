import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:voice_changer/configuration/service_locator.dart';
import 'package:voice_changer/presentation/common/error_widget.dart';
import 'package:voice_changer/presentation/common/loading_widget.dart';
import 'package:voice_changer/presentation/recordings_screen/bloc/player_bloc/player_bloc.dart';
import 'package:voice_changer/presentation/recordings_screen/bloc/recordings_bloc/recordings_bloc.dart';
import 'package:voice_changer/presentation/sound_changer_screen/widget/sound_changer_screen.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

part 'recording_tile_contents.dart';
part 'recordings_listview.dart';
part 'recordings_screen_components.dart';

class RecordingsScreen extends StatelessWidget {
  static const routeName = '/recordings-screen';

  const RecordingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator.get<RecordingsBloc>()
              ..add(const RecordingsBlocEvent.refresh()),
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
                  return ErrorWidget(
                      'playerBloc: ${playerBlocState.errorMessage ?? 'no error'}'
                      ' and recordingsBloc: ${recordingsBlocState.errorMessage ?? 'no error'}');
                } else {
                  if (playerBlocState.playerState.isInitialized &&
                      recordingsBlocState.isInitialized) {
                    return const _RecordingsScreenComponents();
                  } else {
                    return const LoadingWidget();
                  }
                }
              },
            ),
          ),
        ),
      );
}
