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
  required Future<T> Function(MediaServerAdapter adapter) request,
}) async {
  final adapter = ref.read(mediaServerAdapterProvider(session.server.type));
  try {
    return await request(adapter);
  } on DioException catch (error) {
    if (_isUnauthorized(error)) {
      await ref
          .read(serverControllerProvider.notifier)
          .clearCredentials(session.server.id);
    }
    rethrow;
  }
}

bool _isUnauthorized(DioException error) {
  final statusCode = error.response?.statusCode;
  return statusCode == 401 || statusCode == 403;
}
