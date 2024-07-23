
class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String? role; 
  final String? profileImage;
  final String? restaurantId;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    this.role,
    required this.profileImage,
    this.restaurantId
  });
}
