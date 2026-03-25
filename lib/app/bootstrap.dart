import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/logging/app_logger.dart';
import 'flumby_app.dart';

void bootstrap() {
  final logger = AppLogger('bootstrap');

  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        logger.severe(
          'Unhandled Flutter error',
          details.exception,
          details.stack,
        );
        FlutterError.presentError(details);
      };

      runApp(const ProviderScope(child: FlumbyApp()));
    },
    (error, stackTrace) {
      logger.severe('Unhandled zone error', error, stackTrace);
    },
  );
}
