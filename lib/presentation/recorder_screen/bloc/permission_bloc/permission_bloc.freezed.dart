// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'permission_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PermissionBlocEventTearOff {
  const _$PermissionBlocEventTearOff();

  _RequestMicrophonePermissionEvent requestMicrophonePermission(
      {Function? onGranted,
      Function? onDenied,
      Function? onPermanentlyDenied}) {
    return _RequestMicrophonePermissionEvent(
      onGranted: onGranted,
      onDenied: onDenied,
      onPermanentlyDenied: onPermanentlyDenied,
    );
  }

  _CheckMicrophonePermissionEvent checkMicrophonePermission(
      {Function? onGranted, Function? onDenied}) {
    return _CheckMicrophonePermissionEvent(
      onGranted: onGranted,
      onDenied: onDenied,
    );
  }

  _OpenSettingsAppEvent openSettingsApp() {
    return const _OpenSettingsAppEvent();
  }
}

/// @nodoc
const $PermissionBlocEvent = _$PermissionBlocEventTearOff();

/// @nodoc
mixin _$PermissionBlocEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)
        requestMicrophonePermission,
    required TResult Function(Function? onGranted, Function? onDenied)
        checkMicrophonePermission,
    required TResult Function() openSettingsApp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestMicrophonePermissionEvent value)
        requestMicrophonePermission,
    required TResult Function(_CheckMicrophonePermissionEvent value)
        checkMicrophonePermission,
    required TResult Function(_OpenSettingsAppEvent value) openSettingsApp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionBlocEventCopyWith<$Res> {
  factory $PermissionBlocEventCopyWith(
          PermissionBlocEvent value, $Res Function(PermissionBlocEvent) then) =
      _$PermissionBlocEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$PermissionBlocEventCopyWithImpl<$Res>
    implements $PermissionBlocEventCopyWith<$Res> {
  _$PermissionBlocEventCopyWithImpl(this._value, this._then);

  final PermissionBlocEvent _value;
  // ignore: unused_field
  final $Res Function(PermissionBlocEvent) _then;
}

/// @nodoc
abstract class _$RequestMicrophonePermissionEventCopyWith<$Res> {
  factory _$RequestMicrophonePermissionEventCopyWith(
          _RequestMicrophonePermissionEvent value,
          $Res Function(_RequestMicrophonePermissionEvent) then) =
      __$RequestMicrophonePermissionEventCopyWithImpl<$Res>;
  $Res call(
      {Function? onGranted, Function? onDenied, Function? onPermanentlyDenied});
}

/// @nodoc
class __$RequestMicrophonePermissionEventCopyWithImpl<$Res>
    extends _$PermissionBlocEventCopyWithImpl<$Res>
    implements _$RequestMicrophonePermissionEventCopyWith<$Res> {
  __$RequestMicrophonePermissionEventCopyWithImpl(
      _RequestMicrophonePermissionEvent _value,
      $Res Function(_RequestMicrophonePermissionEvent) _then)
      : super(_value, (v) => _then(v as _RequestMicrophonePermissionEvent));

  @override
  _RequestMicrophonePermissionEvent get _value =>
      super._value as _RequestMicrophonePermissionEvent;

  @override
  $Res call({
    Object? onGranted = freezed,
    Object? onDenied = freezed,
    Object? onPermanentlyDenied = freezed,
  }) {
    return _then(_RequestMicrophonePermissionEvent(
      onGranted: onGranted == freezed
          ? _value.onGranted
          : onGranted // ignore: cast_nullable_to_non_nullable
              as Function?,
      onDenied: onDenied == freezed
          ? _value.onDenied
          : onDenied // ignore: cast_nullable_to_non_nullable
              as Function?,
      onPermanentlyDenied: onPermanentlyDenied == freezed
          ? _value.onPermanentlyDenied
          : onPermanentlyDenied // ignore: cast_nullable_to_non_nullable
              as Function?,
    ));
  }
}

/// @nodoc

class _$_RequestMicrophonePermissionEvent
    implements _RequestMicrophonePermissionEvent {
  const _$_RequestMicrophonePermissionEvent(
      {this.onGranted, this.onDenied, this.onPermanentlyDenied});

  @override
  final Function? onGranted;
  @override
  final Function? onDenied;
  @override
  final Function? onPermanentlyDenied;

  @override
  String toString() {
    return 'PermissionBlocEvent.requestMicrophonePermission(onGranted: $onGranted, onDenied: $onDenied, onPermanentlyDenied: $onPermanentlyDenied)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RequestMicrophonePermissionEvent &&
            (identical(other.onGranted, onGranted) ||
                const DeepCollectionEquality()
                    .equals(other.onGranted, onGranted)) &&
            (identical(other.onDenied, onDenied) ||
                const DeepCollectionEquality()
                    .equals(other.onDenied, onDenied)) &&
            (identical(other.onPermanentlyDenied, onPermanentlyDenied) ||
                const DeepCollectionEquality()
                    .equals(other.onPermanentlyDenied, onPermanentlyDenied)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(onGranted) ^
      const DeepCollectionEquality().hash(onDenied) ^
      const DeepCollectionEquality().hash(onPermanentlyDenied);

  @JsonKey(ignore: true)
  @override
  _$RequestMicrophonePermissionEventCopyWith<_RequestMicrophonePermissionEvent>
      get copyWith => __$RequestMicrophonePermissionEventCopyWithImpl<
          _RequestMicrophonePermissionEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)
        requestMicrophonePermission,
    required TResult Function(Function? onGranted, Function? onDenied)
        checkMicrophonePermission,
    required TResult Function() openSettingsApp,
  }) {
    return requestMicrophonePermission(
        onGranted, onDenied, onPermanentlyDenied);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
  }) {
    return requestMicrophonePermission?.call(
        onGranted, onDenied, onPermanentlyDenied);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
    required TResult orElse(),
  }) {
    if (requestMicrophonePermission != null) {
      return requestMicrophonePermission(
          onGranted, onDenied, onPermanentlyDenied);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestMicrophonePermissionEvent value)
        requestMicrophonePermission,
    required TResult Function(_CheckMicrophonePermissionEvent value)
        checkMicrophonePermission,
    required TResult Function(_OpenSettingsAppEvent value) openSettingsApp,
  }) {
    return requestMicrophonePermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
  }) {
    return requestMicrophonePermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
    required TResult orElse(),
  }) {
    if (requestMicrophonePermission != null) {
      return requestMicrophonePermission(this);
    }
    return orElse();
  }
}

