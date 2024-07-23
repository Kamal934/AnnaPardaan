import 'package:annapardaan/screens/donar/widgets/new_donation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/custom_bottom_navbar.dart';
import '../../common_widgets/navigation_drawer.dart.dart';
import '../../screens/community/community_screen.dart';
import '../../screens/donar/screen/donation_home_screen.dart';
import '../../screens/donar/screen/hungerspot_screen.dart';
import '../../providers/user_provider.dart';
import '../../utils/constants/images.dart';
import 'screen/add_restaurant_creen.dart';

class DonorMain extends StatefulWidget {
  const DonorMain({super.key});

  @override
  State<DonorMain> createState() => _DonorMainState();
}

class _DonorMainState extends State<DonorMain> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    DonationScreen(),
    HungerspotScreen(),
    CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget? _buildFloatingActionButton() {
    if (_selectedIndex == 0) {
      return Transform.rotate(
        angle: 0.8,
        child: FloatingActionButton(
          onPressed: () {
            final userProvider = Provider.of<UserProvider>(context, listen: false);
            final restaurantId = userProvider.currentUser.restaurantId;

            if (restaurantId != null && restaurantId.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewDonationScreen(restaurantId: restaurantId),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddRestaurantScreen(isDonor: true),
                ),
              );
            }
          },
          backgroundColor: Colors.red,
          elevation: 0,
          highlightElevation: 0,
          child: Transform.rotate(
            angle: -0.8,
            child: Image.asset(
              TImages.newDonationImageIcon,
              height: 27,
              width: 27,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _screens[_selectedIndex],
      endDrawer: const CustomNavigationDrawer(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          if (index == 3) {
            _scaffoldKey.currentState?.openEndDrawer();
          } else {
            _onItemTapped(index);
          }
        },
        showFloatingActionButton: _selectedIndex == 0,
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
