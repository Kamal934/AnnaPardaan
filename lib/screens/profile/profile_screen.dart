import 'package:flutter/material.dart';
import 'package:annapardaan/screens/profile/edit_profile_screen.dart';
import 'package:annapardaan/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TText.appbarTittle5),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_outlined),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, _) {
            if (!userProvider.isUserLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            String fullName = userProvider.currentUser.fullName;
            String email = userProvider.currentUser.email;
            String? profileImage = userProvider.currentUser.profileImage ??TImages.profileImage;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80.0,
                        height: 80.0, 
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                profileImage,
                                width: 80.0,
                                height: 80.0, 
                                fit: BoxFit.cover,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.bottomRight,
                              child:  CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 20.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0, width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          const Text(
                            'You\'ve been a member for 90 days!',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                const Text(
                  TText.insight,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInsightCard('250', TText.totalDonation,
                        TImages.totalDonationImageIcon),
                    _buildInsightCard('2.5k', TText.pointEarned,
                        TImages.pointEarnedImageIcon),
                  ],
                ),
                const SizedBox(height: 20.0),
                Center(
                  widthFactor: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Share my Impact',
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildProfileOption(
                  icon: Icons.person,
                  title: TText.profileInfo,
                  subtitle: TText.profileInfoSubtitle,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfileScreen()));
                  },
                ),
                _buildProfileOption(
                  icon: Icons.location_pin,
                  title: TText.location,
                  subtitle: TText.locationSubtitle,
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.notifications_active,
                  title: TText.pushNotification,
                  subtitle: TText.pushNotificationSubtitle,
                  trailing: Switch(
                    activeColor: Colors.red,
                    value: true,
                    onChanged: (value) {},
                  ),
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.help_center_rounded,
                  title: TText.faq,
                  subtitle: TText.faqSubtitle,
                  onTap: () {},
                ),
                _buildProfileOption(
                  icon: Icons.logout_outlined,
                  title: TText.logout,
                  subtitle: TText.logoutSubtitle,
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInsightCard(String value, String label, String image) {
    return Container(
      width: 150.0,
      padding:
          const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 239, 238, 245),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                height: 34,
                width: 34,
              ),
              Column(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }



Widget _buildProfileOption({
  required IconData icon,
  required String title,
  required String subtitle,
  Widget? trailing,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6.0),
    leading: Icon(icon),
    minTileHeight:30,
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    ),
    trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
    onTap: onTap,
  );}}

