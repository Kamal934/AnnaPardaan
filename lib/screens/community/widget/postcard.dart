// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:annapardaan/providers/user_provider.dart';
// import 'package:annapardaan/screens/community/widget/comment_screen.dart';
// import 'package:annapardaan/screens/community/widget/full_image.dart';
// import 'package:annapardaan/screens/community/widget/post_interation.dart';
// import 'package:provider/provider.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class PostCard extends StatelessWidget {
//   final DocumentSnapshot? post;
//   final bool isLoading;

//   const PostCard({this.post, this.isLoading = false, super.key});

//   void _toggleLike(BuildContext context) async {
//     if (post == null) return;

//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     final userId = userProvider.currentUser.uid;

//     final likes = post?['likes'] ?? 0;
//     final List<dynamic> likedBy = post?['likedBy'] ?? [];

//     if (likedBy.contains(userId)) {
//       await post!.reference.update({
//         'likes': likes - 1,
//         'likedBy': FieldValue.arrayRemove([userId]),
//       });
//     } else {
//       await post!.reference.update({
//         'likes': likes + 1,
//         'likedBy': FieldValue.arrayUnion([userId]),
//       });
//     }
//   }

//   void _commentOnPost(BuildContext context) {
//     if (post == null) return; 
//     _displayBottomSheet(context, post!.id);
//   }

//   Future<void> _displayBottomSheet(BuildContext context, String postId) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return CommentScreen(postId: postId);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {

//     final likes = post?['likes'] ?? 0;
//     final profileImage = post?['profileImage'] as String? ?? '';
//     final author = post?['author'] as String? ?? 'Unknown Author';
//     final content = post?['content'] as String? ?? 'No content available';
//     final imageUrl = post?['imageUrl'] as String? ?? '';

//     return Skeletonizer(
//       enabled: isLoading,
//       child: Card(
//         color: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 23,
//                     backgroundImage: isLoading
//                         ? null
//                         : (profileImage.isNotEmpty ? NetworkImage(profileImage) : null),
//                   ),
//                   const SizedBox(width: 15),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         author,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         'just now',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                   const Icon(Icons.more_vert_outlined),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 content,
//                 style: const TextStyle(fontSize: 14, color: Colors.black),
//                 maxLines: 3,overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 5),
//               if (imageUrl.isNotEmpty)
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FullImageScreen(
//                           imageUrl: imageUrl,
//                           userName: author,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 200, // Fixed height
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                         image: NetworkImage(imageUrl),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: 5),
//               PostInteraction(
//                 likes: likes,
//                 comments: post?['comments'] ?? 0,
//                 onLike: () => _toggleLike(context),
//                 onComment: () => _commentOnPost(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/providers/user_provider.dart';
import 'package:annapardaan/screens/community/widget/comment_screen.dart';
import 'package:annapardaan/screens/community/widget/full_image.dart';
import 'package:annapardaan/screens/community/widget/post_interation.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostCard extends StatefulWidget {
  final DocumentSnapshot? post;
  final bool isLoading;

  const PostCard({this.post, this.isLoading = false, super.key});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isExpanded = false;

  void _toggleLike(BuildContext context) async {
    if (widget.post == null) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.currentUser.uid;

    final likes = widget.post?['likes'] ?? 0;
    final List<dynamic> likedBy = widget.post?['likedBy'] ?? [];

    if (likedBy.contains(userId)) {
      await widget.post!.reference.update({
        'likes': likes - 1,
        'likedBy': FieldValue.arrayRemove([userId]),
      });
    } else {
      await widget.post!.reference.update({
        'likes': likes + 1,
        'likedBy': FieldValue.arrayUnion([userId]),
      });
    }
  }

  void _commentOnPost(BuildContext context) {
    if (widget.post == null) return; 
    _displayBottomSheet(context, widget.post!.id);
  }

  Future<void> _displayBottomSheet(BuildContext context, String postId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CommentScreen(postId: postId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final likes = post?['likes'] ?? 0;
    final profileImage = post?['profileImage'] as String? ?? '';
    final author = post?['author'] as String? ?? 'Unknown Author';
    final content = post?['content'] as String? ?? 'No content available';
    final imageUrl = post?['imageUrl'] as String? ?? '';

    return Skeletonizer(
      enabled: widget.isLoading,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: widget.isLoading
                        ? null
                        : (profileImage.isNotEmpty ? NetworkImage(profileImage) : null),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'just now',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert_outlined),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: _isExpanded ? null : 3,
                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              if (!_isExpanded && content.length > 100) 
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: const Text('see more'),
                ),
              if (_isExpanded && content.length > 100) // Show 'Show Less' if content is expanded
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                  child: const Text('see less'),
                ),
              const SizedBox(height: 5),
              if (imageUrl.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullImageScreen(
                          imageUrl: imageUrl,
                          userName: author,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 200, // Fixed height
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 5),
              PostInteraction(
                likes: likes,
                comments: post?['comments'] ?? 0,
                onLike: () => _toggleLike(context),
                onComment: () => _commentOnPost(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
