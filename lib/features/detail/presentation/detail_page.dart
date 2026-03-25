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
          final preferredEpisode = _preferredEpisode(value);
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
                                    recommendedEpisode: preferredEpisode,
                                    onOpenRecommendedEpisode:
                                        preferredEpisode == null
                                        ? null
                                        : () => _openEpisodeDetail(
                                            context,
                                            preferredEpisode,
                                          ),
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
                                  recommendedEpisode: preferredEpisode,
                                  onOpenRecommendedEpisode:
                                      preferredEpisode == null
                                      ? null
                                      : () => _openEpisodeDetail(
                                          context,
                                          preferredEpisode,
                                        ),
                                  onPlayPressed: () =>
                                      _openPlayer(context, value.title),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              if (value.isSeries) ...[
                const SizedBox(height: 24),
                _SeriesEpisodesSection(
                  detail: value,
                  onEpisodeTap: (episode) =>
                      _openEpisodeDetail(context, episode),
                ),
              ],
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
    if (detail.isSeries) {
      return 0;
    }
    final localValue = localPlayback.asData?.value?.positionSeconds ?? 0;
    return math.max(localValue, detail.resumePositionSeconds);
  }

  SeriesEpisodeSummary? _preferredEpisode(MediaDetail detail) {
    if (!detail.isSeries || detail.seriesSeasons.isEmpty) {
      return null;
    }

    final episodes = [
      for (final season in detail.seriesSeasons) ...season.episodes,
    ];
    if (episodes.isEmpty) {
      return null;
    }

    final byLastPlayed =
        episodes.where((episode) => episode.lastPlayedAt != null).toList()
          ..sort(
            (left, right) => right.lastPlayedAt!.compareTo(left.lastPlayedAt!),
          );
    if (byLastPlayed.isNotEmpty) {
      return byLastPlayed.first;
    }

    final resumable = episodes.where((episode) => episode.isResumable).toList()
      ..sort((left, right) => right.progress.compareTo(left.progress));
    if (resumable.isNotEmpty) {
      return resumable.first;
    }

    return episodes.first;
  }

  void _openPlayer(BuildContext context, String title) {
    context.push(
      Uri(
        path: '/player/${session.server.id}/$itemId',
        queryParameters: {'title': title},
      ).toString(),
    );
  }

  void _openEpisodeDetail(BuildContext context, SeriesEpisodeSummary episode) {
    context.push(
      Uri(
        path: '/detail/${episode.serverId}/${episode.id}',
        queryParameters: {'title': episode.title},
      ).toString(),
    );
  }
}

class _DetailSummary extends StatelessWidget {
  const _DetailSummary({
    required this.detail,
    required this.resumePosition,
    required this.recommendedEpisode,
    required this.onOpenRecommendedEpisode,
    required this.onPlayPressed,
  });

  final MediaDetail detail;
  final int resumePosition;
  final SeriesEpisodeSummary? recommendedEpisode;
  final VoidCallback? onOpenRecommendedEpisode;
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
        if (detail.isSeries) ...[
          Text(
            recommendedEpisode == null
                ? 'Choose a season and episode below to keep browsing this show.'
                : 'Open ${recommendedEpisode!.episodeLabel} from the episode list below, or jump into that episode detail directly.',
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
            if (detail.isSeries && recommendedEpisode != null)
              FilledButton.icon(
                onPressed: onOpenRecommendedEpisode,
                icon: const Icon(Icons.playlist_play_rounded),
                label: Text(
                  recommendedEpisode!.isResumable
                      ? 'Continue ${recommendedEpisode!.episodeLabel}'
                      : 'Open ${recommendedEpisode!.episodeLabel}',
                ),
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

class _SeriesEpisodesSection extends StatefulWidget {
  const _SeriesEpisodesSection({
    required this.detail,
    required this.onEpisodeTap,
  });

  final MediaDetail detail;
  final ValueChanged<SeriesEpisodeSummary> onEpisodeTap;

  @override
  State<_SeriesEpisodesSection> createState() => _SeriesEpisodesSectionState();
}

class _SeriesEpisodesSectionState extends State<_SeriesEpisodesSection> {
  String? _selectedSeasonId;

  @override
  Widget build(BuildContext context) {
    final seasons = widget.detail.seriesSeasons
        .where((season) => season.episodes.isNotEmpty)
        .toList(growable: false);
    if (seasons.isEmpty) {
      return const EmptyStateCard(
        icon: Icons.live_tv_rounded,
        title: 'No episodes available yet',
        description:
            'This series detail loaded, but Emby did not return any playable episodes for it.',
      );
    }

    final preferredEpisode = _preferredEpisode(seasons);
    final effectiveSeasonId =
        seasons.any((season) => season.id == _selectedSeasonId)
        ? _selectedSeasonId!
        : preferredEpisode?.seasonId ?? seasons.first.id;
    final selectedSeason = seasons.firstWhere(
      (season) => season.id == effectiveSeasonId,
      orElse: () => seasons.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Episodes',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          'Pick a season first, then open an episode to see its detail and playback options.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        if (seasons.length > 1) ...[
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final season in seasons)
                ChoiceChip(
                  label: Text(season.displayTitle),
                  selected: season.id == effectiveSeasonId,
                  onSelected: (_) {
                    setState(() {
                      _selectedSeasonId = season.id;
                    });
                  },
                ),
            ],
          ),
        ],
        const SizedBox(height: 18),
        for (final episode in selectedSeason.episodes) ...[
          _EpisodeListTile(
            episode: episode,
            isRecommended: preferredEpisode?.id == episode.id,
            onTap: () => widget.onEpisodeTap(episode),
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  SeriesEpisodeSummary? _preferredEpisode(List<SeriesSeasonSummary> seasons) {
    final episodes = [for (final season in seasons) ...season.episodes];
    if (episodes.isEmpty) {
      return null;
    }

    final byLastPlayed =
        episodes.where((episode) => episode.lastPlayedAt != null).toList()
          ..sort(
            (left, right) => right.lastPlayedAt!.compareTo(left.lastPlayedAt!),
          );
    if (byLastPlayed.isNotEmpty) {
      return byLastPlayed.first;
    }

    final resumable = episodes.where((episode) => episode.isResumable).toList()
      ..sort((left, right) => right.progress.compareTo(left.progress));
    if (resumable.isNotEmpty) {
      return resumable.first;
    }

    return episodes.first;
  }
}

class _EpisodeListTile extends StatelessWidget {
  const _EpisodeListTile({
    required this.episode,
    required this.isRecommended,
    required this.onTap,
  });

  final SeriesEpisodeSummary episode;
  final bool isRecommended;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final subtitleParts = <String>[
      if (episode.runtimeSeconds > 0)
        '${(episode.runtimeSeconds / 60).round()} min',
      if (episode.progressPercent > 0) '${episode.progressPercent}% watched',
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isRecommended
                  ? scheme.primary.withValues(alpha: 0.65)
                  : scheme.outlineVariant.withValues(alpha: 0.18),
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 148,
                child: MediaArtwork(
                  imageUrl:
                      episode.thumbImageUrl ??
                      episode.backdropImageUrl ??
                      episode.posterImageUrl,
                  aspectRatio: 16 / 9,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Chip(label: Text(episode.episodeLabel)),
                        if (isRecommended) const Chip(label: Text('Continue')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      episode.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (subtitleParts.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        subtitleParts.join(' • '),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                    if (episode.overview.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(
                        episode.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                    if (episode.progressPercent > 0) ...[
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: episode.progress.clamp(0, 1),
                          minHeight: 5,
                          backgroundColor: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.chevron_right_rounded, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
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
