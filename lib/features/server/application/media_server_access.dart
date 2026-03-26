import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/dio_factory.dart';
import '../data/emby_adapter.dart';
import '../domain/media_server_adapter.dart';
import '../domain/server_models.dart';
import 'server_controller.dart';

final mediaServerAdapterProvider =
    Provider.family<MediaServerAdapter, MediaServerType>((ref, serverType) {
      final dio = ref.watch(dioProvider);
      switch (serverType) {
        case MediaServerType.emby:
          return EmbyAdapter(dio);
        case MediaServerType.jellyfin:
          throw UnimplementedError(
            'Jellyfin adapter is reserved for a later phase.',
          );
      }
    });

Future<T> runProtectedServerCall<T>(
  Ref ref, {
  required MediaServerSession session,
  required Future<T> Function(
    MediaServerAdapter adapter,
    MediaServerSession session,
  )
  request,
  bool allowLineFailover = false,
}) async {
  final adapter = ref.read(mediaServerAdapterProvider(session.server.type));
  try {
    return await request(adapter, session);
  } on DioException catch (error) {
    if (_isUnauthorized(error)) {
      await ref
          .read(serverControllerProvider.notifier)
          .clearCredentials(session.line.id);
      rethrow;
    }
    if (allowLineFailover && _isFailoverCandidate(error)) {
      final fallbackSession = await ref
          .read(serverControllerProvider.notifier)
          .failoverFromLine(session.line.id);
      if (fallbackSession != null) {
        final fallbackAdapter = ref.read(
          mediaServerAdapterProvider(fallbackSession.server.type),
        );
        return request(fallbackAdapter, fallbackSession);
      }
    }
    rethrow;
  }
}

bool _isUnauthorized(DioException error) {
  final statusCode = error.response?.statusCode;
  return statusCode == 401 || statusCode == 403;
}

bool _isFailoverCandidate(DioException error) {
  final statusCode = error.response?.statusCode;
  if (statusCode != null && statusCode >= 500) {
    return true;
  }

  return switch (error.type) {
    DioExceptionType.connectionTimeout => true,
    DioExceptionType.sendTimeout => true,
    DioExceptionType.receiveTimeout => true,
    DioExceptionType.connectionError => true,
    DioExceptionType.badCertificate => true,
    _ => false,
  };
}
