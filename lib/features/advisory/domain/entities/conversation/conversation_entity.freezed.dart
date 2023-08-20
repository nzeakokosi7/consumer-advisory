// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConversationEntity _$ConversationEntityFromJson(Map<String, dynamic> json) {
  return _ConversationEntity.fromJson(json);
}

/// @nodoc
mixin _$ConversationEntity {
  String get title => throw _privateConstructorUsedError;
  num get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationEntityCopyWith<ConversationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationEntityCopyWith<$Res> {
  factory $ConversationEntityCopyWith(
          ConversationEntity value, $Res Function(ConversationEntity) then) =
      _$ConversationEntityCopyWithImpl<$Res, ConversationEntity>;
  @useResult
  $Res call({String title, num timestamp});
}

/// @nodoc
class _$ConversationEntityCopyWithImpl<$Res, $Val extends ConversationEntity>
    implements $ConversationEntityCopyWith<$Res> {
  _$ConversationEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ConversationEntityCopyWith<$Res>
    implements $ConversationEntityCopyWith<$Res> {
  factory _$$_ConversationEntityCopyWith(_$_ConversationEntity value,
          $Res Function(_$_ConversationEntity) then) =
      __$$_ConversationEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, num timestamp});
}

/// @nodoc
class __$$_ConversationEntityCopyWithImpl<$Res>
    extends _$ConversationEntityCopyWithImpl<$Res, _$_ConversationEntity>
    implements _$$_ConversationEntityCopyWith<$Res> {
  __$$_ConversationEntityCopyWithImpl(
      _$_ConversationEntity _value, $Res Function(_$_ConversationEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? timestamp = null,
  }) {
    return _then(_$_ConversationEntity(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConversationEntity implements _ConversationEntity {
  const _$_ConversationEntity({required this.title, required this.timestamp});

  factory _$_ConversationEntity.fromJson(Map<String, dynamic> json) =>
      _$$_ConversationEntityFromJson(json);

  @override
  final String title;
  @override
  final num timestamp;

  @override
  String toString() {
    return 'ConversationEntity(title: $title, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConversationEntity &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConversationEntityCopyWith<_$_ConversationEntity> get copyWith =>
      __$$_ConversationEntityCopyWithImpl<_$_ConversationEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConversationEntityToJson(
      this,
    );
  }
}

abstract class _ConversationEntity implements ConversationEntity {
  const factory _ConversationEntity(
      {required final String title,
      required final num timestamp}) = _$_ConversationEntity;

  factory _ConversationEntity.fromJson(Map<String, dynamic> json) =
      _$_ConversationEntity.fromJson;

  @override
  String get title;
  @override
  num get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$_ConversationEntityCopyWith<_$_ConversationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
