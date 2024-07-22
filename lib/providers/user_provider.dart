import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/location/confirm_location_screen.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  late UserModel _currentUser;
  bool _isUserLoaded = false;

  UserModel get currentUser => _currentUser;
  bool get isUserLoaded => _isUserLoaded;

  UserProvider() {
    initUser();
  }

  Future<void> initUser() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();

      if (userDoc.exists) {
        _currentUser = UserModel(
          uid: firebaseUser.uid,
          fullName: userDoc['fullName'],
          email: userDoc['email'],
          role: userDoc['role'],
          profileImage: userDoc['profileImage'],
        );
        _isUserLoaded = true; // Set user loaded flag to true
      }
    }

    notifyListeners();
  }

  Future<void> signup(BuildContext context, String fullName, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'role': 'Volunteer',
        'profileImage': 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      });

      _currentUser = UserModel(
        uid: userCredential.user!.uid,
        fullName: fullName,
        email: email,
        role: 'Volunteer',
        profileImage: 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      );

      _isUserLoaded = true; // Set user loaded flag to true after signup

      notifyListeners();

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const ConfirmLocationScreen()),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error signing up: $e');
      }
    }
  }

  Future<void> updateRole(String role) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        await userRef.update({
          'role': role,
        });

        _currentUser = UserModel(
          uid: _currentUser.uid,
          fullName: _currentUser.fullName,
          email: _currentUser.email,
          role: role,
          profileImage: _currentUser.profileImage,
        );

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating role: $e');
      }
    }
  }
}
