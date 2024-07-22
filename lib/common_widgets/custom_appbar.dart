import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/location_service.dart';
import '../screens/profile/profile_screen.dart';
import '../utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String userName;
  final String userImageUrl;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    required this.userName,
    required this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final LocationController locationController = Get.put(LocationController());
    locationController.getCurrentLocation();

    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      title: Obx(() {
        String currentLocation = locationController.currentLocation.value.isNotEmpty
            ? locationController.currentLocation.value
            : 'Getting location...';

        return Row(
          children: [
            Image.asset(
              'assets/images/icons/location.png',
              width: 20,
              height: 20,
              color: TColors.primaryLight,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    currentLocation,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        );
      }),
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/images/icons/bell-ring_icon.png',
            width: 23,
            height: 23,
            color: Colors.black,
          ),
          onPressed: () {
            // Handle notification button press
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 15.0),
          child: GestureDetector(
            onTap: () {
              // Navigate to the user profile screen
              Navigator.push(context, 
              MaterialPageRoute(builder: (context)=>const ProfileScreen()));
            },
            child: SizedBox(
              height: 35,
              width: 35,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  userImageUrl,
                  fit: BoxFit.cover, // Ensure the image covers the container
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

