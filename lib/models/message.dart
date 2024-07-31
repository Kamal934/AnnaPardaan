class Message {
  final String senderId;
  final String senderName;
  final String receiverId;
  final String message;
  final String timestamp;

  Message({
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      senderName: json['senderName'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
