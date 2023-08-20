import 'package:flutter/rendering.dart';

abstract class AppEdgeInsets {
  static const zero = 0.0;
  static const nano = 1.0;
  static const micro = 2.0;
  static const tiny = 4.0;
  static const small = 6.0;
  static const normal = 8.0;
  static const big = 12.0;
  static const large = 14.0;
  static const huge = 16.0;
  static const great = 18.0;
  static const enormous = 20.0;
  static const dolphin = 28.0;
  static const elephant = 32.0;
  static const seaLion = 40.0;
  static const orca = 60.0;
  static const whale = 76.0;
  static const blueWhale = 100.0;
}

extension DoubleEdgeInsets on double {
  EdgeInsetsGeometry asEdgeInsets() {
    return EdgeInsets.all(this);
  }

  EdgeInsetsGeometry asEdgeInsetsSymmetric({
    bool vertical = false,
    bool horizontal = false,
  }) {
    return EdgeInsets.symmetric(
      vertical: vertical ? this : 0,
      horizontal: horizontal ? this : 0,
    );
  }

  EdgeInsets asEdgeInsetsVertical({
    bool top = false,
    bool bottom = false,
  }) {
    return EdgeInsets.only(
      top: top ? this : 0,
      bottom: bottom ? this : 0,
    );
  }

  EdgeInsetsGeometry asEdgeInsetsOnly({
    bool top = false,
    bool end = false,
    bool start = false,
    bool bottom = false,
  }) {
    return EdgeInsetsDirectional.only(
      top: top ? this : 0,
      end: end ? this : 0,
      start: start ? this : 0,
      bottom: bottom ? this : 0,
    );
  }
}