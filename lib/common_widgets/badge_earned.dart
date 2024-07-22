import 'package:annapardaan/common_widgets/badge_card.dart';
import 'package:annapardaan/common_widgets/custom_section_header.dart';
import 'package:flutter/material.dart';
import '../screens/Insights/leaderboard_screen.dart';

class BadgeEarned extends StatelessWidget {
  const BadgeEarned({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Badges Earned',
            icon: Icons.arrow_forward_ios_rounded,
            onIconPressed: () => const LeaderboardScreen(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BadgeCard(badge: 'Helping Hand', imagePath: 'assets/images/icons/handing_help_icon.png'),
              BadgeCard(badge: 'Rescue Expert', imagePath: 'assets/images/icons/best_badge_icon.png'),
              BadgeCard(badge: 'Team Player', imagePath: 'assets/images/icons/premium-quality_icon.png'),
            ],
          ),
        ],
      ),
    );
  }
}