import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/recipient/donation_details_screen.dart';
import 'food_availability_card.dart';

class FoodAvailabilityCardBuilder {
  static Widget buildFoodAvailabilityCard(BuildContext context, DocumentSnapshot donation, DocumentSnapshot restaurant) {
    final donationData = donation.data() as Map<String, dynamic>;
    final List<String> donationImages = List<String>.from(donationData['images'] ?? []);

    final restaurantData = restaurant.data() as Map<String, dynamic>;
    final List<String> restaurantImages = List<String>.from(restaurantData['images'] ?? []);
    if (kDebugMode) {
      print(donation.id);
    }
    return FoodAvailabilityCard(
      name: restaurantData['name'] ?? 'No name',
      foodTitle: donationData['title'],
      profileUrl: restaurantImages,
      imageUrls: donationImages,
      expiryTime: donationData['mealExpiryTime'].toString(),
      onViewDetails: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonationDetailsScreen(donationId: donation.id, restaurantId: restaurant.id),
          ),
        );
      },
    );
  }
}