import 'package:flutter/material.dart';

class CustomChoosingButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final double? width;

  const CustomChoosingButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.width, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          backgroundColor: isSelected ? Colors.red : const Color.fromARGB(255, 239, 238, 245),
          side: const BorderSide(color: Colors.transparent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set the border radius here
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
