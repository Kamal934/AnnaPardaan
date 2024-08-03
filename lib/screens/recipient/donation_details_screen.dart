import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:annapardaan/common_widgets/custom_button.dart';
import 'package:annapardaan/screens/recipient/skeleton/skeleton_build.dart';
import 'package:annapardaan/utils/constants/colors.dart';
import 'package:validators/validators.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../common_widgets/custom_choosing_button.dart';
import '../../utils/constants/text_strings.dart';
import '../donar/widgets/custom_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DonationDetailsScreen extends StatefulWidget {
  final String donationId;
  final String restaurantId;

  const DonationDetailsScreen(
      {super.key, required this.donationId, required this.restaurantId});

  @override
  State<DonationDetailsScreen> createState() => _DonationDetailsScreenState();
}

class _DonationDetailsScreenState extends State<DonationDetailsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedDiet = 'Veg';

  Future<Map<String, dynamic>> _getDonationDetails() async {
    // Fetch the donation document using its ID and restaurant ID
    final donationSnapshot = await _firestore
        .collection('restaurants')
        .doc(widget.restaurantId)
        .collection('donations')
        .doc(widget.donationId)
        .get();

    if (!donationSnapshot.exists) {
      throw Exception('Donation not found');
    }

    // Fetch the restaurant document using the restaurantId
    final restaurantSnapshot = await _firestore
        .collection('restaurants')
        .doc(widget.restaurantId)
        .get();
    if (!restaurantSnapshot.exists) {
      throw Exception('Restaurant not found');
    }

    final restaurantData = restaurantSnapshot.data();
    if (restaurantData == null) {
      throw Exception('Restaurant data is null');
    }

    return {
      'donation': donationSnapshot,
      'restaurant': restaurantSnapshot,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text(
          AppLocalizations.of(context)!.appbarTittle6,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getDonationDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer(
              enabled: true,
              child: ListView(
                children: List.generate(
                    10, (index) => const BuildSkeletonDonationDetails()),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No donation details available'));
          } else {
            final donation = snapshot.data!['donation'] as DocumentSnapshot;
            final restaurant = snapshot.data!['restaurant'] as DocumentSnapshot;
            final donationData = donation.data() as Map<String, dynamic>?;
            final restaurantData = restaurant.data() as Map<String, dynamic>?;

            if (donationData == null || restaurantData == null) {
              return const Center(
                  child: Text('Error: Donation or Restaurant data is null'));
            }

            final List<String> donationImages =
                List<String>.from(donationData['images'] ?? []);
            final List<String> restaurantImages =
                List<String>.from(restaurantData['images'] ?? []);

            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 12, right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: restaurantImages.isNotEmpty
                                    ? Image.network(
                                        restaurantImages.first,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              const SizedBox(
                                width: 10,
                                height: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    restaurantData['name'] ?? 'No name',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Row(
                                    children: [
                                      Icon(Icons.verified,
                                          color: Colors.blue, size: 16),
                                      SizedBox(width: 4),
                                      Text('Verified',
                                          style: TextStyle(color: Colors.blue)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Meals for ${donationData['mealQuantity'].toInt()} people available',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        size: 15,
                                      ),
                                      const Text('6 km'),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.access_time_filled_outlined,
                                        size: 15,
                                      ),
                                      Text(
                                          ' Exp ${donationData['mealExpiryTime'].toInt()} mins'),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                   Text(
                    AppLocalizations.of(context)!.photos,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (donationImages.isNotEmpty)
                    Row(
                      children: [
                        for (int i = 0; i < donationImages.length && i < 3; i++)
                          if (isURL(donationImages[i]))
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  donationImages[i],
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        if (donationImages.length > 3)
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: !isURL(donationImages[3])
                                    ? Image.file(
                                        File(donationImages[3]),
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black45,
                                ),
                                height: 70,
                                width: 70,
                                child: Center(
                                  child: Text(
                                    '+${donationImages.length - 3}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  else
                    const Text(
                      'No images available for this hunger spot.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  const SizedBox(height: 16),
                   Text(
                    AppLocalizations.of(context)!.dietType,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomChoosingButton(
                        text: "Veg",
                        isSelected: _selectedDiet == "Veg",
                        onPressed: () => setState(() => _selectedDiet = "Veg"),
                        width: 100,
                      ),
                      CustomChoosingButton(
                        text: "Non-Veg",
                        isSelected: _selectedDiet == "Non-veg",
                        onPressed: () =>
                            setState(() => _selectedDiet = "Non-veg"),
                        width: 100,
                      ),
                      CustomChoosingButton(
                        text: "Both",
                        isSelected: _selectedDiet == "Both",
                        onPressed: () => setState(() => _selectedDiet = "Both"),
                        width: 100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                   Text(
                    AppLocalizations.of(context)!.mealQuantity,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  CustomSlider(
                    initialValue: 0,
                    onChanged: (value) {
                      setState(() {});
                    },
                    unit: TText.mins,
                    min: 0,
                    max: (donationData['mealQuantity'] ?? 0).toDouble(),
                    divisions: 100,
                  ),
                  const SizedBox(height: 16),
                   Text(
                    AppLocalizations.of(context)!.instruction,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 238, 245),
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                   Text(
                    AppLocalizations.of(context)!.location,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: const Color.fromARGB(255, 239, 238, 245),
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.red),
                      title: Text(
                        donationData['location'],
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: TColors.primaryLight,
                          value: false,
                          onChanged: (value) {}),
                      const Text(TText.selfPickup),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          checkColor: TColors.primaryLight,
                          value: false,
                          onChanged: (value) {}),
                       Text(AppLocalizations.of(context)!.requestPartner),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Post ID: ${donationData['donationId']}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 160,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 239, 238, 245),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {},
                          child:  Text(
                            AppLocalizations.of(context)!.message,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: AppLocalizations.of(context)!.requestPost,
                        width: 160,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
