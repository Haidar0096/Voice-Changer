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
import '../domain/player/player_service.dart' as _i7;
import '../domain/player/player_service_impl.dart' as _i8;
import '../domain/recorder/recorder_service.dart' as _i9;
import '../domain/recorder/recording_service_impl.dart' as _i10;
import '../domain/recording/recording_details_service.dart' as _i11;
import '../domain/recording/recording_details_service_impl.dart' as _i12;
import '../presentation/recorder_screen/bloc/permission_bloc/permission_bloc.dart'
    as _i14;
import '../presentation/recorder_screen/bloc/recorder/recorder_bloc.dart'
    as _i16;
import '../presentation/recordings_screen/bloc/player_bloc.dart' as _i15;
import '../presentation/recordings_screen/bloc/recordings_bloc.dart' as _i13;
import 'service_locator.dart' as _i17; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.PlayerService>(() => _i8.PLayerServiceImpl());
  gh.factory<_i9.RecorderService>(() => _i10.RecorderServiceImpl());
  gh.factory<_i11.RecordingDetailsService>(
      () => _i12.RecordingDetailsServiceImpl());
  gh.factory<_i13.RecordingsBloc>(() => _i13.RecordingsBloc(
      get<_i3.FileSystemService>(), get<_i11.RecordingDetailsService>()));
  gh.factory<_i14.PermissionBloc>(
      () => _i14.PermissionBloc(get<_i5.PermissionHandlerService>()));
  gh.factory<_i15.PlayerBloc>(() => _i15.PlayerBloc(get<_i7.PlayerService>()));
  gh.factory<_i16.RecorderBloc>(() => _i16.RecorderBloc(
      get<_i9.RecorderService>(), get<_i3.FileSystemService>()));
  return get;
}

class _$RegisterModule extends _i17.RegisterModule {}
