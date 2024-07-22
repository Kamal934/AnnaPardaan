import 'package:flutter/material.dart';
import 'package:annapardaan/screens/donar/screen/add_hungerspot_google_map_screen.dart';
import 'package:annapardaan/screens/donar/screen/donate_to_hungerspot.dart';
import 'package:annapardaan/utils/constants/colors.dart';

import '../../../utils/constants/images.dart';
import '../../../utils/constants/text_strings.dart';

class HungerspotScreen extends StatelessWidget {
  const HungerspotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TText.appbarTittle2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.more_vert_sharp)
          ],
        ),
        centerTitle: true,
        backgroundColor: TColors.white,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: TColors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(TImages.hungerSpotScreenImage,
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
              child: SizedBox(
                height: 140,
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  elevation: 4,
                  shadowColor: TColors.darkGrey,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16.0, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          TText.donateToHungerSpot,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TColors.black,
                          ),
                        ),
                        const Text(
                          TText.donateToHungerSpotSubtittle,
                          style: TextStyle(
                            fontSize: 12,
                            color: TColors.darkGrey,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DonateToHungerSpotScreen(), // Navigate to DonateToHungerSpotScreen
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward,
                                color: TColors.primaryLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12.0, top: 12),
              child: SizedBox(
                height: 140,
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shadowColor: TColors.darkGrey,
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          TText.addToHungerSpot,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TColors.black,
                          ),
                        ),
                        const Text(
                          TText.addToHungerSpotSubtittle,
                          style: TextStyle(
                            fontSize: 12,
                            color: TColors.darkGrey,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AddHungerSpotScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward,
                                color: TColors.primaryLight),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
