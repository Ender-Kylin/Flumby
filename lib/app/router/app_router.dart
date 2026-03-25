import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/detail/presentation/detail_page.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/library/presentation/library_page.dart';
import '../../features/player/presentation/player_page.dart';
import '../../features/search/presentation/search_page.dart';
import '../../features/server/presentation/server_page.dart';
import '../../features/settings/presentation/settings_page.dart';
import '../navigation/app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/servers',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/servers',
                builder: (context, state) => const ServerPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/libraries',
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
      GoRoute(
        path: '/detail/:serverId/:itemId',
        builder: (context, state) {
          final serverId = state.pathParameters['serverId']!;
          final itemId = state.pathParameters['itemId']!;
          final title = state.uri.queryParameters['title'];

          return DetailPage(serverId: serverId, itemId: itemId, title: title);
        },
      ),
      GoRoute(
        path: '/player/:serverId/:itemId',
        builder: (context, state) {
          final serverId = state.pathParameters['serverId']!;
          final itemId = state.pathParameters['itemId']!;
          final title = state.uri.queryParameters['title'];

          return PlayerPage(serverId: serverId, itemId: itemId, title: title);
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Route Error')),
        body: Center(
          child: Text(
            state.error?.toString() ?? 'Unknown navigation error',
            textAlign: TextAlign.center,
          ),
        ),
      );
    },
  );
});
