import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/loading_dots.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/message/message_entity.dart';
import 'package:consumable_advisory/features/advisory/domain/enums/conversation_status.dart';
import 'package:flutter/material.dart';

class MessageComponent extends StatelessWidget {
  final MessageEntity conversationEntity;
  final bool isInitial;

  const MessageComponent({
    super.key,
    required this.conversationEntity,
    this.isInitial = false,
  });

  Widget get _loadingChild {
    final Color dotColor;
    dotColor = Colors.blueAccent;
    return AppLoadingDots(color: dotColor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.seaLion.asEdgeInsetsOnly(bottom: true),
      child: Column(
        children: [
          if (!isInitial)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.titleColor,
                  radius: 20,
                ),
                const SizedBox(width: AppEdgeInsets.normal),
                Expanded(
                  child: Text(
                    conversationEntity.prompt,
                    softWrap: true,
                  ),
                )
              ],
            ),
          const SizedBox(height: AppEdgeInsets.normal),
          if (conversationEntity.status == null ||
              conversationEntity.status?.state.toLowerCase() ==
                  ConversationStatus.processing.name)
            Center(
              child: _loadingChild,
            ),
          if (conversationEntity.status?.state.toLowerCase() ==
              ConversationStatus.completed.name)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.appGreen,
                  radius: 20,
                ),
                const SizedBox(width: AppEdgeInsets.normal),
                Expanded(
                  child: Text(
                    conversationEntity.response,
                    softWrap: true,
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
