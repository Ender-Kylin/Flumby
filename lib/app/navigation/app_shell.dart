import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/server/application/server_controller.dart';
import 'desktop_window_frame.dart';

class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _destinations = <_ShellDestination>[
    _ShellDestination(
      label: '首页',
      icon: Icons.movie_creation_outlined,
      selectedIcon: Icons.movie_creation_rounded,
    ),
    _ShellDestination(
      label: '媒体库',
      icon: Icons.video_library_outlined,
      selectedIcon: Icons.video_library_rounded,
    ),
    _ShellDestination(
      label: '服务器',
      icon: Icons.storage_rounded,
      selectedIcon: Icons.storage,
    ),
    _ShellDestination(
      label: '设置',
      icon: Icons.tune_outlined,
      selectedIcon: Icons.tune_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useRail = MediaQuery.sizeOf(context).width >= 920;
    final currentDestination = _destinations[navigationShell.currentIndex];
    final activeServer = ref.watch(activeServerProvider);
    final activeLine = ref.watch(activeServerLineProvider);
    final useDesktopTitleBar = DesktopWindowFrame.isEnabled;

    final shellScaffold = Scaffold(
      appBar: useDesktopTitleBar
          ? null
          : AppBar(
              title: Text(currentDestination.label),
              actions: [
                if (activeServer != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Center(
                      child: Text(
                        activeLine?.displayName(activeServer.defaultName) ??
                            activeServer.defaultName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                IconButton(
                  tooltip: '搜索当前服务器',
                  onPressed: () => context.push('/search'),
                  icon: const Icon(Icons.search_rounded),
                ),
              ],
            ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF080D13), Color(0xFF0E151D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: useRail
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 0, 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D131B),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.06),
                        ),
                      ),
                      child: NavigationRail(
                        selectedIndex: navigationShell.currentIndex,
                        labelType: NavigationRailLabelType.all,
                        onDestinationSelected: _goToBranch,
                        minWidth: 92,
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF40A6FF), Color(0xFF1E58C7)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Icon(
                              Icons.ondemand_video_rounded,
                              color: Colors.white,
                            ),
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
                  ),
                  const VerticalDivider(width: 1, color: Color(0x1FFFFFFF)),
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

    if (useDesktopTitleBar && Platform.isLinux) {
      return DesktopWindowFrame(
        title: currentDestination.label,
        child: shellScaffold,
      );
    }

    return shellScaffold;
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
