
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:kabil_jedraoui/core/services/api_service.dart';
import 'package:kabil_jedraoui/features/chat/models/message.dart';

part 'chat_provider.g.dart';

@riverpod
ApiService backendApi(Ref ref) {
  return ApiService();
}

@riverpod
class Chat extends _$Chat {
  @override
  List<Message> build() {
    return [];
  }

  // Helper to clean ghost characters
  String _cleanResponse(String text, {bool isFinal = false}) {
    // Remove non-ASCII characters from the end
    String cleaned = text.replaceAll(RegExp(r'[^\x00-\x7F]+$'), '');
    if (isFinal) {
      cleaned = cleaned.trim();
    }
    return cleaned;
  }

  Future<void> sendMessage(String prompt) async {
    // 1. Add User Message
    state = [...state, Message(content: prompt, isUser: true)];

    // 2. Add Placeholder AI Message
    state = [...state, const Message(content: '', isUser: false)];
    final aiMessageIndex = state.length - 1;

    try {
      // 3. Stream response
      final stream = ref.read(backendApiProvider).generateStream(prompt);
      
      await for (final token in stream) {
        // Update the last message (AI) with new token
        final currentMessages = [...state];
        final lastMessage = currentMessages[aiMessageIndex];
        
        // Clean accumulated text slightly (without trim) to remove ghost chars as they appear
        final newContent = _cleanResponse(lastMessage.content + token, isFinal: false);
        
        currentMessages[aiMessageIndex] = lastMessage.copyWith(
          content: newContent,
        );
        state = currentMessages;
      }

      // 4. Final cleanup (trim)
      final currentMessages = [...state];
      final lastMessage = currentMessages[aiMessageIndex];
      currentMessages[aiMessageIndex] = lastMessage.copyWith(
        content: _cleanResponse(lastMessage.content, isFinal: true),
      );
      state = currentMessages;

    } catch (e) {
       // Handle error (append error message)
        final currentMessages = [...state];
        final lastMessage = currentMessages[aiMessageIndex];
        currentMessages[aiMessageIndex] = lastMessage.copyWith(
          content: "${lastMessage.content}\n\n[Error: $e]",
        );
        state = currentMessages;
    }
  }
}
