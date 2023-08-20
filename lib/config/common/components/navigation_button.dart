import 'package:consumable_advisory/config/common/constants/border_radius.dart';
import 'package:consumable_advisory/config/common/constants/edge_insets.dart';
import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final void Function()? onTap;
  final bool swap;
  final Widget? icon;

  const NavigationButton({
    super.key,
    required this.onTap,
    this.swap = false,
    this.icon,
  });

  Widget get _icon {
    if (icon != null) {
      return icon!;
    }
    return Icon(
      Icons.arrow_back,
      color: swap ? Colors.white : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppEdgeInsets.normal.asEdgeInsets(),
      child: Material(
        clipBehavior: Clip.hardEdge,
        borderRadius: AppBorderRadius.normal.asBorderRadius(),
        color: swap ? Colors.transparent : Colors.white,
        child: InkWell(onTap: onTap, child: _icon),
      ),
    );
  }
}
