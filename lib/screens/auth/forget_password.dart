import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:annapardaan/utils/constants/images.dart';
import 'package:toastification/toastification.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/custom_button.dart';
import '../../utils/constants/text_strings.dart';
import 'login_screen.dart';
import 'verification_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset OTP sent to your email.'),
        ),
      );

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => VerificationCodeScreen(email: _emailController.text.trim()),
        ),
      );
    } catch (e) {
      toastification.show(
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.topRight,
        primaryColor: Colors.red,
          title:  Text(
              'Error: $e'));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Error: $e'),
      //   ),
      // );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  // Add this
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(TImages.forgetPasswordImg, height: 300),
              Center(
                child: SizedBox(
                  height: 330,
                  width: 290,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              TText.forgetPassword,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            TText.forgetPassordSubtitle,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            TText.email,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          CustomTextField(
                            controller: _emailController,
                            hintText: TText.emailExample,
                            mainDataType: MainDataType.email,
                          ),
                          const SizedBox(height: 10),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: TText.resetOtp,
                                  onPressed: _resetPassword,
                                ),
                          const SizedBox(height: 5),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()),
                                );
                              },
                              child: const Text(
                                TText.backToLogin,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
