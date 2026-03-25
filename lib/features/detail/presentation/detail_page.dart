import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/navigation/desktop_window_frame.dart';
import '../../../core/widgets/emby_media_widgets.dart';
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
      final fallbackScaffold = Scaffold(
        appBar: DesktopWindowFrame.isEnabled
            ? null
            : AppBar(title: Text(title ?? 'Missing Server')),
        body: const Center(
          child: Text('The selected server is no longer available locally.'),
        ),
      );

      return DesktopWindowFrame(
        title: title ?? 'Missing Server',
        showBackButton: true,
        child: fallbackScaffold,
      );
    }

    final session = ref.watch(serverSessionProvider(serverId));
    final scaffold = Scaffold(
      appBar: DesktopWindowFrame.isEnabled
          ? null
          : AppBar(title: Text(title ?? server.name)),
      body: switch (session) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => _DetailFailureCard(error: error),
        AsyncData(:final value) =>
          value == null
              ? _ReloginPrompt(server: server)
              : _DetailBody(itemId: itemId, session: value),
      },
    );

    return DesktopWindowFrame(
      title: title ?? server.name,
      showBackButton: true,
      child: scaffold,
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
      AsyncData(:final value) => LayoutBuilder(
        builder: (context, constraints) {
          final resumePosition = _resolveResumePosition(localPlayback, value);
          final isWide = constraints.maxWidth >= 920;
          return ListView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  children: [
                    MediaArtwork(
                      imageUrl:
                          value.backdropImageUrl ??
                          value.thumbImageUrl ??
                          value.posterImageUrl,
                      aspectRatio: isWide ? 21 / 9 : 16 / 10,
                      borderRadius: BorderRadius.circular(32),
                      overlay: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.18),
                              Colors.black.withValues(alpha: 0.82),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(26),
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 240,
                                  child: MediaArtwork(
                                    imageUrl:
                                        value.posterImageUrl ??
                                        value.thumbImageUrl ??
                                        value.backdropImageUrl,
                                    aspectRatio: 2 / 3,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                const SizedBox(width: 26),
                                Expanded(
                                  child: _DetailSummary(
                                    detail: value,
                                    resumePosition: resumePosition,
                                    onPlayPressed: () =>
                                        _openPlayer(context, value.title),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: MediaArtwork(
                                    imageUrl:
                                        value.posterImageUrl ??
                                        value.thumbImageUrl ??
                                        value.backdropImageUrl,
                                    aspectRatio: 2 / 3,
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                _DetailSummary(
                                  detail: value,
                                  resumePosition: resumePosition,
                                  onPlayPressed: () =>
                                      _openPlayer(context, value.title),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                value.overview.isEmpty
                    ? 'No overview returned from Emby.'
                    : value.overview,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ],
          );
        },
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

  void _openPlayer(BuildContext context, String title) {
    context.push(
      Uri(
        path: '/player/${session.server.id}/$itemId',
        queryParameters: {'title': title},
      ).toString(),
    );
  }
}

class _DetailSummary extends StatelessWidget {
  const _DetailSummary({
    required this.detail,
    required this.resumePosition,
    required this.onPlayPressed,
  });

  final MediaDetail detail;
  final int resumePosition;
  final VoidCallback onPlayPressed;

  @override
  Widget build(BuildContext context) {
    final metaParts = <String>[
      detail.mediaType,
      if (detail.year != null) detail.year.toString(),
      if (detail.runtimeSeconds > 0)
        '${(detail.runtimeSeconds / 60).round()} min',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detail.title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final part in metaParts) Chip(label: Text(part)),
            if (detail.isFavorite) const Chip(label: Text('Favorite')),
            if (resumePosition > 0)
              Chip(label: Text('Resume at ${_formatSeconds(resumePosition)}')),
          ],
        ),
        if (detail.genres.isNotEmpty) ...[
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final genre in detail.genres) Chip(label: Text(genre)),
            ],
          ),
        ],
        const SizedBox(height: 22),
        Text(
          detail.overview.isEmpty
              ? 'No overview returned from Emby.'
              : detail.overview,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 22),
        if (!detail.isPlayable) ...[
          Text(
            'This entry is grouped at the series level. Open a movie, episode, or video item to start playback.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 18),
        ],
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (detail.isPlayable)
              FilledButton.icon(
                onPressed: onPlayPressed,
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
    );
  }

  String _formatSeconds(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    if (minutes > 0) {
      return '${minutes}m ${secs}s';
    }
    return '${secs}s';
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
