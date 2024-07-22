import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:annapardaan/common_widgets/custom_appbar.dart';
import 'package:annapardaan/common_widgets/custom_choosing_button.dart';
import 'package:annapardaan/common_widgets/food_availability_card_builder.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/text_strings.dart';

class RecipientHomeScreen extends StatefulWidget {
  const RecipientHomeScreen({super.key});

  @override
  State<RecipientHomeScreen> createState() => _RecipientHomeScreenState();
}

class _RecipientHomeScreenState extends State<RecipientHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _selectedIndex = 1;

  void _onButtonPressed(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedIndex = index;
      });
    });
  }

  Future<Map<String, dynamic>> _getDonationsAndRestaurants() async {
    try {
      final donationsSnapshot = await _firestore.collectionGroup('donations').get();
      final restaurantsSnapshot = await _firestore.collection('restaurants').get();

      final donations = donationsSnapshot.docs;
      final restaurants = {for (var doc in restaurantsSnapshot.docs) doc.id: doc};

      if (kDebugMode) {
        print('Fetched ${donations.length} donations and ${restaurants.length} restaurants');
      }

      return {'donations': donations, 'restaurants': restaurants};
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching donations and restaurants: $e');
      }
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        userName: currentUser.fullName,
        userImageUrl: currentUser.profileImage ??
            'https://images.pexels.com/photos/783941/pexels-photo-783941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getDonationsAndRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching donations and restaurants'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No donations available'));
          }

          final donations = snapshot.data!['donations'] as List<DocumentSnapshot>;
          final restaurants = snapshot.data!['restaurants'] as Map<String, DocumentSnapshot>;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const Text(
                  TText.insight,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _buildInsights(),
                const SizedBox(height: 16),
                _buildTopDonors(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomChoosingButton(
                      text: 'Available Foods',
                      isSelected: _selectedIndex == 0,
                      onPressed: () => _onButtonPressed(0),
                      width: 165,
                    ),
                    CustomChoosingButton(
                      text: 'Events',
                      isSelected: _selectedIndex == 1,
                      onPressed: () => _onButtonPressed(1),
                      width: 165,
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    final donation = donations[index];
                    final parentRef = donation.reference.parent.parent;
                    final restaurantId = parentRef?.id;
                    final restaurant = restaurantId != null ? restaurants[restaurantId] : null;

                    if (restaurant != null) {
                      return FoodAvailabilityCardBuilder.buildFoodAvailabilityCard(
                          context, donation, restaurant);
                    } else {
                      if (kDebugMode) {
                        print('Restaurant not found for donation: ${donation.id}');
                      }
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInsights() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInsightCard('40', TText.overallRequest),
        _buildInsightCard('15', TText.donorConnected),
      ],
    );
  }

  Widget _buildInsightCard(String count, String label) {
    return SizedBox(
      width: 160,
      height: 100,
      child: Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(label, style: const TextStyle(fontSize: 12)),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Icon(
                  Icons.family_restroom_rounded,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopDonors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(TText.topDonor, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 95,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildDonorAvatar('https://images.pexels.com/photos/6647002/pexels-photo-6647002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'RHR'),
              const SizedBox(width: 10),
              _buildDonorAvatar('https://images.pexels.com/photos/6647002/pexels-photo-6647002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Muji Hotel'),
              const SizedBox(width: 10),
              _buildDonorAvatar('https://images.pexels.com/photos/6647002/pexels-photo-6647002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Park Inn'),
              const SizedBox(width: 10),
              _buildDonorAvatar('https://images.pexels.com/photos/6647002/pexels-photo-6647002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1', 'Sai Hotel'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDonorAvatar(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imagePath),
            radius: 30,
          ),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
