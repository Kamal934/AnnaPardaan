import 'package:flutter/material.dart';

import '../../utils/constants/images.dart';
import '../../utils/constants/text_strings.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            TText.appbarTittle4,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle back button action
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert,color: Colors.white,),
              onPressed: () {
                // Handle more options action
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TImages.leaderBoardBackgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 105,
              left: 140,
              child: _buildTopUser(
                'Jass',
                '12847',
                'https://images.pexels.com/photos/2690323/pexels-photo-2690323.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                1,
              ),
            ),
            Positioned(
              top: 150,
              left: 35,
              child: _buildTopUser(
                'Preet',
                '2847',
                'https://images.pexels.com/photos/1998497/pexels-photo-1998497.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                2,
              ),
            ),
            Positioned(
              top: 150,
              left: 250,
              child: _buildTopUser(
                'Kml',
                '1847',
                'https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                3,
              ),
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: SizedBox(
                  height: 400,
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 15.0,right: 15,top: 15,bottom: 10),
                           child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                             child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.red,
                                ),
                               child: const TabBar(
                                  indicator: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(Radius.circular(10))
                                 ),
                                 indicatorPadding:EdgeInsets.only(top: 2,bottom: 2,left: 2,right: 2),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 0,
                                  dividerColor: Colors.transparent,
                                  labelColor: Colors.red,
                                  unselectedLabelColor: Colors.white,
                               tabs: [
                                   TabItem(title: TText.all, count: 10),
                                   TabItem(title: TText.thisWeek, count: 5),
                                   TabItem(title: TText.friends, count: 2),
                                 ],
                               ),
                             ),
                           ),
                         ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(child: _buildOtherUsers(TText.all)),
                              SingleChildScrollView(child: _buildOtherUsers(TText.thisWeek)),
                              SingleChildScrollView(child: _buildOtherUsers(TText.friends)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUser(String name, String points, String imageUrl, int rank) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 40),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$points pts',
              style: const TextStyle(
                color: Colors.orangeAccent ,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        // ),
      ],
    );
  }

  Widget _buildOtherUsers(String category) {
    // You can filter users based on the category here if needed.
    final users = [
      User(
        'Sebastian',
        '1124',
        'https://images.pexels.com/photos/837358/pexels-photo-837358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        true,
      ),
      User(
        'Sebastian',
        '1124',
        'https://images.pexels.com/photos/819530/pexels-photo-819530.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        true,
      ),
      User(
        'Sebastian',
        '1124',
        'https://images.pexels.com/photos/837358/pexels-photo-837358.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        true,
      ),
      User(
        'Sebastian',
        '1124',
        'https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        true,
      ),
      User(
        'Jason',
        '875',
        'https://images.pexels.com/photos/819530/pexels-photo-819530.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        false,
      ),
      User(
        'Natalie',
        '774',
        'https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        true,
      ),
      User(
        'Serenity',
        '723',
        'https://images.pexels.com/photos/819530/pexels-photo-819530.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        true,
      ),
      User(
        'Hannah',
        '559',
        'https://images.pexels.com/photos/819530/pexels-photo-819530.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        false,
      ),
    ];

    return Column(
      children: users.map((user) => _buildUserRow(user)).toList(),
    );
  }

  Widget _buildUserRow(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                user.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${user.points} points',
            style: const TextStyle(fontSize: 12,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final String points;
  final String imageUrl;
  final bool isUp;

  User(this.name, this.points, this.imageUrl, this.isUp);
}

class TabItem extends StatelessWidget {
  final String title;
  final int count;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
