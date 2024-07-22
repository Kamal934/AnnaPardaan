import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/data/food_donation_data.dart';
import 'package:annapardaan/screens/donar/widgets/donation_item.dart';
import 'package:annapardaan/utils/constants/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/custom_card_item_data.dart';
import '../../../data/event_data.dart';
import '../../../common_widgets/badge_earned.dart';
import '../../../common_widgets/custom_appbar.dart';
import '../../../common_widgets/custom_section_header.dart';
import '../../../common_widgets/event_card.dart';
import '../../../common_widgets/food_donation_card.dart';
import '../../../utils/constants/text_strings.dart';
import '../../Insights/insights.dart';
import '../../Insights/leaderboard.dart';
import '../widgets/active_donation_marker.dart';
import 'package:annapardaan/providers/user_provider.dart';

class DonationScreen extends StatelessWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    if (!userProvider.isUserLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show skeleton loader
      );
    }

    final bool isDonor = userProvider.currentUser.role == TText.donor;
    if (kDebugMode) {
      print(isDonor);
    }

    final events = getEvents();
    final foodDonations = getFoodDonations();
    final customCardItems = getCustomCardItems();

    final PageController eventPageController = PageController();
    final PageController foodDonationPageController = PageController();

    const LatLng orderLocation = LatLng(40.7128, -74.0060);
    const LatLng volunteerLocation = LatLng(40.7200, -79.0100);

    return Scaffold(
      appBar: CustomAppBar(
        userName: userProvider.currentUser.fullName,
        userImageUrl: userProvider.currentUser.profileImage ?? 'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 170,
              child: PageView.builder(
                controller: foodDonationPageController,
                itemCount: foodDonations.length,
                itemBuilder: (context, index) {
                  return FoodDonationCard(foodDonation: foodDonations[index]);
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SmoothPageIndicator(
                controller: foodDonationPageController,
                count: foodDonations.length,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: TColors.primaryLight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SectionHeader(
                title: TText.activeDonation,
                icon: Icons.arrow_forward_ios_rounded,
                onIconPressed: () {},
              ),
            ),
            const ActiveDonationMarker(
              orderLocation: orderLocation,
              volunteerLocation: volunteerLocation,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: SectionHeader(
                title: TText.featureEvents,
                onViewAllPressed: () {},
              ),
            ),
            SizedBox(
              height: 260,
              child: PageView.builder(
                controller: eventPageController,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  return EventCard(event: events[index]);
                },
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: SmoothPageIndicator(
                controller: eventPageController,
                count: events.length,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: TColors.primaryLight,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: SectionHeader(title: TText.donationHistory),
            ),
            DonationList(),
            const SizedBox(height: 16),
            const Insights(subtitle: TText.insightscard1, isDonorScreen: true,),
            const SizedBox(height: 16),
            const BadgeEarned(),
            const SizedBox(height: 16),
            LeaderBoard(
              leaderBoardMembers: customCardItems,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
