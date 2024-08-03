// import 'package:flutter/material.dart';
// import 'package:food_shift/common_widgets/custom_image_card_picker.dart';
// import 'package:get/get.dart';
// import '../../../controller/hunger_spot_controller.dart';
// import '../../../models/hunger_spot.dart';
// import '../../../utils/constants/colors.dart';
// import '../../../common_widgets/custom_button.dart';
// import '../../../common_widgets/custom_choosing_button.dart';
// import '../../../common_widgets/custom_text_field.dart';

// class FillingAddHungerPointsScreen extends StatefulWidget {
//   final HungerSpot hungerSpot;
//   const FillingAddHungerPointsScreen({super.key, required this.hungerSpot});

//   @override
//   State<FillingAddHungerPointsScreen> createState() => _FillingAddHungerPointsScreenState();
// }

// class _FillingAddHungerPointsScreenState extends State<FillingAddHungerPointsScreen> {
//   final HungerSpotController hungerSpotController = Get.put(HungerSpotController());
//   final TextEditingController hungerSpotNameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   int population = 0;
//   int _selectedIndex = -1;
//   String _selectedType = '';
//   List<String> imageUrls = [];

//   void _onButtonPressed(int index, String type) {
//     setState(() {
//       _selectedIndex = index;
//       _selectedType = type;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     hungerSpotNameController.text = widget.hungerSpot.name;
//     addressController.text = widget.hungerSpot.address;
//     population = widget.hungerSpot.population;
//     imageUrls = widget.hungerSpot.imageUrls ?? [];
//     _selectedType = widget.hungerSpot.type;
//   }

//   void _onImagePicked(String imagePath) {
//     setState(() {
//       imageUrls.add(imagePath);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     return SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//         ),
//         padding: EdgeInsets.only(
//           top: 15,
//           left: 16,
//           right: 16,
//           bottom: keyboardHeight,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.only(left: 140.0, right: 140),
//               child: Divider(
//                 thickness: 3.5,
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             CustomTextField(
//               controller: hungerSpotNameController,
//               hintText: 'Hunger Spot Name',
//             ),
//             const SizedBox(height: 15.0),
//             const Text(
//               'Hunger Spot Type',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//             const SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomChoosingButton(
//                   text: 'Platforms',
//                   isSelected: _selectedIndex == 0,
//                   onPressed: () => _onButtonPressed(0, 'Platforms'),
//                   width: 100,
//                 ),
//                 CustomChoosingButton(
//                   text: 'Slum Area',
//                   isSelected: _selectedIndex == 1,
//                   onPressed: () => _onButtonPressed(1, 'Slum Area'),
//                   width: 100,
//                 ),
//                 CustomChoosingButton(
//                   text: 'Railways',
//                   isSelected: _selectedIndex == 2,
//                   onPressed: () => _onButtonPressed(2, 'Railways'),
//                   width: 100,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10.0),
//             const Text(
//               'Add Photos',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//             const SizedBox(height: 10.0),
//             ImageCard(
//               onImagePicked: _onImagePicked,
//               imageUrls: imageUrls,
//             ),
//             const SizedBox(height: 16.0),
//             const Text(
//               'Population',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//             const SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: Row(
//                 children: [
//                   const Text('0'),
//                   const Spacer(),
//                   Text(population.toString()),
//                   const Spacer(),
//                   const Text('200'),
//                 ],
//               ),
//             ),
//             Slider(
//               activeColor: TColors.primaryLight,
//               value: population.toDouble(),
//               min: 0,
//               max: 200,
//               label: population.toString(),
//               onChanged: (value) {
//                 setState(() {
//                   population = value.toInt();
//                 });
//               },
//             ),
//             const SizedBox(height: 16.0),
//             Row(
//               children: [
//                 Checkbox(
//                   value: false,
//                   onChanged: (value) {},
//                   activeColor: TColors.primaryLight,
//                 ),
//                 const Expanded(
//                   child: Text(
//                     'I hereby declare that the above information was provided according to my knowledge.',
//                     style: TextStyle(fontSize: 12),
//                   ),
//                 ),
//               ],
//             ),
//             CustomButton(
//               text: 'Add Hunger spot',
//               onPressed: () {
//                 // Update the hunger spot with new data
//                 final updatedSpot = HungerSpot(
//                   id: widget.hungerSpot.id,
//                   address: addressController.text,
//                   name: hungerSpotNameController.text,
//                   latitude: widget.hungerSpot.latitude,
//                   longitude: widget.hungerSpot.longitude,
//                   population: population,
//                   imageUrls: imageUrls,
//                   type: _selectedType,
//                 );

//                 // Update the hunger spot controller
//                 hungerSpotController.updateHungerSpot(updatedSpot);

//                 // Navigate to the DonateToHungerspot screen with updated hunger spot
//                 Navigator.pop(context);
//               },
//             ),
//             const SizedBox(height: 16.0),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import '../../../controller/hunger_spot_controller.dart';
import '../../../models/hunger_spot.dart';
import '../../../utils/constants/colors.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_choosing_button.dart';
import '../../../common_widgets/custom_text_field.dart';
import 'package:annapardaan/common_widgets/custom_image_card_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FillingAddHungerPointsScreen extends StatefulWidget {
  final HungerSpot hungerSpot;
  const FillingAddHungerPointsScreen({super.key, required this.hungerSpot});

  @override
  State<FillingAddHungerPointsScreen> createState() =>
      _FillingAddHungerPointsScreenState();
}

