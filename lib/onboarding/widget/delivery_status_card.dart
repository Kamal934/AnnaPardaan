// import 'package:flutter/material.dart';
// import '../../models/delivery_status.dart';

// class DeliveryStatusCard extends StatelessWidget {
//   final DeliveryStatus deliveryStatus;

//   const DeliveryStatusCard({super.key, required this.deliveryStatus});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               deliveryStatus.status,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 5),
//             Text('Arriving in ${deliveryStatus.eta}'),
//             const SizedBox(height: 10),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: Text(deliveryStatus.volunteerName),
//               subtitle: Text(deliveryStatus.volunteerContact),
//               trailing: ElevatedButton(
//                 onPressed: () {},
//                 child: const Text('Track Volunteer'),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ...deliveryStatus.stops.map((stop) => ListTile(
//               leading: const Icon(Icons.location_on),
//               title: Text(stop),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
