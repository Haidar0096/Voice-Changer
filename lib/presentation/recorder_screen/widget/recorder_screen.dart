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
import 'package:voice_changer/domain/recorder/recorder_service.dart';
import 'package:voice_changer/presentation/common/filled_circle.dart';
import 'package:voice_changer/presentation/common/filled_rectangle.dart';
import 'package:voice_changer/presentation/recorder_screen/bloc/permission_bloc/permission_bloc.dart';
// import 'package:sound_changer/presentation/player_screen/widget/player_screen.dart';//todo uncomment this
import 'package:voice_changer/presentation/recorder_screen/bloc/recorder/recorder_bloc.dart';
import 'package:voice_changer/presentation/styles/styles.dart';

part 'error_widget.dart';
part 'loading_widget.dart';
part 'record_button.dart';
part 'recorder_icon_widget.dart';
part 'recorder_screen_widget.dart';
part 'recorder_widget.dart';
part 'recordings_button.dart';
part 'stop_button.dart';
