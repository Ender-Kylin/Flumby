import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/app_preferences_repository.dart';

final settingsControllerProvider =
    NotifierProvider<SettingsController, SettingsState>(SettingsController.new);

class SettingsState {
  const SettingsState({
    this.webDavEnabled = true,
    this.gitSyncEnabled = false,
    this.hardwareDecoding = 'auto-safe',
    this.subtitleLanguage = 'eng',
    this.audioLanguage = 'jpn',
    this.openInSeparateWindow = false,
    this.hideMainWindowDuringExternalPlayback = false,
    this.isHydrated = false,
  });

  factory SettingsState.defaults() {
    final linuxSeparateWindowDefault = Platform.isLinux;
    return SettingsState(
      openInSeparateWindow: linuxSeparateWindowDefault,
      hideMainWindowDuringExternalPlayback: false,
    );
  }

  final bool webDavEnabled;
  final bool gitSyncEnabled;
  final String hardwareDecoding;
  final String subtitleLanguage;
  final String audioLanguage;
  final bool openInSeparateWindow;
  final bool hideMainWindowDuringExternalPlayback;
  final bool isHydrated;

  SettingsState copyWith({
    bool? webDavEnabled,
    bool? gitSyncEnabled,
    String? hardwareDecoding,
    String? subtitleLanguage,
    String? audioLanguage,
    bool? openInSeparateWindow,
    bool? hideMainWindowDuringExternalPlayback,
    bool? isHydrated,
  }) {
    return SettingsState(
      webDavEnabled: webDavEnabled ?? this.webDavEnabled,
      gitSyncEnabled: gitSyncEnabled ?? this.gitSyncEnabled,
      hardwareDecoding: hardwareDecoding ?? this.hardwareDecoding,
      subtitleLanguage: subtitleLanguage ?? this.subtitleLanguage,
      audioLanguage: audioLanguage ?? this.audioLanguage,
      openInSeparateWindow: openInSeparateWindow ?? this.openInSeparateWindow,
      hideMainWindowDuringExternalPlayback:
          hideMainWindowDuringExternalPlayback ??
          this.hideMainWindowDuringExternalPlayback,
      isHydrated: isHydrated ?? this.isHydrated,
    );
  }
}

class SettingsController extends Notifier<SettingsState> {
  static const webDavEnabledKey = 'settings.webDavEnabled';
  static const gitSyncEnabledKey = 'settings.gitSyncEnabled';
  static const hardwareDecodingKey = 'player.hardwareDecoding';
  static const subtitleLanguageKey = 'player.subtitleLanguage';
  static const audioLanguageKey = 'player.audioLanguage';
  static const openInSeparateWindowKey = 'player.openInSeparateWindow';
  static const hideMainWindowDuringExternalPlaybackKey =
      'player.hideMainWindowDuringExternalPlayback';

  bool _hydrating = false;

  @override
  SettingsState build() {
    if (!_hydrating) {
      _hydrating = true;
      unawaited(_hydrate());
    }
    return SettingsState.defaults();
  }

  Future<void> setWebDavEnabled(bool value) async {
    state = state.copyWith(webDavEnabled: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeBool(webDavEnabledKey, value);
  }

  Future<void> setGitSyncEnabled(bool value) async {
    state = state.copyWith(gitSyncEnabled: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeBool(gitSyncEnabledKey, value);
  }

  Future<void> setHardwareDecoding(String value) async {
    state = state.copyWith(hardwareDecoding: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeString(hardwareDecodingKey, value);
  }

  Future<void> setSubtitleLanguage(String value) async {
    state = state.copyWith(subtitleLanguage: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeString(subtitleLanguageKey, value);
  }

  Future<void> setAudioLanguage(String value) async {
    state = state.copyWith(audioLanguage: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeString(audioLanguageKey, value);
  }

  Future<void> setOpenInSeparateWindow(bool value) async {
    state = state.copyWith(openInSeparateWindow: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeBool(openInSeparateWindowKey, value);
  }

  Future<void> setHideMainWindowDuringExternalPlayback(bool value) async {
    state = state.copyWith(hideMainWindowDuringExternalPlayback: value);
    await ref
        .read(appPreferencesRepositoryProvider)
        .writeBool(hideMainWindowDuringExternalPlaybackKey, value);
  }

  Future<void> _hydrate() async {
    final repository = ref.read(appPreferencesRepositoryProvider);
    final defaults = SettingsState.defaults();
    state = SettingsState(
      webDavEnabled:
          await repository.readBool(webDavEnabledKey) ?? defaults.webDavEnabled,
      gitSyncEnabled:
          await repository.readBool(gitSyncEnabledKey) ??
          defaults.gitSyncEnabled,
      hardwareDecoding:
          await repository.readString(hardwareDecodingKey) ??
          defaults.hardwareDecoding,
      subtitleLanguage:
          await repository.readString(subtitleLanguageKey) ??
          defaults.subtitleLanguage,
      audioLanguage:
          await repository.readString(audioLanguageKey) ??
          defaults.audioLanguage,
      openInSeparateWindow:
          await repository.readBool(openInSeparateWindowKey) ??
          defaults.openInSeparateWindow,
      hideMainWindowDuringExternalPlayback:
          await repository.readBool(hideMainWindowDuringExternalPlaybackKey) ??
          defaults.hideMainWindowDuringExternalPlayback,
      isHydrated: true,
    );
  }
}
