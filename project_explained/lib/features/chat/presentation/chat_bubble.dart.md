# File: `lib/features/chat/presentation/chat_bubble.dart`

This file defines how a single chat message looks on the screen. It decides the color, alignment, and formatting (supporting Markdown for code).

### 1. Imports
```dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kabil_jedraoui/core/widgets/glass_container.dart';
import 'package:kabil_jedraoui/features/chat/models/message.dart';
```
**Explanation:**
- `flutter_markdown`: A critical library. Since the AI sends back Python code formatted as Markdown (e.g., inside \`\`\` code blocks), we need this to render it correctly instead of showing raw text.
- `glass_container.dart`: We reuse our custom glass widget to make the bubbles look nice.

### 2. Styling Logic
```dart
class ChatBubble extends StatelessWidget {
  final Message message;
  // ...

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    
    // Align User to right (end), AI to left (start)
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    
    // User gets Blue tint, AI gets Grey tint
    final color = isUser
        ? Colors.blue.withOpacity(0.2)
        : Colors.grey.withOpacity(0.1);
    
    // ...
```
**Explanation:**
- We check `message.isUser` to determine the style:
    - **Alignment**: User messages go to the right (`CrossAxisAlignment.end`), AI messages stay on the left.
    - **Color**: User messages are blueish, AI messages are greyish. Both uses `opacity` to keep the glass effect visible.

### 3. Rendering Content (Text vs Markdown)
```dart
    return Column(
      crossAxisAlignment: align,
      children: [
        GlassContainer(
          // ... margins and padding
          color: color,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: isUser
                ? Text(
                    message.content,
                    style: GoogleFonts.inter(color: textColor, fontSize: 16),
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
                      // ...
                    ),
                  ),
          ),
        ),
      ],
    );
```
**Explanation:**
- `GlassContainer`: Wraps the text bubble to give it that frosted look.
- `ConstrainedBox`: Limits the width (max 300 pixels) so the bubble doesn't stretch across the entire screen.
- **Conditional Rendering (`isUser ? ... : ...`)**:
    - **If User**: We use a simple `Text` widget because users just type plain text.
    - **If AI**: We use `MarkdownBody`.
        - `selectable: true`: Allows the user to copy/paste code.
        - `MarkdownStyleSheet`: We customize the markdown:
            - `p`: Paragraph text uses our 'Inter' font.
            - `code`: Inline code and code blocks use 'RobotoMono' (a monospaced coding font) and are styled with a dark background and green text for that "hacker/terminal" vibe.
