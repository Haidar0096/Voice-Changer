// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'permission_handler_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PermissionStatusTearOff {
  const _$PermissionStatusTearOff();

  _Granted granted() {
    return const _Granted();
  }

  _Denied denied() {
    return const _Denied();
  }

  _DeniedPermanently deniedPermanently() {
    return const _DeniedPermanently();
  }
}

/// @nodoc
const $PermissionStatus = _$PermissionStatusTearOff();

/// @nodoc
mixin _$PermissionStatus {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() deniedPermanently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_DeniedPermanently value) deniedPermanently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionStatusCopyWith<$Res> {
  factory $PermissionStatusCopyWith(
          PermissionStatus value, $Res Function(PermissionStatus) then) =
      _$PermissionStatusCopyWithImpl<$Res>;
}

/// @nodoc
class _$PermissionStatusCopyWithImpl<$Res>
    implements $PermissionStatusCopyWith<$Res> {
  _$PermissionStatusCopyWithImpl(this._value, this._then);

  final PermissionStatus _value;
  // ignore: unused_field
  final $Res Function(PermissionStatus) _then;
}

/// @nodoc
abstract class _$GrantedCopyWith<$Res> {
  factory _$GrantedCopyWith(_Granted value, $Res Function(_Granted) then) =
      __$GrantedCopyWithImpl<$Res>;
}

/// @nodoc
class __$GrantedCopyWithImpl<$Res> extends _$PermissionStatusCopyWithImpl<$Res>
    implements _$GrantedCopyWith<$Res> {
  __$GrantedCopyWithImpl(_Granted _value, $Res Function(_Granted) _then)
      : super(_value, (v) => _then(v as _Granted));

  @override
  _Granted get _value => super._value as _Granted;
}

/// @nodoc

class _$_Granted extends _Granted {
  const _$_Granted() : super._();

  @override
  String toString() {
    return 'PermissionStatus.granted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Granted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() deniedPermanently,
  }) {
    return granted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
  }) {
    return granted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
    required TResult orElse(),
  }) {
    if (granted != null) {
      return granted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_DeniedPermanently value) deniedPermanently,
  }) {
    return granted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
  }) {
    return granted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
    required TResult orElse(),
  }) {
    if (granted != null) {
      return granted(this);
    }
    return orElse();
  }
}

abstract class _Granted extends PermissionStatus {
  const factory _Granted() = _$_Granted;
  const _Granted._() : super._();
}

/// @nodoc
abstract class _$DeniedCopyWith<$Res> {
  factory _$DeniedCopyWith(_Denied value, $Res Function(_Denied) then) =
      __$DeniedCopyWithImpl<$Res>;
}

/// @nodoc
class __$DeniedCopyWithImpl<$Res> extends _$PermissionStatusCopyWithImpl<$Res>
    implements _$DeniedCopyWith<$Res> {
  __$DeniedCopyWithImpl(_Denied _value, $Res Function(_Denied) _then)
      : super(_value, (v) => _then(v as _Denied));

  @override
  _Denied get _value => super._value as _Denied;
}

/// @nodoc

class _$_Denied extends _Denied {
  const _$_Denied() : super._();

  @override
  String toString() {
    return 'PermissionStatus.denied()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Denied);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() deniedPermanently,
  }) {
    return denied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
  }) {
    return denied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
    required TResult orElse(),
  }) {
    if (denied != null) {
      return denied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_DeniedPermanently value) deniedPermanently,
  }) {
    return denied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
  }) {
    return denied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
    required TResult orElse(),
  }) {
    if (denied != null) {
      return denied(this);
    }
    return orElse();
  }
}

abstract class _Denied extends PermissionStatus {
  const factory _Denied() = _$_Denied;
  const _Denied._() : super._();
}

/// @nodoc
abstract class _$DeniedPermanentlyCopyWith<$Res> {
  factory _$DeniedPermanentlyCopyWith(
          _DeniedPermanently value, $Res Function(_DeniedPermanently) then) =
      __$DeniedPermanentlyCopyWithImpl<$Res>;
}

/// @nodoc
class __$DeniedPermanentlyCopyWithImpl<$Res>
    extends _$PermissionStatusCopyWithImpl<$Res>
    implements _$DeniedPermanentlyCopyWith<$Res> {
  __$DeniedPermanentlyCopyWithImpl(
      _DeniedPermanently _value, $Res Function(_DeniedPermanently) _then)
      : super(_value, (v) => _then(v as _DeniedPermanently));

  @override
  _DeniedPermanently get _value => super._value as _DeniedPermanently;
}

/// @nodoc

class _$_DeniedPermanently extends _DeniedPermanently {
  const _$_DeniedPermanently() : super._();

  @override
  String toString() {
    return 'PermissionStatus.deniedPermanently()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _DeniedPermanently);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() granted,
    required TResult Function() denied,
    required TResult Function() deniedPermanently,
  }) {
    return deniedPermanently();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
  }) {
    return deniedPermanently?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? granted,
    TResult Function()? denied,
    TResult Function()? deniedPermanently,
    required TResult orElse(),
  }) {
    if (deniedPermanently != null) {
      return deniedPermanently();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Granted value) granted,
    required TResult Function(_Denied value) denied,
    required TResult Function(_DeniedPermanently value) deniedPermanently,
  }) {
    return deniedPermanently(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
  }) {
    return deniedPermanently?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Granted value)? granted,
    TResult Function(_Denied value)? denied,
    TResult Function(_DeniedPermanently value)? deniedPermanently,
    required TResult orElse(),
  }) {
    if (deniedPermanently != null) {
      return deniedPermanently(this);
    }
    return orElse();
  }
}

abstract class _DeniedPermanently extends PermissionStatus {
  const factory _DeniedPermanently() = _$_DeniedPermanently;
  const _DeniedPermanently._() : super._();
}
