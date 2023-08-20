import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainApp extends StatelessWidget {
  final bool isDebug;
  final ProviderContainer providerContainer;

  const MainApp({
    super.key,
    this.isDebug = true,
    required this.providerContainer,
  });

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: providerContainer,
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        title: 'Product Advisory',
        theme: ThemeData(
          fontFamily: 'Inter',
          scaffoldBackgroundColor: AppColors.appBackground,
        ),
      ),
    );
  }
}
