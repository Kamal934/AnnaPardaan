import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../providers/user_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    fullNameController.text = userProvider.currentUser.fullName;
    emailController.text = userProvider.currentUser.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                userProvider.currentUser.profileImage??'',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: fullNameController,
              hintText: 'Full Name',
              mainDataType: MainDataType.fullName,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: emailController,
              hintText: 'Email',
              mainDataType: MainDataType.email,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: passwordController,
              hintText: AppLocalizations.of(context)!.password,
              obscureText: true,
              mainDataType: MainDataType.password,
            ),
            const SizedBox(height: 20),
            CustomButton(text: 'Save', onPressed:() {_saveProfile(context, userProvider);})
          ],
        ),
      ),
    );
  }

  void _saveProfile(BuildContext context, UserProvider userProvider) {
    // Validate fields and save profile information
    // For example, check if the controllers are not empty and proceed with the update
    final fullName = fullNameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    // Example validation (can be expanded)
    if (fullName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Perform the profile update
      userProvider.updateUserDetails(fullName, email, password).then((_) {
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.green,
          title:      const Text('Profile updated successfully!'));
    
      }).catchError((error) {
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.bottomCenter,
          primaryColor: Colors.red,
          title:       Text('Failed to update profile: $error'));
    
      });
    } else {
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topCenter,
          primaryColor: Colors.red,
          title: const Text('Please fill out all fields.'));
    
    }
  }
}
