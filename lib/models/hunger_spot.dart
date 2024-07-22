class HungerSpot {
  final String id;
  final String address;
  final double latitude;
  final double longitude;
  final String name;
  final int population;
  final List<String> imageUrls;
  final String type;

  HungerSpot({
    required this.id,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.population,
    required this.imageUrls,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'population': population,
      'imageUrls': imageUrls,
      'type': type,
    };
  }

  String get firstImageUrl {
    return imageUrls.isNotEmpty
        ? imageUrls[0]
        : 'https://images.pexels.com/photos/34514/spot-runs-start-la.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  }
}
