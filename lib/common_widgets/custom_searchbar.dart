// lib/widgets/search_bar.dart
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onMicTap;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onMicTap, required void Function(dynamic value) onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor:Colors.grey[200],
          prefixIcon:  const Icon(Icons.search, color: Colors.grey),
          suffixIcon: IconButton(
            icon:  const Icon(Icons.mic, color: Colors.grey),
            onPressed: onMicTap,
          ),
          hintText: 'Search here',
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
