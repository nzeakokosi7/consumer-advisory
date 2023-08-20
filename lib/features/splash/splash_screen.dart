import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/features/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static const route = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(splashControllerProvider).goHome(context);
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              'Consumable Product Advisory',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.titleColor, fontSize: 30),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Text(
                "KO (C) ${DateTime.now().year} All Rights Reserved.",
                style:
                const TextStyle(color: AppColors.appGrey, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
