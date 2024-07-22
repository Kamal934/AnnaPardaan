// CustomHungerSpotCard widget
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../models/hunger_spot.dart';
import '../screen/donate_hungerspot_screen.dart';

class CustomHungerSpotCard extends StatelessWidget {
  final String imageUrl;
  final String hungerSpotName;
  final double population;
  final String type;
  final HungerSpot hungerSpot; 

  const CustomHungerSpotCard({
    super.key,
    required this.imageUrl,
    required this.hungerSpotName,
    required this.population,
    required this.type,
    required this.hungerSpot, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the DonateHungerspotScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DonateHungerspotScreen(hungerSpot: hungerSpot),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.only(left:10,right: 8.0, bottom: 30.0), 
        child: Row(
          mainAxisSize: MainAxisSize.min, 
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imageUrl.startsWith('http') ? Image.network(
                imageUrl,
                height: 80,
                width: 110,
                fit: BoxFit.cover,
              ) : Image.file(
                File(imageUrl),
                height: 80,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hungerSpotName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$population needy people',
                      style: const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

