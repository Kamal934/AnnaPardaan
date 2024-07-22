import 'package:flutter/material.dart';
import '../../../models/donation_item.dart';
import '../../../utils/constants/colors.dart';

class DonationList extends StatelessWidget {
  final List<DonationItem> donations = [
    DonationItem(
      foundationName: 'Ashaa Foundation',
      foundationImage:
          'https://images.pexels.com/photos/762080/pexels-photo-762080.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // replace with actual image URL
      dateTime: 'Oct 10, 2023, 8:30pm',
      foodCount: 50,
    ),
    DonationItem(
      foundationName: 'New Hope Homes',
      foundationImage:
          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // replace with actual image URL
      dateTime: 'Oct 5, 2023, 6:30pm',
      foodCount: 30,
    ),
    DonationItem(
      foundationName: 'Sastra Foundation',
      foundationImage:
          'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', // replace with actual image URL
      dateTime: 'Oct 1, 2023, 8:30pm',
      foodCount: 40,
    ),
  ];

  DonationList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          final donation = donations[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(donation.foundationImage),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donation.foundationName,
                        style: const TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        donation.dateTime,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${donation.foodCount} Foods',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: TColors.darkerGrey),
                    ),
                    const Text(
                      'Successfully Donated',
                      style: TextStyle(fontSize: 12, color: TColors.darkerGrey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
