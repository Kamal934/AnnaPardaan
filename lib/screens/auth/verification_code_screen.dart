import 'dart:async';
import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/images.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/otp_input_field.dart';
import '../../utils/constants/text_strings.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;

  const VerificationCodeScreen({super.key, required this.email});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _seconds = 59;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _resendCode() {
    setState(() {
      _seconds = 59;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.asset(
              TImages.otpVerificationImg,
              height: 300,
            )),
            Center(
              child: Text(
                '00:${_seconds.toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              TText.verificationCode,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              TText.verificationCodeSubtitle,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            OtpInputField(
              controller: _otpController,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: TText.confirm,
              onPressed: () {
                // Handle OTP verification
              },
            ),
            Center(
              child: TextButton(
                onPressed: _seconds == 0 ? _resendCode : null,
                child: const Text(
                  TText.noverificationCodeRecieve,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
