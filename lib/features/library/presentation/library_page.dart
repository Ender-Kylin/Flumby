import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../../server/application/media_server_access.dart';
import '../../server/application/server_controller.dart';
import '../../server/domain/server_models.dart';
import '../domain/library_models.dart';

final activeLibrariesProvider =
    FutureProvider.autoDispose<List<LibrarySummary>>((ref) async {
      final session = await ref.watch(activeServerSessionProvider.future);
      if (session == null) {
        return const [];
      }

      return runProtectedServerCall<List<LibrarySummary>>(
        ref,
        session: session,
        request: (adapter) => adapter.fetchLibraries(session),
      );
    });

final libraryItemsProvider = FutureProvider.autoDispose
    .family<
      List<MediaItemSummary>,
      ({MediaServerSession session, String libraryId})
    >((ref, request) async {
      return runProtectedServerCall<List<MediaItemSummary>>(
        ref,
        session: request.session,
        request: (adapter) => adapter.fetchItems(
          session: request.session,
          libraryId: request.libraryId,
        ),
      );
    });

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  String? _selectedLibraryId;

  @override
  Widget build(BuildContext context) {
    final serverRegistry = ref.watch(serverControllerProvider);
    final activeServer = ref.watch(activeServerProvider);
    if (serverRegistry.isLoading && activeServer == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (activeServer == null) {
      return ListView(
        children: [
          EmptyStateCard(
            icon: Icons.video_library_outlined,
            title: 'No library data available',
            description:
                'Connect to an Emby server before opening libraries and browsing items.',
            action: FilledButton.icon(
              onPressed: () => context.go('/servers'),
              icon: const Icon(Icons.storage_rounded),
              label: const Text('Open servers'),
            ),
          ),
        ],
      );
    }

    final activeSession = ref.watch(activeServerSessionProvider);
    return ListView(
      children: [
        _LibraryHeader(server: activeServer),
        const SizedBox(height: 16),
        switch (activeSession) {
          AsyncLoading() => const Center(child: CircularProgressIndicator()),
          AsyncError(:final error) => _LibraryFailureCard(
            title: 'Library login check failed',
            error: error,
          ),
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
                : _LibraryBody(
                    selectedLibraryId: _selectedLibraryId,
                    onLibrarySelected: (value) {
                      setState(() {
                        _selectedLibraryId = value;
                      });
                    },
                    session: value,
                  ),
        },
      ],
    );
  }
}

class _LibraryHeader extends StatelessWidget {
  const _LibraryHeader({required this.server});

  final MediaServerProfile server;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(server.name, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(server.baseUrl, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _LibraryBody extends ConsumerWidget {
  const _LibraryBody({
    required this.selectedLibraryId,
    required this.onLibrarySelected,
    required this.session,
  });

  final String? selectedLibraryId;
  final ValueChanged<String?> onLibrarySelected;
  final MediaServerSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraries = ref.watch(activeLibrariesProvider);

    return switch (libraries) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => _LibraryFailureCard(
        title: 'Library list failed',
        error: error,
      ),
      AsyncData(:final value) when value.isEmpty => const EmptyStateCard(
        icon: Icons.video_library_outlined,
        title: 'No libraries returned',
        description:
            'Emby did not return any libraries for the current account.',
      ),
      AsyncData(:final value) => _LibraryItemsView(
        libraries: value,
        session: session,
        selectedLibraryId: _resolveSelectedLibraryId(value),
        onLibrarySelected: onLibrarySelected,
      ),
    };
  }

  String _resolveSelectedLibraryId(List<LibrarySummary> libraries) {
    if (libraries.isEmpty) {
      return '';
    }
    if (selectedLibraryId != null &&
        libraries.any((library) => library.id == selectedLibraryId)) {
      return selectedLibraryId!;
    }
    return libraries.first.id;
  }
}

class _LibraryItemsView extends ConsumerWidget {
  const _LibraryItemsView({
    required this.libraries,
    required this.session,
    required this.selectedLibraryId,
    required this.onLibrarySelected,
  });

  final List<LibrarySummary> libraries;
  final MediaServerSession session;
  final String selectedLibraryId;
  final ValueChanged<String?> onLibrarySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(
      libraryItemsProvider((session: session, libraryId: selectedLibraryId)),
    );

    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: DropdownButtonFormField<String>(
              initialValue: selectedLibraryId,
              decoration: const InputDecoration(labelText: 'Current library'),
              items: [
                for (final library in libraries)
                  DropdownMenuItem(
                    value: library.id,
                    child: Text('${library.title} (${library.itemCount})'),
                  ),
              ],
              onChanged: onLibrarySelected,
            ),
          ),
        ),
        const SizedBox(height: 16),
        switch (items) {
          AsyncLoading() => const Center(child: CircularProgressIndicator()),
          AsyncError(:final error) => _LibraryFailureCard(
            title: 'Library items failed',
            error: error,
          ),
          AsyncData(:final value) when value.isEmpty => const EmptyStateCard(
            icon: Icons.movie_outlined,
            title: 'No playable items in this library',
            description:
                'Only movie, episode, and video items are shown in the first Emby pass.',
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
                    trailing: item.isFavorite
                        ? const Icon(Icons.favorite_rounded)
                        : null,
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
        },
      ],
    );
  }
}

class _LibraryFailureCard extends StatelessWidget {
  const _LibraryFailureCard({required this.title, required this.error});

  final String title;
  final Object error;

  @override
  Widget build(BuildContext context) {
    final DioException? dioError = error is DioException
        ? error as DioException
        : null;
    final description = dioError != null
        ? 'Emby request failed with HTTP ${dioError.response?.statusCode ?? 'unknown'}.'
        : error.toString();

    return EmptyStateCard(
      icon: Icons.error_outline_rounded,
      title: title,
      description: description,
    );
  }
}
