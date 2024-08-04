import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';
import 'login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(child: Image.asset(TImages.signupImg, height: 220)),
                Text(
                  AppLocalizations.of(context)!.signupTitle,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
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
                  AppLocalizations.of(context)!.signupSubtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _fullNameController,
                  hintText: AppLocalizations.of(context)!.nameText,
                  mainDataType: MainDataType.fullName,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _emailController,
                  hintText: AppLocalizations.of(context)!.mailTitle,
                  mainDataType: MainDataType.email,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _passwordController,
                  hintText: AppLocalizations.of(context)!.passwordTitle,
                  mainDataType: MainDataType.password,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  mainDataType: MainDataType.password,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: AppLocalizations.of(context)!.signUp,
                  onPressed: () {
                    userProvider.signup(
                      context,
                      _fullNameController.text,
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: IconButton(
                        icon: Image.asset(TImages.googleImage),
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
                        icon: Image.asset(TImages.facebookImage),
                        onPressed: () {
                          // Implement Google login
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.havingAccount,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 2,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
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
      ),
    );
  }
}
