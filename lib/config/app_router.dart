import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/config/providers.dart';
import 'package:consumable_advisory/features/advisory/presentation/screens/advisory_screen.dart';
import 'package:consumable_advisory/features/advisory/presentation/screens/conversation_history_screen.dart';
import 'package:consumable_advisory/features/advisory/presentation/screens/new_advisory_screen.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/login_screen.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/main_auth_screen.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:consumable_advisory/features/home/presentation/home_screen.dart';
import 'package:consumable_advisory/features/on_boarding/on_boarding_screen.dart';
import 'package:consumable_advisory/features/settings/settings_screen.dart';
import 'package:consumable_advisory/features/splash/splash_screen.dart';
import 'package:consumable_advisory/features/text_detection/presentation/screens/text_detection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    routes: _routes,
    initialLocation: SplashScreen.route,
    errorPageBuilder: _errorPageBuilder,
    redirect: (BuildContext context, GoRouterState state) {
      final loggedIn = FirebaseAuth.instance.currentUser != null;
      if (!loggedIn &&
          state.uri.toString() != SignUpScreen.route &&
          state.uri.toString() != LoginScreen.route) {
        AppLogger.log(state.uri.toString() + loggedIn.toString());
        return MainAuthScreen.route;
      } else {
        return state.path;
      }
    },
    refreshListenable: authStateListenable,
    debugLogDiagnostics: true,
  );

  static Page<dynamic> _errorPageBuilder(
      BuildContext context, GoRouterState state,) {
    AppLogger.log(state.error);
    return MaterialPage<SplashScreen>(
      key: state.pageKey,
      child: SplashScreen(),
    );
  }

  // the routes when the user is logged in
  static final _routes = <RouteBase>[
    GoRoute(
      path: SplashScreen.route,
      pageBuilder: (context, state) => MaterialPage<SplashScreen>(
        key: state.pageKey,
        child: SplashScreen(),
      ),
    ),
    GoRoute(
      path: MainAuthScreen.route,
      pageBuilder: (context, state) => MaterialPage<MainAuthScreen>(
        key: state.pageKey,
        child: MainAuthScreen(),
      ),
    ),
    GoRoute(
      path: LoginScreen.route,
      pageBuilder: (context, state) => MaterialPage<LoginScreen>(
        key: state.pageKey,
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      path: SignUpScreen.route,
      pageBuilder: (context, state) => MaterialPage<SignUpScreen>(
        key: state.pageKey,
        child: SignUpScreen(),
      ),
    ),
    GoRoute(
      path: HomeScreen.route,
      pageBuilder: (context, state) => MaterialPage<HomeScreen>(
        key: state.pageKey,
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: TextRecognizerView.route,
      pageBuilder: (context, state) => MaterialPage<TextRecognizerView>(
        key: state.pageKey,
        child: TextRecognizerView(),
      ),
    ),
    GoRoute(
      path: NewAdvisoryScreen.route,
      pageBuilder: (context, state) => MaterialPage<NewAdvisoryScreen>(
        key: state.pageKey,
        child: NewAdvisoryScreen(imagePath: state.extra! as String),
      ),
    ),
    GoRoute(
      path: ConversationHistoryScreen.route,
      pageBuilder: (context, state) => MaterialPage<ConversationHistoryScreen>(
        key: state.pageKey,
        child: ConversationHistoryScreen(),
      ),
    ),
    GoRoute(
      path: AdvisoryScreen.route,
      pageBuilder: (context, state) => MaterialPage<AdvisoryScreen>(
        key: state.pageKey,
        child: AdvisoryScreen(conversationTitle: state.extra! as String),
      ),
    ),
    GoRoute(
      path: OnboardingScreen.route,
      pageBuilder: (context, state) => MaterialPage<OnboardingScreen>(
        key: state.pageKey,
        child: OnboardingScreen(fullName: state.extra as String?),
      ),
    ),
    GoRoute(
      path: SettingsScreen.route,
      pageBuilder: (context, state) => MaterialPage<SettingsScreen>(
        key: state.pageKey,
        child: SettingsScreen(),
      ),
    )
  ];
}
