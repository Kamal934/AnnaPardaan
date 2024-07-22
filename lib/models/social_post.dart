class SocialPost {
  final String authorName;
  final String imageUrl;
  final String content;
  final int likes;
  final int comments;
  final int shares;

  SocialPost({
    required this.authorName,
    required this.imageUrl,
    required this.content,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
