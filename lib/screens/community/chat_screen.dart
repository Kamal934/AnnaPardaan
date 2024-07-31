import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../providers/chat_provider.dart';
import '../../utils/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserId;
  final String chatRoomId;

  const ChatScreen({
    super.key,
    required this.receiverUserName,
    required this.receiverUserId,
    required this.chatRoomId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      await _chatService.sendMessage(widget.chatRoomId, message);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(widget.receiverUserId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('User not found');
            }
            final user = snapshot.data!;
            // final isOnline = user['isOnline'] ?? false;  // Use default value

            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    user['profileImage'] ?? '',
                    fit: BoxFit.cover,
                    height: 30,
                    width: 30,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.receiverUserName,
                        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                        Text('Online',style: TextStyle(fontSize: 12),)
                    // Text(
                    //   isOnline ? 'Online' : 'Offline',
                    //   style: TextStyle(
                    //     color: isOnline ? Colors.green : Colors.red,
                    //     fontSize: 12,
                    //   ),
                    // ),
                  ],
                ),
              ],
            );
          },
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _chatService.getMessages(widget.chatRoomId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final senderId = data['senderId'] as String;
                  final messageText = data['message'] as String;
                  final timestamp = data['timestamp'] ?? '0';
                  final dateTime =
                      DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));

                  final isCurrentUser = senderId == _currentUserId;

                  return Container(
                    alignment: isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: isCurrentUser
                              ? TColors.primaryLight
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  messageText,
                                  style: TextStyle(
                                      color: isCurrentUser
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          _formatMessageTime(dateTime),
                          style: TextStyle(
                            color: isCurrentUser
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList();

                return ListView(
                  reverse: true,
                  children: messages,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _messageController, hintText: 'Enter a message..',  
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.red,),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime time) {
    final now = DateTime.now();
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else if (time.year == now.year) {
      return '${time.month}/${time.day}';
    } else {
      return '${time.year}/${time.month}/${time.day}';
    }
  }
}
