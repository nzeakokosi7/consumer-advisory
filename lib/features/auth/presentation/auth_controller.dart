import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/config/providers.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/bio_password_field.dart';
import 'package:consumable_advisory/features/auth/data/auth_repository_impl.dart';
import 'package:consumable_advisory/features/auth/domain/entities/authentication_state.dart';
import 'package:consumable_advisory/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthenticationState> {
  final AuthRepository _authRepository;
  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final PasswordFieldController passwordController;

  AuthController(
    this._authRepository, {
    required this.emailController,
    required this.passwordController,
    required this.fullNameController,
  }) : super(const AuthenticationState.initial());

  // late final TextEditingController emailController = TextEditingController();
  // late final passwordController = PasswordFieldController();

  Future<void> login() async {
    state = const AuthenticationState.loading();
    debugPrint(emailController.text);
    final response = await _authRepository.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.password,
    );
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (res) => const AuthenticationState.authenticated(),
    );
    if (state == const AuthenticationState.authenticated()) {
      authStateListenable.value = true;
    }
  }

  Future<void> signUp() async {
    state = const AuthenticationState.loading();
    AppLogger.log(emailController.text + passwordController.password);
    final response = await _authRepository.signUpWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.password,
    );
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (res) => const AuthenticationState.authenticated(),
    );
  }

  Future<void> continueWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _authRepository.signInWithGoogle();
    state = response.fold(
          (error) => AuthenticationState.unauthenticated(message: error),
          (response) => const AuthenticationState.authenticated(),
    );
  }


}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthenticationState>(
        (ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final emailController = ref.watch(emailTextController);
  final fullNameController = ref.watch(fullNameTextController);
  final passwordTextController = ref.watch(passwordFieldController.notifier);
  return AuthController(
    authRepository,
    emailController: emailController,
    fullNameController: fullNameController,
    passwordController: passwordTextController,
  );
});

final emailTextController = Provider((ref) => TextEditingController());
final fullNameTextController = Provider((ref) => TextEditingController());
