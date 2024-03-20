import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/elevated_button.dart';
import 'package:consumable_advisory/config/common/components/navigation_button.dart';
import 'package:consumable_advisory/config/common/components/text_field.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/bio_password_field.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/password_field.dart';
import 'package:consumable_advisory/features/auth/presentation/auth_controller.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/login_screen.dart';
import 'package:consumable_advisory/features/on_boarding/on_boarding_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerWidget {
  static const route = '/sign_up';

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: 0,
      title: Text(
        "Sign Up",
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController =
        ref.watch(authControllerProvider.notifier).passwordController;
    final emailController =
        ref.watch(authControllerProvider.notifier).emailController;
    final fullNameController =
        ref.watch(authControllerProvider.notifier).fullNameController;

    ref.listen(authControllerProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: () {
          // Navigate to any screen
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text("User Authenticated"),
          //     behavior: SnackBarBehavior.floating,
          //   ),
          // );
          context.go(OnboardingScreen.route,
              extra: fullNameController.text.trim(),);
        },
        unauthenticated: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
    });

    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: AppEdgeInsets.huge.asEdgeInsets(),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  AppTextField(
                    borderColor: Colors.grey,
                    autofocus: true,
                    hint: "Full name",
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    controller: fullNameController,
                    onChanged: (value) => ref.refresh(authControllerProvider),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 15),
                  AppTextField(
                    borderColor: Colors.grey,
                    hint: "Email",
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    controller: emailController,
                    onChanged: (value) => ref.refresh(authControllerProvider),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),
                  PasswordFieldComponent(
                    hint: "Password",
                    showPasswordChecks: true,
                    controller: passwordController,
                    isNewPassword: true,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    shape: const StadiumBorder(
                      side: BorderSide(),
                    ),
                    loaderColor: AppColors.appBlack,
                    backgroundColor: AppColors.appBackground,
                    isDisabled:
                        !(ref.watch(passwordFieldController).isPasswordValid &&
                            fullNameController.text.trim().isNotEmpty &&
                            EmailValidator.validate(
                                ref.watch(emailTextController).text.trim(),)),
                    title: 'Sign Up',
                    titleStyle: const TextStyle(
                      color: AppColors.appBlack,
                      fontSize: 18,
                    ),
                    loading: ref.watch(authControllerProvider).maybeWhen(
                          orElse: () => false,
                          loading: () => true,
                        ),
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).signUp(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have account? "),
                      TextButton(
                        onPressed: () => context.push(LoginScreen.route),
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
