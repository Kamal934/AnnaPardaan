import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class FoodAvailabilityCard extends StatelessWidget {
  final String name;
  final List<String> imageUrls;
  final List<String> profileUrl;
  final String foodTitle;
  final String expiryTime;
  final VoidCallback onViewDetails;

  const FoodAvailabilityCard({
    super.key,
    required this.name,
    required this.profileUrl,
    required this.imageUrls,
    required this.foodTitle,
    required this.expiryTime,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (profileUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        profileUrl.first,
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 15,
                        ),
                        Text(
                          'Verified',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (imageUrls.isNotEmpty)
              Image.network(
                imageUrls.first,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                foodTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.location_pin, size: 15),
                  const Text('6km'),
                  const Icon(Icons.access_time_filled, size: 15),
                  Text('Exp: $expiryTime min'),
                  const SizedBox(width: 5),
                  SizedBox(
                    height: 40,
                    child: CustomButton(
                      onPressed: onViewDetails,
                      text: 'View Details',
                      width: 130,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:food_shift/common_widgets/custom_button.dart';

// class FoodAvailabilityCard extends StatelessWidget {
//   final String name;
//   final List<String> imageUrls;
//   final List<String> profileUrl;
//   final String foodTitle;
//   final String expiryTime;
//   final VoidCallback onViewDetails;

//   const FoodAvailabilityCard({
//     super.key,
//     required this.name,
//     required this.profileUrl,
//     required this.imageUrls,
//     required this.foodTitle,
//     required this.expiryTime,
//     required this.onViewDetails,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.only(top: 8.0, bottom: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 if (profileUrl.isNotEmpty)
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.file(
//                         File(profileUrl.first),
//                         height: 40,
//                         width: 40,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         name,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const Row(
//                         children: [
//                           Icon(
//                             Icons.verified,
//                             color: Colors.blue,
//                             size: 15,
//                           ),
//                           Text(
//                             'Verified',
//                             style: TextStyle(color: Colors.blue, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             if (imageUrls.isNotEmpty)
//               Image.file(
//                 File(imageUrls.first),
//                 height: 150,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8),
//               child: Text(
//                 foodTitle,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Icon(Icons.location_pin, size: 15),
//                   const Text('6km'),
//                   const Icon(Icons.access_time_filled, size: 15),
//                   Expanded(
//                     child: Text(
//                       'Exp: $expiryTime min',
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   SizedBox(
//                     height: 40,
//                     child: CustomButton(
//                       onPressed: onViewDetails,
//                       text: 'View Details',
//                       width: 130,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
