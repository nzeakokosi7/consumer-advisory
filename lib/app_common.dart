import 'dart:async';

import 'package:consumable_advisory/app.dart';
import 'package:consumable_advisory/config/app_logger.dart';
import 'package:consumable_advisory/config/providers.dart' as providers;
import 'package:consumable_advisory/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Environment globalEnvironment = Environment.dev;

Future<void> mainCommon(Environment environment) async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    //load environment variables from .env
    // await dotenv.load();

    globalEnvironment = environment;

    final container = ProviderContainer(
      overrides: [],
      observers: [if (environment == Environment.dev) _Logger()],
    );
    await providers.initializeProviders(container);

    runApp(
      MainApp(
        isDebug: environment == Environment.dev,
        providerContainer: container,
      ),
    );
  }, (exception, stackTrace) async {
    AppLogger.log(stackTrace.toString(), longMessage: true);
  });
}

class _Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    AppLogger.log(
      '''
      {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue"
      }''',
    );
  }
}
