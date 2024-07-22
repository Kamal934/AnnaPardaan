import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/text_strings.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                Center(child: Image.asset(TImages.signupImg, height: 200)),
                const Text(
                  TText.signupTitle,
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
                  TText.signupSubtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),

                CustomTextField(
                  controller: _fullNameController,
                  hintText: TText.nameText,
                  mainDataType: MainDataType.fullName,
                ),
                const SizedBox(height: 10),
                
                CustomTextField(
                  controller: _emailController,
                  hintText: TText.mailTitle,
                  mainDataType: MainDataType.email,
                ),
                const SizedBox(height: 10),
            
                CustomTextField(
                  controller: _passwordController,
                  hintText:TText.passwordTitle,
                  mainDataType: MainDataType.password,
                ),
                const SizedBox(height: 10),
             
                CustomTextField(
                  controller: _confirmPasswordController,
                  hintText: TText.confirmPassword,
                  mainDataType: MainDataType.password,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  text: TText.signUp,
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
                  SizedBox(width: 60,
                    child: Divider(color: Colors.black,), 
                  ),
                  SizedBox(width: 30,)
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
                      icon:
                          Image.asset(TImages.googleImage),
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
                    const Text(
                      TText.havingAccount,
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        TText.login,
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
      ),
    );
  }
}
