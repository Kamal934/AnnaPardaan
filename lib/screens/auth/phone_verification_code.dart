import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:annapardaan/screens/auth/otp_verification_screen.dart';
import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:toastification/toastification.dart';

import '../../utils/constants/text_strings.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyPhoneNumber() async {
    String phoneNumber = '+91 ${_phoneController.text.trim()}';

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification or instant verification
        await _auth.signInWithCredential(credential);
        toastification.show(
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.topRight,
            primaryColor: Colors.green,
            title: Text(
                'Phone number automatically verified and user signed in: ${credential.smsCode}'));
      },
      verificationFailed: (FirebaseAuthException e) {
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:   Text('Phone number verification failed. Message: ${e.message}'));
       
      },
      codeSent: (String verificationId, int? resendToken) {
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:   const Text('Please check your phone for the verification code.'));
       
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OTPVerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              TText.phnVerficationtitle,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              TText.phnVerficationSubtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 25),
            IntlPhoneField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {},
              controller: _phoneController,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(left: 17, right: 17, bottom: 8),
        color: Colors.white,
        child: CustomButton(
          text: TText.continues,
          onPressed: _verifyPhoneNumber,
        ),
      ),
    );
  }
}
