# File: `lib/features/chat/presentation/chat_screen.dart`

This is the main screen of the application. It ties everything together: the UI, the state management, and the user interaction.

### 1. Imports AND State Definition
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ... other imports

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}
```
**Explanation:**
- `ConsumerStatefulWidget`: This is a Riverpod-specific widget. It gives us access to `ref` (to read providers) AND allows us to have local state (like text controllers). It replaces the standard `StatefulWidget`.

### 2. Local State Management
```dart
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
// ...
```
**Explanation:**
- `_textController`: Controls the input field where users type.
- `_scrollController`: Controls the scrolling of the chat list. We need this to auto-scroll to the bottom when new messages arrive.
- `_sendMessage()`: The core action.
    1. Grabs the text.
    2. Calls `ref.read(chatProvider.notifier).sendMessage(text)` to tell the backend logic to send the message.
    3. Clears the input field.
    4. Scrolls to the bottom.

### 3. Build Implementation & Auto-Scroll
```dart
  @override
  Widget build(BuildContext context) {
    // Listen to chat stream to auto-scroll on new tokens
    ref.listen(chatProvider, (previous, next) {
       if (next.isNotEmpty && !next.last.isUser) {
          // Logic to keep view at bottom if AI is typing...
          _scrollToBottom();
       }
    });

    final messages = ref.watch(chatProvider);
    // ...
```
**Explanation:**
- `ref.listen`: A side-effect listener. It runs code whenever the `chatProvider` state changes (e.g., a new token arrives). We use this to trigger the smooth auto-scroll.
- `ref.watch(chatProvider)`: This REBUILDS the widget whenever the list of messages changes. This is what makes the UI "Reactive". `messages` will always contain the latest list.

### 4. UI Layout (Scaffold & Gradient)
```dart
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows gradient to go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // ... styling with Orbitron font
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              // ... Dark Blue/Teal Gradient
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
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
```
**Explanation:**
- `ListView.builder`: Efficiently renders a list of items. It builds `ChatBubble` widgets for each message in the `messages` list.
- `Expanded`: Tells the list to take up all available space *above* the input area.
- `_buildInputArea()`: A helper helper method (defined below in the file) that returns the `GlassContainer` with the text field and send button.
