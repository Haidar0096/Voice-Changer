// //This file is the "parent file" of all widgets in the player screen
// //This is to improve readability because the code is very large
//
// import 'package:dartz/dartz.dart' hide State;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
// import 'package:sound_changer/common/exception/exception_utils.dart';
// import 'package:sound_changer/common/extensions/double_extensions.dart';
// import 'package:sound_changer/common/widget/common_widgets.dart';
// import 'package:sound_changer/configuration/service_locator.dart';
// import 'package:sound_changer/domain/player/playback_service.dart';
// import 'package:sound_changer/presentation/player_screen/bloc/player/playback_bloc.dart';
// import 'package:sound_changer/presentation/player_screen/bloc/player/sound_effects_bloc.dart';
//
// part 'app_bar.dart';
// part 'apply_effects_button.dart';
// part 'change_delay_slider_widget.dart';
// part 'change_echo_slider_widget.dart';
// part 'change_tempo_slider_widget.dart';
// part 'effects_tab_widget.dart';
// part 'error_widget.dart';
// part 'next_track_button_widget.dart';
// part 'no_recordings_widget.dart';
// part 'override_original_file_checkbox_widget.dart';
// part 'pause_button_widget.dart';
// part 'play_button_widget.dart';
// part 'playback_info_widget.dart';
// part 'player_controls_widget.dart';
// part 'player_pageview_widget.dart';
// part 'player_screen_utils.dart';
// part 'player_screen_widget.dart';
// part 'player_tab_widget.dart';
// part 'previous_track_button_widget.dart';
// part 'recordings_tab_widget.dart';
// part 'recordings_widget.dart';
// part 'stopped_slider_widget.dart';
// part 'track_info_widget.dart';
// part 'waiting_widget.dart';
//
// const String _missingRecordings =
//     'expected that recordingsInfoOption is not None(), but it was None()';
// const String _missingErrorMessage =
//     'expected that errorMessageOption is not None(), but it was None()';
// const String _missingSelectedTrackIndex =
//     'expected that selectedTrackIndexOption is not None(), but it was None()';
// const String _missingPlaybackDetails =
//     'expected that playbackDetailsOption is not None(), but it was None()';
// const String _missingDuration =
//     'expected that durationOption is not None(), but it was None()';
