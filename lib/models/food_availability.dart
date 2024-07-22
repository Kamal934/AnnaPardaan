class FoodAvailability {
  final String provider;
  final String foodName;
  final int availableFor;
  final int timeLeft;
  final int exptime;
  final bool isVerified;
  final String imageUrl;
  final int locationKm;

  FoodAvailability({
    required this.provider,
    required this.foodName,
    required this.availableFor,
    required this.timeLeft,
    required this.exptime,
    required this.isVerified,
    required this.imageUrl,
    required this.locationKm,
  });
}
