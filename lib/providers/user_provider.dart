// import 'package:flutter/foundation.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/user_model.dart';
// import '../screens/auth/login_screen.dart';
// import '../screens/location/confirm_location_screen.dart';

// class UserProvider extends ChangeNotifier {
//   late UserModel _currentUser;
//   bool _isUserLoaded = false;

//   UserModel get currentUser => _currentUser;
//   bool get isUserLoaded => _isUserLoaded;

//   UserProvider() {
//     initUser();
//   }

//   Future<void> initUser() async {
//     User? firebaseUser = FirebaseAuth.instance.currentUser;

//     if (firebaseUser != null) {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();

//       if (userDoc.exists) {
//         _currentUser = UserModel(
//           uid: firebaseUser.uid,
//           fullName: userDoc['fullName'],
//           email: userDoc['email'],
//           role: userDoc['role'],
//           profileImage: userDoc['profileImage'],
//           restaurantId: userDoc['restaurantId'],
//         );
//         _isUserLoaded = true;
//       }
//     }

//     notifyListeners();
//   }

//   Future<void> signup(BuildContext context, String fullName, String email, String password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
//         'fullName': fullName,
//         'email': email,
//         'role': 'Volunteer',
//         'profileImage': 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//         'restaurantId': null,
//       });

//       _currentUser = UserModel(
//         uid: userCredential.user!.uid,
//         fullName: fullName,
//         email: email,
//         role: 'Volunteer',
//         profileImage: 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//         restaurantId: null,
//       );

//       _isUserLoaded = true;

//       notifyListeners();

//       Navigator.pushReplacement(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(builder: (context) => const ConfirmLocationScreen()),
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error signing up: $e');
//       }
//     }
//   }

//   Future<void> updateRole(String role) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;

//       final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//       final userDoc = await userRef.get();

//       if (userDoc.exists) {
//         await userRef.update({
//           'role': role,
//         });

//         _currentUser = UserModel(
//           uid: _currentUser.uid,
//           fullName: _currentUser.fullName,
//           email: _currentUser.email,
//           role: role,
//           profileImage: _currentUser.profileImage,
//           restaurantId: _currentUser.restaurantId,
//         );

//         notifyListeners();
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error updating role: $e');
//       }
//     }
//   }

//   Future<void> updateRestaurantId(String restaurantId) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;

//       final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//       final userDoc = await userRef.get();

//       if (userDoc.exists) {
//         await userRef.update({
//           'restaurantId': restaurantId,
//         });

//         _currentUser = UserModel(
//           uid: _currentUser.uid,
//           fullName: _currentUser.fullName,
//           email: _currentUser.email,
//           role: _currentUser.role,
//           profileImage: _currentUser.profileImage,
//           restaurantId: restaurantId,
//         );

//         notifyListeners();
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error updating restaurant ID: $e');
//       }
//     }
//   }

//   // update the userdetails
//   Future<void> updateUserDetails(String fullName, String email, String password) async {
//     try {
//       String userId = FirebaseAuth.instance.currentUser!.uid;

//       final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

//       // Update the email in FirebaseAuth
//       User? user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         await user.updateEmail(email);
//         await user.updatePassword(password);
//       }

//       await userRef.update({
//         'fullName': fullName,
//         'email': email,
//       });

//       _currentUser = UserModel(
//         uid: _currentUser.uid,
//         fullName: fullName,
//         email: email,
//         role: _currentUser.role,
//         profileImage: _currentUser.profileImage,
//         restaurantId: _currentUser.restaurantId,
//       );

//       notifyListeners();
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error updating user details: $e');
//       }
//     }
//   }
   
//   // logout Function  
//   Future<void> logout(BuildContext context) async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       Get.offAll(() => const LoginScreen());
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error logging out: $e');
//       }
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../screens/auth/login_screen.dart';
import '../screens/location/confirm_location_screen.dart';

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
          restaurantId: userDoc['restaurantId'],
        );
        _isUserLoaded = true;
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
        'restaurantId': null,
      });

      _currentUser = UserModel(
        uid: userCredential.user!.uid,
        fullName: fullName,
        email: email,
        role: 'Volunteer',
        profileImage: 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        restaurantId: null,
      );

      _isUserLoaded = true;

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
          restaurantId: _currentUser.restaurantId,
        );

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating role: $e');
      }
    }
  }

  Future<void> updateRestaurantId(String restaurantId) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        await userRef.update({
          'restaurantId': restaurantId,
        });

        _currentUser = UserModel(
          uid: _currentUser.uid,
          fullName: _currentUser.fullName,
          email: _currentUser.email,
          role: _currentUser.role,
          profileImage: _currentUser.profileImage,
          restaurantId: restaurantId,
        );

        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating restaurant ID: $e');
      }
    }
  }

  Future<void> updateUserDetails(String fullName, String email, String password) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

      // Update the email in FirebaseAuth
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateEmail(email);
        await user.updatePassword(password);
      }

      await userRef.update({
        'fullName': fullName,
        'email': email,
      });

      _currentUser = UserModel(
        uid: _currentUser.uid,
        fullName: fullName,
        email: email,
        role: _currentUser.role,
        profileImage: _currentUser.profileImage,
        restaurantId: _currentUser.restaurantId,
      );

      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user details: $e');
      }
    }
  }
   
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      if (kDebugMode) {
        print('Error logging out: $e');
      }
    }
  }
}
