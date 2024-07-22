import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';



class LocationController extends GetxController {
  var currentPosition = Rx<Position?>(null);
  var isLoading = false.obs;
  var currentLocation = ''.obs;

  Future<Position> getPosition() async {
    LocationPermission? permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission are denied");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAddressFromLatLang(double long, double lat) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);
      Placemark place = placemark[0];
      currentLocation.value =
          "${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.country}";
      if (kDebugMode) {
        print(currentLocation.value);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      isLoading.value = true;
      currentPosition.value = await getPosition();
      await getAddressFromLatLang(currentPosition.value!.longitude, currentPosition.value!.latitude);
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading.value = false;
    }
  }
}
