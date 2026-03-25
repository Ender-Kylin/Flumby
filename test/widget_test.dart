import 'dart:ui';

import 'package:flumby/app/flumby_app.dart';
import 'package:flumby/features/server/application/server_controller.dart';
import 'package:flumby/features/server/domain/server_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app boots into the server setup shell when no server exists', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverControllerProvider.overrideWith(_EmptyServerController.new),
        ],
        child: const FlumbyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No media servers configured'), findsOneWidget);
  });

  testWidgets('server cards do not overflow on narrow layouts', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(820, 640);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverControllerProvider.overrideWith(_TestServerController.new),
        ],
        child: const FlumbyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Reachable'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _EmptyServerController extends ServerController {
  @override
  ServerRegistryState build() {
    return const ServerRegistryState(isLoading: false);
  }
}

class _TestServerController extends ServerController {
  @override
  ServerRegistryState build() {
    return ServerRegistryState(
      isLoading: false,
      activeServerId: 'emby-test',
      servers: [
        MediaServerProfile(
          id: 'emby-test',
          name: 'Local Emby',
          baseUrl: 'http://127.0.0.1:8096',
          type: MediaServerType.emby,
          username: 'tester',
          isOnline: true,
          updatedAt: DateTime.utc(2026, 3, 25, 12),
        ),
      ],
    );
  }
}
