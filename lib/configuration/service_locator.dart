import 'package:voice_changer/configuration/service_locator.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

final GetIt serviceLocator = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(serviceLocator);

@module
abstract class RegisterModule {
  Logger logger(@factoryParam Level? logLevel,@factoryParam LogPrinter? printer) => Logger(level: logLevel,printer: printer);
}
