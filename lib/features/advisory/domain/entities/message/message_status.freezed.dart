// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageStatus _$MessageStatusFromJson(Map<String, dynamic> json) {
  return _MessageStatus.fromJson(json);
}

/// @nodoc
mixin _$MessageStatus {
// Timestamp? created_at,
  String get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageStatusCopyWith<MessageStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageStatusCopyWith<$Res> {
  factory $MessageStatusCopyWith(
          MessageStatus value, $Res Function(MessageStatus) then) =
      _$MessageStatusCopyWithImpl<$Res, MessageStatus>;
  @useResult
  $Res call({String state});
}

/// @nodoc
class _$MessageStatusCopyWithImpl<$Res, $Val extends MessageStatus>
    implements $MessageStatusCopyWith<$Res> {
  _$MessageStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageStatusCopyWith<$Res>
    implements $MessageStatusCopyWith<$Res> {
  factory _$$_MessageStatusCopyWith(
          _$_MessageStatus value, $Res Function(_$_MessageStatus) then) =
      __$$_MessageStatusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String state});
}

/// @nodoc
class __$$_MessageStatusCopyWithImpl<$Res>
    extends _$MessageStatusCopyWithImpl<$Res, _$_MessageStatus>
    implements _$$_MessageStatusCopyWith<$Res> {
  __$$_MessageStatusCopyWithImpl(
      _$_MessageStatus _value, $Res Function(_$_MessageStatus) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$_MessageStatus(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageStatus implements _MessageStatus {
  const _$_MessageStatus({this.state = ""});

  factory _$_MessageStatus.fromJson(Map<String, dynamic> json) =>
      _$$_MessageStatusFromJson(json);

// Timestamp? created_at,
  @override
  @JsonKey()
  final String state;

  @override
  String toString() {
    return 'MessageStatus(state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageStatus &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageStatusCopyWith<_$_MessageStatus> get copyWith =>
      __$$_MessageStatusCopyWithImpl<_$_MessageStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageStatusToJson(
      this,
    );
  }
}

abstract class _MessageStatus implements MessageStatus {
  const factory _MessageStatus({final String state}) = _$_MessageStatus;

  factory _MessageStatus.fromJson(Map<String, dynamic> json) =
      _$_MessageStatus.fromJson;

  @override // Timestamp? created_at,
  String get state;
  @override
  @JsonKey(ignore: true)
  _$$_MessageStatusCopyWith<_$_MessageStatus> get copyWith =>
      throw _privateConstructorUsedError;
}
