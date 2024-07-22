import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class OrderTrackingScreen extends StatefulWidget {
  final LatLng orderLocation;
  final LatLng volunteerLocation;

  const OrderTrackingScreen({
    super.key,
    required this.orderLocation,
    required this.volunteerLocation,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  late GoogleMapController mapController;
  List<LatLng> routePoints = [];
  late PolylinePoints polylinePoints;
  String? apiKey;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    _getApiKey();
  }

  Future<void> _getApiKey() async {
    const platform = MethodChannel('com.example.your_app/api_key');
    try {
      final String result = await platform.invokeMethod('getApiKey');
      setState(() {
        apiKey = result;
        computePath();
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get API key: '${e.message}'.");
      }
    }
  }

  Future<void> computePath() async {
    if (apiKey == null) return;

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: apiKey!,
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Compute path after map is created
    computePath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Order #156079'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('HELP', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: widget.orderLocation,
              zoom: 13.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('orderLocation'),
                position: widget.orderLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              ),
              Marker(
                markerId: const MarkerId('volunteerLocation'),
                position: widget.volunteerLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Arriving in 10 mins', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('To My Restaurant - Avinashi Rd, Peelamedu,Cbe-05'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text('Ramesh is on the way to pick up the order, and will assist over a call if needed'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('Add Pickup Instructions'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.grey[200],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
