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

final activeServerLineProvider = Provider<MediaServerLine?>((ref) {
  return ref.watch(serverControllerProvider).activeLine;
});

final serverProfilesProvider = Provider<List<MediaServerProfile>>((ref) {
  return ref.watch(serverControllerProvider).servers;
});

final serverLinesProvider = Provider<List<MediaServerLine>>((ref) {
  return ref.watch(serverControllerProvider).lines;
});

final serverByIdProvider = Provider.family<MediaServerProfile?, String>((
  ref,
  serverId,
) {
  return ref.watch(
    serverControllerProvider.select((state) => state.serverById(serverId)),
  );
});

final serverLineByIdProvider = Provider.family<MediaServerLine?, String>((
  ref,
  lineId,
) {
  return ref.watch(
    serverControllerProvider.select((state) => state.lineById(lineId)),
  );
});

final serverLinesByServerIdProvider = Provider.family<List<MediaServerLine>, String>(
  (ref, serverId) {
    return ref.watch(
      serverControllerProvider.select((state) => state.linesForServer(serverId)),
    );
  },
);

final serverSessionRevisionProvider = Provider<int>((ref) {
  return ref.watch(
    serverControllerProvider.select((state) => state.sessionRevision),
  );
});

final activeServerSessionProvider = FutureProvider<MediaServerSession?>((
  ref,
) async {
  final line = ref.watch(activeServerLineProvider);
  ref.watch(serverSessionRevisionProvider);
  if (line == null) {
    return null;
  }

  return ref.read(serverLocalRepositoryProvider).loadSessionByLineId(line.id);
});

final serverSessionProvider =
    FutureProvider.family<MediaServerSession?, String>((ref, lineId) async {
      ref.watch(serverSessionRevisionProvider);
      return ref.read(serverLocalRepositoryProvider).loadSessionByLineId(lineId);
    });

class ServerRegistryState {
  const ServerRegistryState({
    this.servers = const [],
    this.lines = const [],
    this.activeLineId,
    this.sessionRevision = 0,
    this.isLoading = true,
  });

  final List<MediaServerProfile> servers;
  final List<MediaServerLine> lines;
  final String? activeLineId;
  final int sessionRevision;
  final bool isLoading;

  MediaServerProfile? get activeServer {
    final activeLine = this.activeLine;
    if (activeLine == null) {
      if (servers.isEmpty) {
        return null;
      }
      return servers.first;
    }
    return serverById(activeLine.serverId);
  }

  MediaServerLine? get activeLine {
    final targetId = activeLineId;
    if (targetId != null) {
      for (final line in lines) {
        if (line.id == targetId) {
          return line;
        }
      }
    }

    if (lines.isEmpty) {
      return null;
    }
    return lines.first;
  }

  MediaServerProfile? serverById(String serverId) {
    for (final server in servers) {
      if (server.id == serverId) {
        return server;
      }
    }
    return null;
  }

  MediaServerLine? lineById(String lineId) {
    for (final line in lines) {
      if (line.id == lineId) {
        return line;
      }
    }
    return null;
  }

  List<MediaServerLine> linesForServer(String serverId) {
    return lines.where((line) => line.serverId == serverId).toList(growable: false);
  }

  ServerRegistryState copyWith({
    List<MediaServerProfile>? servers,
    List<MediaServerLine>? lines,
    String? activeLineId,
    bool clearActiveLineId = false,
    int? sessionRevision,
    bool bumpSessionRevision = false,
    bool? isLoading,
  }) {
    return ServerRegistryState(
      servers: servers ?? this.servers,
      lines: lines ?? this.lines,
      activeLineId: clearActiveLineId
          ? null
          : activeLineId ?? this.activeLineId,
      sessionRevision: bumpSessionRevision
          ? this.sessionRevision + 1
          : sessionRevision ?? this.sessionRevision,
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
    String? password,
  }) async {
    final repository = ref.read(serverLocalRepositoryProvider);
    await repository.saveSession(session, password: password);

    final nextServers = _upsertLocalServer(session.server);
    final nextLines = _upsertLocalLine(session.line);
    final nextActiveLineId = _resolveNextActiveLineId(
      nextLines,
      preferredActiveLineId: makeActive ? session.line.id : state.activeLineId,
    );

    await repository.saveActiveLineId(nextActiveLineId);
    state = state.copyWith(
      servers: nextServers,
      lines: nextLines,
      activeLineId: nextActiveLineId,
      bumpSessionRevision: true,
      isLoading: false,
    );
  }

  Future<void> upsertServer(
    MediaServerProfile server, {
    bool makeActive = false,
    bool bumpSessionRevision = false,
  }) async {
    final repository = ref.read(serverLocalRepositoryProvider);
    await repository.saveServer(server);
    final nextServers = _upsertLocalServer(server);
    final nextActiveLineId = makeActive
        ? _resolveNextActiveLineId(
            state.linesForServer(server.id),
            preferredActiveLineId: state.activeLineId,
          )
        : state.activeLineId;

    await repository.saveActiveLineId(nextActiveLineId);
    state = state.copyWith(
      servers: nextServers,
      activeLineId: nextActiveLineId,
      bumpSessionRevision: bumpSessionRevision,
      isLoading: false,
    );
  }

  Future<void> upsertServerLine(
    MediaServerLine line, {
    bool makeActive = false,
    bool bumpSessionRevision = false,
  }) async {
    final repository = ref.read(serverLocalRepositoryProvider);
    await repository.saveServerLine(line);

    final nextLines = _upsertLocalLine(line);
    final nextActiveLineId = _resolveNextActiveLineId(
      nextLines,
      preferredActiveLineId: makeActive ? line.id : state.activeLineId,
    );

    await repository.saveActiveLineId(nextActiveLineId);
    state = state.copyWith(
      lines: nextLines,
      activeLineId: nextActiveLineId,
      bumpSessionRevision: bumpSessionRevision,
      isLoading: false,
    );
  }

