import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading:  Image.asset('assets/images/icons/list_iocn.png',height: 20,width: 20,color: Colors.black,),
                title: const Text(
                  'My Listings',style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to Request History
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset('assets/images/icons/event_icon.png',height: 23,width: 23,color: Colors.black,),
                title: const Text(
                  'Events',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to Events
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset('assets/images/icons/group_unselected_icon.png',height: 23,width: 23,color: Colors.black,),
                title: const Text(
                  'Community',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to Community
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset('assets/images/icons/ringing_icon.png',height: 20,width: 20,color: Colors.black,),
                title: const Text(
                  'Notifications',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to Notifications
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading:Image.asset('assets/images/icons/user_icon.png',height: 20,width: 20,color: Colors.black,),
                title: const Text(
                  'My Account',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to My Account
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset('assets/images/icons/translate_icon.png',height: 23,width: 23,color: Colors.black,),
                title: const Text(
                  'Language',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to Language
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset('assets/images/icons/exclamation_icon.png',height: 23,width: 23,color: Colors.black,),
                title: const Text(
                  'Help Center',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.right, // Corrected TextAlign assignment
                ),
                onTap: () {
                  // Handle navigation to Help Center
                },
              ),
            ),
            Divider(color: Colors.grey[250]),
            SizedBox(
              height: 30,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                title: const Text(
                  'Business',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  // Handle navigation to Business
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                title: const Text(
                  'Recipients Hub',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  // Handle navigation to Recipients Hub
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  // Handle navigation to Terms & Conditions
                },
              ),
            ),
            const Spacer(),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0.5,horizontal: 6 ),
              title: Text(
                'Version 2.221',
                style: TextStyle(fontSize: 12),
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last update on ',
                    style: TextStyle(fontSize: 10),
                  ),
                  Text('26 June, 2024 at 11:00 pm',style: TextStyle(fontSize: 10,color: Colors.black,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