abstract class _RequestMicrophonePermissionEvent
    implements PermissionBlocEvent {
  const factory _RequestMicrophonePermissionEvent(
      {Function? onGranted,
      Function? onDenied,
      Function? onPermanentlyDenied}) = _$_RequestMicrophonePermissionEvent;

  Function? get onGranted => throw _privateConstructorUsedError;
  Function? get onDenied => throw _privateConstructorUsedError;
  Function? get onPermanentlyDenied => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$RequestMicrophonePermissionEventCopyWith<_RequestMicrophonePermissionEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CheckMicrophonePermissionEventCopyWith<$Res> {
  factory _$CheckMicrophonePermissionEventCopyWith(
          _CheckMicrophonePermissionEvent value,
          $Res Function(_CheckMicrophonePermissionEvent) then) =
      __$CheckMicrophonePermissionEventCopyWithImpl<$Res>;
  $Res call({Function? onGranted, Function? onDenied});
}

/// @nodoc
class __$CheckMicrophonePermissionEventCopyWithImpl<$Res>
    extends _$PermissionBlocEventCopyWithImpl<$Res>
    implements _$CheckMicrophonePermissionEventCopyWith<$Res> {
  __$CheckMicrophonePermissionEventCopyWithImpl(
      _CheckMicrophonePermissionEvent _value,
      $Res Function(_CheckMicrophonePermissionEvent) _then)
      : super(_value, (v) => _then(v as _CheckMicrophonePermissionEvent));

  @override
  _CheckMicrophonePermissionEvent get _value =>
      super._value as _CheckMicrophonePermissionEvent;

  @override
  $Res call({
    Object? onGranted = freezed,
    Object? onDenied = freezed,
  }) {
    return _then(_CheckMicrophonePermissionEvent(
      onGranted: onGranted == freezed
          ? _value.onGranted
          : onGranted // ignore: cast_nullable_to_non_nullable
              as Function?,
      onDenied: onDenied == freezed
          ? _value.onDenied
          : onDenied // ignore: cast_nullable_to_non_nullable
              as Function?,
    ));
  }
}

/// @nodoc

class _$_CheckMicrophonePermissionEvent
    implements _CheckMicrophonePermissionEvent {
  const _$_CheckMicrophonePermissionEvent({this.onGranted, this.onDenied});

  @override
  final Function? onGranted;
  @override
  final Function? onDenied;

  @override
  String toString() {
    return 'PermissionBlocEvent.checkMicrophonePermission(onGranted: $onGranted, onDenied: $onDenied)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CheckMicrophonePermissionEvent &&
            (identical(other.onGranted, onGranted) ||
                const DeepCollectionEquality()
                    .equals(other.onGranted, onGranted)) &&
            (identical(other.onDenied, onDenied) ||
                const DeepCollectionEquality()
                    .equals(other.onDenied, onDenied)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(onGranted) ^
      const DeepCollectionEquality().hash(onDenied);

  @JsonKey(ignore: true)
  @override
  _$CheckMicrophonePermissionEventCopyWith<_CheckMicrophonePermissionEvent>
      get copyWith => __$CheckMicrophonePermissionEventCopyWithImpl<
          _CheckMicrophonePermissionEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)
        requestMicrophonePermission,
    required TResult Function(Function? onGranted, Function? onDenied)
        checkMicrophonePermission,
    required TResult Function() openSettingsApp,
  }) {
    return checkMicrophonePermission(onGranted, onDenied);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
  }) {
    return checkMicrophonePermission?.call(onGranted, onDenied);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
    required TResult orElse(),
  }) {
    if (checkMicrophonePermission != null) {
      return checkMicrophonePermission(onGranted, onDenied);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestMicrophonePermissionEvent value)
        requestMicrophonePermission,
    required TResult Function(_CheckMicrophonePermissionEvent value)
        checkMicrophonePermission,
    required TResult Function(_OpenSettingsAppEvent value) openSettingsApp,
  }) {
    return checkMicrophonePermission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
  }) {
    return checkMicrophonePermission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
    required TResult orElse(),
  }) {
    if (checkMicrophonePermission != null) {
      return checkMicrophonePermission(this);
    }
    return orElse();
  }
}

