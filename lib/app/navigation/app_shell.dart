import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/server/application/server_controller.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _destinations = <_ShellDestination>[
    _ShellDestination(
      label: 'Servers',
      icon: Icons.storage_rounded,
      selectedIcon: Icons.storage,
    ),
    _ShellDestination(
      label: 'Home',
      icon: Icons.movie_creation_outlined,
      selectedIcon: Icons.movie_creation_rounded,
    ),
    _ShellDestination(
      label: 'Libraries',
      icon: Icons.video_library_outlined,
      selectedIcon: Icons.video_library_rounded,
    ),
    _ShellDestination(
      label: 'Settings',
      icon: Icons.tune_outlined,
      selectedIcon: Icons.tune_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useRail = MediaQuery.sizeOf(context).width >= 920;
    final currentDestination = _destinations[navigationShell.currentIndex];
    final activeServer = ref.watch(activeServerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentDestination.label),
        actions: [
          if (activeServer != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Chip(
                    avatar: const Icon(Icons.dns_rounded, size: 18),
                    label: Text(
                      activeServer.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
          IconButton(
            tooltip: 'Search current server',
            onPressed: () => context.push('/search'),
            icon: const Icon(Icons.search_rounded),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Emby-first v1',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: useRail
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 0, 20),
                  child: NavigationRail(
                    selectedIndex: navigationShell.currentIndex,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: _goToBranch,
                    leading: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F4C81), Color(0xFFD79B3B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.ondemand_video,
                        color: Colors.white,
                      ),
                    ),
                    destinations: [
                      for (final destination in _destinations)
                        NavigationRailDestination(
                          icon: Icon(destination.icon),
                          selectedIcon: Icon(destination.selectedIcon),
                          label: Text(destination.label),
                        ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: navigationShell,
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: navigationShell,
            ),
      bottomNavigationBar: useRail
          ? null
          : NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goToBranch,
              destinations: [
                for (final destination in _destinations)
                  NavigationDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.selectedIcon),
                    label: destination.label,
                  ),
              ],
            ),
    );
  }

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
