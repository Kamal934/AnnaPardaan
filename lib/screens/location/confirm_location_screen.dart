import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:annapardaan/common_widgets/custom_button.dart';
import '../../controller/location_service.dart';
import 'map_screen.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  final TextEditingController _locationController = TextEditingController();
  final LocationController _locationControllerGetx = Get.put(LocationController());

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    await _locationControllerGetx.getCurrentLocation();
    setState(() {
      _locationController.text = _locationControllerGetx.currentLocation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirm your location 📍',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please enter your location or allow access to your location to find Donors near you.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Search here',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.location_pin, color: Colors.red),
              title: const Text('Use my current location'),
              subtitle: Obx(() {
                return Text(
                  _locationControllerGetx.currentLocation.value.isNotEmpty
                      ? _locationControllerGetx.currentLocation.value
                      : 'Fetching location...',
                );
              }),
              onTap: _getCurrentLocation,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 10),
          child: CustomButton(
            text: TText.confirm,
            onPressed: () {
              if (kDebugMode) {
                print('Entered location: ${_locationController.text}');
              }
              // Navigate to the map screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapScreen(
                    location: _locationControllerGetx.currentPosition.value,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
