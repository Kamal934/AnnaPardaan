import 'package:flutter/material.dart';

class PostInteraction extends StatelessWidget {
  final int likes;
  final int comments;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const PostInteraction({
    required this.likes,
    required this.comments,
    required this.onLike,
    required this.onComment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite, color: likes > 0 ? Colors.red : Colors.grey),
              onPressed: onLike,
            ),
            Text('$likes'),
          ],
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.comment, color: Colors.black),
              onPressed: onComment,
            ),
            Text('$comments'),
          ],
        ),
        const SizedBox(width: 16),
        const Icon(Icons.share_rounded),
      ],
    );
  }
}
