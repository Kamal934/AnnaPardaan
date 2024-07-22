import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/donar/screen/donation_home_screen.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/custom_button.dart';
import '../../utils/constants/text_strings.dart';

class PasswordScreen extends StatefulWidget {
  final String username;

  const PasswordScreen({super.key, required this.username});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      if (_passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a password.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }


      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const DonationScreen()),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          duration: Duration(seconds: 2),
        ),
      );

      if (kDebugMode) {
        print(e); // Print the error for debugging purposes
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: _passwordController,
                  hintText: TText.password,
                  obscureText: true,
                  mainDataType: null,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle get OTP action
                      },
                      child: Text(
                        TText.getOtp,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomButton(
                      text: TText.continues,
                      onPressed: _login,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
