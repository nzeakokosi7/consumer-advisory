// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) {
  return _MessageEntity.fromJson(json);
}

/// @nodoc
mixin _$MessageEntity {
  String get prompt => throw _privateConstructorUsedError;
  MessageStatus? get status => throw _privateConstructorUsedError;
  String get response => throw _privateConstructorUsedError;
  String get parentMessageId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) then) =
      _$MessageEntityCopyWithImpl<$Res, MessageEntity>;
  @useResult
  $Res call(
      {String prompt,
      MessageStatus? status,
      String response,
      String parentMessageId});

  $MessageStatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res, $Val extends MessageEntity>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = null,
    Object? status = freezed,
    Object? response = null,
    Object? parentMessageId = null,
  }) {
    return _then(_value.copyWith(
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus?,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      parentMessageId: null == parentMessageId
          ? _value.parentMessageId
          : parentMessageId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MessageStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $MessageStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MessageEntityCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$$_MessageEntityCopyWith(
          _$_MessageEntity value, $Res Function(_$_MessageEntity) then) =
      __$$_MessageEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String prompt,
      MessageStatus? status,
      String response,
      String parentMessageId});

  @override
  $MessageStatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$_MessageEntityCopyWithImpl<$Res>
    extends _$MessageEntityCopyWithImpl<$Res, _$_MessageEntity>
    implements _$$_MessageEntityCopyWith<$Res> {
  __$$_MessageEntityCopyWithImpl(
      _$_MessageEntity _value, $Res Function(_$_MessageEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = null,
    Object? status = freezed,
    Object? response = null,
    Object? parentMessageId = null,
  }) {
    return _then(_$_MessageEntity(
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus?,
      response: null == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as String,
      parentMessageId: null == parentMessageId
          ? _value.parentMessageId
          : parentMessageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessageEntity implements _MessageEntity {
  const _$_MessageEntity(
      {required this.prompt,
      this.status,
      this.response = "",
      this.parentMessageId = ""});

  factory _$_MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$$_MessageEntityFromJson(json);

  @override
  final String prompt;
  @override
  final MessageStatus? status;
  @override
  @JsonKey()
  final String response;
  @override
  @JsonKey()
  final String parentMessageId;

  @override
  String toString() {
    return 'MessageEntity(prompt: $prompt, status: $status, response: $response, parentMessageId: $parentMessageId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageEntity &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.parentMessageId, parentMessageId) ||
                other.parentMessageId == parentMessageId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, prompt, status, response, parentMessageId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageEntityCopyWith<_$_MessageEntity> get copyWith =>
      __$$_MessageEntityCopyWithImpl<_$_MessageEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageEntityToJson(
      this,
    );
  }
}

abstract class _MessageEntity implements MessageEntity {
  const factory _MessageEntity(
      {required final String prompt,
      final MessageStatus? status,
      final String response,
      final String parentMessageId}) = _$_MessageEntity;

  factory _MessageEntity.fromJson(Map<String, dynamic> json) =
      _$_MessageEntity.fromJson;

  @override
  String get prompt;
  @override
  MessageStatus? get status;
  @override
  String get response;
  @override
  String get parentMessageId;
  @override
  @JsonKey(ignore: true)
  _$$_MessageEntityCopyWith<_$_MessageEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
