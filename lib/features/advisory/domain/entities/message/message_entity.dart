import 'package:consumable_advisory/features/advisory/domain/entities/message/message_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_entity.freezed.dart';
part 'message_entity.g.dart';

@freezed
class MessageEntity with _$MessageEntity {
  const factory MessageEntity({
    required String prompt,
    MessageStatus? status,
    @Default("") String response,
    @Default("") String parentMessageId,

}) = _MessageEntity;

  factory MessageEntity.fromJson(Map<String, Object?> json)
  => _$MessageEntityFromJson(json);
}
