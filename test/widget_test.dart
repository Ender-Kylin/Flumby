import 'package:flumby/app/flumby_app.dart';
import 'package:flumby/core/widgets/emby_media_widgets.dart';
import 'package:flumby/features/server/application/server_controller.dart';
import 'package:flumby/features/server/domain/server_models.dart';
import 'package:flutter/material.dart';
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
    expect(find.byTooltip('Search'), findsOneWidget);
    expect(find.byTooltip('Minimize'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('poster media cards keep long titles inside the card', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(1.05)),
          child: Scaffold(
            body: Center(
              child: SizedBox(
                width: PosterMediaCard.cardWidth,
                height: PosterMediaCard.cardHeight,
                child: PosterMediaCard(
                  title: '安逸领主的愉快领地防卫与生产魔术',
                  subtitle: '2025 • 24 min',
                  progress: 0.62,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('安逸领主'), findsOneWidget);
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
