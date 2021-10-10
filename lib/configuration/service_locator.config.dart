// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i4;

import '../domain/common/service/filesystem_service.dart' as _i3;
import '../domain/common/service/permission_handler_service.dart' as _i5;
import '../domain/common/service/permission_handler_service_impl.dart' as _i6;
import '../domain/recorder/recorder_service.dart' as _i7;
import '../domain/recorder/recording_service_impl.dart' as _i8;
import '../presentation/recorder_screen/bloc/permission_bloc/permission_bloc.dart'
    as _i9;
import '../presentation/recorder_screen/bloc/recorder/recorder_bloc.dart'
    as _i10;
import 'service_locator.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.FileSystemService>(() => _i3.FileSystemService());
  gh.factoryParam<_i4.Logger, _i4.Level?, dynamic>(
      (logLevel, _) => registerModule.logger(logLevel));
  gh.factory<_i5.PermissionHandlerService>(
      () => _i6.PermissionHandlerServiceImpl());
  gh.factory<_i7.RecorderService>(() => _i8.RecorderServiceImpl());
  gh.factory<_i9.PermissionBloc>(
      () => _i9.PermissionBloc(get<_i5.PermissionHandlerService>()));
  gh.factory<_i10.RecorderBloc>(() => _i10.RecorderBloc(
      get<_i7.RecorderService>(), get<_i3.FileSystemService>()));
  return get;
}

class _$RegisterModule extends _i11.RegisterModule {}
