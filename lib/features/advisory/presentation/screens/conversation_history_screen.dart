import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/loading_dots.dart';
import 'package:consumable_advisory/config/common/components/navigation_button.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/presentation/advisory_controller.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/conversation_component.dart';
import 'package:consumable_advisory/features/advisory/presentation/screens/advisory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConversationHistoryScreen extends ConsumerWidget {
  static const route = '/conversation-history';

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: 0,
      title: Text(
        "History",
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.titleColor,
            ),
      ),
      leading: NavigationButton(
        onTap: context.pop,
      ),
    );
  }

  Widget get _loadingChild {
    final Color dotColor;
    dotColor = Colors.blueAccent;
    return Center(child: AppLoadingDots(color: dotColor));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: AppEdgeInsets.huge.asEdgeInsetsSymmetric(horizontal: true),
        child: Consumer(
          builder: (context, ref, _) {
            final stream = ref.watch(conversationHistoryStream);
            return stream.when(
              data: (conversations) {
                return conversations.isNotEmpty
                    ? ListView(
                        children: conversations.entries
                            .map(
                              (e) => ConversationComponent(
                                title: e.key,
                                conversations: e.value,
                                onTap: (conversationTitle) => context.push(
                                    AdvisoryScreen.route,
                                    extra: conversationTitle),
                              ),
                            )
                            .toList(),
                      )
                    : const Center(
                        child:
                            Text("You are yet to intiate any consultations"),
                      );
              },
              loading: () => _loadingChild,
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            );
          },
        ),
      ),
    );
  }
}
