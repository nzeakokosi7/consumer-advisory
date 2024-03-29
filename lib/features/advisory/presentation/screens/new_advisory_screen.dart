import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/loading_dots.dart';
import 'package:consumable_advisory/config/common/components/navigation_button.dart';
import 'package:consumable_advisory/config/common/components/text_field.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/message_component.dart';
import 'package:consumable_advisory/features/advisory/presentation/controllers/advisory_controller.dart';
import 'package:consumable_advisory/features/advisory/presentation/controllers/user_prompt_controller.dart';
import 'package:consumable_advisory/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewAdvisoryScreen extends ConsumerWidget {
  static const route = '/new-advisory';

  final String imagePath;

  const NewAdvisoryScreen({required this.imagePath});

  AppBar _appBar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: 0,
      title: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.titleColor,
            ),
      ),
      leading: NavigationButton(
        onTap: () => context.go(HomeScreen.route),
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
    final double screenHeight = MediaQuery.of(context).size.height;

    ref.listen(advisoryControllerProvider, (previous, next) {
      next.maybeWhen(
        orElse: () {},
        postInitial: () {
          ref
              .read(advisoryControllerProvider.notifier)
              .initialize(context: context, imagePath: imagePath);
        },
      );
    });

    ref.listen(userPromptControllerProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        errorSendingUserPrompt: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
    });

    final title = ref
        .watch(advisoryControllerProvider.notifier)
        .productTitleController
        .text
        .trim();
    final userPromptController =
        ref.watch(userPromptControllerProvider.notifier).promptController;
    ref.watch(advisoryControllerProvider);

    final controller =
        ref.watch(userPromptControllerProvider.notifier).controller;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.jumpTo(controller.position.maxScrollExtent);
      }
    });

    return Scaffold(
      appBar: _appBar(context, title),
      body: Padding(
        padding: AppEdgeInsets.huge.asEdgeInsetsSymmetric(horizontal: true),
        child: Consumer(
          builder: (context, ref, _) {
            final advisoryController = ref.watch(advisoryControllerProvider);
            return advisoryController.maybeWhen(
              orElse: () => _loadingChild,
              error: (errorMessage) =>
                  Center(child: Text('Error: $errorMessage')),
              finalized: (productTitle) {
                final stream = ref.watch(messageStreamProvider(productTitle));
                return stream.when(
                  data: (messages) {
                    return SizedBox(
                      height: screenHeight,
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: AppEdgeInsets.enormous.asEdgeInsetsOnly(bottom: true),
                              child: Scrollbar(
                                controller: controller,
                                thumbVisibility: true,
                                child: Padding(
                                  padding: AppEdgeInsets.enormous.asEdgeInsetsOnly(end: true),
                                  child: ListView.builder(
                                    controller: controller,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      return MessageComponent(
                                        isInitial: index == 0,
                                        conversationEntity: messages[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: AppEdgeInsets.enormous
                                .asEdgeInsetsOnly(bottom: true),
                            height: 100,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppTextField(
                                      borderColor: AppColors.appGrey,
                                      controller: userPromptController,
                                    ),
                                  ),
                                  ref
                                      .watch(userPromptControllerProvider)
                                      .maybeWhen(
                                        orElse: () => SizedBox(
                                          width: 30,
                                          height: 50,
                                          child: IconButton(
                                            onPressed: () => ref
                                                .read(
                                                    userPromptControllerProvider
                                                        .notifier,)
                                                .sendPrompt(
                                                    conversationTitle:
                                                        productTitle,),
                                            icon:
                                                const Icon(Icons.send_outlined),
                                          ),
                                        ),
                                        sendingUserPrompt: () => Container(
                                          width: 15,
                                          height: 15,
                                          margin: AppEdgeInsets.normal
                                              .asEdgeInsetsOnly(start: true),
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.blue,
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  loading: () => _loadingChild,
                  error: (error, stackTrace) =>
                      Center(child: Text('Error: $error')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
