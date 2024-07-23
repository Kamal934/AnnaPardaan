import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toastification/toastification.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/otp_input_field.dart';
import '../../utils/constants/text_strings.dart';
import '../location/confirm_location_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;

  const OTPVerificationScreen({super.key, required this.verificationId});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';

  @override
  void initState() {
    super.initState();
    _verificationId = widget.verificationId;
  }

  Future<void> _verifyOTP() async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _otpController.text,
    );

    try {
      await _auth.signInWithCredential(credential);
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.green,
          title: const Text('Phone number verified successfully'));

      // Navigate to the ConfirmLocationScreen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const ConfirmLocationScreen()),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title: const Text('Failed to verify OTP.'));

      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _resendOTP() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _auth.currentUser!.phoneNumber!,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:  Text('Failed to resend OTP: ${e.message}'));
        
        if (kDebugMode) {
          print(e);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
        });
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:  const Text('OTP has been resent.'));
        
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      forceResendingToken: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verify Details',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Enter the 6 digit code we have sent to your \nmobile number',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            OtpInputField(controller: _otpController),
            const SizedBox(height: 16),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    TText.noOtpRecieve,
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: _resendOTP,
                    child: const Text(
                      TText.resend,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        color: Colors.white,
        child: CustomButton(
          text: TText.continues,
          onPressed: _verifyOTP,
        ),
      ),
    );
  }
}
