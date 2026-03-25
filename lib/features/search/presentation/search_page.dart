import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../../library/domain/library_models.dart';
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

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeServer?.name ?? 'No active server',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activeServer?.baseUrl ??
                        'Choose and sign in to an Emby server before searching.',
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _queryController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded),
                      labelText: 'Search current server',
                      hintText: 'Movies, episodes, videos',
                    ),
                    onChanged: _handleQueryChanged,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
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
      AsyncData(:final value) => Column(
        children: [
          for (final item in value) ...[
            Card(
              child: ListTile(
                leading: const Icon(Icons.play_circle_outline_rounded),
                title: Text(item.title),
                subtitle: Text(
                  item.overview.isEmpty
                      ? 'No overview from Emby.'
                      : item.overview,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text('${item.progressPercent}%'),
                onTap: () => context.push(
                  Uri(
                    path: '/detail/${item.serverId}/${item.id}',
                    queryParameters: {'title': item.title},
                  ).toString(),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    };
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
