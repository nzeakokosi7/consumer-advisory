import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_status.freezed.dart';
part 'message_status.g.dart';

@freezed
class MessageStatus with _$MessageStatus {
  const factory MessageStatus({
    // Timestamp? created_at,
    @Default("") String state,
    // Timestamp? updated_at
  }) = _MessageStatus;

  factory MessageStatus.fromJson(Map<String, Object?> json) =>
      _$MessageStatusFromJson(json);
}
