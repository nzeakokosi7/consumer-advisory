import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/elevated_button.dart';
import 'package:consumable_advisory/config/common/components/navigation_button.dart';
import 'package:consumable_advisory/config/common/components/text_field.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/bio_password_field.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/password_field.dart';
import 'package:consumable_advisory/features/auth/presentation/auth_controller.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:consumable_advisory/features/home/presentation/screens/home_screen.dart';
import 'package:consumable_advisory/features/on_boarding/on_boarding_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  static const route = '/login';

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: 0,
      title: Text(
        "Login",
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
    final passwordController = ref.watch(authControllerProvider.notifier).passwordController;
    final emailController = ref.watch(authControllerProvider.notifier).emailController;

    ref.listen(authControllerProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: () {
          // Navigate to any screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Authenticated'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.go(HomeScreen.route);
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
                    hint: "Email",
                    hintStyle: TextStyle(color: Colors.grey.shade700),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value)=> ref.refresh(authControllerProvider),
                  ),
                  const SizedBox(height: 30),
                  PasswordFieldComponent(
                    hint: "Password",
                    showPasswordChecks: false,
                    controller: passwordController,
                    isNewPassword: false,
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
                    isDisabled: !(ref.watch(passwordFieldController).isPasswordValid && EmailValidator.validate(ref.watch(emailTextController).text.trim())),
                    title: "Sign In",
                    titleStyle: const TextStyle(
                      color: AppColors.appBlack,
                      fontSize: 18,
                    ),
                    loading: ref.watch(authControllerProvider).maybeWhen(
                      orElse: () => false,
                      loading: () => true,
                    ),
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).login(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () => context.push(SignUpScreen.route),
                        child: const Text('Sign Up'),
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
