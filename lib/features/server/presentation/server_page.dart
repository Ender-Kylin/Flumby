import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../application/media_server_access.dart';
import '../application/server_controller.dart';
import '../data/server_local_repository.dart';
import '../domain/server_models.dart';
import 'server_line_switcher.dart';

class ServerPage extends ConsumerWidget {
  const ServerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(serverControllerProvider);
    final activeServer = ref.watch(activeServerProvider);
    final activeLine = ref.watch(activeServerLineProvider);
    final servers = registry.servers;
    final lines = registry.lines;

    if (registry.isLoading && lines.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (lines.isEmpty) {
      return ListView(
        children: [
          EmptyStateCard(
            icon: Icons.storage_rounded,
            title: '尚未配置媒体服务器',
            description:
                '请先添加并登录一个 Emby 服务器。你可以在同一个服务器下保存多条访问线路，并随时切换。',
            action: FilledButton.icon(
              onPressed: () => _showAddServerDialog(context),
              icon: const Icon(Icons.add_link_rounded),
              label: const Text('添加 Emby 服务器'),
            ),
          ),
        ],
      );
    }

    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '已配置的服务器',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  activeServer == null || activeLine == null
                      ? '请选择一个 Emby 线路作为首页、媒体库、搜索和播放的当前数据源。'
                      : '当前启用的线路：${activeLine.displayName(activeServer.defaultName)}',
                ),
                if (activeServer != null && activeLine != null) ...[
                  const SizedBox(height: 4),
                  Text('所属服务器：${activeServer.defaultName}'),
                ],
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => _showAddServerDialog(context),
                  icon: const Icon(Icons.add_link_rounded),
                  label: const Text('添加 Emby 服务器'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final server in servers) ...[
          _ServerArchiveCard(
            server: server,
            lines: registry.linesForServer(server.id),
            activeLine: activeLine?.serverId == server.id ? activeLine : null,
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

Future<void> _showAddServerDialog(
  BuildContext context, {
  MediaServerProfile? server,
  MediaServerLine? line,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _AddServerDialog(server: server, line: line),
  );
}

class _ServerArchiveCard extends StatelessWidget {
  const _ServerArchiveCard({
    required this.server,
    required this.lines,
    required this.activeLine,
  });

  final MediaServerProfile server;
  final List<MediaServerLine> lines;
  final MediaServerLine? activeLine;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.dns_rounded)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        server.defaultName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text('已保存 ${lines.length} 条线路'),
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      _showAddServerDialog(context, server: server),
                  icon: const Icon(Icons.add_link_rounded),
                  label: const Text('添加线路'),
                ),
              ],
            ),
            if (activeLine != null && lines.length > 1) ...[
              const SizedBox(height: 16),
              ServerLineSwitcher(
                activeServer: server,
                activeLine: activeLine!,
                lines: lines,
              ),
            ],
            const SizedBox(height: 16),
            for (final line in lines) ...[
              _ServerLineTile(
                server: server,
                line: line,
                isActive: activeLine?.id == line.id,
              ),
              if (line != lines.last) const Divider(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

class _ServerLineTile extends ConsumerWidget {
  const _ServerLineTile({
    required this.server,
    required this.line,
    required this.isActive,
  });

  final MediaServerProfile server;
  final MediaServerLine line;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final session = ref.watch(serverSessionProvider(line.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    line.displayName(server.defaultName),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    server.defaultName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive) const Chip(label: Text('当前线路')),
          ],
        ),
        const SizedBox(height: 8),
        Text(line.baseUrl),
        const SizedBox(height: 4),
        Text(line.username ?? '未设置用户名'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(label: Text(line.isOnline ? '可连接' : '离线')),
            Chip(
              label: Text(switch (session) {
                AsyncLoading() => '正在检查凭据',
                AsyncError() => '凭据检查失败',
                AsyncData(:final value) =>
                  value == null ? '需要重新登录' : '凭据已保存',
              }),
            ),
            TextButton.icon(
              onPressed: isActive
                  ? null
                  : () => ref
                        .read(serverControllerProvider.notifier)
                        .setActiveServer(line.id),
              icon: const Icon(Icons.radio_button_checked_rounded),
              label: const Text('设为当前线路'),
            ),
            TextButton.icon(
              onPressed: () =>
                  _showAddServerDialog(context, server: server, line: line),
              icon: const Icon(Icons.login_rounded),
              label: Text(
                session.asData?.value == null ? '登录' : '重新登录',
              ),
            ),
            TextButton.icon(
              onPressed: () => ref
                  .read(serverControllerProvider.notifier)
                  .removeServerLine(line.id),
              icon: const Icon(Icons.delete_outline_rounded),
              label: const Text('移除线路'),
            ),
          ],
        ),
      ],
    );
  }
}

