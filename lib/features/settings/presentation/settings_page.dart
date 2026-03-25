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
                  '同步策略',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('启用 WebDAV 同步'),
                  subtitle: const Text(
                    '在 v1 配置中默认可见。',
                  ),
                  value: state.webDavEnabled,
                  onChanged: controller.setWebDavEnabled,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('启用 Git 同步'),
                  subtitle: const Text(
                    '默认关闭，仅在完成明确配置后启用。',
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
                  'mpv 默认值',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: state.hardwareDecoding,
                  decoration: const InputDecoration(
                    labelText: '硬件解码',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'auto-safe',
                      child: Text('自动安全'),
                    ),
                    DropdownMenuItem(value: 'yes', child: Text('是')),
                    DropdownMenuItem(value: 'no', child: Text('否')),
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
                    labelText: '字幕语言',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'eng', child: Text('英语')),
                    DropdownMenuItem(value: 'chi', child: Text('中文')),
                    DropdownMenuItem(value: 'jpn', child: Text('日语')),
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
                    labelText: '音轨语言',
                  ),
                  items: const [
                    DropdownMenuItem(value: 'eng', child: Text('英语')),
                    DropdownMenuItem(value: 'jpn', child: Text('日语')),
                    DropdownMenuItem(value: 'zho', child: Text('中文')),
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
                    title: const Text('在独立窗口中打开播放'),
                    subtitle: const Text(
                      '默认在 Linux 的独立窗口中启动 libmpv 播放。',
                    ),
                    value: state.openInSeparateWindow,
                    onChanged: controller.setOpenInSeparateWindow,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      '外部播放时最小化 Flumby',
                    ),
                    subtitle: const Text(
                      '播放结束或窗口关闭时，Flumby 会最小化到任务栏并自动恢复。',
                    ),
                    value: state.minimizeMainWindowDuringExternalPlayback,
                    onChanged:
                        controller.setMinimizeMainWindowDuringExternalPlayback,
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
