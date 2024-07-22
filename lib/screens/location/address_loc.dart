import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/hunger_spot.dart';

class AddressWidget extends StatefulWidget {
  final HungerSpot hungerSpot;

  const AddressWidget({super.key, required this.hungerSpot});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  String? address;

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      widget.hungerSpot.latitude,
      widget.hungerSpot.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        address =
            '${place.street}, ${place.locality}, ${place.postalCode},  ${place.administrativeArea}, ${place.country}';
      });
    } else {
      setState(() {
        address = TText.unknownAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return address != null
        ? Text(
          overflow:TextOverflow.fade,
            address!,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          )
        : const CircularProgressIndicator();
  }
}
