import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sync policy',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Expose WebDAV sync'),
                  subtitle: const Text(
                    'Visible by default in v1 configuration.',
                  ),
                  value: state.webDavEnabled,
                  onChanged: controller.setWebDavEnabled,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Enable Git sync'),
                  subtitle: const Text(
                    'Defaults to off and should only be activated after explicit setup.',
                  ),
                  value: state.gitSyncEnabled,
                  onChanged: controller.setGitSyncEnabled,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mpv defaults',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: state.hardwareDecoding,
                  decoration: const InputDecoration(
                    labelText: 'Hardware decoding',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'auto-safe',
                      child: Text('auto-safe'),
                    ),
                    DropdownMenuItem(value: 'yes', child: Text('yes')),
                    DropdownMenuItem(value: 'no', child: Text('no')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.setHardwareDecoding(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: state.subtitleLanguage,
                  decoration: const InputDecoration(
                    labelText: 'Subtitle language',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'eng', child: Text('English')),
                    DropdownMenuItem(value: 'chi', child: Text('Chinese')),
                    DropdownMenuItem(value: 'jpn', child: Text('Japanese')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.setSubtitleLanguage(value);
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: state.audioLanguage,
                  decoration: const InputDecoration(
                    labelText: 'Audio language',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'eng', child: Text('English')),
                    DropdownMenuItem(value: 'jpn', child: Text('Japanese')),
                    DropdownMenuItem(value: 'zho', child: Text('Chinese')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.setAudioLanguage(value);
                    }
                  },
                ),
                if (Platform.isLinux) ...[
                  const SizedBox(height: 24),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Open playback in a separate window'),
                    subtitle: const Text(
                      'Launch libmpv in its own Linux window by default.',
                    ),
                    value: state.openInSeparateWindow,
                    onChanged: controller.setOpenInSeparateWindow,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Hide Flumby while external playback runs',
                    ),
                    subtitle: const Text(
                      'The main window returns automatically when playback ends or closes.',
                    ),
                    value: state.hideMainWindowDuringExternalPlayback,
                    onChanged:
                        controller.setHideMainWindowDuringExternalPlayback,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
