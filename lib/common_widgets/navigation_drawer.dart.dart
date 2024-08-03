import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/local_provider.dart';
import '../utils/constants/images.dart';
import '../providers/user_provider.dart';
import '../utils/constants/text_strings.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userType = userProvider.currentUser.role;
    Provider.of<LocaleProvider>(context);

    String headerTitle;
    String headerImage;

    if (userType == 'donor') {
      headerTitle = 'My Listings';
      headerImage = TImages.listImageIcon;
    } else if (userType == 'recipient') {
      headerTitle = 'Request History';
      headerImage = TImages.requesthistoryImageIcon;
    } else {
      headerTitle = 'My Orders';
      headerImage = TImages.myOrderImageIcon;
    }

    return Drawer(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset(headerImage,
                    height: 20, width: 20, color: Colors.black),
                title: Text(headerTitle,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.right),
                onTap: () {
                  // Handle navigation to Listings/Orders/Hub
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset(TImages.eventImageIcon,
                    height: 23, width: 23, color: Colors.black),
                title: const Text('Events',
                    style: TextStyle(fontSize: 14), textAlign: TextAlign.right),
                onTap: () {
                  // Handle navigation to Events
                },
              ),
            ),
            Divider(color: Colors.grey[300]),
            SizedBox(
              height: 40,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                leading: Image.asset(TImages.communityImageIcon,
                    height: 23, width: 23, color: Colors.black),
                title: const Text(TText.appbarTittle7,
                    style: TextStyle(fontSize: 14), textAlign: TextAlign.right),
                onTap: () {
                  // Handle navigation to Community
                },
              ),
            ),
            Divider(color: Colors.grey[250]),
            if (userType != 'recipient') ...[
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.5, horizontal: 6.0),
                  leading: Image.asset(TImages.achievementsImageIcon,
                      height: 33, width: 33, color: Colors.black),
                  title: const Text('My Achievements',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right),
                  onTap: () {
                    // Handle navigation to My Achievements
                  },
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.5, horizontal: 6.0),
                  leading: Image.asset(TImages.notificationImageIcon,
                      height: 20, width: 20, color: Colors.black),
                  title: const Text('Notifications',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right),
                  onTap: () {
                    // Handle navigation to Notifications
                  },
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.5, horizontal: 6.0),
                  leading: Image.asset(TImages.personImageIcon,
                      height: 20, width: 20, color: Colors.black),
                  title: const Text('My Account',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right),
                  onTap: () {
                    // Handle navigation to My Account
                  },
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.5, horizontal: 6.0),
                  leading: Image.asset(TImages.translateImageIcon,
                      height: 23, width: 23, color: Colors.black),
                  title: const Text('Language',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Language'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                GestureDetector(
                                  child: const Text('English'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('en'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Hindi'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('hi'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Chinese'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('zh'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Russian'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('ru'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('German'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('de'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Arabic'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('ar'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('French'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('fr'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Malay'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('ms'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Portuguese'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('pt'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Spanish'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('es'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Punjabi'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('pa'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                                GestureDetector(
                                  child: const Text('Bangali'),
                                  onTap: () {
                                    _changeLanguage(
                                        context, const Locale('bn'));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                const Padding(padding: EdgeInsets.all(8.0)),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(
                height: 40,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.5, horizontal: 6.0),
                  leading: Image.asset(TImages.helpImageIcon,
                      height: 23, width: 23, color: Colors.black),
                  title: const Text('Help Center',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.right),
                  onTap: () {
                    // Handle navigation to Help Center
                  },
                ),
              ),
              Divider(color: Colors.grey[250]),
            ],
            SizedBox(
              height: 30,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                title: const Text('Business', style: TextStyle(fontSize: 14)),
                onTap: () {
                  // Handle navigation to Business
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                title: const Text('Volunteers Hub',
                    style: TextStyle(fontSize: 14)),
                onTap: () {
                  // Handle navigation to Volunteers Hub
                },
              ),
            ),
            SizedBox(
              height: 30,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 6.0),
                title: const Text('Terms & Conditions',
                    style: TextStyle(fontSize: 14)),
                onTap: () {
                  // Handle navigation to Terms & Conditions
                },
              ),
            ),
            const Spacer(),
            const ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.5, horizontal: 6),
              title: Text('Version 1.221', style: TextStyle(fontSize: 12)),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last update on ', style: TextStyle(fontSize: 10)),
                  Text('26 June, 2024 at 11:00 pm',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);

    // Update LocaleProvider
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(locale);
  }
}
