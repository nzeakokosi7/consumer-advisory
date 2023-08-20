import 'package:consumable_advisory/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashController {

  Future<void> goHome(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1)).then((value) => context.go(HomeScreen.route));
  }
}

final splashControllerProvider = Provider((ref) => SplashController());
