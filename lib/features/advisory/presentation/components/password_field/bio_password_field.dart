import 'dart:async';

import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/constants/border_radius.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/password_field_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'password_field_controller.dart';

part 'single_password_check.dart';

class BioPasswordFieldComponent extends ConsumerWidget {
  final PasswordFieldController controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool isEnabled;
  final bool showPasswordChecks;

  // final BiometricType? biometricType;
  final FutureOr<void> Function()? bioOnTap;
  final bool isNewPassword;
  final Color enabledColor;
  final Color focusedColor;
  final String hint;

  const BioPasswordFieldComponent({
    super.key,
    this.focusNode,
    this.autofocus = true,
    this.isEnabled = true,
    required this.controller,
    this.showPasswordChecks = false,
    // this.biometricType,
    this.bioOnTap,
    required this.enabledColor,
    required this.focusedColor,
    required this.isNewPassword,
    required this.hint,
  });

  Widget _suffix(BuildContext context, WidgetRef ref) {
    return IconButton(
      color: AppColors.appBlack,
      splashRadius: 24,
      onPressed: ref.watch(passwordFieldController.notifier).changeVisibility,
      icon: ref.watch(passwordFieldController).isPasswordVisible
          ? const Icon(CupertinoIcons.eye_slash, color: Colors.grey)
          : const Icon(CupertinoIcons.eye, color: Colors.grey),
    );
    // }
  }

  Widget _passwordField(BuildContext context, WidgetRef ref) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      borderRadius: AppBorderRadius.big.asBorderRadius(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppBorderRadius.micro,
        ),
        child: AutofillGroup(
          child: Row(
            children: [
              SizedBox.fromSize(
                size: Size.zero,
                child: Opacity(
                  opacity: 0,
                  child: EditableText(
                    style: const TextStyle(),
                    cursorColor: Colors.transparent,
                    controller: controller._emailController,
                    focusNode: FocusNode(skipTraversal: true),
                    backgroundCursorColor: Colors.transparent,
                    autofillHints: const [AutofillHints.username],
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  enabled: isEnabled,
                  autofocus: autofocus,
                  focusNode: focusNode,
                  style: const TextStyle(height: 1.2),
                  keyboardAppearance: Brightness.dark,
                  key: const ValueKey(#bio_password_field),
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: [
                    if (isNewPassword)
                      AutofillHints.newPassword
                    else
                      AutofillHints.password,
                  ],
                  controller: ref
                      .watch(passwordFieldController.notifier)
                      ._textController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: enabledColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: focusedColor),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    hintText: hint,
                    suffixIcon: _suffix(context, ref),
                  ),
                  obscureText:
                      !ref.watch(passwordFieldController).isPasswordVisible,
                ),
              ),
              // _suffix(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordChecks(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: AppEdgeInsets.enormous,
      children: [
        _SinglePasswordCheck(
          text: "Uppercase          ",
          isEnable: ref.watch(passwordFieldController).hasCapLetter,
        ),
        _SinglePasswordCheck(
          text: "Lowercase",
          isEnable: ref.watch(passwordFieldController).hasLowerLetter,
        ),
        _SinglePasswordCheck(
          text: "Special character",
          isEnable: ref.watch(passwordFieldController).hasSpecialCharacter,
        ),
        _SinglePasswordCheck(
          text: "Number",
          isEnable: ref.watch(passwordFieldController).hasNumber,
        ),
        _SinglePasswordCheck(
          text: "At least 8 characters",
          isEnable: ref.watch(passwordFieldController).minEightChar,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(passwordFieldController);

    return Consumer(
      builder: (context, ref, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _passwordField(context, ref),
            if (showPasswordChecks) ...[
              const SizedBox(height: AppEdgeInsets.normal),
              _passwordChecks(context, ref),
            ],
          ],
        );
      },
    );
    // return ChangeNotifierProvider.value(
    //   value: controller,
    //   builder: (context, _) {
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         _passwordField(context),
    //         if (showPasswordChecks) ...[
    //           const SizedBox(height: MMEdgeInsets.normal),
    //           _passwordChecks(context, ref),
    //         ],
    //       ],
    //     );
    //   },
    // );
  }
}
