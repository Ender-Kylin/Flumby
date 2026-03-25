import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/navigation/desktop_window_frame.dart';
import '../../../core/widgets/emby_media_widgets.dart';
import '../../../core/widgets/empty_state_card.dart';
import '../../library/domain/library_models.dart';
import '../domain/search_result_utils.dart';
import '../../server/application/media_server_access.dart';
import '../../server/application/server_controller.dart';
import '../../server/domain/server_models.dart';

final searchResultsProvider = FutureProvider.autoDispose
    .family<
      List<MediaItemSummary>,
      ({MediaServerSession session, String query})
    >((ref, request) async {
      return runProtectedServerCall<List<MediaItemSummary>>(
        ref,
        session: request.session,
        request: (adapter) =>
            adapter.searchItems(session: request.session, query: request.query),
      );
    });

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _queryController = TextEditingController();
  Timer? _debounce;
  String _query = '';

  @override
  void dispose() {
    _debounce?.cancel();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeServer = ref.watch(activeServerProvider);
    final activeSession = ref.watch(activeServerSessionProvider);
    final scaffold = Scaffold(
      appBar: DesktopWindowFrame.isEnabled
          ? null
          : AppBar(title: const Text('搜索')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        children: [
          _SearchHero(
            server: activeServer,
            controller: _queryController,
            onChanged: _handleQueryChanged,
          ),
          const SizedBox(height: 22),
          if (activeServer == null)
            const EmptyStateCard(
              icon: Icons.search_off_rounded,
              title: '尚未选择当前服务器',
              description:
                  '请先添加至少一个 Emby 服务器，再选择当前服务器后使用搜索。',
            )
          else
            switch (activeSession) {
              AsyncLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              AsyncError(:final error) => _SearchFailureCard(error: error),
              AsyncData(:final value) =>
                value == null
                    ? EmptyStateCard(
                        icon: Icons.lock_outline_rounded,
                        title: '需要登录',
                        description:
                            '当前服务器已没有保存的凭据，请先到服务器页面重新连接。',
                        action: FilledButton.icon(
                          onPressed: () => context.go('/servers'),
                          icon: const Icon(Icons.storage_rounded),
                          label: const Text('打开服务器'),
                        ),
                      )
                    : _SearchResultsSection(query: _query, session: value),
            },
        ],
      ),
    );

    return DesktopWindowFrame(
      title: '搜索',
      showBackButton: true,
      child: scaffold,
    );
  }

  void _handleQueryChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _query = value.trim();
      });
    });
  }
}

class _SearchHero extends StatelessWidget {
  const _SearchHero({
    required this.server,
    required this.controller,
    required this.onChanged,
  });

  final MediaServerProfile? server;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF101925), Color(0xFF1B365A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              server?.name ?? '未选择当前服务器',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              server?.baseUrl ??
                  '请先选择并登录 Emby 服务器后再进行搜索。',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 22),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                labelText: '搜索当前服务器',
                hintText: '电影、剧集、视频',
              ),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultsSection extends ConsumerWidget {
  const _SearchResultsSection({required this.query, required this.session});

  final String query;
  final MediaServerSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (query.isEmpty) {
      return const EmptyStateCard(
        icon: Icons.manage_search_rounded,
        title: '搜索已就绪',
        description:
            '请输入至少 2 个字符来搜索当前 Emby 服务器。',
      );
    }

    if (query.length < 2) {
      return const EmptyStateCard(
        icon: Icons.short_text_rounded,
        title: '再输入一点',
        description:
            '搜索会在输入 2 个字符后开始，避免频繁请求服务器。',
      );
    }

    final results = ref.watch(
      searchResultsProvider((session: session, query: query)),
    );

    return switch (results) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => _SearchFailureCard(error: error),
      AsyncData(:final value) when value.isEmpty => EmptyStateCard(
        icon: Icons.search_off_rounded,
        title: '没有找到 "$query" 的结果',
        description:
            '可以换个关键词，或者切换当前服务器后重新搜索。',
      ),
      AsyncData(:final value) => _SearchResultsView(results: value),
    };
  }
}

class _SearchResultsView extends StatelessWidget {
  const _SearchResultsView({required this.results});

  final List<MediaItemSummary> results;

  @override
  Widget build(BuildContext context) {
    final groups = buildSearchResultGroups(results);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '搜索结果',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          '剧集在搜索结果中会折叠显示。打开剧集后，可在详情页选择季和集。',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 20),
        _SearchResultsGrid(groups: groups),
      ],
    );
  }
}

class _SearchResultsGrid extends StatelessWidget {
  const _SearchResultsGrid({required this.groups});

  final List<SearchResultGroup> groups;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = switch (width) {
          >= 1500 => 6,
          >= 1220 => 5,
          >= 980 => 4,
          >= 720 => 3,
          _ => 2,
        };

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: groups.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            mainAxisExtent: 360,
          ),
          itemBuilder: (context, index) {
            final group = groups[index];
            final item = group.primaryItem;
            return PosterMediaCard(
              title: group.title,
              subtitle: _subtitleForGroup(group),
              imageUrl:
                  item.posterImageUrl ??
                  item.thumbImageUrl ??
                  item.backdropImageUrl,
              progress: item.isResumable ? item.progress : null,
              isFavorite: item.isFavorite,
              onTap: () => _openDetail(context, item),
            );
          },
        );
      },
    );
  }

  String _subtitleForGroup(SearchResultGroup group) {
    final item = group.primaryItem;
    if (item.isSeries) {
      final episodeCount = group.relatedEpisodeCount;
      if (episodeCount > 0) {
        return '剧集 • $episodeCount 集';
      }
      return '剧集';
    }

    final parts = <String>[
      item.mediaType,
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

class _SearchFailureCard extends StatelessWidget {
  const _SearchFailureCard({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final DioException? dioError = error is DioException
        ? error as DioException
        : null;
    final description = dioError != null
        ? '搜索请求失败，HTTP 状态码为 ${dioError.response?.statusCode ?? '未知'}。'
        : error.toString();

    return EmptyStateCard(
      icon: Icons.error_outline_rounded,
      title: '搜索失败',
      description: description,
    );
  }
}
