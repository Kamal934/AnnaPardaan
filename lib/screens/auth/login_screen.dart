import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/recipient/recipient_main.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:annapardaan/utils/constants/images.dart';
import 'package:annapardaan/screens/auth/signup_screen.dart';
import 'package:annapardaan/screens/auth/forget_password.dart';
import 'package:toastification/toastification.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/custom_button.dart';
import '../../providers/user_provider.dart';
import '../donar/donar_main.dart';
import '../volunteer/volunteer_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Fetch user data to determine role
      User firebaseUser = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      String userRole = userDoc['role'];

      // Initialize user in UserProvider
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false).initUser();

      // Navigate based on user's role
      if (userRole == 'Donor') {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const DonorMain()),
        );
      } else if (userRole == 'Recipient') {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const RecipientMain()),
        );
      } else {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const VolunteerMain()),
        );
      }
    } catch (e) {
      String errorMessage = 'Error occurred';
      if (e is FirebaseAuthException) {
        // Log the specific error message for debugging purposes
        if (kDebugMode) {
          print('FirebaseAuthException: ${e.message}');
        }
        errorMessage = e.message ?? 'Unknown error occurred';
      } else {
        // Log any other unexpected errors
        if (kDebugMode) {
          print('Error: $e');
        }
      }

      // Display error message to the user
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title: Text(errorMessage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Center(child: Image.asset(TImages.loginImg, height: 250)),
              Text(
                AppLocalizations.of(context)!.welcome,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                AppLocalizations.of(context)!.appname,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.logintext,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
              CustomTextField(
                controller: _emailController,
                hintText: AppLocalizations.of(context)!.mailTitle,
                mainDataType: MainDataType.email,
              ),
              const SizedBox(height: 3),
              Text(
                AppLocalizations.of(context)!.password,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: AppLocalizations.of(context)!.passwordTitle,
                mainDataType: MainDataType.password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        AppLocalizations.of(context)!.forgetPasswordQuestion,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: AppLocalizations.of(context)!.login,
                onPressed: _login,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20),
                  const SizedBox(
                    width: 50,
                    child: Divider(color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.anotheroption,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const SizedBox(
                    width: 50,
                    child: Divider(color: Colors.black),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      icon:
                          Image.asset('assets/images/icons/facebook_icon.png'),
                      onPressed: () {
                        // Implement Facebook login
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: IconButton(
                      icon: Image.asset('assets/images/icons/google_icon.png'),
                      onPressed: () {
                        // Implement Google login
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.noAccount,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
