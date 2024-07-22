import 'package:flutter/material.dart';
import 'package:annapardaan/utils/constants/images.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../common_widgets/role_option.dart';
import '../screens/donar/donar_main.dart';
import '../screens/recipient/recipient_main.dart';
import '../screens/volunteer/volunteer_main.dart';
import '../utils/constants/text_strings.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              TText.mainTitle,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              TText.subtitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoleOption(
                  role: TText.donor,
                  description: TText.donorDescription,
                  imagePath:TImages.roleOptionImage1,
                  isSelected: context.watch<UserProvider>().currentUser.role == TText.donor,
                  onTap: () {
                    context.read<UserProvider>().updateRole('Donor');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DonorMain()),
                    );
                  },
                ),
                RoleOption(
                  role: TText.recipient,
                  description:TText.recipientDescription,
                  imagePath:TImages.roleOptionImage2,
                  isSelected: context.watch<UserProvider>().currentUser.role == TText.recipient,
                  onTap: () {
                    context.read<UserProvider>().updateRole('Recipient');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RecipientMain()),
                    );
                  },
                ),
              ],
            ),
            Center(
              child: RoleOption(
                role: TText.volunteer,
                description:TText.volunteerDescription,
                imagePath: TImages.roleOptionImage3,
                isSelected: context.watch<UserProvider>().currentUser.role == TText.volunteer,
                onTap: () {
                  context.read<UserProvider>().updateRole('Volunteer');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const VolunteerMain()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
