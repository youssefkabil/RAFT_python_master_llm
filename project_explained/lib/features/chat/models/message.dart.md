# File: `lib/features/chat/models/message.dart`

This file defines the data model for a single chat message. It is a simple class used to store the text and who sent it.

### 1. Message Class Definition
```dart
class Message {
  final String content;
  final bool isUser;

  const Message({
    required this.content,
    required this.isUser,
  });
```
**Explanation:**
- `Message`: A plain Dart class (POJO).
- `final String content`: Stores the actual text of the message (e.g., "Hello" or a Python code snippet). `final` means it cannot be changed once set.
- `final bool isUser`: A boolean flag.
    - `true`: The message was sent by the user.
    - `false`: The message was sent by the AI.
- `const Message(...)`: The constructor is constant, which helps with performance in Flutter.

### 2. CopyWith Method
```dart
  Message copyWith({
    String? content,
    bool? isUser,
  }) {
    return Message(
      content: content ?? this.content,
      isUser: isUser ?? this.isUser,
    );
  }
}
```
**Explanation:**
- `copyWith`: A helper method commonly used with immutable classes.
- Since our fields are `final`, we cannot edit a message directly. Instead, `copyWith` creates a **new** `Message` instance that copies the existing values but allows us to replace specific ones.
- **Usage:** This is extremely useful for streaming responses. We take the valid "AI Message" and keep calling `copyWith(content: newText)` as new tokens arrive from the server.
