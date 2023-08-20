import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_entity.freezed.dart';
part 'conversation_entity.g.dart';

@freezed
class ConversationEntity with _$ConversationEntity {
  const factory ConversationEntity({
    required String title,
    required num timestamp,

  }) = _ConversationEntity;

  factory ConversationEntity.fromJson(Map<String, Object?> json)
  => _$ConversationEntityFromJson(json);
}