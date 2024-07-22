import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final VoidCallback? onViewAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.onIconPressed,
    this.onViewAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Center align vertically
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (icon != null && onIconPressed != null) ...[
          IconButton(
            icon: Icon(icon, size: 20.0),
            onPressed: (onIconPressed),
          ),
        ] else if (onViewAllPressed != null) ...[
          TextButton(
            onPressed: onViewAllPressed,
            child: const Text(
              'View all',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ],
    );
  }
}
