import 'package:flutter/rendering.dart';

abstract class AppBorderRadius {
  static const zero = 0.0;
  static const nano = 2.0;
  static const micro = 4.0;
  static const midi = 3.0;
  static const tiny = 6.0;
  static const small = 8.0;
  static const normal = 10.0;
  static const medium = 12.0;
  static const big = 14.0;
  static const enormous = 20.0;
  static const elephant = 32.0;
}

extension DoubleBorderRadius on double {
  BorderRadius asBorderRadius() {
    return BorderRadius.all(Radius.circular(this));
  }

  BorderRadiusGeometry asBorderRadiusHorizontal({
    bool start = false,
    bool end = false,
  }) {
    return BorderRadiusDirectional.horizontal(
      start: start ? Radius.circular(this) : Radius.zero,
      end: end ? Radius.circular(this) : Radius.zero,
    );
  }

  BorderRadius asBorderRadiusVertical({
    bool top = false,
    bool bottom = false,
  }) {
    return BorderRadius.vertical(
      top: top ? Radius.circular(this) : Radius.zero,
      bottom: bottom ? Radius.circular(this) : Radius.zero,
    );
  }

  BorderRadiusGeometry asBorderRadiusOnly({
    bool topStart = false,
    bool topEnd = false,
    bool bottomStart = false,
    bool bottomEnd = false,
  }) {
    return BorderRadiusDirectional.only(
      topStart: topStart ? Radius.circular(this) : Radius.zero,
      topEnd: topEnd ? Radius.circular(this) : Radius.zero,
      bottomStart: bottomStart ? Radius.circular(this) : Radius.zero,
      bottomEnd: bottomEnd ? Radius.circular(this) : Radius.zero,
    );
  }
}