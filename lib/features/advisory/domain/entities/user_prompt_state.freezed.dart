// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_prompt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserPromptState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sentPrompt,
    required TResult Function() sendingUserPrompt,
    required TResult Function(String message) errorSendingUserPrompt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? sentPrompt,
    TResult? Function()? sendingUserPrompt,
    TResult? Function(String message)? errorSendingUserPrompt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sentPrompt,
    TResult Function()? sendingUserPrompt,
    TResult Function(String message)? errorSendingUserPrompt,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SentPrompt value) sentPrompt,
    required TResult Function(_SendingUserPrompt value) sendingUserPrompt,
    required TResult Function(_ErrorSendingUserPrompt value)
        errorSendingUserPrompt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SentPrompt value)? sentPrompt,
    TResult? Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult? Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SentPrompt value)? sentPrompt,
    TResult Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPromptStateCopyWith<$Res> {
  factory $UserPromptStateCopyWith(
          UserPromptState value, $Res Function(UserPromptState) then) =
      _$UserPromptStateCopyWithImpl<$Res, UserPromptState>;
}

/// @nodoc
class _$UserPromptStateCopyWithImpl<$Res, $Val extends UserPromptState>
    implements $UserPromptStateCopyWith<$Res> {
  _$UserPromptStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SentPromptCopyWith<$Res> {
  factory _$$_SentPromptCopyWith(
          _$_SentPrompt value, $Res Function(_$_SentPrompt) then) =
      __$$_SentPromptCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SentPromptCopyWithImpl<$Res>
    extends _$UserPromptStateCopyWithImpl<$Res, _$_SentPrompt>
    implements _$$_SentPromptCopyWith<$Res> {
  __$$_SentPromptCopyWithImpl(
      _$_SentPrompt _value, $Res Function(_$_SentPrompt) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SentPrompt implements _SentPrompt {
  const _$_SentPrompt();

  @override
  String toString() {
    return 'UserPromptState.sentPrompt()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SentPrompt);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sentPrompt,
    required TResult Function() sendingUserPrompt,
    required TResult Function(String message) errorSendingUserPrompt,
  }) {
    return sentPrompt();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? sentPrompt,
    TResult? Function()? sendingUserPrompt,
    TResult? Function(String message)? errorSendingUserPrompt,
  }) {
    return sentPrompt?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sentPrompt,
    TResult Function()? sendingUserPrompt,
    TResult Function(String message)? errorSendingUserPrompt,
    required TResult orElse(),
  }) {
    if (sentPrompt != null) {
      return sentPrompt();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SentPrompt value) sentPrompt,
    required TResult Function(_SendingUserPrompt value) sendingUserPrompt,
    required TResult Function(_ErrorSendingUserPrompt value)
        errorSendingUserPrompt,
  }) {
    return sentPrompt(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SentPrompt value)? sentPrompt,
    TResult? Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult? Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
  }) {
    return sentPrompt?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SentPrompt value)? sentPrompt,
    TResult Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
    required TResult orElse(),
  }) {
    if (sentPrompt != null) {
      return sentPrompt(this);
    }
    return orElse();
  }
}

abstract class _SentPrompt implements UserPromptState {
  const factory _SentPrompt() = _$_SentPrompt;
}