abstract class _CheckMicrophonePermissionEvent implements PermissionBlocEvent {
  const factory _CheckMicrophonePermissionEvent(
      {Function? onGranted,
      Function? onDenied}) = _$_CheckMicrophonePermissionEvent;

  Function? get onGranted => throw _privateConstructorUsedError;
  Function? get onDenied => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$CheckMicrophonePermissionEventCopyWith<_CheckMicrophonePermissionEvent>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$OpenSettingsAppEventCopyWith<$Res> {
  factory _$OpenSettingsAppEventCopyWith(_OpenSettingsAppEvent value,
          $Res Function(_OpenSettingsAppEvent) then) =
      __$OpenSettingsAppEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$OpenSettingsAppEventCopyWithImpl<$Res>
    extends _$PermissionBlocEventCopyWithImpl<$Res>
    implements _$OpenSettingsAppEventCopyWith<$Res> {
  __$OpenSettingsAppEventCopyWithImpl(
      _OpenSettingsAppEvent _value, $Res Function(_OpenSettingsAppEvent) _then)
      : super(_value, (v) => _then(v as _OpenSettingsAppEvent));

  @override
  _OpenSettingsAppEvent get _value => super._value as _OpenSettingsAppEvent;
}

/// @nodoc

class _$_OpenSettingsAppEvent implements _OpenSettingsAppEvent {
  const _$_OpenSettingsAppEvent();

  @override
  String toString() {
    return 'PermissionBlocEvent.openSettingsApp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _OpenSettingsAppEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)
        requestMicrophonePermission,
    required TResult Function(Function? onGranted, Function? onDenied)
        checkMicrophonePermission,
    required TResult Function() openSettingsApp,
  }) {
    return openSettingsApp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
  }) {
    return openSettingsApp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Function? onGranted, Function? onDenied,
            Function? onPermanentlyDenied)?
        requestMicrophonePermission,
    TResult Function(Function? onGranted, Function? onDenied)?
        checkMicrophonePermission,
    TResult Function()? openSettingsApp,
    required TResult orElse(),
  }) {
    if (openSettingsApp != null) {
      return openSettingsApp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestMicrophonePermissionEvent value)
        requestMicrophonePermission,
    required TResult Function(_CheckMicrophonePermissionEvent value)
        checkMicrophonePermission,
    required TResult Function(_OpenSettingsAppEvent value) openSettingsApp,
  }) {
    return openSettingsApp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
  }) {
    return openSettingsApp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestMicrophonePermissionEvent value)?
        requestMicrophonePermission,
    TResult Function(_CheckMicrophonePermissionEvent value)?
        checkMicrophonePermission,
    TResult Function(_OpenSettingsAppEvent value)? openSettingsApp,
    required TResult orElse(),
  }) {
    if (openSettingsApp != null) {
      return openSettingsApp(this);
    }
    return orElse();
  }
}

