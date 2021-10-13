// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recorder_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecorderBlocEventTearOff {
  const _$RecorderBlocEventTearOff();

  _InitEvent init() {
    return const _InitEvent();
  }

  _StartRecordingEvent startRecording() {
    return const _StartRecordingEvent();
  }

  _StopRecordingEvent stopRecording() {
    return const _StopRecordingEvent();
  }

  _SaveRecordingEvent saveRecording({required String newRecordingFileName}) {
    return _SaveRecordingEvent(
      newRecordingFileName: newRecordingFileName,
    );
  }

  _DeleteRecordingEvent deleteRecording() {
    return const _DeleteRecordingEvent();
  }

  _AppGoInactiveEvent appGoInactive() {
    return const _AppGoInactiveEvent();
  }
}

/// @nodoc
const $RecorderBlocEvent = _$RecorderBlocEventTearOff();

/// @nodoc
mixin _$RecorderBlocEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecorderBlocEventCopyWith<$Res> {
  factory $RecorderBlocEventCopyWith(
          RecorderBlocEvent value, $Res Function(RecorderBlocEvent) then) =
      _$RecorderBlocEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$RecorderBlocEventCopyWithImpl<$Res>
    implements $RecorderBlocEventCopyWith<$Res> {
  _$RecorderBlocEventCopyWithImpl(this._value, this._then);

  final RecorderBlocEvent _value;
  // ignore: unused_field
  final $Res Function(RecorderBlocEvent) _then;
}

/// @nodoc
abstract class _$InitEventCopyWith<$Res> {
  factory _$InitEventCopyWith(
          _InitEvent value, $Res Function(_InitEvent) then) =
      __$InitEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitEventCopyWithImpl<$Res>
    extends _$RecorderBlocEventCopyWithImpl<$Res>
    implements _$InitEventCopyWith<$Res> {
  __$InitEventCopyWithImpl(_InitEvent _value, $Res Function(_InitEvent) _then)
      : super(_value, (v) => _then(v as _InitEvent));

  @override
  _InitEvent get _value => super._value as _InitEvent;
}

/// @nodoc

class _$_InitEvent implements _InitEvent {
  const _$_InitEvent();

  @override
  String toString() {
    return 'RecorderBlocEvent.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InitEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _InitEvent implements RecorderBlocEvent {
  const factory _InitEvent() = _$_InitEvent;
}

/// @nodoc
abstract class _$StartRecordingEventCopyWith<$Res> {
  factory _$StartRecordingEventCopyWith(_StartRecordingEvent value,
          $Res Function(_StartRecordingEvent) then) =
      __$StartRecordingEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$StartRecordingEventCopyWithImpl<$Res>
    extends _$RecorderBlocEventCopyWithImpl<$Res>
    implements _$StartRecordingEventCopyWith<$Res> {
  __$StartRecordingEventCopyWithImpl(
      _StartRecordingEvent _value, $Res Function(_StartRecordingEvent) _then)
      : super(_value, (v) => _then(v as _StartRecordingEvent));

  @override
  _StartRecordingEvent get _value => super._value as _StartRecordingEvent;
}

/// @nodoc

class _$_StartRecordingEvent implements _StartRecordingEvent {
  const _$_StartRecordingEvent();

  @override
  String toString() {
    return 'RecorderBlocEvent.startRecording()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _StartRecordingEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) {
    return startRecording();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) {
    return startRecording?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) {
    if (startRecording != null) {
      return startRecording();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) {
    return startRecording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) {
    return startRecording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) {
    if (startRecording != null) {
      return startRecording(this);
    }
    return orElse();
  }
}

abstract class _StartRecordingEvent implements RecorderBlocEvent {
  const factory _StartRecordingEvent() = _$_StartRecordingEvent;
}

/// @nodoc
abstract class _$StopRecordingEventCopyWith<$Res> {
  factory _$StopRecordingEventCopyWith(
          _StopRecordingEvent value, $Res Function(_StopRecordingEvent) then) =
      __$StopRecordingEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$StopRecordingEventCopyWithImpl<$Res>
    extends _$RecorderBlocEventCopyWithImpl<$Res>
    implements _$StopRecordingEventCopyWith<$Res> {
  __$StopRecordingEventCopyWithImpl(
      _StopRecordingEvent _value, $Res Function(_StopRecordingEvent) _then)
      : super(_value, (v) => _then(v as _StopRecordingEvent));

  @override
  _StopRecordingEvent get _value => super._value as _StopRecordingEvent;
}

/// @nodoc

class _$_StopRecordingEvent implements _StopRecordingEvent {
  const _$_StopRecordingEvent();

  @override
  String toString() {
    return 'RecorderBlocEvent.stopRecording()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _StopRecordingEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) {
    return stopRecording();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) {
    return stopRecording?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) {
    if (stopRecording != null) {
      return stopRecording();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) {
    return stopRecording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) {
    return stopRecording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) {
    if (stopRecording != null) {
      return stopRecording(this);
    }
    return orElse();
  }
}

abstract class _StopRecordingEvent implements RecorderBlocEvent {
  const factory _StopRecordingEvent() = _$_StopRecordingEvent;
}

/// @nodoc
abstract class _$SaveRecordingEventCopyWith<$Res> {
  factory _$SaveRecordingEventCopyWith(
          _SaveRecordingEvent value, $Res Function(_SaveRecordingEvent) then) =
      __$SaveRecordingEventCopyWithImpl<$Res>;
  $Res call({String newRecordingFileName});
}

/// @nodoc
class __$SaveRecordingEventCopyWithImpl<$Res>
    extends _$RecorderBlocEventCopyWithImpl<$Res>
    implements _$SaveRecordingEventCopyWith<$Res> {
  __$SaveRecordingEventCopyWithImpl(
      _SaveRecordingEvent _value, $Res Function(_SaveRecordingEvent) _then)
      : super(_value, (v) => _then(v as _SaveRecordingEvent));

  @override
  _SaveRecordingEvent get _value => super._value as _SaveRecordingEvent;

  @override
  $Res call({
    Object? newRecordingFileName = freezed,
  }) {
    return _then(_SaveRecordingEvent(
      newRecordingFileName: newRecordingFileName == freezed
          ? _value.newRecordingFileName
          : newRecordingFileName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SaveRecordingEvent implements _SaveRecordingEvent {
  const _$_SaveRecordingEvent({required this.newRecordingFileName});

  @override
  final String newRecordingFileName;

  @override
  String toString() {
    return 'RecorderBlocEvent.saveRecording(newRecordingFileName: $newRecordingFileName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SaveRecordingEvent &&
            (identical(other.newRecordingFileName, newRecordingFileName) ||
                const DeepCollectionEquality()
                    .equals(other.newRecordingFileName, newRecordingFileName)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(newRecordingFileName);

  @JsonKey(ignore: true)
  @override
  _$SaveRecordingEventCopyWith<_SaveRecordingEvent> get copyWith =>
      __$SaveRecordingEventCopyWithImpl<_SaveRecordingEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) {
    return saveRecording(newRecordingFileName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) {
    return saveRecording?.call(newRecordingFileName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) {
    if (saveRecording != null) {
      return saveRecording(newRecordingFileName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) {
    return saveRecording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) {
    return saveRecording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) {
    if (saveRecording != null) {
      return saveRecording(this);
    }
    return orElse();
  }
}

abstract class _SaveRecordingEvent implements RecorderBlocEvent {
  const factory _SaveRecordingEvent({required String newRecordingFileName}) =
      _$_SaveRecordingEvent;

  String get newRecordingFileName => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SaveRecordingEventCopyWith<_SaveRecordingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeleteRecordingEventCopyWith<$Res> {
  factory _$DeleteRecordingEventCopyWith(_DeleteRecordingEvent value,
          $Res Function(_DeleteRecordingEvent) then) =
      __$DeleteRecordingEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$DeleteRecordingEventCopyWithImpl<$Res>
    extends _$RecorderBlocEventCopyWithImpl<$Res>
    implements _$DeleteRecordingEventCopyWith<$Res> {
  __$DeleteRecordingEventCopyWithImpl(
      _DeleteRecordingEvent _value, $Res Function(_DeleteRecordingEvent) _then)
      : super(_value, (v) => _then(v as _DeleteRecordingEvent));

  @override
  _DeleteRecordingEvent get _value => super._value as _DeleteRecordingEvent;
}

/// @nodoc

class _$_DeleteRecordingEvent implements _DeleteRecordingEvent {
  const _$_DeleteRecordingEvent();

  @override
  String toString() {
    return 'RecorderBlocEvent.deleteRecording()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _DeleteRecordingEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) {
    return deleteRecording();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) {
    return deleteRecording?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) {
    if (deleteRecording != null) {
      return deleteRecording();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) {
    return deleteRecording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) {
    return deleteRecording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) {
    if (deleteRecording != null) {
      return deleteRecording(this);
    }
    return orElse();
  }
}

abstract class _DeleteRecordingEvent implements RecorderBlocEvent {
  const factory _DeleteRecordingEvent() = _$_DeleteRecordingEvent;
}

/// @nodoc
abstract class _$AppGoInactiveEventCopyWith<$Res> {
  factory _$AppGoInactiveEventCopyWith(
          _AppGoInactiveEvent value, $Res Function(_AppGoInactiveEvent) then) =
      __$AppGoInactiveEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$AppGoInactiveEventCopyWithImpl<$Res>
    extends _$RecorderBlocEventCopyWithImpl<$Res>
    implements _$AppGoInactiveEventCopyWith<$Res> {
  __$AppGoInactiveEventCopyWithImpl(
      _AppGoInactiveEvent _value, $Res Function(_AppGoInactiveEvent) _then)
      : super(_value, (v) => _then(v as _AppGoInactiveEvent));

  @override
  _AppGoInactiveEvent get _value => super._value as _AppGoInactiveEvent;
}

/// @nodoc

class _$_AppGoInactiveEvent implements _AppGoInactiveEvent {
  const _$_AppGoInactiveEvent();

  @override
  String toString() {
    return 'RecorderBlocEvent.appGoInactive()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AppGoInactiveEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() startRecording,
    required TResult Function() stopRecording,
    required TResult Function(String newRecordingFileName) saveRecording,
    required TResult Function() deleteRecording,
    required TResult Function() appGoInactive,
  }) {
    return appGoInactive();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
  }) {
    return appGoInactive?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? startRecording,
    TResult Function()? stopRecording,
    TResult Function(String newRecordingFileName)? saveRecording,
    TResult Function()? deleteRecording,
    TResult Function()? appGoInactive,
    required TResult orElse(),
  }) {
    if (appGoInactive != null) {
      return appGoInactive();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitEvent value) init,
    required TResult Function(_StartRecordingEvent value) startRecording,
    required TResult Function(_StopRecordingEvent value) stopRecording,
    required TResult Function(_SaveRecordingEvent value) saveRecording,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
    required TResult Function(_AppGoInactiveEvent value) appGoInactive,
  }) {
    return appGoInactive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
  }) {
    return appGoInactive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitEvent value)? init,
    TResult Function(_StartRecordingEvent value)? startRecording,
    TResult Function(_StopRecordingEvent value)? stopRecording,
    TResult Function(_SaveRecordingEvent value)? saveRecording,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    TResult Function(_AppGoInactiveEvent value)? appGoInactive,
    required TResult orElse(),
  }) {
    if (appGoInactive != null) {
      return appGoInactive(this);
    }
    return orElse();
  }
}

abstract class _AppGoInactiveEvent implements RecorderBlocEvent {
  const factory _AppGoInactiveEvent() = _$_AppGoInactiveEvent;
}

/// @nodoc
class _$RecorderBlocStateTearOff {
  const _$RecorderBlocStateTearOff();

  _RecorderBlocState call(
      {Stream<RecorderInfo>? recorderInfoStream,
      File? recordingFile,
      bool isError = false,
      String? errorMessage}) {
    return _RecorderBlocState(
      recorderInfoStream: recorderInfoStream,
      recordingFile: recordingFile,
      isError: isError,
      errorMessage: errorMessage,
    );
  }
}

/// @nodoc
const $RecorderBlocState = _$RecorderBlocStateTearOff();

/// @nodoc
mixin _$RecorderBlocState {
  Stream<RecorderInfo>? get recorderInfoStream =>
      throw _privateConstructorUsedError;
  File? get recordingFile => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecorderBlocStateCopyWith<RecorderBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecorderBlocStateCopyWith<$Res> {
  factory $RecorderBlocStateCopyWith(
          RecorderBlocState value, $Res Function(RecorderBlocState) then) =
      _$RecorderBlocStateCopyWithImpl<$Res>;
  $Res call(
      {Stream<RecorderInfo>? recorderInfoStream,
      File? recordingFile,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class _$RecorderBlocStateCopyWithImpl<$Res>
    implements $RecorderBlocStateCopyWith<$Res> {
  _$RecorderBlocStateCopyWithImpl(this._value, this._then);

  final RecorderBlocState _value;
  // ignore: unused_field
  final $Res Function(RecorderBlocState) _then;

  @override
  $Res call({
    Object? recorderInfoStream = freezed,
    Object? recordingFile = freezed,
    Object? isError = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      recorderInfoStream: recorderInfoStream == freezed
          ? _value.recorderInfoStream
          : recorderInfoStream // ignore: cast_nullable_to_non_nullable
              as Stream<RecorderInfo>?,
      recordingFile: recordingFile == freezed
          ? _value.recordingFile
          : recordingFile // ignore: cast_nullable_to_non_nullable
              as File?,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$RecorderBlocStateCopyWith<$Res>
    implements $RecorderBlocStateCopyWith<$Res> {
  factory _$RecorderBlocStateCopyWith(
          _RecorderBlocState value, $Res Function(_RecorderBlocState) then) =
      __$RecorderBlocStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Stream<RecorderInfo>? recorderInfoStream,
      File? recordingFile,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class __$RecorderBlocStateCopyWithImpl<$Res>
    extends _$RecorderBlocStateCopyWithImpl<$Res>
    implements _$RecorderBlocStateCopyWith<$Res> {
  __$RecorderBlocStateCopyWithImpl(
      _RecorderBlocState _value, $Res Function(_RecorderBlocState) _then)
      : super(_value, (v) => _then(v as _RecorderBlocState));

  @override
  _RecorderBlocState get _value => super._value as _RecorderBlocState;

  @override
  $Res call({
    Object? recorderInfoStream = freezed,
    Object? recordingFile = freezed,
    Object? isError = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_RecorderBlocState(
      recorderInfoStream: recorderInfoStream == freezed
          ? _value.recorderInfoStream
          : recorderInfoStream // ignore: cast_nullable_to_non_nullable
              as Stream<RecorderInfo>?,
      recordingFile: recordingFile == freezed
          ? _value.recordingFile
          : recordingFile // ignore: cast_nullable_to_non_nullable
              as File?,
      isError: isError == freezed
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RecorderBlocState extends _RecorderBlocState {
  const _$_RecorderBlocState(
      {this.recorderInfoStream,
      this.recordingFile,
      this.isError = false,
      this.errorMessage})
      : super._();

  @override
  final Stream<RecorderInfo>? recorderInfoStream;
  @override
  final File? recordingFile;
  @JsonKey(defaultValue: false)
  @override
  final bool isError;
  @override
  final String? errorMessage;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RecorderBlocState &&
            (identical(other.recorderInfoStream, recorderInfoStream) ||
                const DeepCollectionEquality()
                    .equals(other.recorderInfoStream, recorderInfoStream)) &&
            (identical(other.recordingFile, recordingFile) ||
                const DeepCollectionEquality()
                    .equals(other.recordingFile, recordingFile)) &&
            (identical(other.isError, isError) ||
                const DeepCollectionEquality()
                    .equals(other.isError, isError)) &&
            (identical(other.errorMessage, errorMessage) ||
                const DeepCollectionEquality()
                    .equals(other.errorMessage, errorMessage)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(recorderInfoStream) ^
      const DeepCollectionEquality().hash(recordingFile) ^
      const DeepCollectionEquality().hash(isError) ^
      const DeepCollectionEquality().hash(errorMessage);

  @JsonKey(ignore: true)
  @override
  _$RecorderBlocStateCopyWith<_RecorderBlocState> get copyWith =>
      __$RecorderBlocStateCopyWithImpl<_RecorderBlocState>(this, _$identity);
}

abstract class _RecorderBlocState extends RecorderBlocState {
  const factory _RecorderBlocState(
      {Stream<RecorderInfo>? recorderInfoStream,
      File? recordingFile,
      bool isError,
      String? errorMessage}) = _$_RecorderBlocState;
  const _RecorderBlocState._() : super._();

  @override
  Stream<RecorderInfo>? get recorderInfoStream =>
      throw _privateConstructorUsedError;
  @override
  File? get recordingFile => throw _privateConstructorUsedError;
  @override
  bool get isError => throw _privateConstructorUsedError;
  @override
  String? get errorMessage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RecorderBlocStateCopyWith<_RecorderBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}
