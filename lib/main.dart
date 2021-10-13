import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_changer/configuration/service_locator.dart'
    as service_locator;
import 'package:voice_changer/presentation/recorder_screen/widget/recorder_screen.dart';
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
      home: const RecorderScreen(),
      theme: ThemeData(
        colorScheme: styles.colorScheme,
      ),
    );
  }
}
