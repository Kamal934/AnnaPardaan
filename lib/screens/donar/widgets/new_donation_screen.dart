import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:annapardaan/screens/donar/widgets/custom_slider.dart';
import 'package:annapardaan/common_widgets/custom_image_card_picker.dart';
import '../../../controller/location_service.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_choosing_button.dart';
import '../../../common_widgets/custom_text_field.dart';
import '../../../utils/constants/text_strings.dart';

class NewDonationScreen extends StatefulWidget {
  final String restaurantId;

  const NewDonationScreen({super.key, required this.restaurantId});

  @override
  State<NewDonationScreen> createState() => _NewDonationScreenState();
}

class _NewDonationScreenState extends State<NewDonationScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<File> _images = [];
  final LocationController locationController = Get.put(LocationController());
  double _mealQuantity = 50;
  double _mealExpiryTime = 120;
  String _selectedMeal = 'Breakfast';
  String _selectedDiet = 'Veg';
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
          .child('donation_images')
          .child('${DateTime.now().toIso8601String()}.jpg');

      await ref.putFile(image);
      final imageUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print('Image uploaded: $imageUrl');
      }
      return imageUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
      return null;
    }
  }

  void _saveDonationDetails() async {
    // if (titleController.text.isEmpty ||
    //     descriptionController.text.isEmpty ||
    //     _images.isEmpty ||
    //     locationController.currentLocation.value.isEmpty) {
    //   Get.snackbar('Incomplete Details', 'Please enter all required fields and add at least one photo');
    //   return;
    // }

    try {
      List<String> imageUrls = [];
      for (File image in _images) {
        final imageUrl = await _uploadImageToFirestore(image);
        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        } else {
          if (kDebugMode) {
            print('Failed to upload image: $image');
          }
          Get.snackbar(
              'Error', 'Failed to upload some images. Please try again.');
          return;
        }
      }

      await FirebaseFirestore.instance
          .collection('restaurants')
          .doc(widget.restaurantId)
          .collection('donations')
          .add({
        'title': titleController.text,
        'description': descriptionController.text,
        'images': imageUrls,
        'location': locationController.currentLocation.value,
        'mealType': _selectedMeal,
        'dietType': _selectedDiet,
        'mealQuantity': _mealQuantity,
        'mealExpiryTime': _mealExpiryTime,
        'restaurantId': widget.restaurantId,
      });

      Navigator.pop(context);
      Get.snackbar('Success', 'Donation details saved successfully');
    } catch (e) {
      if (kDebugMode) {
        print('Error saving donation details: $e');
      }
      Get.snackbar('Error', 'Failed to save donation details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(TText.appbarTittle3),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                TText.tittle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: titleController,
                hintText: TText.donationTittle,
              ),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 239, 238, 245)),
              const Text(
                TText.addPhotos,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ImageCard(
                imageFiles: _images,
                onImagePicked: (file) => _pickImage(file),
              ),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 239, 238, 245)),
              const Text(
                TText.description,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: descriptionController,
                hintText: TText.description,
              ),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 239, 238, 245)),
              const Text(
                TText.mealQuantity,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomSlider(
                initialValue: _mealQuantity,
                min: 1,
                max: 100,
                divisions: 99,
                onChanged: (value) {
                  setState(() {
                    _mealQuantity = value;
                  });
                },
                unit: TText.kg,
              ),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 239, 238, 245)),
              const Text(
                TText.mealExpiryTime,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              CustomSlider(
                initialValue: _mealExpiryTime,
                min: 30,
                max: 300,
                divisions: 270,
                onChanged: (value) {
                  setState(() {
                    _mealExpiryTime = value;
                  });
                },
                unit: TText.mins,
              ),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 239, 238, 245)),
              const Text(
                TText.mealType,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomChoosingButton(
                    text: "Breakfast",
                    isSelected: _selectedMeal == "Breakfast",
                    onPressed: () =>
                        setState(() => _selectedMeal = "Breakfast"),
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  ),
                  CustomChoosingButton(
                    text: "Lunch",
                    isSelected: _selectedMeal == "Lunch",
                    onPressed: () => setState(() => _selectedMeal = "Lunch"),
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  ),
                  CustomChoosingButton(
                    text: "Dinner",
                    isSelected: _selectedMeal == "Dinner",
                    onPressed: () => setState(() => _selectedMeal = "Dinner"),
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Color.fromARGB(255, 239, 238, 245)),
              const Text(
                TText.diet,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomChoosingButton(
                    text: "Veg",
                    isSelected: _selectedDiet == "Veg",
                    onPressed: () => setState(() => _selectedDiet = "Veg"),
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  ),
                  CustomChoosingButton(
                    text: "Non-Veg",
                    isSelected: _selectedDiet == "Non-Veg",
                    onPressed: () => setState(() => _selectedDiet = "Non-Veg"),
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  ),
                  CustomChoosingButton(
                    text: "Both",
                    isSelected: _selectedDiet == "Both",
                    onPressed: () => setState(() => _selectedDiet = "Both"),
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  ),
                ],
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
              const SizedBox(height: 20),
              CustomButton(
                text: TText.saveDonation,
                onPressed: _saveDonationDetails,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
