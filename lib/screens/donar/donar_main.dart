import 'package:flutter/material.dart';
import 'package:annapardaan/common_widgets/custom_bottom_navbar.dart';
import 'package:annapardaan/screens/community/community_screen.dart';
import 'package:annapardaan/screens/donar/screen/add_restaurant_creen.dart';
import 'package:annapardaan/screens/donar/screen/donation_home_screen.dart';
import 'package:annapardaan/screens/donar/screen/hungerspot_screen.dart';
import '../../common_widgets/navigation_drawer.dart.dart';
import '../../utils/constants/images.dart';

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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AddRestaurantScreen(isDonor: true)));
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
