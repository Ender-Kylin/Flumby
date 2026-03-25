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
            title: 'No media servers configured',
            description:
                'Add and sign in to an Emby server first. Once a server is available, home, libraries, search, detail pages, and playback switch to real data.',
            action: FilledButton.icon(
              onPressed: () => _showAddServerDialog(context),
              icon: const Icon(Icons.add_link_rounded),
              label: const Text('Add Emby Server'),
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
                  'Configured servers',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  activeServer == null
                      ? 'Pick an Emby server as the active source for home, libraries, search, and playback.'
                      : 'Current active server: ${activeServer.name}',
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => _showAddServerDialog(context),
                  icon: const Icon(Icons.add_link_rounded),
                  label: const Text('Add Emby Server'),
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
                      if (isActive) const Chip(label: Text('Active server')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(server.baseUrl),
                  const SizedBox(height: 4),
                  Text(server.username ?? 'No username'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(server.isOnline ? 'Reachable' : 'Offline'),
                      ),
                      Chip(
                        label: Text(switch (session) {
                          AsyncLoading() => 'Checking credentials',
                          AsyncError() => 'Credential check failed',
                          AsyncData(:final value) =>
                            value == null
                                ? 'Login required'
                                : 'Credentials saved',
                        }),
                      ),
                      TextButton.icon(
                        onPressed: isActive
                            ? null
                            : () => ref
                                  .read(serverControllerProvider.notifier)
                                  .setActiveServer(server.id),
                        icon: const Icon(Icons.radio_button_checked_rounded),
                        label: const Text('Use this server'),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            _showAddServerDialog(context, server: server),
                        icon: const Icon(Icons.login_rounded),
                        label: Text(
                          session.asData?.value == null
                              ? 'Sign in'
                              : 'Re-login',
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => ref
                            .read(serverControllerProvider.notifier)
                            .removeServer(server.id),
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: const Text('Remove'),
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
    final title = widget.server == null ? 'Add Emby Server' : 'Reconnect Emby';

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
                  labelText: 'Base URL',
                  hintText: 'http://127.0.0.1:8096',
                ),
                keyboardType: TextInputType.url,
                validator: (value) {
                  final normalized = value?.trim() ?? '';
                  if (normalized.isEmpty) {
                    return 'Enter your Emby server URL.';
                  }

                  final uri = Uri.tryParse(normalized);
                  if (uri == null || uri.scheme.isEmpty || uri.host.isEmpty) {
                    return 'Use a full URL like http://127.0.0.1:8096.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                enabled: !_submitting,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if ((value?.trim() ?? '').isEmpty) {
                    return 'Enter your Emby username.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                enabled: !_submitting,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if ((value?.trim() ?? '').isEmpty) {
                    return 'Enter your Emby password.';
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
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: Text(_submitting ? 'Connecting...' : 'Connect'),
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
        _errorText = message ?? 'Failed to connect to the Emby server.';
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