class _FillingAddHungerPointsScreenState
    extends State<FillingAddHungerPointsScreen> {
  final HungerSpotController hungerSpotController =
      Get.put(HungerSpotController());
  final TextEditingController hungerSpotNameController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  int population = 0;
  int _selectedIndex = -1;
  String _selectedType = '';
  final List<File> _images = [];
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    hungerSpotNameController.text = widget.hungerSpot.name;
    addressController.text = widget.hungerSpot.address;
    population = widget.hungerSpot.population;
    imageUrls = widget.hungerSpot.imageUrls;
    _selectedType = widget.hungerSpot.type;
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   final pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     final imageFile = File(pickedFile.path);
  //     String? imageUrl = await _uploadImageToFirestore(imageFile);
  //     if (imageUrl != null) {
  //       setState(() {
  //         _images.add(imageFile);
  //         imageUrls.add(imageUrl);
  //       });
  //     }
  //   }
  // }

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
          .child('hunger_spot_images')
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

  void _onButtonPressed(int index, String type) {
    setState(() {
      _selectedIndex = index;
      _selectedType = type;
    });
  }

  void _saveHungerSpotDetails() async {
    // Check if all required fields are filled
    if (hungerSpotNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        _selectedType.isEmpty ||
        imageUrls.isEmpty) {
          toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:      const Text('Incomplete Details\',\'Please enter all required fields and add at least one photo'));
       
      return;
    }

    // Update the hunger spot with new data
    final updatedSpot = HungerSpot(
      id: widget.hungerSpot.id,
      address: addressController.text,
      name: hungerSpotNameController.text,
      latitude: widget.hungerSpot.latitude,
      longitude: widget.hungerSpot.longitude,
      population: population,
      imageUrls: imageUrls,
      type: _selectedType,
    );

    // Update the hunger spot controller
    hungerSpotController.updateHungerSpot(updatedSpot);

    // Navigate to the DonateToHungerspot screen with updated hunger spot
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          top: 15,
          left: 16,
          right: 16,
          bottom: keyboardHeight,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 140.0, right: 140),
              child: Divider(
                thickness: 3.5,
              ),
            ),
            const SizedBox(height: 30.0),
            CustomTextField(
              controller: hungerSpotNameController,
              hintText: AppLocalizations.of(context)!.hungerSpotName,
            ),
            const SizedBox(height: 15.0),
             Text(
              AppLocalizations.of(context)!.hungerSpotType,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomChoosingButton(
                  text: 'Platforms',
                  isSelected: _selectedIndex == 0,
                  onPressed: () => _onButtonPressed(0, 'Platforms'),
                  width: 100,
                ),
                CustomChoosingButton(
                  text: 'Slum Area',
                  isSelected: _selectedIndex == 1,
                  onPressed: () => _onButtonPressed(1, 'Slum Area'),
                  width: 100,
                ),
                CustomChoosingButton(
                  text: 'Railways',
                  isSelected: _selectedIndex == 2,
                  onPressed: () => _onButtonPressed(2, 'Railways'),
                  width: 100,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
             Text(
              AppLocalizations.of(context)!.addPhotos,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10.0),
            ImageCard(
              onImagePicked: (file) => _pickImage(file),
              imageFiles: _images,
            ),
            const SizedBox(height: 16.0),
             Text(
              AppLocalizations.of(context)!.population,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Text('0'),
                  const Spacer(),
                  Text(population.toString()),
                  const Spacer(),
                  const Text('200'),
                ],
              ),
            ),
            Slider(
              activeColor: TColors.primaryLight,
              value: population.toDouble(),
              min: 0,
              max: 200,
              label: population.toString(),
              onChanged: (value) {
                setState(() {
                  population = value.toInt();
                });
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  activeColor: TColors.primaryLight,
                ),
                 Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.declaration,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            CustomButton(
              text: AppLocalizations.of(context)!.addHungerSpot,
              onPressed: _saveHungerSpotDetails,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
