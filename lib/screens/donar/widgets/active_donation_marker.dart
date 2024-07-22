// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:food_shift/common_widgets/custom_button.dart';

// class ActiveDonationMarker extends StatelessWidget {
//   final LatLng orderLocation;
//   final List<LatLng> routePoints;

//   const ActiveDonationMarker({
//     super.key,
//     required this.orderLocation,
//     required this.routePoints,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
//       child: Card(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         elevation: 4,
//         child: Column(
//           children: [
//             // Map
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: SizedBox(
//                     height: 150,
//                     child: GoogleMap(
//                       initialCameraPosition: CameraPosition(
//                         target: orderLocation,
//                         zoom: 13.0,
//                       ),
//                       markers: {
//                         Marker(
//                           markerId: const MarkerId('orderLocation'),
//                           position: orderLocation,
//                           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//                         ),
//                       },
//                       polylines: {
//                         Polyline(
//                           polylineId: const PolylineId('route'),
//                           points: routePoints,
//                           color: Colors.blue,
//                           width: 4,
//                         ),
//                       },
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: IconButton(
//                     onPressed: () {
//                       // Handle zoom out action
//                     },
//                     icon: Image.asset(
//                       'assets/images/icons/zoom-out_icon.png',
//                       width: 20,
//                       height: 20,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 110,
//                   left: 100,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     padding: const EdgeInsets.all(6.0),
//                     child: const Row(
//                       children: [
//                         Icon(
//                           Icons.circle,
//                           color: Colors.green,
//                           size: 10,
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           'Arriving in 10mins',
//                           style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Order Status
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Row(
//                     children: [
//                       Text(
//                         'Delivery Person Assigned',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(width: 45),
//                       Icon(Icons.phone),
//                       SizedBox(width: 15),
//                       Icon(Icons.message),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       const Text(
//                         'Ramesh is on the way to\npickup the order',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       const SizedBox(width: 15),
//                       SizedBox(
//                         height: 40,
//                         child: CustomButton(
//                           text: 'Track Volunteer',
//                           onPressed: () {},
//                           width: 152,
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:annapardaan/screens/donar/widgets/order_tracking.dart';

import '../../../utils/constants/images.dart';

class ActiveDonationMarker extends StatefulWidget {
  final LatLng orderLocation;
  final LatLng volunteerLocation;

  const ActiveDonationMarker({
    super.key,
    required this.orderLocation,
    required this.volunteerLocation,
  });

  @override
  State<ActiveDonationMarker> createState() => _ActiveDonationMarkerState();
}

class _ActiveDonationMarkerState extends State<ActiveDonationMarker> {
  List<LatLng> routePoints = [];
  late PolylinePoints polylinePoints;
  final String apiKey = ''; 

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    computePath();
  }

  Future<void> computePath() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: apiKey,
      request: PolylineRequest(
        origin: PointLatLng(widget.volunteerLocation.latitude, widget.volunteerLocation.longitude),
        destination: PointLatLng(widget.orderLocation.latitude, widget.orderLocation.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        routePoints = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        if (kDebugMode) {
          print("Route points: $routePoints");
        }
      });
    } else {
      if (kDebugMode) {
        print("No route found: ${result.errorMessage}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          children: [
            // Map
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
                  child: SizedBox(
                    height: 150,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: widget.orderLocation,
                        zoom: 13.0,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('orderLocation'),
                          position: widget.orderLocation,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                        ),
                        Marker(
                          markerId: const MarkerId('volunteerLocation'),
                          position: widget.volunteerLocation,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                        ),
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId('route'),
                          points: routePoints,
                          color: Colors.black,
                          width: 4,
                        ),
                      },
                      onMapCreated: (GoogleMapController controller) {
                        // Optionally, perform additional map setup here
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: IconButton(
                    onPressed: () {
                      // Handle zoom out action
                    },
                    icon: Image.asset(
                      TImages.zoomOutImageIcon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.all(6.0),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.green,
                          size: 10,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Arriving in 10mins',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Order Status
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Delivery Person Assigned',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 45),
                      Icon(Icons.phone),
                      SizedBox(width: 15),
                      Icon(Icons.message),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        'Ramesh is on the way to\npickup the order',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        height: 40,
                        child: CustomButton(
                          text: 'Track Volunteer',
                          onPressed: () {
                            // Navigate to detailed tracking screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderTrackingScreen(
                                  orderLocation: widget.orderLocation,
                                  volunteerLocation: widget.volunteerLocation,
                                ),
                              ),
                            );
                          },
                          width: 152,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
