import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voice_changer/configuration/service_locator.dart'
    as service_locator;
import 'package:voice_changer/presentation/recorder_screen/widget/recorder_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  service_locator.configureDependencies();
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]); //set mode to portrait only
    return MaterialApp(
      home: const SafeArea(child: RecorderScreenWidget()),
      theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
