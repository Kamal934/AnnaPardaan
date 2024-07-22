// import 'package:flutter/material.dart';
// import 'package:food_shift/controller/location_service.dart';
// import 'package:food_shift/screens/donar/widgets/new_donation_screen.dart';
// import 'package:get/get.dart';
// import '../../../common_widgets/custom_button.dart';
// import '../../../common_widgets/custom_image_card_picker.dart';
// import '../../../common_widgets/custom_text_field.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddRestaurantScreen extends StatefulWidget {
//   final bool isDonor;

//   const AddRestaurantScreen({super.key, required this.isDonor});

//   @override
//   State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
// }

// class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController fssaiController = TextEditingController();
//   final TextEditingController panController = TextEditingController();
//   final List<String> _imageUrls = [];
//   final LocationController locationController = Get.put(LocationController());

//   @override
//   void initState() {
//     super.initState();
//     locationController.getCurrentLocation();
//   }

//   void _onImagePicked(String imagePath) {
//     setState(() {
//       _imageUrls.add(imagePath);
//     });
//   }

//   void _saveRestaurantDetails() async {
//   if (nameController.text.isEmpty ||
//       fssaiController.text.isEmpty ||
//       panController.text.isEmpty ||
//       _imageUrls.isEmpty ||
//       locationController.currentLocation.value.isEmpty) {
//     Get.snackbar('Incomplete Details', 'Please enter all required fields and add at least one photo');
//     return;
//   }

//   try {
//     final docRef = await FirebaseFirestore.instance.collection('restaurants').add({
//       'name': nameController.text,
//       'fssai': fssaiController.text,
//       'pan': panController.text,
//       'images': _imageUrls,
//       'location': locationController.currentLocation.value,
//       'isDonor': widget.isDonor,
//     });
//     Get.snackbar('Success', 'Details saved successfully');
//     Navigator.pushReplacement(
//       // ignore: use_build_context_synchronously
//       context,
//       MaterialPageRoute(
//         builder: (context) => NewDonationScreen(restaurantId: docRef.id),
//       ),
//     );
//   } catch (e) {
//     Get.snackbar('Error', 'Failed to save details');
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     final String titleText = widget.isDonor ? 'Restaurant' : 'Organization';
//     final String nameHint = widget.isDonor ? 'Restaurant Name' : 'Organization Name';
//     final String licenseHint = widget.isDonor ? 'FSSAI Licence' : 'Registration Number';
//     const String panHint = 'PAN Number';

//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 30,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Row(
//               children: [
//                 const Text(
//                   'Add ',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 Text(
//                   titleText,
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Title',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             CustomTextField(
//               controller: nameController,
//               hintText: nameHint,
//             ),
//             const SizedBox(height: 10),
//             const Divider(color: Color.fromARGB(255, 239, 238, 245)),
//             const Text(
//               'Add Photos',
//               style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             ImageCard(
//               imageUrls: _imageUrls,
//               onImagePicked: _onImagePicked,
//             ),
//             const SizedBox(height: 10),
//             const Divider(color: Color.fromARGB(255, 239, 238, 245)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Location',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     locationController.getCurrentLocation();
//                   },
//                   child: const Text(
//                     'Refresh',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ],
//             ),
//             Obx(() {
//               if (locationController.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 return Container(
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 239, 238, 245),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.location_pin, color: Colors.red),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           locationController.currentLocation.value,
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 15,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       const Icon(Icons.check_circle, color: Colors.red),
//                     ],
//                   ),
//                 );
//               }
//             }),
//             const SizedBox(height: 8),
//             const Divider(color: Color.fromARGB(255, 239, 238, 245)),
//             const SizedBox(height: 8),
//             CustomTextField(
//               controller: fssaiController,
//               hintText: licenseHint,
//             ),
//             const SizedBox(height: 10),
//             CustomTextField(
//               controller: panController,
//               hintText: panHint,
//             ),
//             const SizedBox(height: 8),
//             const Divider(color: Color.fromARGB(255, 239, 238, 245)),
//             const SizedBox(height: 8),
//             const Text(
//               'Add another Restaurant',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             CustomButton(
//               text: 'Done',
//               onPressed: _saveRestaurantDetails,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:annapardaan/controller/location_service.dart';
import 'package:annapardaan/screens/donar/widgets/new_donation_screen.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../common_widgets/custom_image_card_picker.dart';
import '../../../utils/constants/text_strings.dart';

class AddRestaurantScreen extends StatefulWidget {
  final bool isDonor;

  const AddRestaurantScreen({super.key, required this.isDonor});

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController fssaiController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final List<File> _images = [];
  final LocationController locationController = Get.put(LocationController());
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    locationController.getCurrentLocation();
  }

  Future<void> _pickImage(File imageFile) async {
  setState(() {
    _images.add(imageFile);
  });
  final imageUrl = await _uploadImageToFirestore(imageFile);
  if (imageUrl != null) {
    setState(() {
      imageUrls.add(imageUrl);
    });
  }
}

  Future<String?> _uploadImageToFirestore(File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('restaurant_images')
          .child('${DateTime.now().toIso8601String()}.jpg');

      await ref.putFile(image);
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  void _saveRestaurantDetails() async {
    if (nameController.text.isEmpty ||
        fssaiController.text.isEmpty ||
        panController.text.isEmpty ||
        _images.isEmpty ||
        locationController.currentLocation.value.isEmpty) {
      Get.snackbar('Incomplete Details', 'Please enter all required fields and add at least one photo');
      return;
    }

    List<String> imageUrls = [];
    for (File image in _images) {
      final imageUrl = await _uploadImageToFirestore(image);
      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      }
    }

    try {
      final docRef = await FirebaseFirestore.instance.collection('restaurants').add({
        'name': nameController.text,
        'fssai': fssaiController.text,
        'pan': panController.text,
        'images': imageUrls,
        'location': locationController.currentLocation.value,
        'isDonor': widget.isDonor,
      });
      Get.snackbar('Success', 'Details saved successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NewDonationScreen(restaurantId: docRef.id),
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to save details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String titleText = widget.isDonor ? TText.restaurant : TText.organization;
    final String nameHint = widget.isDonor ? TText.restaurantName: TText.organizationName;
    final String licenseHint = widget.isDonor ? TText.fssaiLicence :TText.registrationNumber;
    const String panHint =TText.panCardNumber;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                const Text(
                  TText.add,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  titleText,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              TText.tittle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: nameController,
              hintText: nameHint,
            ),
            const SizedBox(height: 10),
            const Divider(color: Color.fromARGB(255, 239, 238, 245)),
            const Text(
              TText.addPhotos,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ImageCard(
              imageFiles: _images,
              onImagePicked: (file) => _pickImage(file),
            ),
            const SizedBox(height: 10),
            const Divider(color: Color.fromARGB(255, 239, 238, 245)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  TText.location,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    locationController.getCurrentLocation();
                  },
                  child: const Text(
                    TText.refresh,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            Obx(() {
              if (locationController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 238, 245),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_pin, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          locationController.currentLocation.value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.check_circle, color: Colors.red),
                    ],
                  ),
                );
              }
            }),
            const SizedBox(height: 8),
            const Divider(color: Color.fromARGB(255, 239, 238, 245)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: fssaiController,
              hintText: licenseHint,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: panController,
              hintText: panHint,
            ),
            const SizedBox(height: 8),
            const Divider(color: Color.fromARGB(255, 239, 238, 245)),
            const SizedBox(height: 8),
            const Text(
              TText.addAnotherRestaurant,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: TText.done,
              onPressed: _saveRestaurantDetails,
            ),
          ],
        ),
      ),
    );
  }
}
