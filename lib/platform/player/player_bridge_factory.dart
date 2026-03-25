import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mpv/mpv_player_bridge.dart';
import 'player_bridge.dart';

typedef PlayerBridgeFactoryCallback = PlayerBridge Function();

final playerBridgeFactoryProvider = Provider<PlayerBridgeFactoryCallback>((
  ref,
) {
  return PlayerBridgeFactory.create;
});

class PlayerBridgeFactory {
  static PlayerBridge create() {
    if (Platform.isWindows || Platform.isLinux) {
      return MpvPlayerBridge();
    }

    return StubPlayerBridge();
  }
}
