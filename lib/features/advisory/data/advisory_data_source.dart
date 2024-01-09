import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/config/providers.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/conversation/conversation_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/message/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvisoryDataSource {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firebaseFireStore;
  final String uuid;

  AdvisoryDataSource(this._firebaseStorage, this._firebaseFireStore, this.uuid);

  Future<Either<String, String>> uploadFile({
    required String filePath,
    required String uploadDirectory,
  }) async {
    final fileName = filePath.split("/").last;
    final ref = _firebaseStorage.ref().child('$uploadDirectory/$fileName');

    try {
      // Uploading the selected image with some custom meta data
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'picked-file-path': filePath,
          'upload-date': DateTime.now().toIso8601String()
        },
      );

      await ref.putFile(File(filePath), metadata);
      return right("gs://${ref.bucket}/${ref.fullPath}");
    } catch (e) {
      return left(e.toString());
    }
  }

  Stream<String?> retrieveExtractedTest({
    required String directory,
  }) {
    AppLogger.log(directory);
    final ref = _firebaseFireStore.collection("extractedText");
    return ref.where("file", isEqualTo: directory).snapshots().map((event) {
      if (event.docs.isNotEmpty) {
        final doc = event.docs.first.data();
        return doc["text"] as String;
      }
      return null;
    });
  }

  Future<Either<String, bool>> sendPrompt({
    required String collectionPath,
    required String prompt,
  }) async {
    AppLogger.log(
        "Sending prompt $prompt to users/$uuid/conversations/$collectionPath/messages",
        longMessage: true,);
    final timeStamp = DateTime.now().microsecondsSinceEpoch;

    final collectionRef = _firebaseFireStore
        .collection("users/$uuid/conversations")
        .doc(collectionPath);

    final documentRef = _firebaseFireStore
        .collection("users/$uuid/conversations/$collectionPath/messages")
        .doc();

    try {
      await collectionRef.set({
        'timestamp': timeStamp,
        'title': collectionPath,
      });

      await documentRef.set({
        'prompt': prompt,
        'timestamp': timeStamp,
      });
      AppLogger.log('Prompt sent successfully!');
      return right(true);
    } catch (e) {
      final errorMessage = 'Error sending prompt: $e';
      AppLogger.log(errorMessage);
      return left(errorMessage);
    }
  }

  Stream<List<String>> fetchConversationTitles() {
    return _firebaseFireStore
        .collection('users/$uuid/conversations')
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.id;
      }).toList();
    });
  }

  Future<void> removeConversation({
    required String conversationId,
  }) async {
    return _firebaseFireStore
        .collection("users/$uuid/conversations")
        .doc(conversationId)
        .delete();
  }

  Stream<List<ConversationEntity>> fetchConversations() {
    return _firebaseFireStore
        .collection('users/$uuid/conversations')
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ConversationEntity.fromJson(data);
      }).toList();
    });
  }

  Stream<List<MessageEntity>> fetchMessages({
    required String conversationId,
  }) {
    return _firebaseFireStore
        .collection("users/$uuid/conversations/$conversationId/messages")
        .orderBy("timestamp", descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return MessageEntity.fromJson(data);
      }).toList();
    });
  }
}

final advisoryDataSourceProvider = Provider<AdvisoryDataSource>((ref) {
  final firebaseStorage = ref.watch(firebaseStorageProvider);
  final firebaseFireStore = ref.watch(firebaseFireStoreProvider);
  final uuid = ref.watch(firebaseAuthProvider).currentUser!.uid;

  return AdvisoryDataSource(firebaseStorage, firebaseFireStore, uuid);
});
