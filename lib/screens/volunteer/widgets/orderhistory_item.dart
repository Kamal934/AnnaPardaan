import 'package:flutter/material.dart';

class OrderHistoryItem extends StatelessWidget {
  final String from;
  final String to;
  final String date;
  final String time;
  final bool delivered;

  const OrderHistoryItem({
    super.key,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.delivered,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              delivered ? Icons.check_circle : Icons.pending,
              color: delivered ? Colors.green : Colors.orange,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$from to $to', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('$date, $time'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
