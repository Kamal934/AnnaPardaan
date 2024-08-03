import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:annapardaan/screens/auth/login_screen.dart';
import 'package:toastification/toastification.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _resetPassword() async {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      try {
        User? user = _auth.currentUser;
        if (user != null && user.email == widget.email) {
          await user.updatePassword(_passwordController.text.trim());
          toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.green,
          title:   const Text('Password reset successful.'));
       
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:   const Text('User not found or email mismatch.'));
       
        }
      } catch (e) {
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:    Text('Error: $e'));
       
      }
    } else {
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:    const Text('Passwords do not match.'));
       
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
                height: 20), // Adjust height to position content vertically
            Image.asset('assets/images/reset_password_image.png', height: 200),
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
                         Center(
                          child: Text(
                            AppLocalizations.of(context)!.resetPassword,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          AppLocalizations.of(context)!.resetPasswordSubtitle,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 10),
                         Text(
                          AppLocalizations.of(context)!.password,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: AppLocalizations.of(context)!.passwordTitle,
                          mainDataType: MainDataType.password,
                        ),
                        const SizedBox(height: 10),
                         Text(
                          AppLocalizations.of(context)!.confirmPassword,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: AppLocalizations.of(context)!.confirmPasswordSubtitle,
                          mainDataType: MainDataType.password,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: AppLocalizations.of(context)!.confirm,
                          onPressed: _resetPassword,
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
    );
  }
}
