import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/domain/entities/conversation/conversation_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConversationComponent extends StatelessWidget {
  final String title;
  final List<ConversationEntity> conversations;
  final void Function(String conversationTitle) onTap;

  const ConversationComponent({
    super.key,
    required this.title,
    required this.conversations,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.titleColor,
              ),
        ),
        ...conversations.map(
          (e) => ListTile(
            horizontalTitleGap: 0,
            leading: const Icon(CupertinoIcons.collections),
            title: Text(e.title),
            onTap: () => onTap.call(e.title),
          ),
        ),
        Padding(
          padding: AppEdgeInsets.enormous
              .asEdgeInsetsSymmetric(horizontal: true, vertical: true),
          child: const Divider(color: AppColors.titleColor),
        ),
      ],
    );
  }
}
