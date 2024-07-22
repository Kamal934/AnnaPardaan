import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/constants/images.dart';

class ActiveOrderMarker extends StatelessWidget {
  final LatLng orderLocation;
  final List<LatLng> routePoints;

  const ActiveOrderMarker({
    super.key,
    required this.orderLocation,
    required this.routePoints,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0, right: 6),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            // Map
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: orderLocation,
                        zoom: 13.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('orderLocation'),
                          position: orderLocation,
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                        ),
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId('route'),
                          points: routePoints,
                          color: Colors.blue,
                          width: 4,
                        ),
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 90,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 10,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Your order is on the way',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  width: 30, // Set the desired width
                  height: 30, // Set the desired height
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      TImages.zoomOutImageIcon,
                      width: 25, // Set the width of the image
                      height: 25, // Set the height of the image
                    ),
                    iconSize: 25, // Set the size of the IconButton
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Order Status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  // Locations
                  _buildLocationRow(
                    'Vijay Elanza',
                    'Avinashi Rd, Peelamedu,\nCoimbatore-641004',
                  ),
                  const SizedBox(height: 8),
                  _buildLocationRow(
                    'Asha Foundation',
                    'Dr Nanjapaa Rd, Ram Nagar,\nCoimbatore-641005',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(String name, String address) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_pin, color: Colors.black),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                address,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.phone, color: Colors.black),
        const SizedBox(width: 8),
        const Icon(Icons.message, color: Colors.black),
      ],
    );
  }
}
