import 'package:consumable_advisory/features/advisory/domain/entities/conversation/conversation_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AdvisoryRepository {

  Future<Either<String, String>> uploadFile({required String filePath, required String uploadDirectory});

  Future<Either<String, bool>> sendPrompt({required String collection, required String prompt});

  Stream<String?> retrieveExtractedText({required String queryParam});

  Stream<List<String>> fetchConversationTitles();

  Stream<List<ConversationEntity>> fetchConversations();

  Future<void> deleteConversation({required String conversationId});

  Stream<List<MessageEntity>> fetchMessages({required String conversationId});
}
