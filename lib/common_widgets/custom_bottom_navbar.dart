import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/images.dart';
import '../utils/constants/text_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final bool showFloatingActionButton;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.showFloatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      // shape: const CustomNotchedRectangle(),
      color: Colors.white, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, TImages.homeImageIcon, TText.home),
          _buildNavItem(1, TImages.hungrSpotImageIcon, TText.hungerSpots),
          if (showFloatingActionButton) const SizedBox(width: 36),
          _buildNavItem(2, TImages.communityImageIcon, TText.community),
          _buildNavItem(3, TImages.menuImageIcon, TText.menu),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 23,
            width: 23,
            color: selectedIndex == index ? TColors.primaryLight : Colors.black, // Red color when selected
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: selectedIndex == index ? TColors.primaryLight : Colors.black, // Red color when selected
            ),
          ),
        ],
      ),
    );
  }
}




// class CustomNotchedRectangle extends NotchedShape {
//   const CustomNotchedRectangle();

//   @override
//   Path getOuterPath(Rect host, Rect? guest) {
//     if (guest == null || !host.overlaps(guest)) {
//       return Path()..addRect(host);
//     }

//     final double notchRadius = guest.width / 6.0;
//     final double notchWidth = notchRadius * 2.0;
//     final double notchHeight = notchRadius * 2.0;

//     final double leftCornerX = guest.left - notchWidth / 3;
//     final double rightCornerX = guest.right + notchWidth / 3;
//     final double topCornerY = guest.top - notchHeight;

//     return Path()
//       ..moveTo(host.left, host.top)
//       ..lineTo(leftCornerX, host.top)
//       ..lineTo(guest.center.dx, topCornerY)
//       ..lineTo(rightCornerX, host.top)
//       ..lineTo(host.right, host.top)
//       ..lineTo(host.right, host.bottom)
//       ..lineTo(host.left, host.bottom)
//       ..close();
//   }
// }
