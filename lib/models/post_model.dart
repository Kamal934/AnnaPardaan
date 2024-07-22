class Post {
  String id;
  String authorName;
  String content;
  DateTime timestamp;

  Post({
    required this.id,
    required this.authorName,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'authorName': authorName,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  static Post fromMap(Map<String, dynamic> map, String documentId) {
    return Post(
      id: documentId,
      authorName: map['authorName'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
