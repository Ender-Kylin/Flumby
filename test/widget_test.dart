import 'package:flumby/app/flumby_app.dart';
import 'package:flumby/core/widgets/emby_media_widgets.dart';
import 'package:flumby/features/home/domain/home_models.dart';
import 'package:flumby/features/home/presentation/home_page.dart';
import 'package:flumby/features/library/domain/library_models.dart';
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

    expect(find.text('尚未配置媒体服务器'), findsOneWidget);
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

  testWidgets('home page shows line switcher and continue watching first', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(430, 900);
    addTearDown(tester.view.reset);

    await _pumpHomePage(
      tester,
      activeLineId: _homeTestLines.first.id,
      homeFeed: HomeFeed(
        continueWatching: [
          _homeMediaItem(id: 'continue-1', title: '正在播放'),
        ],
        sections: [
          HomeSection(
            id: 'recent',
            title: '最近添加',
            items: [_homeMediaItem(id: 'recent-1', title: '最新电影')],
          ),
        ],
      ),
    );

    expect(find.byKey(const Key('home-server-switcher')), findsOneWidget);
    expect(find.text('当前线路'), findsOneWidget);
    expect(find.text('继续观看'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home page switches active line from the top menu', (
    tester,
  ) async {
    await _pumpHomePage(
      tester,
      activeLineId: _homeTestLines.first.id,
      homeFeed: HomeFeed(
        continueWatching: [
          _homeMediaItem(id: 'continue-1', title: '正在播放'),
        ],
      ),
    );

    await tester.tap(find.byKey(const Key('home-server-switcher')));
    await tester.pumpAndSettle();

    expect(find.text('卧室线路'), findsOneWidget);

    await tester.tap(find.text('卧室线路'));
    await tester.pumpAndSettle();

    expect(find.text('卧室线路'), findsOneWidget);
  });
}

Future<void> _pumpHomePage(
  WidgetTester tester, {
  required String activeLineId,
  required HomeFeed homeFeed,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        serverControllerProvider.overrideWith(
          () => _HomePageTestController(
            ServerRegistryState(
              isLoading: false,
              activeLineId: activeLineId,
              servers: _homeTestServers,
              lines: _homeTestLines,
            ),
          ),
        ),
        activeHomeFeedProvider.overrideWith((ref) async => homeFeed),
      ],
      child: const MaterialApp(home: Scaffold(body: HomePage())),
    ),
  );
  await tester.pumpAndSettle();
}

class _EmptyServerController extends ServerController {
  @override
  ServerRegistryState build() {
    return const ServerRegistryState(isLoading: false);
  }
}

class _HomePageTestController extends ServerController {
  _HomePageTestController(this._initialState);

  final ServerRegistryState _initialState;

  @override
  ServerRegistryState build() {
    return _initialState;
  }

  @override
  Future<void> setActiveServer(String serverId) async {
    state = state.copyWith(activeLineId: serverId, isLoading: false);
  }
}

final _homeTestServers = [
  MediaServerProfile(
    id: 'server-a',
    defaultName: '客厅 Emby',
    type: MediaServerType.emby,
    updatedAt: DateTime.utc(2026, 3, 25, 10),
  ),
];

final _homeTestLines = [
  MediaServerLine(
    id: buildMediaServerLineId(
      serverId: 'server-a',
      baseUrl: 'http://192.168.1.2:8096',
    ),
    serverId: 'server-a',
    customName: '客厅线路',
    baseUrl: 'http://192.168.1.2:8096',
    type: MediaServerType.emby,
    username: 'alice',
    isOnline: true,
    updatedAt: DateTime.utc(2026, 3, 25, 10),
  ),
  MediaServerLine(
    id: buildMediaServerLineId(
      serverId: 'server-a',
      baseUrl: 'http://192.168.1.3:8096',
    ),
    serverId: 'server-a',
    customName: '卧室线路',
    baseUrl: 'http://192.168.1.3:8096',
    type: MediaServerType.emby,
    username: 'bob',
    isOnline: true,
    updatedAt: DateTime.utc(2026, 3, 25, 11),
  ),
];

MediaItemSummary _homeMediaItem({
  required String id,
  required String title,
}) {
  return MediaItemSummary(
    id: id,
    serverId: _homeTestLines.first.id,
    libraryId: 'library-1',
    title: title,
    overview: '$title 的简介',
    runtimeSeconds: 1500,
    progress: 0.35,
    isResumable: true,
    year: 2026,
  );
}
