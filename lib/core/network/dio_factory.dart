import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logging/app_logger.dart';

final dioProvider = Provider<Dio>((ref) {
  final logger = AppLogger('dio');
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: const {'Accept': 'application/json', 'X-Emby-Client': 'Flumby'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        logger.warning(
          'HTTP ${error.requestOptions.method} ${error.requestOptions.uri} failed',
          error.error ?? error.message,
          error.stackTrace,
        );
        handler.next(error);
      },
    ),
  );

  return dio;
});
