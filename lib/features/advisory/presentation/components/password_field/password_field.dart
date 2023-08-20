import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/features/advisory/presentation/components/password_field/bio_password_field.dart';
import 'package:flutter/material.dart';

class PasswordFieldComponent extends StatelessWidget {
  final PasswordFieldController controller;
  final bool autofocus;
  final bool isEnabled;
  final bool showPasswordChecks;
  final bool isNewPassword;
  final Color enabledColor;
  final Color focusedColor;
  final String hint;

  const PasswordFieldComponent({
    super.key,
    this.autofocus = true,
    this.isEnabled = true,
    this.enabledColor = Colors.grey,
    this.focusedColor = Colors.grey,
    this.hint = "Enter your password",
    required this.showPasswordChecks,
    required this.controller,
    required this.isNewPassword,
  });

  @override
  Widget build(BuildContext context) {
    return BioPasswordFieldComponent(
      controller: controller,
      autofocus: autofocus,
      isEnabled: isEnabled,
      hint: hint,
      showPasswordChecks: showPasswordChecks,
      isNewPassword: isNewPassword,
      enabledColor: enabledColor,
      focusedColor: focusedColor,
    );
  }
}
