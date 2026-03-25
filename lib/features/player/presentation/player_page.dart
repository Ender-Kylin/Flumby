import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../../detail/domain/media_detail.dart';
import '../../player/data/playback_state_repository.dart';
import '../../server/application/media_server_access.dart';
import '../../server/application/server_controller.dart';
import '../../server/domain/server_models.dart';
import '../../settings/application/settings_controller.dart';
import '../application/player_controller.dart';
import '../domain/playback_models.dart';

final playerLaunchContextProvider = FutureProvider.autoDispose
    .family<PlayerLaunchContext, ({MediaServerSession session, String itemId})>(
      (ref, request) async {
        final detail = await runProtectedServerCall<MediaDetail>(
          ref,
          session: request.session,
          request: (adapter) => adapter.fetchItemDetail(
            session: request.session,
            itemId: request.itemId,
          ),
        );
        final localPlayback = await ref
            .watch(playbackStateRepositoryProvider)
            .loadState(
              serverId: request.session.server.id,
              itemId: request.itemId,
            );
        final resumePositionSeconds = math.max(
          localPlayback?.positionSeconds ?? 0,
          detail.resumePositionSeconds,
        );

        return PlayerLaunchContext(
          session: request.session,
          source: PlayerMediaSource(
            serverId: request.session.server.id,
            itemId: request.itemId,
            title: detail.title,
            streamUrl: detail.streamUrl,
            mediaSourceId: detail.mediaSourceId,
            playSessionId: detail.playSessionId,
            durationSeconds: detail.runtimeSeconds,
            resumePositionSeconds: resumePositionSeconds,
          ),
        );
      },
    );

class PlayerPage extends ConsumerWidget {
  const PlayerPage({
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
      return Scaffold(
        appBar: AppBar(title: Text(title ?? 'Missing Server')),
        body: const Center(
          child: Text('The selected server is no longer available locally.'),
        ),
      );
    }

    final session = ref.watch(serverSessionProvider(serverId));
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Player')),
      body: switch (session) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => _PlayerFailureCard(error: error),
        AsyncData(:final value) =>
          value == null
              ? _PlayerReloginPrompt(server: server)
              : _PlayerSessionBody(itemId: itemId, session: value),
      },
    );
  }
}

class _PlayerSessionBody extends ConsumerWidget {
  const _PlayerSessionBody({required this.itemId, required this.session});

  final String itemId;
  final MediaServerSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final launchContext = ref.watch(
      playerLaunchContextProvider((session: session, itemId: itemId)),
    );
    final settings = ref.watch(settingsControllerProvider);

    return switch (launchContext) {
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      AsyncError(:final error) => _PlayerFailureCard(error: error),
      AsyncData(:final value) => _PlayerView(
        launchContext: value,
        hardwareDecoding: settings.hardwareDecoding,
      ),
    };
  }
}

class _PlayerView extends ConsumerWidget {
  const _PlayerView({
    required this.launchContext,
    required this.hardwareDecoding,
  });

