
class Message {
  final String content;
  final bool isUser;

  const Message({
    required this.content,
    required this.isUser,
  });

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
