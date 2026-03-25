import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AppLogger {
  AppLogger(String name) : _logger = Logger(name) {
    _configureRootLogger();
  }

  static bool _configured = false;

  final Logger _logger;

  void info(String message) => _logger.info(message);

  void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.warning(message, error, stackTrace);
  }

  void severe(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  static void _configureRootLogger() {
    if (_configured) {
      return;
    }

    hierarchicalLoggingEnabled = true;
    Logger.root.level = Level.INFO;
    Logger.root.onRecord.listen((record) {
      debugPrint(
        '[${record.level.name}] ${record.loggerName}: ${record.message}',
      );
      if (record.error != null) {
        debugPrint('  error: ${record.error}');
      }
      if (record.stackTrace != null) {
        debugPrint(record.stackTrace.toString());
      }
    });
    _configured = true;
  }
}
