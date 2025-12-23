
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kabil_jedraoui/features/chat/provider/chat_provider.dart';

class SettingsDialog extends ConsumerStatefulWidget {
  const SettingsDialog({super.key});

  @override
  ConsumerState<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends ConsumerState<SettingsDialog> {
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1a1a2e),
      title: const Text('Server Settings', style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter the Ngrok URL for the backend:',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _urlController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'https://....ngrok-free.app',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.purpleAccent),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            final url = _urlController.text.trim();
            if (url.isNotEmpty) {
              ref.read(chatProvider.notifier).updateApiUrl(url);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('API URL Updated!')),
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
