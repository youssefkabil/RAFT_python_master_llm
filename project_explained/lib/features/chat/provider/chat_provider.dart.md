# File: `lib/features/chat/provider/chat_provider.dart`

This is the "Brain" of the chat feature. It manages the state (the list of messages) and handles the business logic (sending requests, processing streams).

### 1. Setup & Annotations
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
// ... imports

part 'chat_provider.g.dart';

@riverpod
ApiService backendApi(Ref ref) {
  return ApiService();
}
```
**Explanation:**
- `@riverpod`: This annotation tells the `riverpod_generator` package to automatically generate the necessary provider code (in `chat_provider.g.dart`). This makes the syntax much cleaner.
- `backendApi`: A simple provider that gives us an instance of our `ApiService`.

### 2. Chat Notifier Class
```dart
@riverpod
class Chat extends _$Chat {
  @override
  List<Message> build() {
    return []; // Initial state is an empty list of messages
  }
```
**Explanation:**
- `class Chat extends _$Chat`: Defines a Riverpod "Notifier". This class holds the state (`List<Message>`) and methods to modify it.
- `build()`: The initialization method. We start with an empty chat.

### 3. Send Message Logic (Refined)
```dart
  Future<void> sendMessage(String prompt) async {
    // 1. Add User Message immediately so it appears on screen
    state = [...state, Message(content: prompt, isUser: true)];

    // 2. Add an "Empty" AI Message as a placeholder
    state = [...state, const Message(content: '', isUser: false)];
    final aiMessageIndex = state.length - 1; // Track where this message is

    try {
      // 3. Start the stream from the API
      final stream = ref.read(backendApiProvider).generateStream(prompt);
      
      await for (final token in stream) {
        // ... Process each chunk of text
        final currentMessages = [...state];
        final lastMessage = currentMessages[aiMessageIndex];
        
        // Append new token to existing content
        String newContent = lastMessage.content + token; 
        
        // Update the state with the new content
        currentMessages[aiMessageIndex] = lastMessage.copyWith(
          content: newContent,
        );
        state = currentMessages; // Trigger UI rebuild
      }
    } catch (e) {
       // ... Handle errors by updating the message with the error text
    }
  }
}
```
**Explanation:**
- **Optimistic UI**: We add the user's message to the `state` *immediately* so the UI feels responsive, without waiting for the network.
- **Streaming**:
    - We request a `Stream` from our `ApiService`.
    - `await for (final token in stream)`: This loop runs every time a new piece of text arrives from the server.
    - Inside the loop, we find the "Placeholder" AI message we created and append the new text to it.
    - `state = currentMessages`: **Crucial Step**. In Riverpod, to update the UI, you must assign a *new* value to `state`. We replace the old list with the updated list, causing `chat_screen.dart` to rebuild and show the new text text as if it's being typed in real-time.
