import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/hunger_spot.dart';

class HungerSpotController extends GetxController {
  var hungerSpots = <HungerSpot>[].obs;
  var mapCenter = const LatLng(20.5937, 78.9629).obs;

  late GoogleMapController mapController;

  @override
  void onInit() {
    super.onInit();
    fetchHungerSpots();
  }

  void addHungerSpot(HungerSpot hungerSpot) {
    hungerSpots.add(hungerSpot);
    FirebaseFirestore.instance
        .collection('hungerSpots')
        .doc(hungerSpot.id)
        .set(hungerSpot.toJson());
  }

  void updateHungerSpot(HungerSpot updatedSpot) {
    int index = hungerSpots.indexWhere((spot) => spot.id == updatedSpot.id);
    if (index != -1) {
      hungerSpots[index] = updatedSpot;
    }
    FirebaseFirestore.instance
        .collection('hungerSpots')
        .doc(updatedSpot.id)
        .update(updatedSpot.toJson());
  }

  void updateMapPosition(double latitude, double longitude) {
    mapCenter.value = LatLng(latitude, longitude);
  }

  void fetchHungerSpots() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('hungerSpots').get();
    var spots = snapshot.docs.map((doc) {
      // Debugging print statements
      if (kDebugMode) {
        print('Document ID: ${doc.id}');
      }
      if (kDebugMode) {
        print('Data: ${doc.data()}');
      }

      List<String> imageUrls = [];
      if (doc['imageUrls'] != null) {
        imageUrls = List<String>.from(doc['imageUrls']);
      }

      if (kDebugMode) {
        print('Image URLs: $imageUrls');
      }

      return HungerSpot(
        id: doc['id'],
        address: doc['address'],
        latitude: doc['latitude'],
        longitude: doc['longitude'],
        name: doc['name'],
        population: doc['population'],
        imageUrls: imageUrls,
        type: doc['type'],
      );
    }).toList();

    hungerSpots.assignAll(spots);
  }
}
