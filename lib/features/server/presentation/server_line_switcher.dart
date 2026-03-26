import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/server_controller.dart';
import '../domain/server_models.dart';

class ServerLineSwitcher extends ConsumerWidget {
  const ServerLineSwitcher({
    required this.activeServer,
    required this.activeLine,
    required this.lines,
    super.key,
  });

  final MediaServerProfile activeServer;
  final MediaServerLine activeLine;
  final List<MediaServerLine> lines;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return PopupMenuButton<String>(
      tooltip: '切换线路',
      position: PopupMenuPosition.under,
      onSelected: (lineId) {
        ref.read(serverControllerProvider.notifier).setActiveServer(lineId);
      },
      itemBuilder: (context) => [
        for (final line in lines)
          PopupMenuItem<String>(
            value: line.id,
            enabled: line.id != activeLine.id,
            child: Row(
              children: [
                Icon(
                  line.id == activeLine.id
                      ? Icons.check_circle_rounded
                      : Icons.storage_rounded,
                  size: 18,
                  color: line.id == activeLine.id
                      ? scheme.primary
                      : scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        line.displayName(activeServer.defaultName),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${activeServer.defaultName} · ${line.baseUrl}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
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
                      '当前线路',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      activeLine.displayName(activeServer.defaultName),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activeServer.defaultName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
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