  Future<void> setActiveServer(String lineId) async {
    final nextActiveLineId = _resolveNextActiveLineId(
      state.lines,
      preferredActiveLineId: lineId,
    );
    await ref.read(serverLocalRepositoryProvider).saveActiveLineId(nextActiveLineId);
    state = state.copyWith(activeLineId: nextActiveLineId, isLoading: false);
  }

  Future<void> switchToLine(String lineId) async {
    await setActiveServer(lineId);
  }

  Future<void> removeServer(String serverId) async {
    await ref.read(serverLocalRepositoryProvider).removeServer(serverId);
    final nextServers = state.servers
        .where((server) => server.id != serverId)
        .toList(growable: false);
    final nextLines = state.lines
        .where((line) => line.serverId != serverId)
        .toList(growable: false);
    final nextActiveLineId = _resolveNextActiveLineId(
      nextLines,
      preferredActiveLineId: nextLines.any((line) => line.id == state.activeLineId)
          ? state.activeLineId
          : null,
    );
    await ref.read(serverLocalRepositoryProvider).saveActiveLineId(nextActiveLineId);
    state = state.copyWith(
      servers: nextServers,
      lines: nextLines,
      activeLineId: nextActiveLineId,
      bumpSessionRevision: true,
      isLoading: false,
    );
  }

  Future<void> removeServerLine(String lineId) async {
    final line = state.lineById(lineId);
    if (line == null) {
      return;
    }

    await ref.read(serverLocalRepositoryProvider).removeServerLine(lineId);
    final nextLines = state.lines
        .where((entry) => entry.id != lineId)
        .toList(growable: false);
    var nextServers = state.servers;
    if (!nextLines.any((entry) => entry.serverId == line.serverId)) {
      await ref.read(serverLocalRepositoryProvider).removeServer(line.serverId);
      nextServers = state.servers
          .where((server) => server.id != line.serverId)
          .toList(growable: false);
    }

    final nextActiveLineId = _resolveNextActiveLineId(
      nextLines,
      preferredActiveLineId: state.activeLineId == lineId ? null : state.activeLineId,
    );
    await ref.read(serverLocalRepositoryProvider).saveActiveLineId(nextActiveLineId);
    state = state.copyWith(
      servers: nextServers,
      lines: nextLines,
      activeLineId: nextActiveLineId,
      bumpSessionRevision: true,
      isLoading: false,
    );
  }

  Future<void> clearCredentials(String lineId) async {
    await ref.read(serverLocalRepositoryProvider).clearSessionCredentials(lineId);
    final line = ref.read(serverLineByIdProvider(lineId));
    if (line != null) {
      await upsertServerLine(
        line.copyWith(isOnline: false, updatedAt: DateTime.now().toUtc()),
        bumpSessionRevision: true,
      );
    } else {
      state = state.copyWith(bumpSessionRevision: true, isLoading: false);
    }
  }

  Future<MediaServerSession?> failoverFromLine(String lineId) async {
    final currentLine = state.lineById(lineId);
    if (currentLine == null) {
      return null;
    }

    final repository = ref.read(serverLocalRepositoryProvider);
    for (final candidate in state.linesForServer(currentLine.serverId)) {
      if (candidate.id == lineId) {
        continue;
      }

      final session = await repository.loadSessionByLineId(candidate.id);
      if (session == null) {
        continue;
      }

      await setActiveServer(candidate.id);
      return session;
    }

    return null;
  }

  Future<void> _hydrate() async {
    final repository = ref.read(serverLocalRepositoryProvider);
    final servers = await repository.loadServers();
    final lines = await repository.loadServerLines();
    final activeLineId = await repository.loadActiveLineId();
    state = state.copyWith(
      servers: _sortServers(servers),
      lines: _sortLines(lines),
      activeLineId: _resolveNextActiveLineId(
        lines,
        preferredActiveLineId: activeLineId,
      ),
      isLoading: false,
    );
  }

  List<MediaServerProfile> _upsertLocalServer(MediaServerProfile server) {
    final nextServers = [...state.servers];
    final index = nextServers.indexWhere((entry) => entry.id == server.id);

    if (index == -1) {
      nextServers.add(server);
    } else {
      nextServers[index] = server;
    }

    return _sortServers(nextServers);
  }

  List<MediaServerLine> _upsertLocalLine(MediaServerLine line) {
    final nextLines = [...state.lines];
    final index = nextLines.indexWhere((entry) => entry.id == line.id);

    if (index == -1) {
      nextLines.add(line);
    } else {
      nextLines[index] = line;
    }

    return _sortLines(nextLines);
  }

  List<MediaServerProfile> _sortServers(List<MediaServerProfile> servers) {
    final next = [...servers];
    next.sort((left, right) => right.updatedAt.compareTo(left.updatedAt));
    return next.toList(growable: false);
  }

  List<MediaServerLine> _sortLines(List<MediaServerLine> lines) {
    final next = [...lines];
    next.sort((left, right) => right.updatedAt.compareTo(left.updatedAt));
    return next.toList(growable: false);
  }

  String? _resolveNextActiveLineId(
    List<MediaServerLine> lines, {
    required String? preferredActiveLineId,
  }) {
    if (lines.isEmpty) {
      return null;
    }

    if (preferredActiveLineId != null &&
        lines.any((line) => line.id == preferredActiveLineId)) {
      return preferredActiveLineId;
    }

    return lines.first.id;
  }
}
