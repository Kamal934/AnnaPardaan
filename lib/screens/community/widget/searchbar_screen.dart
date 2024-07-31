import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/community/chat_screen.dart';
import '../../../providers/chat_provider.dart';

class SearchResultsScreen extends StatefulWidget {
  final List<DocumentSnapshot> searchResults;

  const SearchResultsScreen({super.key, required this.searchResults});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<DocumentSnapshot> _filteredResults;

  @override
  void initState() {
    super.initState();
    _filteredResults = widget.searchResults;
  }

  void _filterResults(String query) {
    setState(() {
      _filteredResults = widget.searchResults
          .where((user) =>
              (user['fullName'] as String).toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _navigateToChat(BuildContext context, String receiverUserId, String receiverUserName) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final chatRoomId = ChatService().generateChatRoomId(currentUserId, receiverUserId);

    final chatRoom = await FirebaseFirestore.instance.collection('chatrooms').doc(chatRoomId).get();
    if (!chatRoom.exists) {
      await ChatService().createChatRoom(receiverUserId, receiverUserName);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          chatRoomId: chatRoomId,
          receiverUserId: receiverUserId,
          receiverUserName: receiverUserName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _filterResults,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button press if needed
            },
          ),
        ],
      ),
      body: _filteredResults.isEmpty
          ? const Center(child: Text('No users found'))
          : ListView.builder(
              itemCount: _filteredResults.length,
              itemBuilder: (context, index) {
                final user = _filteredResults[index];
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
                    context,
                    user.id,
                    user['fullName'],
                  ),
                );
              },
            ),
    );
  }
}
