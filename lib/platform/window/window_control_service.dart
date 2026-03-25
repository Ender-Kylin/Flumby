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
  Future<void> hideMainWindow();

  Future<void> showMainWindow();

  Future<void> presentMainWindow();
}

class LinuxWindowControlService implements WindowControlService {
  const LinuxWindowControlService();

  static const MethodChannel _channel = MethodChannel('flumby/window_control');

  @override
  Future<void> hideMainWindow() {
    return _channel.invokeMethod<void>('hideMainWindow');
  }

  @override
  Future<void> presentMainWindow() {
    return _channel.invokeMethod<void>('presentMainWindow');
  }

  @override
  Future<void> showMainWindow() {
    return _channel.invokeMethod<void>('showMainWindow');
  }
}

class NoopWindowControlService implements WindowControlService {
  const NoopWindowControlService();

  @override
  Future<void> hideMainWindow() async {}

  @override
  Future<void> presentMainWindow() async {}

  @override
  Future<void> showMainWindow() async {}
}
