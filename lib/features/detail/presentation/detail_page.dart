import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../../player/data/playback_state_repository.dart';
import '../../server/application/media_server_access.dart';
import '../../server/application/server_controller.dart';
import '../../server/domain/server_models.dart';
import '../domain/media_detail.dart';

final mediaDetailProvider = FutureProvider.autoDispose
    .family<MediaDetail, ({MediaServerSession session, String itemId})>((
      ref,
      request,
    ) async {
      return runProtectedServerCall<MediaDetail>(
        ref,
        session: request.session,
        request: (adapter) => adapter.fetchItemDetail(
          session: request.session,
          itemId: request.itemId,
        ),
      );
    });

final savedPlaybackStateProvider = FutureProvider.autoDispose
    .family<SavedPlaybackState?, ({String serverId, String itemId})>((
      ref,
      request,
    ) {
      return ref
          .watch(playbackStateRepositoryProvider)
          .loadState(serverId: request.serverId, itemId: request.itemId);
    });

class DetailPage extends ConsumerWidget {
  const DetailPage({
    required this.serverId,
    required this.itemId,
    this.title,
    super.key,
  });

  final String serverId;
  final String itemId;
  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final server = ref.watch(serverByIdProvider(serverId));
    if (server == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title ?? 'Missing Server')),
        body: const Center(
          child: Text('The selected server is no longer available locally.'),
        ),
      );
    }

    final session = ref.watch(serverSessionProvider(serverId));
    return Scaffold(
      appBar: AppBar(title: Text(title ?? server.name)),
      body: switch (session) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => _DetailFailureCard(error: error),
        AsyncData(:final value) =>
          value == null
              ? _ReloginPrompt(server: server)
              : _DetailBody(itemId: itemId, session: value),
      },
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.itemId, required this.session});

  final String itemId;
  final MediaServerSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(
      mediaDetailProvider((session: session, itemId: itemId)),
    );
    final localPlayback = ref.watch(
      savedPlaybackStateProvider((serverId: session.server.id, itemId: itemId)),
    );

    return switch (detail) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => _DetailFailureCard(error: error),
      AsyncData(:final value) => ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${value.mediaType} • ${value.year ?? 'Unknown year'} • '
                    '${(value.runtimeSeconds / 60).round()} min',
                  ),
                  const SizedBox(height: 20),
                  Text(value.overview),
                  if (value.genres.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final genre in value.genres)
                          Chip(label: Text(genre)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton.icon(
                        onPressed: () => context.push(
                          Uri(
                            path: '/player/${session.server.id}/$itemId',
                            queryParameters: {'title': value.title},
                          ).toString(),
                        ),
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('Play'),
                      ),
                      OutlinedButton.icon(
                        onPressed: context.pop,
                        icon: const Icon(Icons.arrow_back_rounded),
                        label: const Text('Back'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Resume position'),
              subtitle: Text(
                '${_resolveResumePosition(localPlayback, value)}s available for resume',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              title: const Text('Playback source'),
              subtitle: Text(
                value.streamUrl,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    };
  }

  int _resolveResumePosition(
    AsyncValue<SavedPlaybackState?> localPlayback,
    MediaDetail detail,
  ) {
    final localValue = localPlayback.asData?.value?.positionSeconds ?? 0;
    return math.max(localValue, detail.resumePositionSeconds);
  }
}

class _ReloginPrompt extends StatelessWidget {
  const _ReloginPrompt({required this.server});

  final MediaServerProfile server;

  @override
  Widget build(BuildContext context) {
    return EmptyStateCard(
      icon: Icons.lock_outline_rounded,
      title: 'Login required',
      description:
          '${server.name} no longer has saved credentials on this device.',
      action: FilledButton.icon(
        onPressed: () => context.go('/servers'),
        icon: const Icon(Icons.storage_rounded),
        label: const Text('Open servers'),
      ),
    );
  }
}

class _DetailFailureCard extends StatelessWidget {
  const _DetailFailureCard({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final DioException? dioError = error is DioException
        ? error as DioException
        : null;
    final description = dioError != null
        ? 'Detail request failed with HTTP ${dioError.response?.statusCode ?? 'unknown'}.'
        : error.toString();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: EmptyStateCard(
          icon: Icons.error_outline_rounded,
          title: 'Detail load failed',
          description: description,
        ),
      ),
    );
  }
}
