import 'package:annapardaan/screens/community/message_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:annapardaan/common_widgets/custom_searchbar.dart';
import 'package:annapardaan/screens/community/create_post_screen.dart';
import 'package:annapardaan/screens/community/widget/ngo_card.dart';
import 'package:annapardaan/screens/community/widget/postcard.dart';
import '../../common_widgets/custom_choosing_button.dart';
import '../../common_widgets/custom_section_header.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import '../../utils/constants/text_strings.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TText.appbarTittle7,
            style: TextStyle(fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          Row(
            children: [
              GestureDetector(
                child: Image.asset(
                  TImages.bellImageIcon,
                  height: 25,
                  width: 25,
                  color: Colors.black,
                ),
                onTap: () {},
              ),
              GestureDetector(
                child: Image.asset(
                  TImages.chatImageIcon,
                  height: 25,
                  width: 25,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MessagesScreen()));
                },
              ),
              const SizedBox(width: 5),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 65,
                  width: 300,
                  child: CustomSearchBar(
                    controller: _searchController,
                    onMicTap: () {
                      // Handle mic tap action here
                    },
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: Ink(
                    decoration: const ShapeDecoration(
                      color: TColors.primaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        TImages.settingImageIcon,
                        color: Colors.white,
                        width: 24,
                        height: 24,
                      ),
                      iconSize: 24,
                      onPressed: () {
                        // Handle settings button tap here
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: SectionHeader(
                title: TText.connectNgo,
                icon: Icons.arrow_forward_ios_rounded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    final ngoCards = [
                      const NGOCard(
                        title: 'Helping Hands',
                        description: 'Together, let\'s share the goodness!',
                        imageUrl:
                            'https://images.pexels.com/photos/6647002/pexels-photo-6647002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                      const NGOCard(
                        title: 'Feed Angels',
                        description: 'Feed the future your food, their hope',
                        imageUrl:
                            'https://images.pexels.com/photos/6647002/pexels-photo-6647002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                    ];
                    return ngoCards[index];
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomChoosingButton(
                    text: 'All Posts',
                    isSelected: _selectedIndex == 0,
                    onPressed: () => _onButtonPressed(0),
                    width: 100,
                  ),
                  CustomChoosingButton(
                    text: 'Donars',
                    isSelected: _selectedIndex == 1,
                    onPressed: () => _onButtonPressed(1),
                    width: 100,
                  ),
                  CustomChoosingButton(
                    text: 'Events',
                    isSelected: _selectedIndex == 2,
                    onPressed: () => _onButtonPressed(2),
                    width: 100,
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: _firestore
                  .collection('posts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const PostCard(
                        isLoading: true,
                        post: null,
                      );
                    },
                  );
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final docs = snapshot.data?.docs ?? [];

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    if (index >= docs.length) {
                      return const SizedBox
                          .shrink(); // Return empty widget if index is out of bounds
                    }
                    final post = docs[index];
                    return PostCard(
                      post: post,
                      isLoading: false,
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
