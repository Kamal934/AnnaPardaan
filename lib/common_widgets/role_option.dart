import 'package:flutter/material.dart';

class RoleOption extends StatelessWidget {
  final String role;
  final String description;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleOption({
    super.key,
    required this.role,
    required this.description,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                color: isSelected ? Colors.red : Colors.transparent,
                borderRadius: BorderRadius.circular(80),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  imagePath,
                  height: 60,
                  width: 60,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            role,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color:  Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color:  Colors.black54,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
