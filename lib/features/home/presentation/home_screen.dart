import 'package:avatars/avatars.dart';
import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/config/providers.dart';
import 'package:consumable_advisory/features/advisory/presentation/screens/conversation_history_screen.dart';
import 'package:consumable_advisory/features/settings/settings_screen.dart';
import 'package:consumable_advisory/features/text_detection/presentation/screens/text_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  static const route = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.titleColor),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: FloatingActionButton(
          onPressed: () {
            // context.push(OnboardingScreen.route);
            context.push(TextRecognizerView.route);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class NavigationDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(firebaseAuthProvider).currentUser!;

    AppLogger.log(currentUser);
    return Drawer(
      elevation: 1,
      child: Container(
        margin: AppEdgeInsets.great.asEdgeInsetsOnly(top: true),
        padding: AppEdgeInsets.huge
            .asEdgeInsetsSymmetric(horizontal: true, vertical: true),
        child: Column(
          children: [
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
                      name: currentUser.displayName ??
                          currentUser.email!.split("@")[0].toUpperCase(),
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
                    if (currentUser.displayName != null)
                      Text(
                        currentUser.displayName!,
                      ),
                    Text(
                      currentUser.email!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(color: AppColors.titleColor),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(
                "New consultation",
              ),
              onTap: () => context.push(TextRecognizerView.route),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                "History",
              ),
              onTap: () => context.push(ConversationHistoryScreen.route),
            ),
            const Divider(color: AppColors.titleColor),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                "Setting",
              ),
              onTap: () => context.push(SettingsScreen.route),
            ),
          ],
        ),
      ),
    );
  }
}
