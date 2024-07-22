import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/constants/colors.dart';

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  void _addComment(String comment) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;

    await FirebaseFirestore.instance.collection('posts').doc(widget.postId).collection('comments').add({
      'name': user.fullName,
      'profileImageUrl': user.profileImage,
      'comment': comment,
      'time': Timestamp.now(),
    });

    // Update the comment count
    await FirebaseFirestore.instance.collection('posts').doc(widget.postId).update({
      'comments': FieldValue.increment(1),
    });

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: 600,
      padding: EdgeInsets.only(top: 16, left: 12, right: 12, bottom: keyboardHeight),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              TText.comment,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').doc(widget.postId).collection('comments').orderBy('time', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comments = snapshot.data?.docs ?? [];

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 16.0,
                                backgroundImage: NetworkImage(comment['profileImageUrl']),
                              ),
                              const SizedBox(width: 8.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        comment['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Just now',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    comment['comment'],
                                    style: const TextStyle(
                                      color: TColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 38,
                                    child: TextButton(
                                      onPressed: () {
                                        // Add functionality for reply
                                      },
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                      ),
                                      child: const Text(
                                        TText.reply,
                                        style: TextStyle(
                                          color: TColors.primaryLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.thumb_up,
                                size: 20,
                                color: TColors.primaryLight,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: _commentController,
                        hintText: TText.typeComment,
                      ),
                    ),
                  IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        _addComment(_commentController.text);
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: TColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
