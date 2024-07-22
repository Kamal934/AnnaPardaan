import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../models/custom_card_item_model.dart';
import '../../common_widgets/custom_card_item.dart';
import '../../common_widgets/custom_section_header.dart';
import '../../utils/constants/text_strings.dart';
import 'leaderboard_screen.dart';


class LeaderBoard extends StatelessWidget {
  const LeaderBoard({
    super.key,
    required List<TopLeaderBoardCardItemModel> leaderBoardMembers,
  }) : _leaderBoardMembers = leaderBoardMembers;

  final List<TopLeaderBoardCardItemModel> _leaderBoardMembers;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: TText.leaderBoard,
              icon: Icons.arrow_forward_ios_rounded,
              onIconPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LeaderboardScreen()),
                );
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 200,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return CustomTopCardItemWidget(customCardItem: _leaderBoardMembers[index]);
                },
                itemCount: _leaderBoardMembers.length,
                viewportFraction: 0.35,
                scale: 0.50,
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'You are currently ranked 3rd among all Donors',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
