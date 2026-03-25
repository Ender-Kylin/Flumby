import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/emby_media_widgets.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../../library/domain/library_models.dart';
import '../../server/application/media_server_access.dart';
import '../../server/application/server_controller.dart';
import '../../server/domain/server_models.dart';
import '../domain/home_models.dart';

final activeHomeFeedProvider = FutureProvider.autoDispose<HomeFeed?>((
  ref,
) async {
  final session = await ref.watch(activeServerSessionProvider.future);
  if (session == null) {
    return null;
  }

  return runProtectedServerCall<HomeFeed>(
    ref,
    session: session,
    request: (adapter) => adapter.fetchHome(session),
  );
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serverRegistry = ref.watch(serverControllerProvider);
    final activeServer = ref.watch(activeServerProvider);

    if (serverRegistry.isLoading && activeServer == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activeServer == null) {
      return ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          EmptyStateCard(
            icon: Icons.home_outlined,
            title: 'No server connected',
            description:
                'Connect and sign in to an Emby server before browsing the home feed.',
            action: FilledButton.icon(
              onPressed: () => context.go('/servers'),
              icon: const Icon(Icons.storage_rounded),
              label: const Text('Open servers'),
            ),
          ),
        ],
      );
    }

    final homeFeed = ref.watch(activeHomeFeedProvider);

    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        _ServerHero(server: activeServer),
        const SizedBox(height: 28),
        switch (homeFeed) {
          AsyncLoading() => const Center(child: CircularProgressIndicator()),
          AsyncError(:final error) => _HomeFailureCard(error: error),
          AsyncData(:final value) when value == null => EmptyStateCard(
            icon: Icons.lock_outline_rounded,
            title: 'Login required',
            description:
                'The active server no longer has saved credentials. Reconnect it from the servers page first.',
            action: FilledButton.icon(
              onPressed: () => context.go('/servers'),
              icon: const Icon(Icons.storage_rounded),
              label: const Text('Open servers'),
            ),
          ),
          AsyncData(:final value)
              when value != null &&
                  value.continueWatching.isEmpty &&
                  value.sections.every((section) => section.items.isEmpty) =>
            const EmptyStateCard(
              icon: Icons.home_outlined,
              title: 'No playable home items yet',
              description:
                  'Emby returned no playable movie, episode, or video items for the current home feed.',
            ),
          AsyncData(:final value) => _HomeFeedView(feed: value!),
        },
      ],
    );
  }
}

class _ServerHero extends StatelessWidget {
  const _ServerHero({required this.server});

  final MediaServerProfile server;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF163A60), Color(0xFF0C1118)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Continue with ${server.name}',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              server.baseUrl,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 18),
            Text(
              'Your Emby home feed is now shown as posters and cinematic strips instead of placeholder text lists.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeFeedView extends StatelessWidget {
  const _HomeFeedView({required this.feed});

  final HomeFeed feed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (feed.continueWatching.isNotEmpty) ...[
          _SectionHeading(title: 'Continue Watching'),
          const SizedBox(height: 14),
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: feed.continueWatching.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = feed.continueWatching[index];
                return SizedBox(
                  width: 380,
                  child: WideMediaCard(
                    title: item.title,
                    subtitle: item.overview,
                    imageUrl:
                        item.backdropImageUrl ??
                        item.thumbImageUrl ??
                        item.posterImageUrl,
                    progress: item.progress,
                    progressText: '${item.progressPercent}% watched',
                    onTap: () => _openDetail(context, item),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
        for (final section in feed.sections) ...[
          _SectionHeading(title: section.title),
          const SizedBox(height: 14),
          if (section.items.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'No items returned for this Emby section.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          else
            SizedBox(
              height: PosterMediaCard.cardHeight,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: section.items.length,
                separatorBuilder: (context, index) => const SizedBox(width: 18),
                itemBuilder: (context, index) {
                  final item = section.items[index];
                  return SizedBox(
                    width: PosterMediaCard.cardWidth,
                    child: PosterMediaCard(
                      title: item.title,
                      subtitle: _mediaMeta(item),
                      imageUrl:
                          item.posterImageUrl ??
                          item.thumbImageUrl ??
                          item.backdropImageUrl,
                      progress: item.isResumable ? item.progress : null,
                      isFavorite: item.isFavorite,
                      onTap: () => _openDetail(context, item),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(height: 30),
        ],
      ],
    );
  }

  String _mediaMeta(MediaItemSummary item) {
    final parts = <String>[
      if (item.year != null) item.year.toString(),
      if (item.runtimeSeconds > 0) '${(item.runtimeSeconds / 60).round()} min',
    ];
    return parts.join(' • ');
  }

  void _openDetail(BuildContext context, MediaItemSummary item) {
    context.push(
      Uri(
        path: '/detail/${item.serverId}/${item.id}',
        queryParameters: {'title': item.title},
      ).toString(),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}

class _HomeFailureCard extends StatelessWidget {
  const _HomeFailureCard({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final DioException? dioError = error is DioException
        ? error as DioException
        : null;
    final description = dioError != null
        ? 'Home request failed with HTTP ${dioError.response?.statusCode ?? 'unknown'}.'
        : error.toString();

    return EmptyStateCard(
      icon: Icons.error_outline_rounded,
      title: 'Home load failed',
      description: description,
    );
  }
}
