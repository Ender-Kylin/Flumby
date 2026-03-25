import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/server/application/server_controller.dart';
import '../../platform/window/window_control_service.dart';

class DesktopWindowFrame extends StatelessWidget {
  const DesktopWindowFrame({
    required this.title,
    required this.child,
    this.showSearchAction = true,
    this.showBackButton = false,
    super.key,
  });

  final String title;
  final Widget child;
  final bool showSearchAction;
  final bool showBackButton;

  static bool get isEnabled => !kIsWeb && Platform.isLinux;

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) {
      return child;
    }

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          LinuxTitleBar(
            title: title,
            showSearchAction: showSearchAction,
            showBackButton: showBackButton,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class LinuxTitleBar extends ConsumerStatefulWidget {
  const LinuxTitleBar({
    required this.title,
    this.showSearchAction = true,
    this.showBackButton = false,
    super.key,
  });

  final String title;
  final bool showSearchAction;
  final bool showBackButton;

  @override
  ConsumerState<LinuxTitleBar> createState() => _LinuxTitleBarState();
}

class _LinuxTitleBarState extends ConsumerState<LinuxTitleBar> {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    _refreshMaximizedState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final activeServer = ref.watch(activeServerProvider);
    final windowControl = ref.read(windowControlServiceProvider);

    return Material(
      color: const Color(0xFF0B1118),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 760;
          final showServerName = constraints.maxWidth >= 680;
          final showSearchAction =
              widget.showSearchAction && constraints.maxWidth >= 700;

          return Container(
            height: 58,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.28),
                ),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                if (widget.showBackButton)
                  _WindowActionButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Back',
                    compact: compact,
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        context.pop();
                      }
                    },
                  ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (event) {
                      if (event.kind == PointerDeviceKind.mouse &&
                          event.buttons == kPrimaryMouseButton) {
                        unawaited(
                          windowControl.startWindowDrag(event.position),
                        );
                      }
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onDoubleTap: _toggleMaximize,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          if (showServerName)
                            Text(
                              activeServer?.name ?? 'Flumby',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showSearchAction)
                      _WindowActionButton(
                        icon: Icons.search_rounded,
                        tooltip: 'Search',
                        compact: compact,
                        onPressed: () => context.push('/search'),
                      ),
                    _WindowActionButton(
                      icon: Icons.minimize_rounded,
                      tooltip: 'Minimize',
                      compact: compact,
                      onPressed: () => windowControl.minimizeMainWindow(),
                    ),
                    _WindowActionButton(
                      icon: _isMaximized
                          ? Icons.filter_none_rounded
                          : Icons.crop_square_rounded,
                      tooltip: _isMaximized ? 'Restore' : 'Maximize',
                      compact: compact,
                      onPressed: _toggleMaximize,
                    ),
                    _WindowActionButton(
                      icon: Icons.close_rounded,
                      tooltip: 'Close',
                      compact: compact,
                      onPressed: () => windowControl.closeMainWindow(),
                      hoverColor: const Color(0xFFE05252),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _refreshMaximizedState() async {
    final isMaximized = await ref
        .read(windowControlServiceProvider)
        .isMainWindowMaximized();
    if (!mounted) {
      return;
    }

    setState(() {
      _isMaximized = isMaximized;
    });
  }

  Future<void> _toggleMaximize() async {
    await ref.read(windowControlServiceProvider).toggleMaximizeMainWindow();
    await _refreshMaximizedState();
  }
}

class _WindowActionButton extends StatefulWidget {
  const _WindowActionButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.compact = false,
    this.hoverColor,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool compact;
  final Color? hoverColor;

  @override
  State<_WindowActionButton> createState() => _WindowActionButtonState();
}

class _WindowActionButtonState extends State<_WindowActionButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _hovering
        ? (widget.hoverColor ?? Colors.white.withValues(alpha: 0.08))
        : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Tooltip(
        message: widget.tooltip,
        child: InkWell(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            width: widget.compact ? 40 : 44,
            height: 58,
            color: backgroundColor,
            alignment: Alignment.center,
            child: Icon(widget.icon, size: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
