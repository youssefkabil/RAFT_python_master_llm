
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabil_jedraoui/core/widgets/glass_container.dart';
import 'package:kabil_jedraoui/features/chat/presentation/chat_bubble.dart';
import 'package:kabil_jedraoui/features/chat/provider/chat_provider.dart';
import 'package:kabil_jedraoui/features/settings/settings_dialog.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      ref.read(chatProvider.notifier).sendMessage(text);
      _textController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to chat stream to auto-scroll on new tokens (optional refinement: throttling)
    ref.listen(chatProvider, (previous, next) {
      // Simple heuristic: if length changed or last message content changed significantly
       // For streaming, we might want to stay sticky to bottom if already at bottom.
       // For now, just scroll to bottom if it's the AI typing.
       if (next.isNotEmpty && !next.last.isUser) {
          // Check if we are close to bottom
          if (_scrollController.hasClients && 
              _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
             _scrollToBottom();
          }
       } else {
         _scrollToBottom();
       }
    });

    final messages = ref.watch(chatProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Anti-Gravity Tutor',
          style: GoogleFonts.orbitron(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.purpleAccent,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SettingsDialog(),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 100, bottom: 20),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: messages[index]);
                },
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return GlassContainer(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      borderRadius: 30.0,
      color: Colors.black.withOpacity(0.3),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ask your python question...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, color: Colors.purpleAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
