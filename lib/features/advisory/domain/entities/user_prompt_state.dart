import 'package:freezed_annotation/freezed_annotation.dart';

part "user_prompt_state.freezed.dart";

@freezed
class UserPromptState with _$UserPromptState {
  const factory UserPromptState.sentPrompt() = _SentPrompt;

  const factory UserPromptState.sendingUserPrompt() = _SendingUserPrompt;

  const factory UserPromptState.errorSendingUserPrompt({required String message}) = _ErrorSendingUserPrompt;
}
