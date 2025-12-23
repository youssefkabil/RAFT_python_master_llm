
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabil_jedraoui/core/widgets/glass_container.dart';
import 'package:kabil_jedraoui/features/chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isUser
        ? Colors.blue.withOpacity(0.2)
        : Colors.grey.withOpacity(0.1);
    final textColor = Colors.white;

    return Column(
      crossAxisAlignment: align,
      children: [
        GlassContainer(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: const EdgeInsets.all(12.0),
          color: color,
          borderRadius: 12.0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: isUser
                ? Text(
                    message.content,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: 16,
                    ),
                  )
                : MarkdownBody(
                    data: message.content,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                      p: GoogleFonts.inter(color: textColor, fontSize: 16),
                      code: GoogleFonts.robotoMono(
                        color: Colors.greenAccent,
                        backgroundColor: Colors.black54,
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
