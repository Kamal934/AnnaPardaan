import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  final String imageUrl;
  final String userName;

  const FullImageScreen({super.key, required this.imageUrl ,required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}