import 'dart:io';

import 'package:avatars/avatars.dart';
import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/components/navigation_button.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/config/providers.dart';
import 'package:consumable_advisory/features/auth/presentation/screens/main_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  static const route = '/setting';

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appBackground,
      elevation: 0,
      title: Text(
        "Setting",
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
    final currentUser = ref.watch(firebaseAuthProvider).currentUser!;

    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppEdgeInsets.enormous,
          left: AppEdgeInsets.dolphin,
        ),
        child: ListView(
          children: [
            Text(
              "Account",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
            ),
            const SizedBox(height: AppEdgeInsets.great),
            Row(
              children: [
                if (currentUser.photoURL != null)
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        currentUser.photoURL!,
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: Avatar(
                      name: currentUser.displayName ?? currentUser.email!.split("@")[0].toUpperCase(),
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appBackground,
                      ),
                      placeholderColors: const [AppColors.titleColor],
                    ),
                  ),
                const SizedBox(width: AppEdgeInsets.great),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.titleColor,
                          ),
                    ),
                    Text(
                      currentUser.email!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.subTitleColor,
                          ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: AppEdgeInsets.elephant),
            Text(
              "App",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
            ),
            const SizedBox(height: AppEdgeInsets.great),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mic),
                ],
              ),
              title: Text(
                "Preferred Language",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.titleColor,
                    ),
              ),
              subtitle: Text(
                "Auto detect",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTitleColor,
                    ),
              ),
            ),
            const SizedBox(height: AppEdgeInsets.elephant),
            Text(
              "About",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue,
                  ),
            ),
            const SizedBox(height: AppEdgeInsets.great),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: AppColors.appGreen,
                radius: 20,
              ),
              title: Text(
                "Consumer Advisory for ${Platform.operatingSystem.toUpperCase()}",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.titleColor,
                    ),
              ),
              subtitle: Text(
                "1.000",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.subTitleColor,
                    ),
              ),
            ),
            const SizedBox(height: AppEdgeInsets.elephant),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                "Sign Out",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
              onTap: () async {
                await ref.read(firebaseAuthProvider).signOut();
                if(context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Signed out'),
                      behavior: SnackBarBehavior.fixed,
                    ),
                  );
                  context.go(MainAuthScreen.route);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