/// @nodoc
abstract class _$$_SendingUserPromptCopyWith<$Res> {
  factory _$$_SendingUserPromptCopyWith(_$_SendingUserPrompt value,
          $Res Function(_$_SendingUserPrompt) then) =
      __$$_SendingUserPromptCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SendingUserPromptCopyWithImpl<$Res>
    extends _$UserPromptStateCopyWithImpl<$Res, _$_SendingUserPrompt>
    implements _$$_SendingUserPromptCopyWith<$Res> {
  __$$_SendingUserPromptCopyWithImpl(
      _$_SendingUserPrompt _value, $Res Function(_$_SendingUserPrompt) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_SendingUserPrompt implements _SendingUserPrompt {
  const _$_SendingUserPrompt();

  @override
  String toString() {
    return 'UserPromptState.sendingUserPrompt()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SendingUserPrompt);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sentPrompt,
    required TResult Function() sendingUserPrompt,
    required TResult Function(String message) errorSendingUserPrompt,
  }) {
    return sendingUserPrompt();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? sentPrompt,
    TResult? Function()? sendingUserPrompt,
    TResult? Function(String message)? errorSendingUserPrompt,
  }) {
    return sendingUserPrompt?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sentPrompt,
    TResult Function()? sendingUserPrompt,
    TResult Function(String message)? errorSendingUserPrompt,
    required TResult orElse(),
  }) {
    if (sendingUserPrompt != null) {
      return sendingUserPrompt();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SentPrompt value) sentPrompt,
    required TResult Function(_SendingUserPrompt value) sendingUserPrompt,
    required TResult Function(_ErrorSendingUserPrompt value)
        errorSendingUserPrompt,
  }) {
    return sendingUserPrompt(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SentPrompt value)? sentPrompt,
    TResult? Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult? Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
  }) {
    return sendingUserPrompt?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SentPrompt value)? sentPrompt,
    TResult Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
    required TResult orElse(),
  }) {
    if (sendingUserPrompt != null) {
      return sendingUserPrompt(this);
    }
    return orElse();
  }
}

abstract class _SendingUserPrompt implements UserPromptState {
  const factory _SendingUserPrompt() = _$_SendingUserPrompt;
}

/// @nodoc
abstract class _$$_ErrorSendingUserPromptCopyWith<$Res> {
  factory _$$_ErrorSendingUserPromptCopyWith(_$_ErrorSendingUserPrompt value,
          $Res Function(_$_ErrorSendingUserPrompt) then) =
      __$$_ErrorSendingUserPromptCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$_ErrorSendingUserPromptCopyWithImpl<$Res>
    extends _$UserPromptStateCopyWithImpl<$Res, _$_ErrorSendingUserPrompt>
    implements _$$_ErrorSendingUserPromptCopyWith<$Res> {
  __$$_ErrorSendingUserPromptCopyWithImpl(_$_ErrorSendingUserPrompt _value,
      $Res Function(_$_ErrorSendingUserPrompt) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$_ErrorSendingUserPrompt(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorSendingUserPrompt implements _ErrorSendingUserPrompt {
  const _$_ErrorSendingUserPrompt({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'UserPromptState.errorSendingUserPrompt(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorSendingUserPrompt &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorSendingUserPromptCopyWith<_$_ErrorSendingUserPrompt> get copyWith =>
      __$$_ErrorSendingUserPromptCopyWithImpl<_$_ErrorSendingUserPrompt>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() sentPrompt,
    required TResult Function() sendingUserPrompt,
    required TResult Function(String message) errorSendingUserPrompt,
  }) {
    return errorSendingUserPrompt(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? sentPrompt,
    TResult? Function()? sendingUserPrompt,
    TResult? Function(String message)? errorSendingUserPrompt,
  }) {
    return errorSendingUserPrompt?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? sentPrompt,
    TResult Function()? sendingUserPrompt,
    TResult Function(String message)? errorSendingUserPrompt,
    required TResult orElse(),
  }) {
    if (errorSendingUserPrompt != null) {
      return errorSendingUserPrompt(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SentPrompt value) sentPrompt,
    required TResult Function(_SendingUserPrompt value) sendingUserPrompt,
    required TResult Function(_ErrorSendingUserPrompt value)
        errorSendingUserPrompt,
  }) {
    return errorSendingUserPrompt(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SentPrompt value)? sentPrompt,
    TResult? Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult? Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
  }) {
    return errorSendingUserPrompt?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SentPrompt value)? sentPrompt,
    TResult Function(_SendingUserPrompt value)? sendingUserPrompt,
    TResult Function(_ErrorSendingUserPrompt value)? errorSendingUserPrompt,
    required TResult orElse(),
  }) {
    if (errorSendingUserPrompt != null) {
      return errorSendingUserPrompt(this);
    }
    return orElse();
  }
}

abstract class _ErrorSendingUserPrompt implements UserPromptState {
  const factory _ErrorSendingUserPrompt({required final String message}) =
      _$_ErrorSendingUserPrompt;

  String get message;
  @JsonKey(ignore: true)
  _$$_ErrorSendingUserPromptCopyWith<_$_ErrorSendingUserPrompt> get copyWith =>
      throw _privateConstructorUsedError;
}
