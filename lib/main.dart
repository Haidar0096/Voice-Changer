import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_changer/configuration/service_locator.dart'
    as service_locator;
import 'package:voice_changer/presentation/recorder_screen/widget/recorder_screen.dart';
import 'package:voice_changer/presentation/recordings_screen/widget/recordings_screen.dart';
import 'package:voice_changer/presentation/sound_changer_screen/widget/sound_changer_screen.dart';
import 'package:voice_changer/presentation/styles/styles.dart' as styles;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  service_locator.configureDependencies();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //set mode to portrait only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      routes: _routes(),
      theme: ThemeData(
        colorScheme: styles.colorScheme,
      ),
    );
  }

  Map<String, WidgetBuilder> _routes() => {
        '/': (context) => const RecorderScreen(),
        RecorderScreen.routeName: (context) => const RecorderScreen(),
        RecordingsScreen.routeName: (context) => const RecordingsScreen(),
        SoundChangerScreen.routeName: (context) => const SoundChangerScreen(),
      };
}
