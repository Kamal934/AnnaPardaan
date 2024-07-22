import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/colors.dart';

class OtpInputField extends StatefulWidget {
  final TextEditingController controller;

  const OtpInputField({
    super.key,
    required this.controller,
  });

  @override
  // ignore: library_private_types_in_public_api
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final List<FocusNode> _focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers = List<TextEditingController>.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
    widget.controller.text = _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 40,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: TColors.primaryLight),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              onChanged: (value) => _onChanged(value, index),
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: "",
              ),
            ),
          ),
        );
      }),
    );
  }
}
