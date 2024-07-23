import 'package:annapardaan/common_widgets/custom_text_field.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toastification/toastification.dart';
import 'filling_add_hunger_spot_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/hunger_spot_controller.dart';
import '../../../models/hunger_spot.dart';

class AddHungerSpotScreen extends StatefulWidget {
  const AddHungerSpotScreen({super.key});

  @override
  State<AddHungerSpotScreen> createState() => _AddHungerSpotScreenState();
}

class _AddHungerSpotScreenState extends State<AddHungerSpotScreen> {
  final HungerSpotController hungerSpotController = Get.put(HungerSpotController());
  final TextEditingController addressController = TextEditingController();
  LatLng? tappedPoint;
  late GoogleMapController _mapController;

  void _searchAddress() async {
    try {
      List<Location> locations = await locationFromAddress(addressController.text);
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          tappedPoint = LatLng(location.latitude, location.longitude);
        });
        final newHungerSpot = HungerSpot(
          id: DateTime.now().toString(),
          address: addressController.text,
          latitude: location.latitude,
          longitude: location.longitude,
          name: '',
          population: 0,
          imageUrls: [], 
          type: '',
        );
        hungerSpotController.addHungerSpot(newHungerSpot);
        hungerSpotController.updateMapPosition(
          location.latitude,
          location.longitude,
        );
        _mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(location.latitude, location.longitude),
          ),
        );
        toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.green,
          title:     Text('Hunger spot added at (${location.latitude}, ${location.longitude})'));
       
        

        // ignore: use_build_context_synchronously
        _displayBottomSheet(context, newHungerSpot);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.red,
          title:     const Text('Could not find location. Please try again.'));
       

    }
  }

  void _onMapTapped(LatLng point) async {
    setState(() {
      tappedPoint = point;
    });

    // Reverse geocoding to get the address from coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(point.latitude, point.longitude);
    String address = placemarks.isNotEmpty
        ? '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}'
        : 'Unknown Location';

    final newHungerSpot = HungerSpot(
      id: DateTime.now().toString(),
      address: address,
      latitude: point.latitude,
      longitude: point.longitude,
      name: '',
      population: 0,
      imageUrls: [], 
      type: '',
    );

    hungerSpotController.addHungerSpot(newHungerSpot);
    hungerSpotController.updateMapPosition(
      point.latitude,
      point.longitude,
    );

    toastification.show(
          style: ToastificationStyle.minimal,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topRight,
          primaryColor: Colors.black,
          title:      Text('Hunger spot added at - $address'));
       

    _displayBottomSheet(context, newHungerSpot);
  }

  Future<void> _displayBottomSheet(BuildContext context, HungerSpot hungerSpot) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FillingAddHungerPointsScreen(hungerSpot: hungerSpot);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TText.addHungerPoint),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: addressController,
                        hintText: TText.enterAddress,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _searchAddress,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  return GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        hungerSpotController.mapCenter.value.latitude,
                        hungerSpotController.mapCenter.value.longitude,
                      ),
                      zoom: 13.0,
                    ),
                    onTap: _onMapTapped,
                    markers: hungerSpotController.hungerSpots.map((spot) {
                      return Marker(
                        markerId: MarkerId(spot.id),
                        position: LatLng(spot.latitude, spot.longitude),
                        infoWindow: InfoWindow(
                          title: TText.hungerSpot,
                          // snippet: 'Lat: ${spot.latitude}, Lng: ${spot.longitude}',
                          onTap: () {
                            _displayBottomSheet(context, spot);
                          },
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                      );
                    }).toSet(),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