  final PlayerLaunchContext launchContext;
  final String hardwareDecoding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playerControllerProvider(launchContext));
    final controller = ref.read(
      playerControllerProvider(launchContext).notifier,
    );
    final source = launchContext.source;
    final isSeparateWindow = state.isSeparateWindow;
    final maxSeconds = math.max(
      1,
      source.durationSeconds > 0
          ? source.durationSeconds
          : source.resumePositionSeconds + 3600,
    );
    final playbackMessage = _buildPlaybackMessage(state);
    final actionLabel = isSeparateWindow
        ? (state.externalWindowActive
              ? 'Window Active'
              : (state.launchError != null ? 'Retry Window' : 'Open Window'))
        : (state.isPlaying ? 'Pause' : 'Play');
    final actionIcon = isSeparateWindow
        ? Icons.open_in_new_rounded
        : (state.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded);

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.source?.title ?? source.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    Chip(label: Text('Backend: ${state.backend.name}')),
                    Chip(label: Text('State: ${state.status.name}')),
                    Chip(
                      label: Text(
                        'Window: ${isSeparateWindow ? 'separate' : 'inline'}',
                      ),
                    ),
                    if (isSeparateWindow)
                      Chip(
                        label: Text(
                          state.externalWindowActive
                              ? 'Window active'
                              : 'Window idle',
                        ),
                      ),
                    if (source.durationSeconds > 0)
                      Chip(label: Text('Duration: ${source.durationSeconds}s')),
                  ],
                ),
                const SizedBox(height: 16),
                Text(playbackMessage),
                if (state.errorMessage != null &&
                    state.errorMessage != playbackMessage) ...[
                  const SizedBox(height: 12),
                  Text(
                    state.errorMessage!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                const SizedBox(height: 24),
                if (!isSeparateWindow)
                  Slider(
                    value: state.positionSeconds
                        .clamp(0, maxSeconds)
                        .toDouble(),
                    max: maxSeconds.toDouble(),
                    onChanged: (value) => controller.seekTo(value.round()),
                  ),
                Text('Position: ${state.positionSeconds}s'),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: isSeparateWindow && state.externalWindowActive
                          ? null
                          : controller.togglePlayback,
                      icon: Icon(actionIcon),
                      label: Text(actionLabel),
                    ),
                    if (isSeparateWindow)
                      OutlinedButton.icon(
                        onPressed: state.externalWindowActive
                            ? controller.closePlaybackWindow
                            : null,
                        icon: const Icon(Icons.close_rounded),
                        label: const Text('Close Window'),
                      ),
                    if (!isSeparateWindow) ...[
                      OutlinedButton(
                        onPressed: () =>
                            controller.seekTo(state.positionSeconds + 30),
                        child: const Text('+30s'),
                      ),
                      OutlinedButton(
                        onPressed: () => controller.selectSubtitle(
                          state.subtitleTrackId == 'eng' ? null : 'eng',
                        ),
                        child: Text(
                          state.subtitleTrackId == 'eng'
                              ? 'Subs Off'
                              : 'Subs ENG',
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () => controller.selectAudio(
                          state.audioTrackId == 'jpn' ? 'eng' : 'jpn',
                        ),
                        child: Text(
                          state.audioTrackId == 'jpn'
                              ? 'Audio ENG'
                              : 'Audio JPN',
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            title: const Text('Hardware decoding'),
            subtitle: Text('Current saved preference: $hardwareDecoding'),
            trailing: FilledButton(
              onPressed: () => controller.setOption('hwdec', hardwareDecoding),
              child: const Text('Reapply'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            title: const Text('Back to detail'),
            trailing: OutlinedButton(
              onPressed: context.pop,
              child: const Text('Back'),
            ),
          ),
        ),
      ],
    );
  }
}

class _PlayerReloginPrompt extends StatelessWidget {
  const _PlayerReloginPrompt({required this.server});

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

class _PlayerFailureCard extends StatelessWidget {
  const _PlayerFailureCard({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final DioException? dioError = error is DioException
        ? error as DioException
        : null;
    final description = dioError != null
        ? 'Player request failed with HTTP ${dioError.response?.statusCode ?? 'unknown'}.'
        : error.toString();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: EmptyStateCard(
          icon: Icons.error_outline_rounded,
          title: 'Player setup failed',
          description: description,
        ),
      ),
    );
  }
}

String _buildPlaybackMessage(PlayerStateSnapshot state) {
  if (state.launchError != null) {
    return state.launchError!;
  }

  if (state.isSeparateWindow) {
    if (state.externalWindowActive) {
      return 'Playback is running in a separate mpv window. Flumby will restore itself when that window closes.';
    }

    return 'Flumby launches Linux playback in a separate mpv window. The Play button here reopens that window if needed.';
  }

  return state.errorMessage ??
      'Playback is driven by the shared mpv bridge with Emby progress reporting enabled.';
}
