import 'package:flutter/material.dart';
import 'package:annapardaan/common_widgets/custom_switch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:annapardaan/screens/Insights/insights.dart';
import 'package:annapardaan/screens/Insights/leaderboard.dart';
import 'package:annapardaan/screens/volunteer/widgets/order_history.dart';
import 'package:annapardaan/common_widgets/custom_appbar.dart';
import 'package:annapardaan/common_widgets/custom_section_header.dart';
import '../../data/custom_card_item_data.dart';
import '../../common_widgets/badge_earned.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/active_order.dart';

class VolunteerHomeScreen extends StatelessWidget {
  final LatLng orderLocation =
      const LatLng(40.7128, -74.0060);
  final List<LatLng> routePoints = [
    const LatLng(40.7128, -74.0060),
    const LatLng(40.7200, -74.0100),
  ];
  final customCardItems = getCustomCardItems();

  VolunteerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(userName: 'Preet', userImageUrl: 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',),
      body: ListView(
        children: [
           Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.online,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocalizations.of(context)!.onlineSubtitle,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                const CustomSwitch(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: SectionHeader(
              title: AppLocalizations.of(context)!.activeOrder,
              onViewAllPressed: () {},
            ),
          ),
          ActiveOrderMarker(
            orderLocation: orderLocation,
            routePoints: routePoints,
          ),
          const SizedBox(height: 16),
          const OrderHistory(),
          const SizedBox(height: 16),
           Insights(subtitle: AppLocalizations.of(context)!.insightsVolunteer, isDonorScreen: false,),
          const SizedBox(height: 16),
          const BadgeEarned(),
          const SizedBox(height: 16),
          LeaderBoard(leaderBoardMembers: customCardItems),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
