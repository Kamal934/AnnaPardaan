import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../models/food_donation.dart';

class FoodDonationCard extends StatelessWidget {
  final FoodDonation foodDonation;

  const FoodDonationCard({super.key, required this.foodDonation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10,top: 15),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Adjust the radius as needed
        ),
        // margin: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(15.0), // Adjust the radius as needed
              child: Image.network(
                foodDonation.imageUrl,
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover, // Make sure the image covers the area
              ),
            ),
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(15.0), // Adjust the radius as needed
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 30,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    foodDonation.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 40,
                    child: CustomButton(
                      text: 'Donate Food',
                      onPressed: () {},
                      width: 135,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
