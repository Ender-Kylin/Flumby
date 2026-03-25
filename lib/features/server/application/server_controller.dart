import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/server_local_repository.dart';
import '../domain/server_models.dart';

final serverControllerProvider =
    NotifierProvider<ServerController, ServerRegistryState>(
      ServerController.new,
    );

final activeServerProvider = Provider<MediaServerProfile?>((ref) {
  return ref.watch(serverControllerProvider).activeServer;
});

final serverProfilesProvider = Provider<List<MediaServerProfile>>((ref) {
  return ref.watch(serverControllerProvider).servers;
});

final serverByIdProvider = Provider.family<MediaServerProfile?, String>((
  ref,
  serverId,
) {
  final servers = ref.watch(serverProfilesProvider);
  for (final server in servers) {
    if (server.id == serverId) {
      return server;
    }
  }

  return null;
});

final activeServerSessionProvider = FutureProvider<MediaServerSession?>((
  ref,
) async {
  final server = ref.watch(activeServerProvider);
  if (server == null) {
    return null;
  }

  return ref.watch(serverLocalRepositoryProvider).loadSession(server);
});

final serverSessionProvider =
    FutureProvider.family<MediaServerSession?, String>((ref, serverId) async {
      return ref.watch(serverLocalRepositoryProvider).loadSessionById(serverId);
    });

class ServerRegistryState {
  const ServerRegistryState({
    this.servers = const [],
    this.activeServerId,
    this.isLoading = true,
  });

  final List<MediaServerProfile> servers;
  final String? activeServerId;
  final bool isLoading;

  MediaServerProfile? get activeServer {
    final targetId = activeServerId;
    if (targetId != null) {
      for (final server in servers) {
        if (server.id == targetId) {
          return server;
        }
      }
    }

    if (servers.isEmpty) {
      return null;
    }
    return servers.first;
  }

  ServerRegistryState copyWith({
    List<MediaServerProfile>? servers,
    String? activeServerId,
    bool clearActiveServerId = false,
    bool? isLoading,
  }) {
    return ServerRegistryState(
      servers: servers ?? this.servers,
      activeServerId: clearActiveServerId
          ? null
          : activeServerId ?? this.activeServerId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ServerController extends Notifier<ServerRegistryState> {
  bool _hydrating = false;

  @override
  ServerRegistryState build() {
    if (!_hydrating) {
      _hydrating = true;
      unawaited(_hydrate());
    }

    return const ServerRegistryState();
  }

  Future<void> saveSession(
    MediaServerSession session, {
    bool makeActive = true,
  }) async {
    final repository = ref.read(serverLocalRepositoryProvider);
    await repository.saveSession(session);

    final nextServers = _upsertLocalServer(session.server);
    final nextActiveServerId = _resolveNextActiveServerId(
      nextServers,
      preferredActiveServerId: makeActive
          ? session.server.id
          : state.activeServerId,
    );

    await repository.saveActiveServerId(nextActiveServerId);
    state = state.copyWith(
      servers: nextServers,
      activeServerId: nextActiveServerId,
      isLoading: false,
    );
    _invalidateSessionProviders(session.server.id);
  }

  Future<void> upsertServer(
    MediaServerProfile server, {
    bool makeActive = false,
  }) async {
    final repository = ref.read(serverLocalRepositoryProvider);
    await repository.saveServer(server);

    final nextServers = _upsertLocalServer(server);
    final nextActiveServerId = _resolveNextActiveServerId(
      nextServers,
      preferredActiveServerId: makeActive ? server.id : state.activeServerId,
    );

    await repository.saveActiveServerId(nextActiveServerId);
    state = state.copyWith(
      servers: nextServers,
      activeServerId: nextActiveServerId,
      isLoading: false,
    );
    _invalidateSessionProviders(server.id);
  }

  Future<void> setActiveServer(String serverId) async {
    final nextActiveServerId = _resolveNextActiveServerId(
      state.servers,
      preferredActiveServerId: serverId,
    );
    await ref
        .read(serverLocalRepositoryProvider)
        .saveActiveServerId(nextActiveServerId);
    state = state.copyWith(
      activeServerId: nextActiveServerId,
      isLoading: false,
    );
    ref.invalidate(activeServerSessionProvider);
  }

  Future<void> removeServer(String serverId) async {
    await ref.read(serverLocalRepositoryProvider).removeServer(serverId);
    final nextServers = state.servers
        .where((server) => server.id != serverId)
        .toList(growable: false);
    final nextActiveServerId = _resolveNextActiveServerId(
      nextServers,
      preferredActiveServerId: state.activeServerId == serverId
          ? null
          : state.activeServerId,
    );
    await ref
        .read(serverLocalRepositoryProvider)
        .saveActiveServerId(nextActiveServerId);
    state = state.copyWith(
      servers: nextServers,
      activeServerId: nextActiveServerId,
      isLoading: false,
    );
    _invalidateSessionProviders(serverId);
  }

  Future<void> clearCredentials(String serverId) async {
    await ref
        .read(serverLocalRepositoryProvider)
        .clearSessionCredentials(serverId);
    final server = ref.read(serverByIdProvider(serverId));
    if (server != null) {
      await upsertServer(
        server.copyWith(isOnline: false, updatedAt: DateTime.now().toUtc()),
      );
    } else {
      _invalidateSessionProviders(serverId);
    }
  }

  Future<void> _hydrate() async {
    final repository = ref.read(serverLocalRepositoryProvider);
    final servers = await repository.loadServers();
    final activeServerId = await repository.loadActiveServerId();
    state = state.copyWith(
      servers: servers,
      activeServerId: _resolveNextActiveServerId(
        servers,
        preferredActiveServerId: activeServerId,
      ),
      isLoading: false,
    );
    ref.invalidate(activeServerSessionProvider);
  }

  List<MediaServerProfile> _upsertLocalServer(MediaServerProfile server) {
    final nextServers = [...state.servers];
    final index = nextServers.indexWhere((entry) => entry.id == server.id);

    if (index == -1) {
      nextServers.add(server);
    } else {
      nextServers[index] = server;
    }

    nextServers.sort(
      (left, right) => right.updatedAt.compareTo(left.updatedAt),
    );
    return nextServers.toList(growable: false);
  }

  String? _resolveNextActiveServerId(
    List<MediaServerProfile> servers, {
    required String? preferredActiveServerId,
  }) {
    if (servers.isEmpty) {
      return null;
    }
    if (preferredActiveServerId != null &&
        servers.any((server) => server.id == preferredActiveServerId)) {
      return preferredActiveServerId;
    }
    return servers.first.id;
  }

  void _invalidateSessionProviders(String serverId) {
    ref.invalidate(serverSessionProvider(serverId));
    ref.invalidate(activeServerSessionProvider);
  }
}
