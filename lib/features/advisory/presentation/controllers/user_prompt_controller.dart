import 'package:consumable_advisory/features/advisory/data/advisory_repository_impl.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/user_prompt_state.dart';
import 'package:consumable_advisory/features/advisory/domain/repositories/advisory_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// TODO: migrate to AsyncNotifier
class UserPromptController extends StateNotifier<UserPromptState> {
  final AdvisoryRepository advisoryRepository;
  UserPromptController(this.advisoryRepository)
      : super(const UserPromptState.sentPrompt());
  final controller = ScrollController();
  late final TextEditingController promptController = TextEditingController();

  Future<void> sendPrompt({required String conversationTitle}) async {
    final collection = conversationTitle;
    final userPrompt = promptController.text.trim();
    if (userPrompt.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      state = const UserPromptState.sendingUserPrompt();
      final response = await advisoryRepository.sendPrompt(
        collection: collection,
        prompt: userPrompt,
      );
      response.fold(
        (error) {
          state = UserPromptState.errorSendingUserPrompt(message: error);
        },
        (isSuccessful) {
          state = const UserPromptState.sentPrompt();
          if (controller.hasClients) {
            controller.jumpTo(controller.position.maxScrollExtent);
          }
          promptController.clear();
        },
      );
    }
  }
}

final userPromptControllerProvider =
    StateNotifierProvider.autoDispose<UserPromptController, UserPromptState>(
        (ref) {
  final advisoryRepository = ref.watch(advisoryRepositoryProvider);
  return UserPromptController(advisoryRepository);
});
