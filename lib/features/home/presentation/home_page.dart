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
    final servers = serverRegistry.servers;

    if (serverRegistry.isLoading && activeServer == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activeServer == null) {
      return ListView(
        padding: const EdgeInsets.only(bottom: 28),
        children: [
          EmptyStateCard(
            icon: Icons.home_outlined,
            title: '尚未连接服务器',
            description:
                '请先连接并登录 Emby 服务器，再浏览首页内容。',
            action: FilledButton.icon(
              onPressed: () => context.go('/servers'),
              icon: const Icon(Icons.storage_rounded),
              label: const Text('打开服务器'),
            ),
          ),
        ],
      );
    }

    final homeFeed = ref.watch(activeHomeFeedProvider);

    return ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        if (servers.length > 1) ...[
          _HomeServerSwitcher(activeServer: activeServer, servers: servers),
          const SizedBox(height: 24),
        ],
        switch (homeFeed) {
          AsyncLoading() => const Center(child: CircularProgressIndicator()),
          AsyncError(:final error) => _HomeFailureCard(error: error),
          AsyncData(:final value) when value == null => EmptyStateCard(
            icon: Icons.lock_outline_rounded,
            title: '需要登录',
            description:
                '当前服务器已没有保存的凭据，请先到服务器页面重新连接。',
            action: FilledButton.icon(
              onPressed: () => context.go('/servers'),
              icon: const Icon(Icons.storage_rounded),
              label: const Text('打开服务器'),
            ),
          ),
          AsyncData(:final value)
              when value != null &&
                  value.continueWatching.isEmpty &&
                  value.sections.every((section) => section.items.isEmpty) =>
            const EmptyStateCard(
              icon: Icons.home_outlined,
              title: '首页暂无可播放内容',
              description:
                  'Emby 当前首页未返回可播放的电影、剧集或视频内容。',
            ),
          AsyncData(:final value) => _HomeFeedView(feed: value!),
        },
      ],
    );
  }
}

class _HomeServerSwitcher extends ConsumerWidget {
  const _HomeServerSwitcher({
    required this.activeServer,
    required this.servers,
  });

  final MediaServerProfile activeServer;
  final List<MediaServerProfile> servers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return PopupMenuButton<String>(
      tooltip: '切换服务器',
      position: PopupMenuPosition.under,
      onSelected: (serverId) {
        ref.read(serverControllerProvider.notifier).setActiveServer(serverId);
      },
      itemBuilder: (context) => [
        for (final server in servers)
          PopupMenuItem<String>(
            value: server.id,
            enabled: server.id != activeServer.id,
            child: Row(
              children: [
                Icon(
                  server.id == activeServer.id
                      ? Icons.check_circle_rounded
                      : Icons.storage_rounded,
                  size: 18,
                  color: server.id == activeServer.id
                      ? scheme.primary
                      : scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    server.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.24),
          ),
        ),
        child: Padding(
          key: const Key('home-server-switcher'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                Icons.swap_horiz_rounded,
                size: 18,
                color: scheme.primary,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '当前服务器',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activeServer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.expand_more_rounded,
                color: scheme.onSurfaceVariant,
              ),
            ],
          ),
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
          _SectionHeading(title: '继续观看'),
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
                    progressText: '已观看 ${item.progressPercent}%',
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
                  '该 Emby 分区没有返回任何内容。',
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
      if (item.runtimeSeconds > 0) '${(item.runtimeSeconds / 60).round()} 分钟',
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
        ? '首页请求失败，HTTP 状态码为 ${dioError.response?.statusCode ?? '未知'}。'
        : error.toString();

    return EmptyStateCard(
      icon: Icons.error_outline_rounded,
      title: '首页加载失败',
      description: description,
    );
  }
}
