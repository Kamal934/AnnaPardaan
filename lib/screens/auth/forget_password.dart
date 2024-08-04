import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:annapardaan/utils/constants/images.dart';
import 'package:toastification/toastification.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/custom_button.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset OTP sent to your email.'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerificationCodeScreen(email: _emailController.text.trim()),
        ),
      );
    } catch (e) {
      toastification.show(
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.topRight,
        primaryColor: Colors.red,
        title: Text('Error: $e'),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Make the body scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(TImages.forgetPasswordImg,
                  height: 300), // Reduced height
              Center(
                child: SizedBox(
                  width: 290,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.forgetPassword,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.forgetPassordSubtitle,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.email,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          CustomTextField(
                            controller: _emailController,
                            hintText:
                                AppLocalizations.of(context)!.emailExample,
                            mainDataType: MainDataType.email,
                          ),
                          const SizedBox(height: 10),
                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : SizedBox(
                                height: 45,
                                child: CustomButton(
                                    text: AppLocalizations.of(context)!.resetOtp,
                                    onPressed: _resetPassword,
                                  ),
                              ),
                          const SizedBox(height: 5),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red, 
                                  elevation: 2, 
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), 
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.backToLogin,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
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
