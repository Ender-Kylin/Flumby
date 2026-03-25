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
  Future<void> minimizeMainWindow();

  Future<void> restoreMainWindow();
}

class LinuxWindowControlService implements WindowControlService {
  const LinuxWindowControlService();

  static const MethodChannel _channel = MethodChannel('flumby/window_control');

  @override
  Future<void> minimizeMainWindow() {
    return _channel.invokeMethod<void>('minimizeMainWindow');
  }

  @override
  Future<void> restoreMainWindow() {
    return _channel.invokeMethod<void>('restoreMainWindow');
  }
}

class NoopWindowControlService implements WindowControlService {
  const NoopWindowControlService();

  @override
  Future<void> minimizeMainWindow() async {}

  @override
  Future<void> restoreMainWindow() async {}
}
