import 'package:flutter/material.dart';

enum MainDataType {
  numeric,
  fullName,
  email,
  password,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final MainDataType? mainDataType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.mainDataType,
    String? errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.black,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: _getKeyboardType(),
      style: const TextStyle(color: Colors.black), // Set text color to grey
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 239, 238, 245),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 3.0,
          horizontal: 20.0,
        ), // Adjust padding as needed
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color:Colors.transparent, // Set inactive border color to transparent
          ),
          borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red, // Set active border color to red
          ),
          borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
        ),
        errorText: _errorText,
      ),
      onChanged: (text) => validateInput(),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.mainDataType) {
      case MainDataType.fullName:
        return TextInputType.text;
      case MainDataType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text; // Default to text if mainDataType is not specified
    }
  }

  void validateInput() {
    setState(() {
      switch (widget.mainDataType) {
        case MainDataType.fullName:
          if (!_isAlphabetic(widget.controller.text)) {
            _errorText = 'Please enter alphabetic characters only.';
          } else {
            _errorText = null;
          }
          break;
        case MainDataType.numeric:
          if (!_isNumeric(widget.controller.text)) {
            _errorText = 'Please enter numeric characters only.';
          } else {
            _errorText = null;
          }
          break;
        default:
          _errorText = null;
          break;
      }
    });
  }

  bool _isAlphabetic(String input) {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(input);
  }

  bool _isNumeric(String input) {
    return RegExp(r'^[0-9]+$').hasMatch(input);
  }
}
