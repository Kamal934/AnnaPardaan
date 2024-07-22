import 'package:flutter/material.dart';

class DonationCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final VoidCallback onViewDetails;

  const DonationCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onViewDetails,
              child: const Text("View Details"),
            ),
          ],
        ),
      ),
    );
  }
}
