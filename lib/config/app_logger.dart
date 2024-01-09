import 'dart:developer' as developer;

import 'package:consumable_advisory/app_common.dart';
import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();
  static final Logger _logger = Logger();

  static void log(
    dynamic message, {
    bool longMessage = false,
  }) {
    /// logger would only show logs in dev environment
    if (globalEnvironment != Environment.prod) {
      if (longMessage) {
        developer.log('$message');
      } else {
        _logger.i(message);
      }
    }
  }
}

enum Environment {
  dev,
  prod,
}
