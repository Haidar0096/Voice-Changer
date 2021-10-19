// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recordings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RecordingsBlocEventTearOff {
  const _$RecordingsBlocEventTearOff();

  _Init init() {
    return const _Init();
  }

  _DeleteRecordingEvent deleteRecording(String path) {
    return _DeleteRecordingEvent(
      path,
    );
  }
}

/// @nodoc
const $RecordingsBlocEvent = _$RecordingsBlocEventTearOff();

/// @nodoc
mixin _$RecordingsBlocEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String path) deleteRecording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String path)? deleteRecording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String path)? deleteRecording,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingsBlocEventCopyWith<$Res> {
  factory $RecordingsBlocEventCopyWith(
          RecordingsBlocEvent value, $Res Function(RecordingsBlocEvent) then) =
      _$RecordingsBlocEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$RecordingsBlocEventCopyWithImpl<$Res>
    implements $RecordingsBlocEventCopyWith<$Res> {
  _$RecordingsBlocEventCopyWithImpl(this._value, this._then);

  final RecordingsBlocEvent _value;
  // ignore: unused_field
  final $Res Function(RecordingsBlocEvent) _then;
}

/// @nodoc
abstract class _$InitCopyWith<$Res> {
  factory _$InitCopyWith(_Init value, $Res Function(_Init) then) =
      __$InitCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitCopyWithImpl<$Res> extends _$RecordingsBlocEventCopyWithImpl<$Res>
    implements _$InitCopyWith<$Res> {
  __$InitCopyWithImpl(_Init _value, $Res Function(_Init) _then)
      : super(_value, (v) => _then(v as _Init));

  @override
  _Init get _value => super._value as _Init;
}

/// @nodoc

class _$_Init implements _Init {
  const _$_Init();

  @override
  String toString() {
    return 'RecordingsBlocEvent.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Init);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String path) deleteRecording,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String path)? deleteRecording,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String path)? deleteRecording,
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
    required TResult Function(_Init value) init,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _Init implements RecordingsBlocEvent {
  const factory _Init() = _$_Init;
}

/// @nodoc
abstract class _$DeleteRecordingEventCopyWith<$Res> {
  factory _$DeleteRecordingEventCopyWith(_DeleteRecordingEvent value,
          $Res Function(_DeleteRecordingEvent) then) =
      __$DeleteRecordingEventCopyWithImpl<$Res>;
  $Res call({String path});
}

/// @nodoc
class __$DeleteRecordingEventCopyWithImpl<$Res>
    extends _$RecordingsBlocEventCopyWithImpl<$Res>
    implements _$DeleteRecordingEventCopyWith<$Res> {
  __$DeleteRecordingEventCopyWithImpl(
      _DeleteRecordingEvent _value, $Res Function(_DeleteRecordingEvent) _then)
      : super(_value, (v) => _then(v as _DeleteRecordingEvent));

  @override
  _DeleteRecordingEvent get _value => super._value as _DeleteRecordingEvent;

  @override
  $Res call({
    Object? path = freezed,
  }) {
    return _then(_DeleteRecordingEvent(
      path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DeleteRecordingEvent implements _DeleteRecordingEvent {
  const _$_DeleteRecordingEvent(this.path);

  @override
  final String path;

  @override
  String toString() {
    return 'RecordingsBlocEvent.deleteRecording(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeleteRecordingEvent &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(path);

  @JsonKey(ignore: true)
  @override
  _$DeleteRecordingEventCopyWith<_DeleteRecordingEvent> get copyWith =>
      __$DeleteRecordingEventCopyWithImpl<_DeleteRecordingEvent>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(String path) deleteRecording,
  }) {
    return deleteRecording(path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String path)? deleteRecording,
  }) {
    return deleteRecording?.call(path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(String path)? deleteRecording,
    required TResult orElse(),
  }) {
    if (deleteRecording != null) {
      return deleteRecording(path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_DeleteRecordingEvent value) deleteRecording,
  }) {
    return deleteRecording(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
  }) {
    return deleteRecording?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_DeleteRecordingEvent value)? deleteRecording,
    required TResult orElse(),
  }) {
    if (deleteRecording != null) {
      return deleteRecording(this);
    }
    return orElse();
  }
}

abstract class _DeleteRecordingEvent implements RecordingsBlocEvent {
  const factory _DeleteRecordingEvent(String path) = _$_DeleteRecordingEvent;

  String get path => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DeleteRecordingEventCopyWith<_DeleteRecordingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$RecordingsBlocStateTearOff {
  const _$RecordingsBlocStateTearOff();

  _RecordingsBlocState call(
      {List<RecordingDetails> recordings = const [],
      bool isInitialized = false,
      bool isProcessing = false,
      bool isError = false,
      String? errorMessage}) {
    return _RecordingsBlocState(
      recordings: recordings,
      isInitialized: isInitialized,
      isProcessing: isProcessing,
      isError: isError,
      errorMessage: errorMessage,
    );
  }
}

/// @nodoc
const $RecordingsBlocState = _$RecordingsBlocStateTearOff();

/// @nodoc
mixin _$RecordingsBlocState {
  List<RecordingDetails> get recordings => throw _privateConstructorUsedError;
  bool get isInitialized => throw _privateConstructorUsedError;
  bool get isProcessing => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecordingsBlocStateCopyWith<RecordingsBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordingsBlocStateCopyWith<$Res> {
  factory $RecordingsBlocStateCopyWith(
          RecordingsBlocState value, $Res Function(RecordingsBlocState) then) =
      _$RecordingsBlocStateCopyWithImpl<$Res>;
  $Res call(
      {List<RecordingDetails> recordings,
      bool isInitialized,
      bool isProcessing,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class _$RecordingsBlocStateCopyWithImpl<$Res>
    implements $RecordingsBlocStateCopyWith<$Res> {
  _$RecordingsBlocStateCopyWithImpl(this._value, this._then);

  final RecordingsBlocState _value;
  // ignore: unused_field
  final $Res Function(RecordingsBlocState) _then;

  @override
  $Res call({
    Object? recordings = freezed,
    Object? isInitialized = freezed,
    Object? isProcessing = freezed,
    Object? isError = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      recordings: recordings == freezed
          ? _value.recordings
          : recordings // ignore: cast_nullable_to_non_nullable
              as List<RecordingDetails>,
      isInitialized: isInitialized == freezed
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: isProcessing == freezed
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$RecordingsBlocStateCopyWith<$Res>
    implements $RecordingsBlocStateCopyWith<$Res> {
  factory _$RecordingsBlocStateCopyWith(_RecordingsBlocState value,
          $Res Function(_RecordingsBlocState) then) =
      __$RecordingsBlocStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<RecordingDetails> recordings,
      bool isInitialized,
      bool isProcessing,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class __$RecordingsBlocStateCopyWithImpl<$Res>
    extends _$RecordingsBlocStateCopyWithImpl<$Res>
    implements _$RecordingsBlocStateCopyWith<$Res> {
  __$RecordingsBlocStateCopyWithImpl(
      _RecordingsBlocState _value, $Res Function(_RecordingsBlocState) _then)
      : super(_value, (v) => _then(v as _RecordingsBlocState));

  @override
  _RecordingsBlocState get _value => super._value as _RecordingsBlocState;

  @override
  $Res call({
    Object? recordings = freezed,
    Object? isInitialized = freezed,
    Object? isProcessing = freezed,
    Object? isError = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_RecordingsBlocState(
      recordings: recordings == freezed
          ? _value.recordings
          : recordings // ignore: cast_nullable_to_non_nullable
              as List<RecordingDetails>,
      isInitialized: isInitialized == freezed
          ? _value.isInitialized
          : isInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      isProcessing: isProcessing == freezed
          ? _value.isProcessing
          : isProcessing // ignore: cast_nullable_to_non_nullable
              as bool,
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

class _$_RecordingsBlocState extends _RecordingsBlocState {
  const _$_RecordingsBlocState(
      {this.recordings = const [],
      this.isInitialized = false,
      this.isProcessing = false,
      this.isError = false,
      this.errorMessage})
      : super._();

  @JsonKey(defaultValue: const [])
  @override
  final List<RecordingDetails> recordings;
  @JsonKey(defaultValue: false)
  @override
  final bool isInitialized;
  @JsonKey(defaultValue: false)
  @override
  final bool isProcessing;
  @JsonKey(defaultValue: false)
  @override
  final bool isError;
  @override
  final String? errorMessage;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RecordingsBlocState &&
            (identical(other.recordings, recordings) ||
                const DeepCollectionEquality()
                    .equals(other.recordings, recordings)) &&
            (identical(other.isInitialized, isInitialized) ||
                const DeepCollectionEquality()
                    .equals(other.isInitialized, isInitialized)) &&
            (identical(other.isProcessing, isProcessing) ||
                const DeepCollectionEquality()
                    .equals(other.isProcessing, isProcessing)) &&
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
      const DeepCollectionEquality().hash(recordings) ^
      const DeepCollectionEquality().hash(isInitialized) ^
      const DeepCollectionEquality().hash(isProcessing) ^
      const DeepCollectionEquality().hash(isError) ^
      const DeepCollectionEquality().hash(errorMessage);

  @JsonKey(ignore: true)
  @override
  _$RecordingsBlocStateCopyWith<_RecordingsBlocState> get copyWith =>
      __$RecordingsBlocStateCopyWithImpl<_RecordingsBlocState>(
          this, _$identity);
}

abstract class _RecordingsBlocState extends RecordingsBlocState {
  const factory _RecordingsBlocState(
      {List<RecordingDetails> recordings,
      bool isInitialized,
      bool isProcessing,
      bool isError,
      String? errorMessage}) = _$_RecordingsBlocState;
  const _RecordingsBlocState._() : super._();

  @override
  List<RecordingDetails> get recordings => throw _privateConstructorUsedError;
  @override
  bool get isInitialized => throw _privateConstructorUsedError;
  @override
  bool get isProcessing => throw _privateConstructorUsedError;
  @override
  bool get isError => throw _privateConstructorUsedError;
  @override
  String? get errorMessage => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RecordingsBlocStateCopyWith<_RecordingsBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}
