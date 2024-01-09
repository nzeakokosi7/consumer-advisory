import 'dart:async';

import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/features/accounts/domain/entities/health_bio_entity.dart';
import 'package:consumable_advisory/features/advisory/data/advisory_repository_impl.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/advisory_state.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/conversation/conversation_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/message/message_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/enums/stage.dart';
import 'package:consumable_advisory/features/advisory/domain/repositories/advisory_repository_interface.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/health_bio_bottom_sheet.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/product_title_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


// TODO: Need to understand how the bottomsheet stream works to before migration
class AdvisoryController extends StateNotifier<AdvisoryState> {
  final AdvisoryRepository advisoryRepository;
  final StreamController<Stage> _productTitleBottomSheetStream =
      StreamController<Stage>.broadcast();
  final StreamController<Stage> _bioBottomSheetStream =
      StreamController<Stage>.broadcast();
  late final TextEditingController productTitleController =
      TextEditingController();
  late List<String> existingTitles;
  late Map<String, ConversationEntity> conversationHistory;

  AdvisoryController(this.advisoryRepository)
      : super(const AdvisoryState.initial()) {
    init();
  }

  Future<void> init() async {
    // await Future.delayed(const Duration(milliseconds: 500));
    existingTitles = await advisoryRepository.fetchConversationTitles().first;

    AppLogger.log(existingTitles);
    // existingTitles = await stream.single;
    state = const AdvisoryState.postInitial();
  }

  void initialize({required BuildContext context, required String imagePath}) {
    ProductTitleBottomSheet.show(
      context: context,
      proceed: (String productCategory) async {
        AppLogger.log(productCategory);
        if (productCategory == "Medication" || productCategory == "Alcohol") {
          _productTitleBottomSheetStream.add(Stage.end);
          await Future.delayed(const Duration(milliseconds: 200))
              .then((value) => showBioBottomSheet(context, imagePath));
        } else {
          _uploadFile(imagePath);
        }
      },
      bottomSheetStream: _productTitleBottomSheetStream,
      controller: productTitleController,
    );
  }

  void showBioBottomSheet(BuildContext context, String imagePath) {
    HealthBioBottomSheet.show(
      context: context,
      proceed: (HealthBioEntity healthBioEntity) {
        _uploadFileForBioResponse(imagePath, healthBioEntity);
      },
      bottomSheetStream: _bioBottomSheetStream,
    );
  }

  Future<void> _uploadFile(String imagePath) async {
    state = AdvisoryState.uploading(title: productTitleController.text.trim());
    _productTitleBottomSheetStream.add(Stage.initial);
    final response = await advisoryRepository.uploadFile(
      filePath: imagePath,
      uploadDirectory: FirebaseAuth.instance.currentUser!.email!,
    );

    response.fold(
      (error) {
        _productTitleBottomSheetStream.add(Stage.error);
        state = AdvisoryState.error(errorMessage: error);
      },
      (storagePath) {
        _productTitleBottomSheetStream.add(Stage.end);
        _retrieveExtractedText(storagePath);
      },
    );
  }

  Future<void> _uploadFileForBioResponse(
      String imagePath, HealthBioEntity healthBioEntity,) async {
    state = AdvisoryState.uploading(title: productTitleController.text.trim());
    _bioBottomSheetStream.add(Stage.initial);
    final response = await advisoryRepository.uploadFile(
      filePath: imagePath,
      uploadDirectory: FirebaseAuth.instance.currentUser!.email!,
    );

    response.fold(
      (error) {
        _bioBottomSheetStream.add(Stage.error);
        state = AdvisoryState.error(errorMessage: error);
      },
      (storagePath) {
        _bioBottomSheetStream.add(Stage.end);
        _retrieveExtractedText(storagePath, healthBioEntity: healthBioEntity);
      },
    );
  }

  Future<void> _retrieveExtractedText(
    String storagePath, {
    HealthBioEntity? healthBioEntity,
  }) async {
    state = const AdvisoryState.extractText(state: "Fetching extracted text");
    final stream =
        advisoryRepository.retrieveExtractedText(queryParam: storagePath);
    // final extractedText = await stream.first;
    // if(extractedText!=null) {
    //   _sendPrompt(extractedText, healthBioEntity: healthBioEntity);
    //   AppLogger.log(extractedText);
    // }
    stream.listen((event) {
      if (event != null) {
        _sendPrompt(event, healthBioEntity: healthBioEntity);
        AppLogger.log(event);
      }
    });
  }

