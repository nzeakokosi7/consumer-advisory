import 'package:consumable_advisory/config/app_colors.dart';
import 'package:consumable_advisory/config/common/constants/border_radius.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final bool hasError;
  final bool enabled;
  final String? hint;
  final String? label;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool autocorrect;
  final String? errorLabel;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  // final MMIcons? mmPrefixIcon;
  final Color? mmPrefixIconColor;
  final Curve errorAnimationCurve;
  final TextStyle? hintStyle;
  final TextFieldType textFieldType;
  final TextInputType? keyboardType;
  final Duration errorAnimationDuration;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Color? textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final TextCapitalization textCapitalization;
  final Iterable<String>? autofillHints;
  final int? characterLength;

  const AppTextField({
    super.key,
    this.hint,
    this.label,
    this.onTap,
    this.focusNode,
    this.onChanged,
    this.controller,
    this.errorLabel,
    this.prefixWidget,
    // this.mmPrefixIcon,
    this.suffixWidget,
    this.keyboardType,
    this.enabled = true,
    this.inputFormatters,
    this.mmPrefixIconColor,
    this.hasError = false,
    this.autofocus = false,
    this.autocorrect = false,
    this.hintStyle,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.textFieldType = TextFieldType.normal,
    this.errorAnimationCurve = Curves.easeInOut,
    this.errorAnimationDuration = const Duration(milliseconds: 300),
    this.textColor,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.characterLength,
  });
  // : assert(
  //     prefixWidget == null || mmPrefixIcon == null,
  //     "Can't have both [prefixIcon] and [dariaPrefixIcon]",
  //   );

  Widget? get _prefixIcon {
    final prefixIcon = prefixWidget;
    // final mmPrefixIcon = this.mmPrefixIcon;

    final Widget icon;
    if (prefixIcon != null) {
      icon = prefixIcon;
      // } else if (mmPrefixIcon != null) {
      //   icon = MMIcon(
      //     mmPrefixIcon,
      //     size: MMIconRadius.small,
      //     color: mmPrefixIconColor,
      //   );
    } else {
      return null;
    }
    return Align(
      alignment: const Alignment(.6, 0),
      child: icon,
    );
  }

  Color get errorColor {
    switch (textFieldType) {
      case TextFieldType.normal:
      case TextFieldType.lighter:
        return Colors.red;
      case TextFieldType.special:
        return Colors.red;
    }
  }

  RoundedRectangleBorder get errorBorder {
    return RoundedRectangleBorder(
      side: BorderSide(color: errorColor),
      borderRadius: AppBorderRadius.normal.asBorderRadius(),
    );
  }

  ShapeBorder get border {
    if (hasError) {
      return errorBorder;
    } else {
      return RoundedRectangleBorder(
        side: BorderSide(color: borderColor ?? Colors.grey.withOpacity(.1)),
        borderRadius: AppBorderRadius.tiny.asBorderRadius(),
      );
    }
  }

  TextStyle get labelStyle {
    return const TextStyle(
      height: 1.2,
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: AppColors.textFieldLabelColor,
    );
  }

  TextStyle get _hintStyle {
    if (hintStyle != null) return hintStyle!;
    return labelStyle;
  }

  TextStyle get floatingLabelStyle {
    final Color textFieldFloatingLabelColor;
    switch (textFieldType) {
      case TextFieldType.normal:
      case TextFieldType.lighter:
        textFieldFloatingLabelColor = AppColors.textFieldFloatingLabelColor;
      case TextFieldType.special:
        textFieldFloatingLabelColor =
            AppColors.textFieldSpecialFloatingLabelColor;
    }
    return TextStyle(
      height: 1.2,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: textFieldFloatingLabelColor,
    );
  }

  TextStyle get textStyle {
    final Color textFieldTextColor;
    switch (textFieldType) {
      case TextFieldType.normal:
      case TextFieldType.lighter:
        textFieldTextColor = AppColors.textFieldTextColor;
      case TextFieldType.special:
        textFieldTextColor = AppColors.textFieldSpecialTextColor;
    }
    return TextStyle(
      height: 1.2,
      fontSize: 16,
      color: textColor ?? textFieldTextColor,
      fontWeight: FontWeight.normal,
    );
  }

  bool get hasErrorLabel => hasError && errorLabel != null;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (errorLabel != null)
          Positioned(
            left: 18,
            bottom: 0,
            child: Text(
              errorLabel!,
              style: TextStyle(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        AnimatedPadding(
          curve: errorAnimationCurve,
          duration: errorAnimationDuration,
          padding: hasErrorLabel
              ? AppEdgeInsets.enormous.asEdgeInsetsOnly(bottom: true)
              : AppEdgeInsets.zero.asEdgeInsets(),
          child: Material(
            shape: border,
            color: backgroundColor,
            clipBehavior: Clip.hardEdge,
            animationDuration: errorAnimationDuration,
            child: TextField(
              cursorWidth: 1,
              cursorHeight: 21,
              style: textStyle,
              enabled: enabled,
              autofocus: autofocus,
              textAlign: textAlign,
              focusNode: focusNode,
              onChanged: onChanged,
              controller: controller,
              textInputAction: textInputAction,
              autocorrect: autocorrect,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              keyboardAppearance: Brightness.dark,
              textCapitalization: textCapitalization,
              autofillHints: autofillHints,
              onTap: onTap,
              maxLength: characterLength,
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                labelText: label,
                hintStyle: _hintStyle,
                labelStyle: labelStyle,
                border: InputBorder.none,
                floatingLabelStyle: floatingLabelStyle,
                counterText: "",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppEdgeInsets.enormous,
                  vertical: label == null
                      ? AppEdgeInsets.enormous
                      : AppEdgeInsets.big,
                )..add(
                    EdgeInsetsDirectional.only(
                      end: suffixWidget != null ? 60 : 0,
                    ),
                  ),
                prefixIconConstraints: const BoxConstraints.tightFor(
                  width: 42,
                  height: 20,
                ),
                prefixIcon: _prefixIcon,
              ),
            ),
          ),
        ),
        if (suffixWidget != null)
          PositionedDirectional(
            end: 0,
            top: 0,
            width: 60,
            height: 60,
            child: suffixWidget!,
          ),
      ],
    );
  }
}

enum TextFieldType { normal, lighter, special }
