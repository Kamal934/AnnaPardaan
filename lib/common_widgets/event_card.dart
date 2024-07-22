import 'package:flutter/material.dart';
import '../models/events.dart';
import '../screens/event/event_screen.dart';
import 'custom_button.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
        ),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0), // Adjust the radius as needed
              ),
              child: Image.network(event.imageUrl,
              width: double.infinity,
                height: 150,
                fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // To separate the location/date/time and the button
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 18,color: Colors.grey,),
                                const SizedBox(width: 3),
                                Text(event.location,
                                style: const TextStyle(
                                  color: Colors.grey
                                ),),
                              ],
                            ),
                            const SizedBox(height: 5), // Add spacing between location and date/time
                            Row(
                              children: [
                                const Icon(Icons.calendar_today_rounded, size: 18,color: Colors.grey,),
                                const SizedBox(width: 3),
                                Text('${event.date} | ${event.time}',),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,
                        child: CustomButton(
                          text: 'Register',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EventScreen()));
                          },
                          width: 115,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
