import 'package:flutter/material.dart';
import 'package:annapardaan/screens/donar/screen/add_hungerspot_google_map_screen.dart';
import 'package:annapardaan/screens/donar/screen/donate_to_hungerspot.dart';
import 'package:annapardaan/utils/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/constants/images.dart';

class HungerspotScreen extends StatelessWidget {
  const HungerspotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.appbarTittle2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.more_vert_sharp)
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
                height: 145,
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
                         Text(
                          AppLocalizations.of(context)!.donateToHungerSpot,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TColors.black,
                          ),
                        ),
                         Text(
                          AppLocalizations.of(context)!.donateToHungerSpotSubtittle,
                          style: const TextStyle(
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
                height: 145,
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
                         Text(
                          AppLocalizations.of(context)!.addToHungerSpot,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TColors.black,
                          ),
                        ),
                         Expanded(
                           child: Text(
                            AppLocalizations.of(context)!.addToHungerSpotSubtittle,
                            style: const TextStyle(
                              fontSize: 12,
                              color: TColors.darkGrey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
