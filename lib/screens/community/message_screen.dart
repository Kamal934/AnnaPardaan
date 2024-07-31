import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/community/chat_screen.dart';
import 'package:annapardaan/screens/community/widget/searchbar_screen.dart';
import '../../common_widgets/custom_searchbar.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  final _searchController = TextEditingController();
  late TabController _tabController;
  late Stream<QuerySnapshot> _chatStream;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
    _tabController = TabController(length: 2, vsync: this);
    _chatStream = _firestore
        .collection('chatrooms')
        .where('users', arrayContains: _currentUser!.uid)
        .snapshots();
  }

  void _searchUsers(String query) async {
    if (query.isNotEmpty) {
      if (kDebugMode) {
        print('Searching for: $query');
      }
      final results = await _firestore
          .collection('users')
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      if (kDebugMode) {
        print('Found ${results.docs.length} results');
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(
            searchResults: results.docs,
          ),
        ),
      );
    }
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(
                      controller: _searchController,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SearchResultsScreen(
                              searchResults: [], // Initial empty results
                            ),
                          ),
                        );
                      },
                      onMicTap: () {
                        // Handle mic tap action here
                      },
                      onChanged: (value) {
                        _searchUsers(value);
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
            TabBar(
              controller: _tabController,
              indicatorColor: TColors.primaryLight,
              indicatorWeight: 4,
              labelColor: TColors.primaryLight,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(
                  child: Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Groups',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildChatsTab(),
                  const Center(child: Text('Groups')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatStream,
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
              future: _firestore.collection('users').doc(receiverId).get(),
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
                } else if (lastMessageTime is DateTime) {
                  messageTime = lastMessageTime;
                } else {
                  messageTime = DateTime.now();
                }

                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      user['profileImage'] ?? '',
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
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
                    final chatRoom = await _firestore
                        .collection('chatrooms')
                        .doc(chatRoomId)
                        .get();
                    if (!chatRoom.exists) {
                      await _firestore
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