class _AddServerDialog extends ConsumerStatefulWidget {
  const _AddServerDialog({this.server, this.line});

  final MediaServerProfile? server;
  final MediaServerLine? line;

  @override
  ConsumerState<_AddServerDialog> createState() => _AddServerDialogState();
}

class _AddServerDialogState extends ConsumerState<_AddServerDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _baseUrlController;
  late final TextEditingController _usernameController;
  final _passwordController = TextEditingController();

  bool _submitting = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.line?.customName ?? '');
    _baseUrlController = TextEditingController(
      text: widget.line?.baseUrl ?? 'http://127.0.0.1:8096',
    );
    _usernameController = TextEditingController(
      text: widget.line?.username ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _baseUrlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.line != null
        ? '重新连接线路'
        : widget.server != null
        ? '添加备用线路'
        : '添加 Emby 服务器';
    final requiresCredentials = widget.server == null || widget.line != null;

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                enabled: !_submitting,
                decoration: const InputDecoration(
                  labelText: '线路名称（可选）',
                  hintText: '例如：内网 / 外网 / CDN',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _baseUrlController,
                enabled: !_submitting,
                decoration: const InputDecoration(
                  labelText: '基础地址',
                  hintText: 'http://127.0.0.1:8096',
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  final normalized = value?.trim() ?? '';
                  if (normalized.isEmpty) {
                    return '请输入 Emby 服务器地址。';
                  }

                  final uri = Uri.tryParse(normalized);
                  if (uri == null || uri.scheme.isEmpty || uri.host.isEmpty) {
                    return '请输入完整 URL，例如 http://127.0.0.1:8096。';
                  }

                  return null;
                },
              ),
              if (requiresCredentials) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  enabled: !_submitting,
                  decoration: const InputDecoration(labelText: '用户名'),
                  validator: (value) {
                    if ((value?.trim() ?? '').isEmpty) {
                      return '请输入 Emby 用户名。';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  enabled: !_submitting,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: '密码'),
                  validator: (value) {
                    if ((value?.trim() ?? '').isEmpty) {
                      return '请输入 Emby 密码。';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _submit(),
                ),
              ] else ...[
                const SizedBox(height: 16),
                Text(
                  '会使用该 Emby 服务器已保存的账号密码重新登录新线路地址。',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (_errorText != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: Text(_submitting ? '连接中...' : '连接'),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _submitting = true;
      _errorText = null;
    });

    try {
      final customName = _nameController.text.trim().isEmpty
          ? null
          : _nameController.text.trim();
      final baseUrl = _baseUrlController.text.trim().replaceFirst(
        RegExp(r'/$'),
        '',
      );
      final controller = ref.read(serverControllerProvider.notifier);

      if (widget.server != null && widget.line == null) {
        final repository = ref.read(serverLocalRepositoryProvider);
        final credentials = await repository.loadServerCredentials(
          widget.server!.id,
        );
        if (credentials == null) {
          throw StateError('请先在任意线路重新登录，再添加新线路。');
        }
        final adapter = ref.read(mediaServerAdapterProvider(widget.server!.type));
        final session = await adapter.signIn(
          ServerSignInRequest(
            baseUrl: baseUrl,
            username: credentials.username,
            password: credentials.password,
            customName: customName,
            type: widget.server!.type,
          ),
        );
        if (session.server.id != widget.server!.id) {
          throw StateError('该线路连接到了另一个 Emby 服务器，请检查地址是否正确。');
        }
        await controller.saveSession(session, password: credentials.password);
      } else {
        final adapter = ref.read(
          mediaServerAdapterProvider(MediaServerType.emby),
        );
        final session = await adapter.signIn(
          ServerSignInRequest(
            baseUrl: baseUrl,
            username: _usernameController.text.trim(),
            password: _passwordController.text,
            customName: customName,
            type: MediaServerType.emby,
          ),
        );
        if (widget.server != null && session.server.id != widget.server!.id) {
          throw StateError('该线路连接到了另一个 Emby 服务器，请检查地址是否正确。');
        }
        await controller.saveSession(
          session,
          password: _passwordController.text,
        );
      }

      if (mounted) {
        Navigator.of(context).pop();
      }
    } on DioException catch (error) {
      final message = error.response?.data is Map<String, dynamic>
          ? (error.response?.data as Map<String, dynamic>)['Message']
                    ?.toString() ??
                error.message
          : error.message;
      setState(() {
        _errorText = message ?? '连接 Emby 服务器失败。';
      });
    } catch (error) {
      setState(() {
        _errorText = error.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }
}
