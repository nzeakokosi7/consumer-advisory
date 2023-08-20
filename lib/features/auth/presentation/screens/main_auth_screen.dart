import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/elevated_button.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/auth/presentation/auth_controller.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/login_screen.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:consumable_advisory/features/on_boarding/on_boarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainAuthScreen extends ConsumerWidget {
  static const route = '/auth';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(authControllerProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User Authenticated"),
              behavior: SnackBarBehavior.fixed,
            ),
          );
          context.go(OnboardingScreen.route);
        },
        unauthenticated: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message!),
                behavior: SnackBarBehavior.fixed,
              ),
            ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.subTitleColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.subTitleColor,
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text(
                'Consumable Product Advisory',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 250,
                padding: AppEdgeInsets.enormous
                    .asEdgeInsetsSymmetric(horizontal: true, vertical: true),
                decoration: const BoxDecoration(
                  color: AppColors.appBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppEdgeInsets.elephant),
                    topRight: Radius.circular(AppEdgeInsets.elephant),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      shape: const StadiumBorder(),
                      isDisabled: false,
                      loading: ref.watch(authControllerProvider).maybeWhen(
                            orElse: () => false,
                            loading: () => true,
                          ),
                      onPressed: ()=> ref.read(authControllerProvider.notifier).continueWithGoogle(),
                      backgroundColor: AppColors.appBlack,
                      icon: Image.asset(
                        "assets/google_icon.png",
                        fit: BoxFit.cover,
                      ),
                      title: "Continue with Google",
                    ),
                    // const SizedBox(height: AppEdgeInsets.huge),
                    // const AppButton(
                    //   shape: StadiumBorder(),
                    //   isDisabled: false,
                    //   backgroundColor: Colors.grey,
                    //   icon: Icon(Icons.apple),
                    //   title: "Continue with Apple",
                    // ),
                    const SizedBox(height: AppEdgeInsets.huge),
                    AppButton(
                      shape: const StadiumBorder(),
                      onPressed: () => context.push(SignUpScreen.route),
                      isDisabled: false,
                      backgroundColor: Colors.grey.shade400,
                      icon: const Icon(Icons.mail_outline),
                      title: "Sign up with Email",
                    ),
                    const SizedBox(height: AppEdgeInsets.huge),
                    AppButton(
                      shape: const StadiumBorder(
                        side: BorderSide(),
                      ),
                      onPressed: () => context.push(LoginScreen.route),
                      isDisabled: false,
                      backgroundColor: AppColors.appBackground,
                      title: "Login",
                      titleStyle: const TextStyle(
                        color: AppColors.appBlack,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
