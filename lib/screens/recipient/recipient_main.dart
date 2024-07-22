import 'package:flutter/material.dart';
import 'package:annapardaan/screens/community/community_screen.dart';
import 'package:annapardaan/common_widgets/navigation_drawer.dart.dart';
import 'package:annapardaan/screens/recipient/recipient_home_screen.dart';
import 'package:annapardaan/common_widgets/custom_bottom_navbar.dart';
import '../../utils/constants/images.dart';
import '../donar/screen/add_restaurant_creen.dart';
import '../donar/screen/hungerspot_screen.dart';

class RecipientMain extends StatefulWidget {
  const RecipientMain({super.key});

  @override
  State<RecipientMain> createState() => _RecipientMainState();
}

class _RecipientMainState extends State<RecipientMain> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    RecipientHomeScreen(),
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
                        const AddRestaurantScreen(isDonor: false)));
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
        showFloatingActionButton:  _selectedIndex == 0,

      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
