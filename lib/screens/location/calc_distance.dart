import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../models/hunger_spot.dart';

class DistanceWidget extends StatefulWidget {
  final HungerSpot hungerSpot;

  const DistanceWidget({super.key, required this.hungerSpot});

  @override
  State<DistanceWidget> createState() => _DistanceWidgetState();
}

class _DistanceWidgetState extends State<DistanceWidget> {
  double? distance;

  @override
  void initState() {
    super.initState();
    _calculateDistance();
  }

  Future<void> _calculateDistance() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double calculatedDistance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      widget.hungerSpot.latitude,
      widget.hungerSpot.longitude,
    ) / 1000; // Convert meters to kilometers

    setState(() {
      distance = calculatedDistance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return distance != null
        ? Text('${distance!.toStringAsFixed(2)} km')
        : const Skeletonizer
        (enabled: true, child: Card.filled(),);
  }
}
