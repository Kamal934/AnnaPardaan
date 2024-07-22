class DeliveryStatus {
  final String status;
  final String eta;
  final String volunteerName;
  final String volunteerContact;
  final List<String> stops;

  DeliveryStatus({
    required this.status,
    required this.eta,
    required this.volunteerName,
    required this.volunteerContact,
    required this.stops,
  });
}
