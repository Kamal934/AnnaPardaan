import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/community/chat_screen.dart';
import '../../common_widgets/custom_searchbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  final _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  bool _showSearchResults = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _searchController.addListener(() {
      _searchUsers(_searchController.text);
    });
  }

  void _searchUsers(String query) async {
    if (query.isNotEmpty) {
      final results = await _firestore
          .collection('users')
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      setState(() {
        _searchResults = results.docs;
        _showSearchResults = _searchResults.isNotEmpty;
      });
    } else {
      setState(() {
        _searchResults = [];
        _showSearchResults = false;
      });
    }
  }

  void _navigateToChat(String receiverUserId, String receiverUserName) async {
    setState(() {
      _isNavigating = true; // Indicate navigation in progress
    });

    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatRoomId = _generateChatRoomId(currentUserId, receiverUserId);

    final chatRoom = await FirebaseFirestore.instance.collection('chatrooms').doc(chatRoomId).get();
    if (!chatRoom.exists) {
      await FirebaseFirestore.instance.collection('chatrooms').doc(chatRoomId).set({
        'chatRoomId': chatRoomId,
        'users': [currentUserId, receiverUserId],
        'lastMessage': '',
        'lastMessageTime': FieldValue.serverTimestamp(),
        'unreadMessagesCount': {
          currentUserId: 0,
          receiverUserId: 0,
        },
      });
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          chatRoomId: chatRoomId,
          receiverUserId: receiverUserId,
          receiverUserName: receiverUserName,
        ),
      ),
    ).then((_) {
      // Reset states after returning from ChatScreen
      setState(() {
        _isNavigating = false;
        _searchController.clear(); // Clear search bar
        _showSearchResults = false; // Hide search results
      });
    });
  }

  String _generateChatRoomId(String userId1, String userId2) {
    return userId1.hashCode <= userId2.hashCode
        ? '${userId1}_$userId2'
        : '${userId2}_$userId1';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Messages',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Icon(Icons.more_vert_outlined)
            ],
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSearchBar(
                          controller: _searchController,
                          onChanged: (value) {
                            _searchUsers(value);
                          },
                          onTap: () {
                            // Optionally handle search bar tap here
                          },
                          onMicTap: () {
                            // Handle mic tap action here
                          },
                        ),
                      ),
                      SizedBox(
                        height: 41,
                        child: Ink(
                          decoration: const ShapeDecoration(
                            color: TColors.primaryLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              TImages.settingImageIcon,
                              color: Colors.white,
                              width: 22,
                              height: 22,
                            ),
                            iconSize: 22,
                            onPressed: () {
                              // Handle settings button tap here
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  indicatorColor: TColors.primaryLight,
                  indicatorWeight: 4,
                  labelColor: TColors.primaryLight,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        'Chats',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Groups',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildChatsTab(),
                      const Center(child: Text('Groups')),
                    ],
                  ),
                ),
              ],
            ),
            Visibility(
              visible: !_isNavigating && _showSearchResults,
              child: Positioned(
                top: 90, // Adjust based on the height of the search bar and other UI elements
                left: 8,
                right: 8,
                child: Material(
                  elevation: 4,
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: _searchResults.map((user) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              user['profileImage'],
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                            ),
                          ),
                          title: Text(user['fullName']),
                          onTap: () => _navigateToChat(
                            user.id,
                            user['fullName'],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chatrooms')
          .where('users', arrayContains: _currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No conversations yet.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final chat = snapshot.data!.docs[index];
            final users = chat['users'] as List<dynamic>?;

            if (users == null || users.length < 2) {
              return const SizedBox.shrink(); // Handle the invalid state
            }

            final receiverId = users
                    .where(
                      (userId) => userId != _currentUser!.uid,
                    )
                    .isNotEmpty
                ? users.firstWhere(
                    (userId) => userId != _currentUser!.uid,
                  )
                : '';

            if (receiverId.isEmpty) {
              return const SizedBox.shrink(); // Handle the invalid state
            }

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(receiverId).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(title: Text('Loading...'));
                }
                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return const ListTile(title: Text('User not found.'));
                }
                final user = userSnapshot.data!;
                final lastMessage = chat['lastMessage'] ?? '';
                final lastMessageTime = chat['lastMessageTime'];

                // Ensure lastMessageTime is a Timestamp or default to now
                DateTime messageTime;
                if (lastMessageTime == null) {
                  messageTime = DateTime.now();
                } else if (lastMessageTime is Timestamp) {
                  messageTime = lastMessageTime.toDate();
                } else {
                  messageTime = DateTime.now();
                }

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      user['profileImage'] ?? '',
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  title: Text(
                    user['fullName'] ?? 'Unknown User',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(lastMessage),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          _formatMessageTime(messageTime),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      _getUnreadMessageCount(chat) > 0
                          ? CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                '${_getUnreadMessageCount(chat)}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  onTap: () async {
                    final chatRoomId = chat.id;
                    final chatRoom = await FirebaseFirestore.instance
                        .collection('chatrooms')
                        .doc(chatRoomId)
                        .get();
                    if (!chatRoom.exists) {
                      await FirebaseFirestore.instance
                          .collection('chatrooms')
                          .doc(chatRoomId)
                          .set({
                        'chatRoomId': chatRoomId,
                        'users': [_currentUser!.uid, receiverId],
                        'lastMessage': '',
                        'lastMessageTime': FieldValue.serverTimestamp(),
                        'unreadMessagesCount': {
                          _currentUser!.uid: 0,
                          receiverId: 0,
                        },
                      });
                    }

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          chatRoomId: chatRoomId,
                          receiverUserName: user['fullName'],
                          receiverUserId: user.id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
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

  int _getUnreadMessageCount(DocumentSnapshot chat) {
    final unreadMessages =
        chat['unreadMessagesCount'] as Map<String, dynamic>? ?? {};
    return unreadMessages[_currentUser!.uid] ?? 0;
  }
}
