import 'package:flutter/material.dart';
import 'package:annapardaan/screens/Insights/leaderboard_screen.dart';

import '../../../common_widgets/custom_section_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'orderhistory_item.dart'; 

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: AppLocalizations.of(context)!.orderHistory,
            onViewAllPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const LeaderboardScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          const OrderHistoryItem(
            from: 'Vijay Elanza',
            to: 'Aasha Foundation',
            date: 'Oct 15, 2023',
            time: '5:00PM',
            delivered: true,
          ),
          const SizedBox(height: 8),
          const OrderHistoryItem(
            from: '535 Grand',
            to: 'New Hope Homes',
            date: 'Oct 12, 2023',
            time: '3:30PM',
            delivered: true,
          ),
        ],
      ),
    );
  }
}
