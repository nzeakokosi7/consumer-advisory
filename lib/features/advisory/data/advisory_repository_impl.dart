import 'package:consumable_advisory/features/advisory/data/advisory_data_source.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/conversation/conversation_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/message/message_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/repositories/advisory_repository_interface.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvisoryRepositoryImpl extends AdvisoryRepository {
  final AdvisoryDataSource advisoryDataSource;

  AdvisoryRepositoryImpl(this.advisoryDataSource);

  @override
  Stream<List<String>> fetchConversationTitles() {
    return advisoryDataSource.fetchConversationTitles();
  }

  @override
  Stream<List<ConversationEntity>> fetchConversations() {
    return advisoryDataSource.fetchConversations();
  }

  @override
  Future<void> deleteConversation({required String conversationId}) {
    return advisoryDataSource.removeConversation(conversationId: conversationId);
  }

  @override
  Stream<List<MessageEntity>> fetchMessages({required String conversationId}) {
    return advisoryDataSource.fetchMessages(conversationId: conversationId);
  }

  @override
  Stream<String?> retrieveExtractedText({required String queryParam}) {
    return advisoryDataSource.retrieveExtractedTest(directory: queryParam);
  }

  @override
  Future<Either<String, bool>> sendPrompt({required String collection, required String prompt}) {
    return advisoryDataSource.sendPrompt(collectionPath: collection, prompt: prompt);
  }

  @override
  Future<Either<String, String>> uploadFile({required String filePath, required String uploadDirectory}) {
    return advisoryDataSource.uploadFile(filePath: filePath, uploadDirectory: uploadDirectory);
  }
}

final advisoryRepositoryProvider = Provider<AdvisoryRepositoryImpl>((ref) {
  final advisoryDataSource = ref.watch(advisoryDataSourceProvider);
  return AdvisoryRepositoryImpl(
    advisoryDataSource,
  );
});
