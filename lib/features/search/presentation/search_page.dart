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
          : AppBar(title: const Text('Search')),
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
              title: 'No active server selected',
              description:
                  'Add at least one Emby server, then choose the current server before using search.',
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
                        title: 'Login required',
                        description:
                            'The active server no longer has saved credentials. Reconnect it from the servers page first.',
                        action: FilledButton.icon(
                          onPressed: () => context.go('/servers'),
                          icon: const Icon(Icons.storage_rounded),
                          label: const Text('Open servers'),
                        ),
                      )
                    : _SearchResultsSection(query: _query, session: value),
            },
        ],
      ),
    );

    return DesktopWindowFrame(
      title: 'Search',
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
              server?.name ?? 'No active server',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              server?.baseUrl ??
                  'Choose and sign in to an Emby server before searching.',
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
                labelText: 'Search current server',
                hintText: 'Movies, episodes, videos',
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
        title: 'Search ready',
        description:
            'Enter at least 2 characters to search the active Emby server.',
      );
    }

    if (query.length < 2) {
      return const EmptyStateCard(
        icon: Icons.short_text_rounded,
        title: 'Type a little more',
        description:
            'Search starts after 2 characters so we do not spam the server.',
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
        title: 'No results for "$query"',
        description:
            'Try a different title, or switch the active server and search again.',
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
    final clusteredGroups = groups.where((group) => group.isClustered).toList();
    final standaloneItems = groups
        .where((group) => !group.isClustered)
        .map((group) => group.primaryItem)
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Results',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          'Exact title and series matches are ranked first, and related episodes stay grouped together.',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        if (clusteredGroups.isNotEmpty) ...[
          const SizedBox(height: 24),
          for (final group in clusteredGroups) ...[
            _GroupedSearchSection(group: group),
            const SizedBox(height: 28),
          ],
        ],
        if (standaloneItems.isNotEmpty) ...[
          Text(
            clusteredGroups.isEmpty ? 'Matches' : 'Other Matches',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          MediaPosterGrid(
            items: standaloneItems,
            onItemTap: (item) => _openDetail(context, item),
          ),
        ],
      ],
    );
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

class _GroupedSearchSection extends StatelessWidget {
  const _GroupedSearchSection({required this.group});

  final SearchResultGroup group;

  @override
  Widget build(BuildContext context) {
    final caption = switch ((group.primaryItem.mediaType, group.items.length)) {
      ('Series', final count) when count > 1 =>
        'Series · $count related matches',
      ('Series', _) => 'Series',
      (_, final count) when count > 1 => '$count related matches',
      _ => group.primaryItem.mediaType,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          caption,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: PosterMediaCard.cardHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: group.items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 18),
            itemBuilder: (context, index) {
              final item = group.items[index];
              return SizedBox(
                width: PosterMediaCard.cardWidth,
                child: PosterMediaCard(
                  title: item.title,
                  subtitle: item.isSeries
                      ? item.mediaType
                      : item.searchGroupTitle,
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
      ],
    );
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
        ? 'Search request failed with HTTP ${dioError.response?.statusCode ?? 'unknown'}.'
        : error.toString();

    return EmptyStateCard(
      icon: Icons.error_outline_rounded,
      title: 'Search failed',
      description: description,
    );
  }
}
