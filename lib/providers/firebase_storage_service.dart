// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';

// class FirebaseStorageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<String> uploadFile(Uint8List fileData, String filePath) async {
//     try {
//       Reference ref = _storage.ref().child(filePath);
//       UploadTask uploadTask = ref.putData(fileData);

//       await uploadTask.whenComplete(() => null);
//       String downloadURL = await ref.getDownloadURL();
//       return downloadURL;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error uploading file: $e');
//       }
//       return '';
//     }
//   }

//   Future<String> getDownloadURL(String filePath) async {
//     try {
//       String downloadURL = await _storage.ref().child(filePath).getDownloadURL();
//       return downloadURL;
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error getting download URL: $e');
//       }
//       return '';
//     }
//   }

//   Future<void> deleteFile(String filePath) async {
//     try {
//       await _storage.ref().child(filePath).delete();
//     } catch (e) {
//       if (kDebugMode) {
//         print('Error deleting file: $e');
//       }
//     }
//   }
// }
