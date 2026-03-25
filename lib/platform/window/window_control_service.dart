import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final windowControlServiceProvider = Provider<WindowControlService>((ref) {
  if (Platform.isLinux) {
    return const LinuxWindowControlService();
  }

  return const NoopWindowControlService();
});

abstract interface class WindowControlService {
  Future<void> startWindowDrag(Offset globalPosition);

  Future<void> minimizeMainWindow();

  Future<void> restoreMainWindow();

  Future<void> toggleMaximizeMainWindow();

  Future<bool> isMainWindowMaximized();

  Future<void> closeMainWindow();
}

class LinuxWindowControlService implements WindowControlService {
  const LinuxWindowControlService();

  static const MethodChannel _channel = MethodChannel('flumby/window_control');

  @override
  Future<void> startWindowDrag(Offset globalPosition) async {
    await _invokeVoid('startWindowDrag', {
      'x': globalPosition.dx,
      'y': globalPosition.dy,
    });
  }

  @override
  Future<void> minimizeMainWindow() async {
    await _invokeVoid('minimizeMainWindow');
  }

  @override
  Future<void> restoreMainWindow() async {
    await _invokeVoid('restoreMainWindow');
  }

  @override
  Future<void> toggleMaximizeMainWindow() async {
    await _invokeVoid('toggleMaximizeMainWindow');
  }

  @override
  Future<bool> isMainWindowMaximized() async {
    try {
      return await _channel.invokeMethod<bool>('isMainWindowMaximized') ??
          false;
    } on MissingPluginException {
      return false;
    }
  }

  @override
  Future<void> closeMainWindow() async {
    await _invokeVoid('closeMainWindow');
  }

  Future<void> _invokeVoid(String method, [Object? arguments]) async {
    try {
      await _channel.invokeMethod<void>(method, arguments);
    } on MissingPluginException {
      return;
    }
  }
}

class NoopWindowControlService implements WindowControlService {
  const NoopWindowControlService();

  @override
  Future<void> startWindowDrag(Offset globalPosition) async {}

  @override
  Future<void> minimizeMainWindow() async {}

  @override
  Future<void> restoreMainWindow() async {}

  @override
  Future<void> toggleMaximizeMainWindow() async {}

  @override
  Future<bool> isMainWindowMaximized() async => false;

  @override
  Future<void> closeMainWindow() async {}
}