  Future<void> _sendPrompt(
    String extractedText, {
    HealthBioEntity? healthBioEntity,
  }) async {
    state = const AdvisoryState.sendPrompt(state: "Sending prompt");
    final userInput = productTitleController.text.trim();
    final productTitle = getUniqueInput(userInput);
    final prompt = getPrompt(
      userInput,
      extractedText,
      healthBioEntity: healthBioEntity,
    );

    final response = await advisoryRepository.sendPrompt(
      collection: productTitle,
      prompt: prompt,
    );

    response.fold(
      (error) {
        state = AdvisoryState.error(errorMessage: error);
      },
      (isSuccessful) {
        state = AdvisoryState.finalized(productTitle: productTitle);
      },
    );
  }

  String getUniqueInput(String userInput, {int? salt}) {
    final String saltedInput = salt != null ? "$userInput$salt" : userInput;
    AppLogger.log(saltedInput);
    if (existingTitles.contains(saltedInput)) {
      return getUniqueInput(userInput, salt: (salt ?? 0) + 1);
    } else {
      return saltedInput;
    }
  }

  String getPrompt(
    String productTitle,
    String extractedText, {
    HealthBioEntity? healthBioEntity,
  }) {
    String prompt;
    if (healthBioEntity != null) {
      prompt =
          "You're a primary health care provider, who gives basic advice to patients who consults you with details of medications they want to consume. ";
      prompt +=
          "I am ${healthBioEntity.age} year old ${healthBioEntity.gender}, who weighs ${healthBioEntity.weight}kg at a height of of about ${healthBioEntity.height}inches. ";
      prompt +=
          "My blood group and genotype are ${healthBioEntity.bloodGroup} are ${healthBioEntity.genotype} respectively. ";

      if (healthBioEntity.gender == "female") {
        if (healthBioEntity.isPregnant &&
            healthBioEntity.isAMother &&
            healthBioEntity.isLactating) {
          prompt += "I am currently a pregnant, lactating mother. ";
        } else if (healthBioEntity.isPregnant && healthBioEntity.isAMother) {
          prompt += "I am currently a pregnant mother.";
        } else if (healthBioEntity.isPregnant && healthBioEntity.isLactating) {
          prompt += "I am currently a pregnant, lactating mother. ";
        } else if (healthBioEntity.isLactating) {
          prompt += "I am currently a lactating mother. ";
        } else if (healthBioEntity.isAMother) {
          prompt += "I am a non lactating mother. ";
        }
      }

      if (healthBioEntity.stds.trim().isNotEmpty) {
        prompt +=
            " I am currently living with the following STDs/STIs ${healthBioEntity.stds}. ";
      }

      if (healthBioEntity.allergies.trim().isNotEmpty) {
        prompt += " I have the following allergies ${healthBioEntity.stds}. ";
      }
    } else {
      prompt =
          "You're a consulting scientist, who gives basic advice to clients who consults you with details of items they want to consume or make use of.  ";
    }

    prompt +=
        "Below are the details of the product($productTitle) \n $extractedText. \n";
    prompt += "Provide detailed advise on usage/consumption of this product. ";
    prompt += "Keep your response simple, without complex sentences and words";
    return prompt;
  }
}

final advisoryControllerProvider =
    StateNotifierProvider.autoDispose<AdvisoryController, AdvisoryState>((ref) {
  final advisoryRepository = ref.watch(advisoryRepositoryProvider);
  return AdvisoryController(advisoryRepository);
});

final messageStreamProvider =
    StreamProvider.family<List<MessageEntity>, String>((ref, productTitle) {
  final advisoryRepository = ref.watch(advisoryRepositoryProvider);
  return advisoryRepository.fetchMessages(conversationId: productTitle);
});

final conversationHistoryStream =
    StreamProvider<Map<String, List<ConversationEntity>>>((ref) {
  final advisoryRepository = ref.watch(advisoryRepositoryProvider);

  return advisoryRepository.fetchConversations().map((entities) {
    final Map<String, List<ConversationEntity>> conversationMap = {};
    for (final entity in entities) {
      final formattedDate = DateFormat.yMMMEd().format(
          DateTime.fromMicrosecondsSinceEpoch(
              int.parse(entity.timestamp.toString()),),);
      if (!conversationMap.containsKey(formattedDate)) {
        conversationMap[formattedDate] = [entity];
      } else {
        conversationMap[formattedDate]?.add(entity);
      }
    }

    return conversationMap;
  });
});
