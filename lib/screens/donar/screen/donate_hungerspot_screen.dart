import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/screens/location/calc_distance.dart';
import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:validators/validators.dart'; // Add this import for URL validation
import '../../../models/hunger_spot.dart';
import '../../location/address_loc.dart';

class DonateHungerspotScreen extends StatefulWidget {
  final HungerSpot hungerSpot;

  const DonateHungerspotScreen({super.key, required this.hungerSpot});

  @override
  State<DonateHungerspotScreen> createState() => _DonateHungerspotScreenState();
}

class _DonateHungerspotScreenState extends State<DonateHungerspotScreen> {
  @override
  Widget build(BuildContext context) {
    // Debug statement to check the firstImageUrl
    if (kDebugMode) {
      print('First Image URL: ${widget.hungerSpot.firstImageUrl}');
    }
    if (kDebugMode) {
      print('Is valid URL: ${isURL(widget.hungerSpot.firstImageUrl)}');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(TText.appbarTittle1),
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Handle more action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: isURL(widget.hungerSpot.firstImageUrl)
                            ? Image.network(
                                widget.hungerSpot.firstImageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(widget.hungerSpot.firstImageUrl),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hungerSpot.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                TText.verified,
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          Text(
                            'Meals for ${widget.hungerSpot.population} people needed',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                '📍',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              DistanceWidget(hungerSpot: widget.hungerSpot),
                              const SizedBox(width: 10),
                              Text(
                                widget.hungerSpot.type,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                TText.photos,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (widget.hungerSpot.imageUrls.isNotEmpty)
                Row(
                  children: [
                    for (int i = 0;
                        i < widget.hungerSpot.imageUrls.length && i < 3;
                        i++)
                      if (isURL(widget.hungerSpot.imageUrls[i]))
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.hungerSpot.imageUrls[i],
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    if (widget.hungerSpot.imageUrls.length > 3)
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: isURL(widget.hungerSpot.imageUrls[3])
                                ? Image.network(
                                    widget.hungerSpot.imageUrls[3],
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  )
                                : const SizedBox(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black45,
                            ),
                            height: 70,
                            width: 70,
                            child: Center(
                              child: Text(
                                '+${widget.hungerSpot.imageUrls.length - 3}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                )
              else
                const Text(
                  'No images available for this hunger spot.',
                  style: TextStyle(color: Colors.grey),
                ),
              const SizedBox(height: 16),
              const Text(
                TText.location,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    '📍',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AddressWidget(hungerSpot: widget.hungerSpot),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.hungerSpot.latitude,
                        widget.hungerSpot.longitude),
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('locationMarker'),
                      position: LatLng(widget.hungerSpot.latitude,
                          widget.hungerSpot.longitude),
                    ),
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 10),
        child: CustomButton(text: TText.donate, onPressed: () {}),
      ),
    );
  }
}
