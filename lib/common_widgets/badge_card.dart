
import 'package:flutter/material.dart';

class BadgeCard extends StatelessWidget {
  const BadgeCard({
    super.key,
    required this.badge,
    required this.imagePath,
  });

  final String badge;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(
            imagePath,
          ), 
          radius: 50,
        ),
        const SizedBox(height: 4),
        Text(badge,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
