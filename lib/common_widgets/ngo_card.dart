// lib/widgets/ngo_card.dart
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../models/ngo_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NgoCard extends StatefulWidget {
  final NGO ngo;

  const NgoCard({super.key, required this.ngo});

  @override
  State<NgoCard> createState() => _NgoCardState();
}

class _NgoCardState extends State<NgoCard> {
  bool isLiked = false;
  int likes = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
          child: Card(
            color: Theme.of(context).colorScheme.onSecondary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            shadowColor: Colors.black,
            elevation: 40.0,
            child: Container(
              height: 350,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                child: CachedNetworkImage(
                  imageUrl: widget.ngo.postUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height:350,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.red.shade100,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              isLiked = !isLiked;
              if (isLiked) {
                likes += 1;
              } else if (likes > 0) {
                likes -= 1;
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.8, vertical: 3.9),
            child: Container(
              height: 350.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.onSecondary,
                  gradient: LinearGradient(
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.transparent,
                      Colors.black.withOpacity(1),
                    ],
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 13.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              backgroundImage: CachedNetworkImageProvider(widget.ngo.profileUrl),
            ),
            title: Text(
              widget.ngo.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSecondary,
                fontFamily: 'Metropolis',
                fontSize: 14.0,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            dense: true,
            trailing: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        Positioned.fill(
          top: 250,
          left: 25,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked;
                              if (isLiked) {
                                likes += 1;
                              } else if (likes > 0) {
                                likes -= 1;
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 400,
                            ),
                            decoration: BoxDecoration(
                              color: !isLiked
                                  ? Colors.grey.withOpacity(0.5)
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Theme.of(context).colorScheme.onSecondary,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '$likes',
                                      style: TextStyle(
                                        fontFamily: 'Metropolis',
                                        color: Theme.of(context).colorScheme.onSecondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),   
                    // Comment icon
                    MaterialButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        // Navigate to comment screen
                      },
                      child: FaIcon(
                        FontAwesomeIcons.comment,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      ),
                    ),        
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20.0),
                  child: LikeButton(
                    likeBuilder: (bool isLiked) {
                      return FaIcon(
                        FontAwesomeIcons.bookmark,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 20,
                      );
                    },
                  ),
                ),     
              ],
            ),       
          ),    
        ),
      ],
    ); 
  }
}
