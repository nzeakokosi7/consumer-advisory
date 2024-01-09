import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/elevated_button.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/home/presentation/home_screen.dart';
import 'package:consumable_advisory/features/on_boarding/on_boarding_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  static const route = '/on_boarding';
  final String? fullName;

  const OnboardingScreen({this.fullName});

  void initialize(WidgetRef ref) {
    Future.delayed(Duration.zero, () {
      ref
          .read(onboardingControllerProvider.notifier)
          .initialize(fullName: fullName);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initialize(ref);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: AppEdgeInsets.huge,
            right: AppEdgeInsets.huge,
            top: AppEdgeInsets.elephant,
            bottom: AppEdgeInsets.enormous,),
        child: Column(
          children: [
            Text(
              "Welcome to Consumer Advisory",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppColors.titleColor,
                  ),
            ),
            const SizedBox(height: AppEdgeInsets.huge),
            Text(
              "This app is still in its early experiemental stages, its services aren't based off any professional expert opinion, "
              "and as such, is prone to errors.",
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.titleColor,
                  ),
            ),
            const SizedBox(height: AppEdgeInsets.huge),
            Padding(
              padding: AppEdgeInsets.huge.asEdgeInsetsOnly(start: true),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: Padding(
                      padding:
                          AppEdgeInsets.normal.asEdgeInsetsOnly(bottom: true),
                      child: Text(
                        "Don't share sensitive information",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                            ),
                      ),
                    ),
                    subtitle: Text(
                      "The services of this app is based off third party AI services. Who's AI trainers review its chats for system improvements.",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppEdgeInsets.normal),
                  ListTile(
                    leading: const Icon(CupertinoIcons.wand_rays_inverse),
                    title: Padding(
                      padding:
                          AppEdgeInsets.normal.asEdgeInsetsOnly(bottom: true),
                      child: Text(
                        "Easy to Use",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                            ),
                      ),
                    ),
                    subtitle: Text(
                      "Simply snap or upload an image and allow us extract relevant texts for the AI. \n\n"
                      "The camera has on screen guide to ensure you keep relevant texts in view.",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                    ),
                  ),
                  const SizedBox(height: AppEdgeInsets.normal),
                  ListTile(
                    leading: const Icon(CupertinoIcons.settings),
                    title: Padding(
                      padding:
                          AppEdgeInsets.normal.asEdgeInsetsOnly(bottom: true),
                      child: Text(
                        "Control your chat history",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                            ),
                      ),
                    ),
                    subtitle: Text(
                      "You can easily clear your chat history from our systems.",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.titleColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    isDisabled: ref.watch(onboardingControllerProvider),
                    loading: ref.watch(onboardingControllerProvider),
                    onPressed: () => context.go(HomeScreen.route),
                    shape: const StadiumBorder(
                      side: BorderSide(),
                    ),
                    backgroundColor: AppColors.appBackground,
                    title: "Proceed",
                    titleStyle: const TextStyle(
                      color: AppColors.appBlack,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: AppEdgeInsets.normal),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
