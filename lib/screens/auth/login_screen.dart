import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/recipient/recipient_main.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
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
          title:  Text(
              errorMessage));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(errorMessage),
      //   ),
      // );
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
              Center(child: Image.asset(TImages.loginImg, height: 200)),
              const Text(
                TText.welcome,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const Text(
                TText.appname,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const Text(
                TText.logintext,
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
              CustomTextField(
                controller: _emailController,
                hintText: TText.mailTitle,
                mainDataType: MainDataType.email,
              ),
              const SizedBox(height: 3),
              const Text(
                TText.password,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: TText.passwordTitle,
                mainDataType: MainDataType.password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to forget password screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      TText.forgetPasswordQuestion,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: TText.login,
                onPressed: _login,
              ),
              const SizedBox(
                height: 10,
              ),
               const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 30,),
                  SizedBox(
                    width: 70,
                    child:
                         Divider(color: Colors.black,), 
                  ),
                  SizedBox(width: 5,),
                  Text(
                    TText.anotheroption,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 5,),
                  SizedBox(width: 70,
                    child: Divider(color: Colors.black,), 
                  ),
                  SizedBox(width: 30,),
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
                children: [
                  const Text(
                    TText.noAccount,
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
                    child: const Text(
                      TText.signUp,
                      style: TextStyle(
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
