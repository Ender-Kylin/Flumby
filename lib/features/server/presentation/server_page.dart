import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/empty_state_card.dart';
import '../application/media_server_access.dart';
import '../application/server_controller.dart';
import '../domain/server_models.dart';

class ServerPage extends ConsumerWidget {
  const ServerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registry = ref.watch(serverControllerProvider);
    final activeServer = ref.watch(activeServerProvider);
    final servers = registry.servers;

    if (registry.isLoading && servers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (servers.isEmpty) {
      return ListView(
        children: [
          EmptyStateCard(
            icon: Icons.storage_rounded,
            title: '尚未配置媒体服务器',
            description:
                '请先添加并登录一个 Emby 服务器。连接成功后，首页、媒体库、搜索、详情和播放都会切换到真实数据。',
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
                  activeServer == null
                      ? '请选择一个 Emby 服务器作为首页、媒体库、搜索和播放的当前数据源。'
                      : '当前启用的服务器：${activeServer.name}',
                ),
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
          _ServerCard(server: server, isActive: activeServer?.id == server.id),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

Future<void> _showAddServerDialog(
  BuildContext context, {
  MediaServerProfile? server,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _AddServerDialog(server: server),
  );
}

class _ServerCard extends ConsumerWidget {
  const _ServerCard({required this.server, required this.isActive});

  final MediaServerProfile server;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final session = ref.watch(serverSessionProvider(server.id));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: server.isOnline
                  ? scheme.secondaryContainer
                  : scheme.surfaceContainerHighest,
              child: Icon(
                server.type == MediaServerType.emby
                    ? Icons.connected_tv
                    : Icons.hub_rounded,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          server.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      if (isActive) const Chip(label: Text('当前服务器')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(server.baseUrl),
                  const SizedBox(height: 4),
                  Text(server.username ?? '未设置用户名'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(server.isOnline ? '可连接' : '离线'),
                      ),
                      Chip(
                        label: Text(switch (session) {
                          AsyncLoading() => '正在检查凭据',
                          AsyncError() => '凭据检查失败',
                          AsyncData(:final value) =>
                            value == null
                                ? '需要重新登录'
                                : '凭据已保存',
                        }),
                      ),
                      TextButton.icon(
                        onPressed: isActive
                            ? null
                            : () => ref
                                  .read(serverControllerProvider.notifier)
                                  .setActiveServer(server.id),
                        icon: const Icon(Icons.radio_button_checked_rounded),
                        label: const Text('设为当前服务器'),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            _showAddServerDialog(context, server: server),
                        icon: const Icon(Icons.login_rounded),
                        label: Text(
                          session.asData?.value == null
                              ? '登录'
                              : '重新登录',
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => ref
                            .read(serverControllerProvider.notifier)
                            .removeServer(server.id),
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: const Text('移除'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddServerDialog extends ConsumerStatefulWidget {
  const _AddServerDialog({this.server});

  final MediaServerProfile? server;

  @override
  ConsumerState<_AddServerDialog> createState() => _AddServerDialogState();
}

class _AddServerDialogState extends ConsumerState<_AddServerDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _baseUrlController;
  late final TextEditingController _usernameController;
  final _passwordController = TextEditingController();

  bool _submitting = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _baseUrlController = TextEditingController(
      text: widget.server?.baseUrl ?? 'http://127.0.0.1:8096',
    );
    _usernameController = TextEditingController(
      text: widget.server?.username ?? '',
    );
  }

  @override
  void dispose() {
    _baseUrlController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.server == null ? '添加 Emby 服务器' : '重新连接 Emby';

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
      final adapter = ref.read(
        mediaServerAdapterProvider(MediaServerType.emby),
      );
      final session = await adapter.signIn(
        ServerSignInRequest(
          baseUrl: _baseUrlController.text.trim(),
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          type: MediaServerType.emby,
        ),
      );
      await ref.read(serverControllerProvider.notifier).saveSession(session);

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
