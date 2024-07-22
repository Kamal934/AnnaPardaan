// models/event_data.dart
import 'package:annapardaan/models/events.dart';

List<Event> getEvents() {
  return [
    Event(
      title: 'Nourish Together - Community Day',
      location: 'Greenwich, CT',
      date: 'Dec 15',
      time: '5:00 PM',
      imageUrl: 'https://images.pexels.com/photos/6646917/pexels-photo-6646917.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Event(
      title: 'Food Drive',
      location: 'New York, NY',
      date: 'Nov 10',
      time: '11:00 PM',
      imageUrl: 'https://images.pexels.com/photos/6591154/pexels-photo-6591154.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
    Event(
      title: 'Nourish Together - Community Day',
      location: 'Greenwich, CT',
      date: 'Oct 8',
      time: '1:00 PM',
      imageUrl: 'https://images.pexels.com/photos/6646917/pexels-photo-6646917.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
  ];
}
