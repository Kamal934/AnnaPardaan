import 'package:flutter/material.dart';
import 'package:annapardaan/screens/community/community_screen.dart';
import 'package:annapardaan/common_widgets/navigation_drawer.dart.dart';
import 'package:annapardaan/common_widgets/custom_bottom_navbar.dart';
import 'package:annapardaan/screens/volunteer/volunteer_screen.dart';
import '../donar/screen/hungerspot_screen.dart';

class VolunteerMain extends StatefulWidget {
  const VolunteerMain({super.key});

  @override
  State<VolunteerMain> createState() => _VolunteerMainState();
}

class _VolunteerMainState extends State<VolunteerMain> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    VolunteerHomeScreen(),
    const HungerspotScreen(),
    const CommunityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
        showFloatingActionButton: false,
      ),
    );
  }
}
