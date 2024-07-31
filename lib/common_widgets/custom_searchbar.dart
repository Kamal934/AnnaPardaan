import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;  // Add this
  final VoidCallback? onMicTap;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onTap,  // Add this
    this.onMicTap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // Add this
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5),
      child: SizedBox(
        height: 43,
        child: TextField(
          controller: controller,
          onChanged: onChanged, // Use the onChanged callback here
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: const Icon(Icons.mic, color: Colors.grey),
              onPressed: onMicTap,
            ),
            hintText: 'Search here',
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    )
    );
  }
}
