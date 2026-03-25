import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      children: [
        _ServerHeader(server: activeServer),
        const SizedBox(height: 16),
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

class _ServerHeader extends StatelessWidget {
  const _ServerHeader({required this.server});

  final MediaServerProfile server;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              server.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(server.baseUrl),
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
          Text(
            'Continue watching',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          for (final item in feed.continueWatching) ...[
            _HomeItemCard(item: item),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 20),
        ],
        for (final section in feed.sections) ...[
          Text(section.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          if (section.items.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('No items returned for this Emby section.'),
              ),
            )
          else
            for (final item in section.items) ...[
              _HomeItemCard(item: item),
              const SizedBox(height: 12),
            ],
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}

class _HomeItemCard extends StatelessWidget {
  const _HomeItemCard({required this.item});

  final MediaItemSummary item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.play_circle_outline_rounded),
        title: Text(item.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 6),
            Text(
              item.overview.isEmpty ? 'No overview from Emby.' : item.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(value: item.progress),
            const SizedBox(height: 6),
            Text('${item.progressPercent}% watched'),
          ],
        ),
        onTap: () => context.push(
          Uri(
            path: '/detail/${item.serverId}/${item.id}',
            queryParameters: {'title': item.title},
          ).toString(),
        ),
      ),
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
