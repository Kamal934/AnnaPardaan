import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controller/hunger_spot_controller.dart';
import '../widgets/custom_hungerspot_card.dart';

class DonateToHungerSpotScreen extends StatelessWidget {
  final HungerSpotController hungerSpotController = Get.put(HungerSpotController());

  DonateToHungerSpotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TText.appbarTittle2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (kDebugMode) {
                print('Rendering GoogleMap with ${hungerSpotController.hungerSpots.length} spots');
              }
              return Stack(
                children: [
                  GoogleMap(
                    onMapCreated: (controller) {
                      hungerSpotController.mapController = controller;
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        hungerSpotController.mapCenter.value.latitude,
                        hungerSpotController.mapCenter.value.longitude,
                      ),
                      zoom: 13.0,
                    ),
                    markers: hungerSpotController.hungerSpots.map((spot) {
                      return Marker(
                        markerId: MarkerId(spot.id),
                        position: LatLng(spot.latitude, spot.longitude),
                        infoWindow: InfoWindow(
                          title: spot.name.isNotEmpty ? spot.name : TText.hungerSpot,
                          snippet: spot.address,
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                      );
                    }).toSet(),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 100,
                      child: Obx(() {
                        if (kDebugMode) {
                          print('Rendering ListView with ${hungerSpotController.hungerSpots.length} spots');
                        }
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: hungerSpotController.hungerSpots.length,
                          itemBuilder: (context, index) {
                            final hungerSpot = hungerSpotController.hungerSpots[index];
                            return CustomHungerSpotCard(
                              imageUrl: hungerSpot.firstImageUrl,
                              hungerSpotName: hungerSpot.name,
                              population: hungerSpot.population.toDouble(),
                              type: hungerSpot.type,
                              hungerSpot: hungerSpot,
                            );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