abstract class _OpenSettingsAppEvent implements PermissionBlocEvent {
  const factory _OpenSettingsAppEvent() = _$_OpenSettingsAppEvent;
}

/// @nodoc
class _$PermissionBlocStateTearOff {
  const _$PermissionBlocStateTearOff();

  _PermissionBlocState call({bool isMicrophonePermissionGranted = false}) {
    return _PermissionBlocState(
      isMicrophonePermissionGranted: isMicrophonePermissionGranted,
    );
  }
}

/// @nodoc
const $PermissionBlocState = _$PermissionBlocStateTearOff();

/// @nodoc
mixin _$PermissionBlocState {
  bool get isMicrophonePermissionGranted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionBlocStateCopyWith<PermissionBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionBlocStateCopyWith<$Res> {
  factory $PermissionBlocStateCopyWith(
          PermissionBlocState value, $Res Function(PermissionBlocState) then) =
      _$PermissionBlocStateCopyWithImpl<$Res>;
  $Res call({bool isMicrophonePermissionGranted});
}

/// @nodoc
class _$PermissionBlocStateCopyWithImpl<$Res>
    implements $PermissionBlocStateCopyWith<$Res> {
  _$PermissionBlocStateCopyWithImpl(this._value, this._then);

  final PermissionBlocState _value;
  // ignore: unused_field
  final $Res Function(PermissionBlocState) _then;

  @override
  $Res call({
    Object? isMicrophonePermissionGranted = freezed,
  }) {
    return _then(_value.copyWith(
      isMicrophonePermissionGranted: isMicrophonePermissionGranted == freezed
          ? _value.isMicrophonePermissionGranted
          : isMicrophonePermissionGranted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$PermissionBlocStateCopyWith<$Res>
    implements $PermissionBlocStateCopyWith<$Res> {
  factory _$PermissionBlocStateCopyWith(_PermissionBlocState value,
          $Res Function(_PermissionBlocState) then) =
      __$PermissionBlocStateCopyWithImpl<$Res>;
  @override
  $Res call({bool isMicrophonePermissionGranted});
}

/// @nodoc
class __$PermissionBlocStateCopyWithImpl<$Res>
    extends _$PermissionBlocStateCopyWithImpl<$Res>
    implements _$PermissionBlocStateCopyWith<$Res> {
  __$PermissionBlocStateCopyWithImpl(
      _PermissionBlocState _value, $Res Function(_PermissionBlocState) _then)
      : super(_value, (v) => _then(v as _PermissionBlocState));

  @override
  _PermissionBlocState get _value => super._value as _PermissionBlocState;

  @override
  $Res call({
    Object? isMicrophonePermissionGranted = freezed,
  }) {
    return _then(_PermissionBlocState(
      isMicrophonePermissionGranted: isMicrophonePermissionGranted == freezed
          ? _value.isMicrophonePermissionGranted
          : isMicrophonePermissionGranted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PermissionBlocState extends _PermissionBlocState {
  const _$_PermissionBlocState({this.isMicrophonePermissionGranted = false})
      : super._();

  @JsonKey(defaultValue: false)
  @override
  final bool isMicrophonePermissionGranted;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PermissionBlocState &&
            (identical(other.isMicrophonePermissionGranted,
                    isMicrophonePermissionGranted) ||
                const DeepCollectionEquality().equals(
                    other.isMicrophonePermissionGranted,
                    isMicrophonePermissionGranted)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isMicrophonePermissionGranted);

  @JsonKey(ignore: true)
  @override
  _$PermissionBlocStateCopyWith<_PermissionBlocState> get copyWith =>
      __$PermissionBlocStateCopyWithImpl<_PermissionBlocState>(
          this, _$identity);
}

abstract class _PermissionBlocState extends PermissionBlocState {
  const factory _PermissionBlocState({bool isMicrophonePermissionGranted}) =
      _$_PermissionBlocState;
  const _PermissionBlocState._() : super._();

  @override
  bool get isMicrophonePermissionGranted => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PermissionBlocStateCopyWith<_PermissionBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}
