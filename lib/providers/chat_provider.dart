import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createChatRoom(String receiverUserId, String receiverUserName) async {
    try {
      final currentUserId = _auth.currentUser!.uid;
      final chatRoomId = generateChatRoomId(currentUserId, receiverUserId);

      final chatRoomData = {
        'chatRoomId': chatRoomId,
        'users': [currentUserId, receiverUserId],
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'unreadMessagesCount': {
          currentUserId: 0,
          receiverUserId: 0,
        },
      };

      await _firestore.collection('chatrooms').doc(chatRoomId).set(chatRoomData);
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  Stream<QuerySnapshot> getMessages(String chatRoomId) {
    return _firestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> sendMessage(String chatRoomId, String message) async {
    final currentUser = _auth.currentUser!;
    final messageData = {
      'senderId': currentUser.uid,
      'senderName': currentUser.displayName ?? 'Unknown',
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    };

    await _firestore.collection('chatrooms').doc(chatRoomId).collection('messages').add(messageData);

    await _firestore.collection('chatrooms').doc(chatRoomId).update({
      'lastMessage': message,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadMessagesCount.${currentUser.uid}': 0,
    });
  }

  String generateChatRoomId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '$userId1-$userId2'
        : '$userId2-$userId1';
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/message.dart';

// class ChatService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> sendMessage(String receiverId, String message) async {
//     final currentUser = _auth.currentUser;
//     if (currentUser == null) return;

//     final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

//     final newMessage = Message(
//       senderId: currentUser.uid,
//       senderName: currentUser.displayName ?? 'Unknown',
//       receiverId: receiverId,
//       message: message,
//       timestamp: timestamp,
//     );

//     await _firestore
//         .collection('chats')
//         .doc(currentUser.uid)
//         .collection(receiverId)
//         .doc(timestamp)
//         .set(newMessage.toJson());

//     await _firestore
//         .collection('chats')
//         .doc(receiverId)
//         .collection(currentUser.uid)
//         .doc(timestamp)
//         .set(newMessage.toJson());
//   }

//   Stream<QuerySnapshot> getMessages(String receiverId) {
//     final currentUser = _auth.currentUser;
//     if (currentUser == null) return const Stream.empty();

//     return _firestore
//         .collection('chats')
//         .doc(currentUser.uid)
//         .collection(receiverId)
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }
// }
