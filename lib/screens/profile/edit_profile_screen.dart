import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Edit Profile', ),
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset('')),
          const SizedBox(height: 10,),
          
        ],
      ),
    );
  }
}
