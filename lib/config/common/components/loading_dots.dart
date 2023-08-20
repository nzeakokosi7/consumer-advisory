import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoadingDots extends StatelessWidget {
  final Color color;

  const AppLoadingDots({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/dot_loading.json',
      frameRate: FrameRate.max,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(
            // we need to access sublayers to change the color.
            const ['形状图层 4', '椭圆 1', '填充 1'],
            value: color,
          ),
          ValueDelegate.color(
            // we need to access sublayers to change the color.
            const ['形状图层 2', '椭圆 1', '填充 1'],
            value: color,
          ),
          ValueDelegate.color(
            // we need to access sublayers to change the color.
            const ['形状图层 5', '椭圆 1', '填充 1'],
            value: color,
          ),
        ],
      ),
    );
  }
}
